import Flutter
import UIKit
import ACPCore
import ACPAnalytics

public class SwiftAdobeAnalyticsPlugin: NSObject, FlutterPlugin {
  
  private enum Method: String {
    case track
  }
  
  private enum TrackingType: String {
    case action
    case state
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
  
}

//MARK: - FlutterPlugin conformance

extension SwiftAdobeAnalyticsPlugin {
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "adobe_analytics", binaryMessenger: registrar.messenger())
    let instance = SwiftAdobeAnalyticsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case Method.track.rawValue:
      guard let (type, key, contextData) = parseTrackingArgs(call.arguments) else {
        result(FlutterError(code: "-1", message: "Invalid args (expected 'data' (Dictionary) and 'action' (String))", details: nil))
        return
      }
      switch type {
      case TrackingType.action:
        ACPCore.trackAction(key, data: contextData)
      case TrackingType.state:
        ACPCore.trackState(key, data: contextData)
      }
      result(true)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
}

//MARK: - Helpers

extension SwiftAdobeAnalyticsPlugin {
  
  private func parseTrackingArgs(_ args: Any?) -> (type: TrackingType, key: String, data: [String: String])? {
    guard
      let args = args as? [String: Any],
      let type: String = args["type"] as? String,
      let key: String = args["key"] as? String,
      let contextData: [String: String] = args["data"] as? [String: String]
      else {
        return nil
    }
    switch type {
    case TrackingType.action.rawValue:
      return (type: .action, key: key, data: contextData)
    case TrackingType.state.rawValue:
      return (type: .state, key: key, data: contextData)
    default:
      return nil
    }
  }
  
}
