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
    case trackAction
    case trackState
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
        result(true)
      case AdobeExtensionName.campaign.rawValue:
        ACPCampaign.registerExtension()
        result(true)
      case AdobeExtensionName.identity.rawValue:
        ACPIdentity.registerExtension()
        result(true)
      case AdobeExtensionName.lifecycle.rawValue:
        ACPLifecycle.registerExtension()
        result(true)
      case AdobeExtensionName.media.rawValue:
        ACPMedia.registerExtension()
        result(true)
      case AdobeExtensionName.signal.rawValue:
        ACPSignal.registerExtension()
        result(true)
      case AdobeExtensionName.userProfile.rawValue:
        ACPUserProfile.registerExtension()
        result(true)
      default:
        result(FlutterError(code: "-1", message: "Invalid args (invalid extension name)", details: nil))
      }
    case Method.trackAction.rawValue:
      guard let (action, contextData) = parseActionTrackingArgs(call.arguments) else {
          result(FlutterError(code: "-1", message: "Invalid args (expected 'data' (Dictionary) and 'action' (String))", details: nil))
          return
      }
      ACPCore.trackAction(action, data: contextData)
      result(true)
    case Method.trackState.rawValue:
      guard let (state, contextData) = parseStateTrackingArgs(call.arguments) else {
          result(FlutterError(code: "-1", message: "Invalid args (expected 'data' (Dictionary) and 'state' (String))", details: nil))
          return
      }
      ACPCore.trackState(state, data: contextData)
      result(true)
    default:
      result(FlutterMethodNotImplemented)
    }
    
  }
  
  private func parseActionTrackingArgs(_ args: Any?) -> (action: String, data: [String: String])? {
    guard
      let args = args as? [String: Any],
      let contextData: [String: String] = args["data"] as? [String: String],
      let action: String = args["action"] as? String
      else {
        return nil
    }
    return (action: action, data: contextData)
  }
  
  private func parseStateTrackingArgs(_ args: Any?) -> (state: String, data: [String: String])? {
    guard
      let args = args as? [String: Any],
      let contextData: [String: String] = args["data"] as? [String: String],
      let state: String = args["state"] as? String
      else {
        return nil
    }
    return (state: state, data: contextData)
  }
  
}
