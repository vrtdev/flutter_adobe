//
//  FlutterArguments.swift
//
//  Created by Kymer Gryson on 02/10/2019.
//

import Foundation

protocol FlutterArguments: Decodable {
  init(from call: FlutterMethodCall) throws
}

extension FlutterArguments {
  init(from call: FlutterMethodCall) throws {
    let arguments = try call.arguments.valueOr(throw: PluginError.missingMethodArguments(for: call))
    
    do {
      let data = try JSONSerialization.data(withJSONObject: arguments, options: [])
      self = try JSONDecoder().decode(Self.self, from: data)
    } catch let decodingError as DecodingError {
      throw PluginError.argumentsParsingError(for: call, message: decodingError.nicelyFormattedErrorMessage())
    } catch {
      throw PluginError.argumentsParsingError(for: call, message: error.localizedDescription)
    }
  }
}

struct TrackingArguments: FlutterArguments {
  let type: String
  let key: String
  let contextData: [String: String]?
}
