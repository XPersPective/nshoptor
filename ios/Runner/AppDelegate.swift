import BackgroundTasks
import Flutter
import UIKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var speechBridge: OnDeviceSpeechBridge?
  private var printBridge: HtmlPrintBridge?
  private var appleSubscriptionBridge: AppleSubscriptionBridge?
  private static let receiptQueueTaskId = "com.crazypenguin.nshoptor.receipt-queue"
  private var backgroundQueueChannel: FlutterMethodChannel?
  private var receiptBackgroundTaskId: UIBackgroundTaskIdentifier = .invalid
  private var scheduleRequested = false

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    BGTaskScheduler.shared.register(
      forTaskWithIdentifier: Self.receiptQueueTaskId,
      using: nil
    ) { [weak self] task in
      guard let processingTask = task as? BGProcessingTask else {
        task.setTaskCompleted(success: false)
        return
      }
      self?.handleReceiptQueueTask(processingTask)
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func applicationDidEnterBackground(_ application: UIApplication) {
    super.applicationDidEnterBackground(application)
    if scheduleRequested {
      beginShortReceiptBackgroundTask()
      submitReceiptProcessingRequest()
    }
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    guard let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "NShoptorNativeChannels") else {
      return
    }
    speechBridge?.dispose()
    printBridge?.dispose()
    appleSubscriptionBridge?.dispose()
    backgroundQueueChannel?.setMethodCallHandler(nil)
    speechBridge = OnDeviceSpeechBridge(messenger: registrar.messenger())
    printBridge = HtmlPrintBridge(messenger: registrar.messenger())
    appleSubscriptionBridge = AppleSubscriptionBridge(messenger: registrar.messenger())
    let queueChannel = FlutterMethodChannel(
      name: "nshoptor/background_queue",
      binaryMessenger: registrar.messenger()
    )
    queueChannel.setMethodCallHandler { [weak self] call, result in
      switch call.method {
      case "scheduleQueue":
        self?.scheduleRequested = true
        self?.beginShortReceiptBackgroundTask()
        self?.submitReceiptProcessingRequest()
        result(nil)
      case "backgroundDrainFinished":
        self?.scheduleRequested = false
        self?.endShortReceiptBackgroundTask()
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
    backgroundQueueChannel = queueChannel
  }

  private func beginShortReceiptBackgroundTask() {
    guard receiptBackgroundTaskId == .invalid else { return }
    receiptBackgroundTaskId = UIApplication.shared.beginBackgroundTask(
      withName: "ReceiptQueueDrain"
    ) { [weak self] in
      self?.endShortReceiptBackgroundTask()
    }
  }

  private func endShortReceiptBackgroundTask() {
    let taskId = receiptBackgroundTaskId
    guard taskId != .invalid else { return }
    receiptBackgroundTaskId = .invalid
    UIApplication.shared.endBackgroundTask(taskId)
  }

  private func submitReceiptProcessingRequest() {
    let request = BGProcessingTaskRequest(identifier: Self.receiptQueueTaskId)
    request.requiresNetworkConnectivity = true
    request.requiresExternalPower = false
    try? BGTaskScheduler.shared.submit(request)
  }

  private func handleReceiptQueueTask(_ task: BGProcessingTask) {
    var completed = false
    var headlessEngine: FlutterEngine?
    var headlessChannel: FlutterMethodChannel?

    func finishOnMain(_ ok: Bool) {
      DispatchQueue.main.async { [weak self] in
        guard !completed else { return }
        completed = true
        if ok {
          self?.scheduleRequested = false
        }
        headlessChannel?.setMethodCallHandler(nil)
        headlessChannel = nil
        headlessEngine?.destroyContext()
        headlessEngine = nil
        task.setTaskCompleted(success: ok)
      }
    }

    task.expirationHandler = {
      finishOnMain(false)
    }

    DispatchQueue.main.async { [weak self] in
      if let liveChannel = self?.backgroundQueueChannel {
        liveChannel.invokeMethod("drainQueue", arguments: nil) { result in
          let ok = (result as? Bool) ?? !(result is FlutterError)
          finishOnMain(ok)
        }
        return
      }

      let engine = FlutterEngine(name: "ReceiptQueueWorker")
      headlessEngine = engine
      let channel = FlutterMethodChannel(
        name: "nshoptor/background_queue",
        binaryMessenger: engine.binaryMessenger
      )
      headlessChannel = channel
      channel.setMethodCallHandler { call, res in
        if call.method == "backgroundDrainFinished" {
          let args = call.arguments as? [String: Any]
          let ok = (args?["ok"] as? Bool) ?? true
          res(nil)
          finishOnMain(ok)
        } else {
          res(FlutterMethodNotImplemented)
        }
      }
      GeneratedPluginRegistrant.register(with: engine)
      if !engine.run(withEntrypoint: "receiptQueueBackgroundMain") {
        finishOnMain(false)
      }
    }
  }
}
