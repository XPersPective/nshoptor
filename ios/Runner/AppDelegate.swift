import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var speechBridge: OnDeviceSpeechBridge?
  private var printBridge: HtmlPrintBridge?
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    guard let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "NShoptorNativeChannels") else {
      return
    }
    speechBridge?.dispose()
    printBridge?.dispose()
    speechBridge = OnDeviceSpeechBridge(messenger: registrar.messenger())
    printBridge = HtmlPrintBridge(messenger: registrar.messenger())
  }
}
