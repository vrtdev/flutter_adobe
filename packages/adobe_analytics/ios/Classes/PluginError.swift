//
//  PluginError.swift
//
//  Created by Kymer Gryson on 02/10/2019.
//

import Foundation

enum PluginError: Error {
  case unhandledMethod(_ call: FlutterMethodCall)
  case missingMethodArguments(for: FlutterMethodCall)
  case argumentsParsingError(for: FlutterMethodCall, message: String)
  
  var message: String {
    switch self {
    case .unhandledMethod(let call):
      return "Method '\(call.method)' not implemented"
    case .missingMethodArguments(let call):
      return "Expected arguments to not be nil for method '\(call.method)'"
    case .argumentsParsingError(let call, let error):
      let errorMessage = """
      Something went wrong when parsing flutter arguments: "\(error)"
      
      \((call.arguments as? [String: Any])?.debugDescription ?? "no arguments")
      
      """
      return errorMessage
    }
  }
}
