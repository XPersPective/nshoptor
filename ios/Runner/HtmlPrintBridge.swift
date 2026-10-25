import Flutter
import UIKit

/// UIKit owns pagination and the print UI; cancellation is not a failed save.
final class HtmlPrintBridge: NSObject {
  private let channel: FlutterMethodChannel
  private var pending: FlutterResult?
  private var controller: UIPrintInteractionController?
  private var generation: UInt64 = 0
  private var backgroundObserver: NSObjectProtocol?
  private var renderingPdf = false
  private var renderTimeout: DispatchWorkItem?
  private var disposed = false

  init(messenger: FlutterBinaryMessenger) {
    channel = FlutterMethodChannel(name: "nshoptor/print", binaryMessenger: messenger)
    super.init()
    channel.setMethodCallHandler { [weak self] call, result in
      DispatchQueue.main.async {
        guard let self = self else {
          result(FlutterError(code: "print_unavailable", message: "Printing unavailable", details: nil)); return
        }
        self.handle(call, result: result)
      }
    }
    backgroundObserver = NotificationCenter.default.addObserver(
      forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main
    ) { [weak self] _ in self?.cancel() }
  }

  func dispose() {
    disposed = true
    cancel()
    channel.setMethodCallHandler(nil)
    if let observer = backgroundObserver { NotificationCenter.default.removeObserver(observer) }
    backgroundObserver = nil
  }

  private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard call.method == "print" || call.method == "renderPdf" else { result(FlutterMethodNotImplemented); return }
    guard !disposed else {
      result(FlutterError(code: "print_unavailable", message: "Printing unavailable", details: nil)); return
    }
    guard let args = call.arguments as? [String: Any], let html = args["html"] as? String,
          !html.isEmpty, html.utf16.count <= 2_000_000, let title = args["title"] as? String,
          !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, title.count <= 200 else {
      result(FlutterError(code: "invalid_report", message: "Invalid report", details: nil)); return
    }
    guard pending == nil else {
      result(FlutterError(code: "print_busy", message: "A print job is already active", details: nil)); return
    }
    if call.method == "renderPdf" {
      renderPdf(html: html, title: title, result: result)
      return
    }
    guard UIApplication.shared.applicationState == .active,
          UIPrintInteractionController.isPrintingAvailable,
          let view = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene })
            .filter({ $0.activationState == .foregroundActive })
            .flatMap({ $0.windows }).first(where: { $0.isKeyWindow })?.rootViewController?.view,
          view.window != nil else {
      result(FlutterError(code: "print_unavailable", message: "Printing unavailable", details: nil)); return
    }
    let printController = UIPrintInteractionController.shared
    let info = UIPrintInfo(dictionary: nil)
    info.jobName = title
    info.outputType = .general
    info.duplex = .none
    printController.printInfo = info
    printController.printingItem = nil
    printController.printingItems = nil
    printController.printPageRenderer = nil
    // Dart generates escaped HTML and a restrictive CSP; do not double-escape it.
    printController.printFormatter = UIMarkupTextPrintFormatter(markupText: html)
    printController.showsPageRange = true
    pending = result
    controller = printController
    generation &+= 1
    let version = generation
    let completion: UIPrintInteractionController.CompletionHandler = { [weak self] _, _, error in
      DispatchQueue.main.async {
        guard let self = self, self.generation == version, self.pending != nil else { return }
        if error != nil {
          self.finish(FlutterError(code: "print_failed", message: "Unable to print report", details: nil))
        } else {
          self.finish(nil) // Includes user cancellation; never claims a PDF was saved.
        }
      }
    }
    let presented: Bool
    if UIDevice.current.userInterfaceIdiom == .pad {
      let anchor = CGRect(x: view.bounds.midX, y: view.bounds.maxY - 1, width: 1, height: 1)
      presented = printController.present(from: anchor, in: view, animated: true, completionHandler: completion)
    } else {
      presented = printController.present(animated: true, completionHandler: completion)
    }
    if !presented {
      finish(FlutterError(code: "print_failed", message: "Unable to open report", details: nil))
    }
  }

  private func cancel() {
    controller?.dismiss(animated: false)
    if renderingPdf {
      finish(FlutterError(code: "render_cancelled", message: "PDF rendering cancelled", details: nil))
    } else {
      finish(nil)
    }
  }

  private func finish(_ error: FlutterError?) {
    complete(error)
  }

  private func complete(_ value: Any?) {
    generation &+= 1
    let callback = pending
    pending = nil
    renderTimeout?.cancel()
    renderTimeout = nil
    renderingPdf = false
    controller?.printFormatter = nil
    controller = nil
    callback?(value)
  }

  private func renderPdf(html: String, title: String, result: @escaping FlutterResult) {
    guard UIApplication.shared.applicationState == .active else {
      result(FlutterError(code: "print_unavailable", message: "PDF rendering unavailable", details: nil)); return
    }
    pending = result
    renderingPdf = true
    generation &+= 1
    let version = generation
    let deadline = ProcessInfo.processInfo.systemUptime + 30
    let timeout = DispatchWorkItem { [weak self] in
      guard let self = self, self.generation == version, self.renderingPdf else { return }
      self.finish(FlutterError(code: "render_timeout", message: "PDF rendering timed out", details: nil))
    }
    renderTimeout = timeout
    DispatchQueue.main.asyncAfter(deadline: .now() + 30, execute: timeout)
    // Yield before UIKit work so a queued lifecycle cancellation can win.
    DispatchQueue.main.async { [weak self] in
      guard let self = self, self.generation == version, self.renderingPdf else { return }
      guard UIApplication.shared.applicationState == .active else {
        self.cancel(); return
      }
      let renderer = ReportA4PageRenderer()
      renderer.addPrintFormatter(UIMarkupTextPrintFormatter(markupText: html), startingAtPageAt: 0)
      let count = renderer.numberOfPages
      guard count > 0, count <= 500 else {
        self.finish(FlutterError(code: "report_too_large", message: "Invalid report page count", details: nil)); return
      }
      renderer.prepare(forDrawingPages: NSRange(location: 0, length: count))
      guard ProcessInfo.processInfo.systemUptime < deadline else {
        self.finish(FlutterError(code: "render_timeout", message: "PDF rendering timed out", details: nil)); return
      }
      let format = UIGraphicsPDFRendererFormat()
      format.documentInfo = [kCGPDFContextTitle as String: title]
      let pdf = UIGraphicsPDFRenderer(bounds: renderer.paperRect, format: format)
      var failure: String?
      let data = pdf.pdfData { context in
        for page in 0..<count {
          guard self.generation == version, self.renderingPdf,
                UIApplication.shared.applicationState == .active else {
            failure = "render_cancelled"; break
          }
          guard ProcessInfo.processInfo.systemUptime < deadline else {
            failure = "render_timeout"; break
          }
          context.beginPage()
          renderer.drawPage(at: page, in: renderer.printableRect)
        }
      }
      guard self.generation == version, self.renderingPdf else { return }
      if let code = failure {
        self.finish(FlutterError(code: code, message: "Unable to render report", details: nil)); return
      }
      guard ProcessInfo.processInfo.systemUptime < deadline else {
        self.finish(FlutterError(code: "render_timeout", message: "PDF rendering timed out", details: nil)); return
      }
      guard data.count >= 5, data.count <= 20 * 1024 * 1024,
            data.starts(with: Data("%PDF-".utf8)) else {
        self.finish(FlutterError(code: "invalid_pdf", message: "Invalid report PDF", details: nil)); return
      }
      self.complete(FlutterStandardTypedData(bytes: data))
    }
  }
}

/// Fixed A4 geometry without writing UIKit's read-only properties using KVC.
private final class ReportA4PageRenderer: UIPrintPageRenderer {
  override var paperRect: CGRect { CGRect(x: 0, y: 0, width: 595.28, height: 841.89) }
  override var printableRect: CGRect { paperRect.insetBy(dx: 28.35, dy: 28.35) }
}
