import 'dart:async';
import 'package:meta/meta.dart';

import 'package:flutter/services.dart';

const MethodChannel _channel =
    const MethodChannel('flutter_adobe_experience_platform_plugin');

enum AdobeExtension {
  Analytics,
  Campaign,
  Identity,
  Lifecycle,
  Media,
  Signal,
  UserProfile,
}

class FlutterAdobeExperiencePlatformPlugin {
  FlutterAdobeExperiencePlatformPlugin._();

  static Future<bool> configureAdobeCore({@required final String appId}) async {
    return await _channel.invokeMethod('configure', {'appId': appId});
  }

  static Future<bool> startAdobeCore() async {
    return await _channel.invokeMethod('start');
  }

  static Future<bool> registerExtension(AdobeExtension extension) async {
    return await _channel.invokeMethod(
        'registerExtension', {'extension': _extensionName(extension)});
  }

  static String _extensionName(AdobeExtension extension) {
    String extensionName;
    switch (extension) {
      case AdobeExtension.Analytics:
        extensionName = 'analytics';
        break;
      case AdobeExtension.Campaign:
        extensionName = 'campaign';
        break;
      case AdobeExtension.Identity:
        extensionName = 'identity';
        break;
      case AdobeExtension.Lifecycle:
        extensionName = 'lifecycle';
        break;
      case AdobeExtension.Media:
        extensionName = 'media';
        break;
      case AdobeExtension.Signal:
        extensionName = 'signal';
        break;
      case AdobeExtension.UserProfile:
        extensionName = 'userProfile';
        break;
    }
    return extensionName;
  }
}
