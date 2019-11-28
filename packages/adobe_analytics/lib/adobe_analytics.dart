import 'dart:async';

import 'package:flutter/services.dart';

class AdobeAnalytics {
  static const MethodChannel _channel = const MethodChannel('adobe_analytics');

  static Future<bool> trackAction(String action, Map<String, String> contextData) =>
      _channel.invokeMethod('track', {'type': 'action', 'key': action, 'data': contextData});

  static Future<bool> trackState(String action, Map<String, String> contextData) =>
      _channel.invokeMethod('track', {'type': 'state', 'key': action, 'data': contextData});
}
