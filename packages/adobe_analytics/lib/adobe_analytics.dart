import 'dart:async';

import 'package:flutter/services.dart';

class AdobeAnalytics {
  static const MethodChannel _channel = const MethodChannel('adobe_analytics');

  /// Track a new action with optional context data. Make sure ACPCore has been configured, and both ACPAnalytics and ACPIdentity
  /// have been registered before calling this method.
  Future<bool> trackAction(String action, {Map<String, String> data}) =>
      _channel.invokeMethod('track', {'type': 'action', 'key': action, 'data': data});

  /// Track a new state with optional context data. Make sure ACPCore has been configured, and both ACPAnalytics and ACPIdentity
  /// have been registered before calling this method.
  Future<bool> trackState(String action, {Map<String, String> data}) =>
      _channel.invokeMethod('track', {'type': 'state', 'key': action, 'data': data});

  /// Retrieves the Experience Cloud ID.
  Future<String> getExperienceCloudId() => _channel.invokeMethod('getExperienceCloudId');
}
