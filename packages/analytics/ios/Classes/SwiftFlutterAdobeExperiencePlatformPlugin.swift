import Flutter
import UIKit
import ACPCore

public class SwiftFlutterAdobeExperiencePlatformPlugin: NSObject, FlutterPlugin {

  private enum Method: String {
    case configure
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_adobe_experience_platform_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterAdobeExperiencePlatformPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case Method.configure.rawValue:
      guard let args = call.arguments as? [String: String], let appId = args["appId"] else {
        result(FlutterError(code: "-1", message: "Invalid args", details: nil))
        return
      }
      ACPCore.configure(withAppId: appId)
      print("Debug - ACPCore successfully configured.")
      result(true)
    default:
      result(FlutterMethodNotImplemented)
    }

  }
}
