import Flutter
import UIKit
import PDFKit
import CoreFoundation

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
  private var paginationJob: ReportPaginationJob?

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
    if call.method == "renderPdf", let payload = args["pagination"] {
      guard let fragments = ReportFragments(payload, html: html) else {
        result(FlutterError(code: "invalid_report", message: "Invalid report", details: nil)); return
      }
      renderPaginated(fragments, title: title, result: result)
      return
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
    paginationJob = nil
    controller?.printFormatter = nil
    controller = nil
    callback?(value)
  }

  private func renderPaginated(_ fragments: ReportFragments, title: String,
                               result: @escaping FlutterResult) {
    guard UIApplication.shared.applicationState == .active else {
      result(FlutterError(code: "print_unavailable", message: "PDF rendering unavailable", details: nil)); return
    }
    pending = result
    renderingPdf = true
    generation &+= 1
    let job = ReportPaginationJob(fragments: fragments, title: title, generation: generation)
    paginationJob = job
    let timeout = DispatchWorkItem { [weak self, weak job] in
      guard let self = self, let job = job, self.isCurrent(job) else { return }
      self.failPagination("render_timeout")
    }
    renderTimeout = timeout
    DispatchQueue.main.asyncAfter(deadline: .now() + 30, execute: timeout)
    nextSectionChunk(job)
  }

  private func isCurrent(_ job: ReportPaginationJob) -> Bool {
    !disposed && paginationJob === job && generation == job.generation && renderingPdf && pending != nil
  }

  private func checkPagination(_ job: ReportPaginationJob) -> Bool {
    guard isCurrent(job) else { return false }
    guard UIApplication.shared.applicationState == .active else { cancel(); return false }
    guard ProcessInfo.processInfo.systemUptime < job.deadline else {
      failPagination("render_timeout"); return false
    }
    return true
  }

  private func failPagination(_ code: String) {
    finish(FlutterError(code: code, message: "Unable to render report", details: nil))
  }

  // Each operation gets a separate main-queue turn. UIKit and PDFKit calls are
  // synchronous: this is a soft deadline, never preemption of an individual call.
  // No PDF graphics context survives a turn, including cancellation/timeout turns.
  private func enqueue(_ job: ReportPaginationJob, _ operation: @escaping () -> Void) {
    DispatchQueue.main.async { [weak self, weak job] in
      guard let self = self, let job = job, self.checkPagination(job) else { return }
      autoreleasepool { operation() }
      _ = self.checkPagination(job)
    }
  }

  private func measure(_ job: ReportPaginationJob, count: Int, footer: Bool,
                       completion: @escaping (ReportA4PageRenderer, Int) -> Void) {
    enqueue(job) { [weak self] in
      guard let self = self else { return }
      let section = job.fragments.sections[job.section]
      let rows = section.rows[job.row..<(job.row + count)].joined()
      let html = job.fragments.start + section.start + rows + section.end
        + (footer ? section.footer : "") + job.fragments.end
      let renderer = ReportA4PageRenderer()
      renderer.addPrintFormatter(UIMarkupTextPrintFormatter(markupText: html), startingAtPageAt: 0)
      let pages = renderer.numberOfPages
      guard self.checkPagination(job) else { return }
      guard pages > 0 else { self.failPagination("invalid_pdf"); return }
      completion(renderer, pages)
    }
  }

  private func nextSectionChunk(_ job: ReportPaginationJob) {
    guard checkPagination(job) else { return }
    guard job.section < job.fragments.sections.count else { serialize(job); return }
    let remaining = job.fragments.sections[job.section].rows.count - job.row
    job.phase = .measuringFinal
    // Always try the exact final footer first, including zero-row sections.
    measure(job, count: remaining, footer: true) { [weak self] renderer, pages in
      guard let self = self else { return }
      if pages == 1 {
        self.accept(job, renderer: renderer, consumed: remaining, completesSection: true)
      } else if remaining == 0 {
        self.failPagination("report_too_large")
      } else {
        job.phase = .searching
        job.best = nil
        self.search(job, low: 1, high: remaining)
      }
    }
  }

  // Fixed table/column geometry makes prefix height monotonic. Every candidate
  // repeats root context, section metadata and the explicit table header.
  private func search(_ job: ReportPaginationJob, low: Int, high: Int) {
    guard checkPagination(job) else { return }
    guard low <= high else {
      guard let best = job.best else { failPagination("report_too_large"); return }
      job.best = nil
      accept(job, renderer: best.renderer, consumed: best.count, completesSection: false)
      return
    }
    let middle = low + (high - low) / 2
    measure(job, count: middle, footer: false) { [weak self] renderer, pages in
      guard let self = self else { return }
      if pages == 1 {
        job.best = (middle, renderer)
        self.search(job, low: middle + 1, high: high)
      } else {
        self.search(job, low: low, high: middle - 1)
      }
    }
  }

  private func accept(_ job: ReportPaginationJob, renderer: ReportA4PageRenderer,
                      consumed: Int, completesSection: Bool) {
    guard checkPagination(job) else { return }
    guard job.document.pageCount < 500 else { failPagination("report_too_large"); return }
    job.phase = .preparing
    enqueue(job) { [weak self] in
      guard let self = self else { return }
      renderer.prepare(forDrawingPages: NSRange(location: 0, length: 1))
      guard self.checkPagination(job) else { return }
      // Retain and draw this exact measured renderer; never truncate a candidate.
      guard renderer.numberOfPages == 1 else { self.failPagination("report_too_large"); return }
      guard self.checkPagination(job) else { return }
      job.phase = .rendering
      self.enqueue(job) { [weak self] in
        guard let self = self else { return }
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = [kCGPDFContextTitle as String: job.title]
        let pdf = UIGraphicsPDFRenderer(bounds: renderer.paperRect, format: format)
        let data = pdf.pdfData { context in
          context.beginPage()
          renderer.drawPage(at: 0, in: renderer.printableRect)
        }
        guard self.checkPagination(job) else { return }
        guard data.count >= 5, data.count <= 20 * 1024 * 1024,
              data.starts(with: Data("%PDF-".utf8)) else { self.failPagination("invalid_pdf"); return }
        job.phase = .merging
        self.enqueue(job) { [weak self] in
          guard let self = self else { return }
          guard let pageDocument = PDFDocument(data: data), pageDocument.pageCount == 1,
                let page = pageDocument.page(at: 0) else { self.failPagination("invalid_pdf"); return }
          guard self.checkPagination(job) else { return }
          job.document.insert(page, at: job.document.pageCount)
          guard self.checkPagination(job) else { return }
          job.row += consumed
          if completesSection {
            job.section += 1
            job.row = 0
          }
          // A non-final page consumes >=1 row. If it consumes all remaining
          // rows, the next measurement is the explicit repeated-context footer.
          self.nextSectionChunk(job)
        }
      }
    }
  }

  private func serialize(_ job: ReportPaginationJob) {
    job.phase = .serializing
    enqueue(job) { [weak self] in
      guard let self = self else { return }
      job.document.documentAttributes = [PDFDocumentAttribute.titleAttribute: job.title]
      guard let data = job.document.dataRepresentation() else { self.failPagination("invalid_pdf"); return }
      guard self.checkPagination(job) else { return }
      guard job.document.pageCount > 0, job.document.pageCount <= 500,
            data.count >= 5, data.count <= 20 * 1024 * 1024,
            data.starts(with: Data("%PDF-".utf8)) else { self.failPagination("report_too_large"); return }
      self.complete(FlutterStandardTypedData(bytes: data))
    }
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

private struct ReportFragments {
  struct Section {
    let start: String
    let rows: [String]
    let end: String
    let footer: String
  }
  let start: String
  let end: String
  let sections: [Section]

  init?(_ payload: Any, html: String) {
    guard let map = payload as? [String: Any],
          let version = map["version"] as? NSNumber,
          CFGetTypeID(version) != CFBooleanGetTypeID(), version.doubleValue == 1,
          ["c", "s", "i", "l", "q", "C", "S", "I", "L", "Q"].contains(String(cString: version.objCType)),
          let start = map["start"] as? String, let end = map["end"] as? String,
          let rawSections = map["sections"] as? [[String: Any]],
          !rawSections.isEmpty, rawSections.count <= 500 else { return nil }
    var units = html.utf16.count
    func include(_ value: String) -> Bool {
      units += value.utf16.count
      return units <= 2_000_000
    }
    guard include(start), include(end) else { return nil }
    var sections: [Section] = []
    var totalRows = 0
    for raw in rawSections {
      guard let sectionStart = raw["start"] as? String,
            let sectionEnd = raw["end"] as? String,
            let footer = raw["footer"] as? String,
            let rows = raw["rows"] as? [String] else { return nil }
      totalRows += rows.count
      guard totalRows <= 10_000, include(sectionStart), include(sectionEnd), include(footer) else { return nil }
      for row in rows {
        guard !row.isEmpty, include(row) else { return nil }
      }
      sections.append(Section(start: sectionStart, rows: rows, end: sectionEnd, footer: footer))
    }
    self.start = start
    self.end = end
    self.sections = sections
  }
}

private final class ReportPaginationJob {
  enum Phase { case measuringFinal, searching, preparing, rendering, merging, serializing }
  let fragments: ReportFragments
  let title: String
  let generation: UInt64
  let deadline = ProcessInfo.processInfo.systemUptime + 30
  let document = PDFDocument()
  var phase: Phase = .measuringFinal
  var section = 0
  var row = 0
  var best: (count: Int, renderer: ReportA4PageRenderer)?

  init(fragments: ReportFragments, title: String, generation: UInt64) {
    self.fragments = fragments
    self.title = title
    self.generation = generation
  }
}

/// Fixed A4 geometry without writing UIKit's read-only properties using KVC.
private final class ReportA4PageRenderer: UIPrintPageRenderer {
  override var paperRect: CGRect { CGRect(x: 0, y: 0, width: 595.28, height: 841.89) }
  override var printableRect: CGRect { paperRect.insetBy(dx: 28.35, dy: 28.35) }
}
