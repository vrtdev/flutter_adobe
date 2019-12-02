import 'dart:async';

import 'package:flutter/services.dart';

class AdobeAnalytics {
  static const MethodChannel _channel = const MethodChannel('adobe_analytics');

  /// Track a new action. Make sure ACPCore has been configured, and both ACPAnalytics and ACPIdentity
  /// have been registered before calling this method.
  Future<bool> trackAction(String action, Map<String, String> contextData) =>
      _channel.invokeMethod('track', {'type': 'action', 'key': action, 'data': contextData});

  /// Track a new state. Make sure ACPCore has been configured, and both ACPAnalytics and ACPIdentity
  /// have been registered before calling this method.
  Future<bool> trackState(String action, Map<String, String> contextData) =>
      _channel.invokeMethod('track', {'type': 'state', 'key': action, 'data': contextData});
}
