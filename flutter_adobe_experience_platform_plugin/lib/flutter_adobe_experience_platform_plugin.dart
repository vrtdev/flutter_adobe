import 'dart:async';

import 'package:flutter/services.dart';

class FlutterAdobeExperiencePlatformPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_adobe_experience_platform_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
