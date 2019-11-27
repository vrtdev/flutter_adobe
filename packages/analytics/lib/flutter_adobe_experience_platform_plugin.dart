import 'dart:async';

import 'package:flutter/services.dart';

const MethodChannel _channel = const MethodChannel('flutter_adobe_experience_platform_plugin');

enum AdobeExtension {
  Analytics,
  Campaign,
  Identity,
  Lifecycle,
  Media,
  Signal,
  UserProfile,
}

class AdobeExperiencePlatform {
  AdobeExperiencePlatform._();

  static Future<bool> trackAction(String action, Map<String, String> data) async {
    return await _channel.invokeMethod('track', {'type': 'action', 'key': action, 'data': data});
  }

  static Future<bool> trackState(String state, Map<String, String> data) async {
    return await _channel.invokeMethod('track', {'type': 'action', 'key': state, 'data': data});
  }
}
