//
//  PluginMethod.swift
//
//  Created by Kymer Gryson on 02/10/2019.
//

import Foundation

enum PluginMethod {
  case trackAction(TrackingArguments)
  case trackState(TrackingArguments)
  case getExperienceCloudId
  
  public init(from call: FlutterMethodCall) throws {
    switch call.method {
    case "track":
      let arguments = try TrackingArguments(from: call)
      switch arguments.type {
      case "action":
        self = .trackAction(arguments)
      case "state":
        self = .trackState(arguments)
      default:
        throw PluginError.argumentsParsingError(for: call, message: "Invalid tracking type")
      }
    case "getExperienceCloudId":
      self = .getExperienceCloudId
    default:
      throw PluginError.unhandledMethod(call)
    }
    
  }
}
