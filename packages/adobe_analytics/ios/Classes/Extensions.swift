//
//  Extensions.swift
//
//  Created by Kymer Gryson on 02/10/2019.
//

import Foundation

extension Optional{
  func valueOr(throw error: Error) throws -> Wrapped {
    switch self {
    case .some(let value):
      return value
    case .none:
      throw error
    }
  }
}

extension Error {
  var asFlutterError: FlutterError {
    let errorMessage = (self as? PluginError)?.message ?? self.localizedDescription
    return FlutterError(code: "🔥", message: errorMessage, details: "")
  }
}

extension DecodingError {
  func nicelyFormattedErrorMessage() -> String {
    switch self {
    case .dataCorrupted(let context):
      return context.debugDescription
    case .keyNotFound(let key, let context):
      return "\(key.stringValue) was not found: \(context.debugDescription)"
    case .typeMismatch(_ , let context):
      return context.debugDescription
    case .valueNotFound(_ , let context):
      return "no value was found for '\(context.codingPathAsString)': \(context.debugDescription)"
    default:
      return localizedDescription
    }
  }
}

extension DecodingError.Context {
  var codingPathAsString: String { codingPath.map{ $0.stringValue }.joined(separator: ".") }
}
