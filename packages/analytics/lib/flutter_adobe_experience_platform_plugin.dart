import 'dart:async';

import 'package:flutter/services.dart';

const MethodChannel _channel = const MethodChannel('flutter_adobe_experience_platform_plugin');

class AdobeExperiencePlatform {
  AdobeExperiencePlatform._();

  /// Track a new action. Requires ACPCore to be configured and the ACPAnalytics extension to be registered.
  static Future<bool> trackAction(String action, Map<String, String> data) async {
    return await _channel.invokeMethod('track', {'type': 'action', 'key': action, 'data': data});
  }

  /// Track a new state. Requires ACPCore to be configured and the ACPAnalytics extension to be registered.
  static Future<bool> trackState(String state, Map<String, String> data) async {
    return await _channel.invokeMethod('track', {'type': 'action', 'key': state, 'data': data});
  }
}
