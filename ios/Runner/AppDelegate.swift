import Flutter
import UIKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var speechBridge: OnDeviceSpeechBridge?
  private var printBridge: HtmlPrintBridge?
  private var appleSubscriptionBridge: AppleSubscriptionBridge?
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    guard let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "NShoptorNativeChannels") else {
      return
    }
    speechBridge?.dispose()
    printBridge?.dispose()
    appleSubscriptionBridge?.dispose()
    speechBridge = OnDeviceSpeechBridge(messenger: registrar.messenger())
    printBridge = HtmlPrintBridge(messenger: registrar.messenger())
    appleSubscriptionBridge = AppleSubscriptionBridge(messenger: registrar.messenger())
  }
}
