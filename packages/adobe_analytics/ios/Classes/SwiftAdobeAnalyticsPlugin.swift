import Flutter
import UIKit
import ACPCore
import ACPAnalytics

public protocol AdobeAnalyticsProtocol {
  func trackAction(_ action: String, data: [String: String]?)
  func trackState(_ state: String, data: [String: String]?)
  func getExperienceCloudId(completion: @escaping (String?) -> Void)
  func appendVisitorInfo(to url: URL, completion: @escaping (String) -> Void)
}

public class SwiftAdobeAnalyticsPlugin: NSObject, FlutterPlugin {
  
  private enum Method: String {
    case track
    case getExperienceCloudId
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
    do {
      switch try PluginMethod(from: call) {
      case .trackAction(let arguments):
        trackAction(arguments.key, data: arguments.data)
        result(true)
      case .trackState(let arguments):
        trackState(arguments.key, data: arguments.data)
        result(true)
      case .appendVisitorInfo(let arguments):
        appendVisitorInfo(to: arguments.url) { appendedUrl in
          result(appendedUrl)
        }
      case .getExperienceCloudId:
        ACPIdentity.getExperienceCloudId { experienceCloudId in
          result(experienceCloudId)
        }
      }
    } catch {
      result(error.asFlutterError)
    }
  }
}

//MARK: - AdobeAnalyticsProtocol conformance

extension SwiftAdobeAnalyticsPlugin: AdobeAnalyticsProtocol {
  
  public func trackAction(_ action: String, data: [String : String]?) {
    if (UIApplication.shared.applicationState != .background) {
        ACPCore.trackAction(action, data: data)
    }
  }
  
  public func trackState(_ state: String, data: [String : String]?) {
    if (UIApplication.shared.applicationState != .background) {
        ACPCore.trackState(state, data: data)
    }
  }
  
  public func appendVisitorInfo(to url: URL, completion: @escaping (String) -> Void) {
    ACPIdentity.append(to: url) { updatedURL in
      completion(updatedURL?.absoluteString ?? url.absoluteString)
    }
  }
  
  public func getExperienceCloudId(completion: @escaping (String?) -> Void) {
    ACPIdentity.getExperienceCloudId { experienceCloudId in
      completion(experienceCloudId)
    }
  }
  
}
