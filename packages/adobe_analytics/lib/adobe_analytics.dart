import 'dart:async';

import 'package:flutter/services.dart';

class AdobeAnalytics {
  static const MethodChannel _channel =
      const MethodChannel('adobe_analytics');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
