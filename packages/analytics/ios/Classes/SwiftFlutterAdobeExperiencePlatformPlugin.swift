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
      ACPCore.setLogLevel(ACPMobileLogLevel.verbose)
      ACPCore.configure(withAppId: appId)
      result(true)
    case Method.start.rawValue:
      ACPCore.start {
        result(true)
      }
    case Method.registerExtension.rawValue:
      guard
        let args = call.arguments as? [String: String],
        let extensionName = args["extension"],
        let extensionClass = extensionClass(for: extensionName)
        else {
          result(FlutterError(code: "-1", message: "Invalid args (expected 'extension')", details: nil))
          return
      }
      try! ACPCore.registerExtension(extensionClass)
      result(true)
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
  
  private func extensionClass(for extensionName: String) -> AnyClass? {
    let extensionClass: AnyClass?
    switch extensionName {
    case "analytics":
      extensionClass = ACPAnalytics.self
    case "campaign":
      extensionClass = ACPCampaign.self
    case "identity":
      extensionClass = ACPIdentity.self
    case "lifecycle":
      extensionClass = ACPLifecycle.self
    case "media":
      extensionClass = ACPMedia.self
    case "signal":
      extensionClass = ACPSignal.self
    case "userProfile":
      extensionClass = ACPUserProfile.self
    default:
      extensionClass = nil
    }
    return extensionClass
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
