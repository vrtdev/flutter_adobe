import Flutter
import UIKit
import ACPCore
import ACPAnalytics
import ACPCampaign
import ACPMedia
import ACPUserProfile

public class SwiftFlutterAdobeExperiencePlatformPlugin: NSObject, FlutterPlugin {
  
  private enum Method: String {
    case configure
    case start
    case registerExtension
  }
  
  private enum AdobeExtensionName: String {
    case analytics
    case campaign
    case identity
    case lifecycle
    case media
    case signal
    case userProfile
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
      result(true)
    case Method.start.rawValue:
      ACPCore.start {
        result(true)
      }
    case Method.registerExtension.rawValue:
      guard let args = call.arguments as? [String: String], let extensionName = args["extension"] else {
        result(FlutterError(code: "-1", message: "Invalid args (expected 'extension')", details: nil))
        return
      }
      switch extensionName {
      case AdobeExtensionName.analytics.rawValue:
        ACPAnalytics.registerExtension()
      case AdobeExtensionName.campaign.rawValue:
        ACPCampaign.registerExtension()
      case AdobeExtensionName.identity.rawValue:
        ACPIdentity.registerExtension()
      case AdobeExtensionName.lifecycle.rawValue:
        ACPLifecycle.registerExtension()
      case AdobeExtensionName.media.rawValue:
        ACPMedia.registerExtension()
      case AdobeExtensionName.signal.rawValue:
        ACPSignal.registerExtension()
      case AdobeExtensionName.userProfile.rawValue:
        ACPUserProfile.registerExtension()
      default:
        result(FlutterError(code: "-1", message: "Invalid args (invalid extension name)", details: nil))
      }
    default:
      result(FlutterMethodNotImplemented)
    }
    
  }
}
