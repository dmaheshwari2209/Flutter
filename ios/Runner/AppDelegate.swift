import UIKit
import Flutter
import CleverTapSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    CleverTap.autoIntegrate()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
