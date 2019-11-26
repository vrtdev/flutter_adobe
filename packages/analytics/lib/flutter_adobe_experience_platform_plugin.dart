import 'dart:async';
import 'package:meta/meta.dart';

import 'package:flutter/services.dart';

const MethodChannel _channel =
    const MethodChannel('flutter_adobe_experience_platform_plugin');

class FlutterAdobeExperiencePlatformPlugin {
  FlutterAdobeExperiencePlatformPlugin._();

  static Future<bool> configureAdobeCore({@required final String appId}) async {
    return await _channel.invokeMethod('configure', {'appId': appId});
  }
}
