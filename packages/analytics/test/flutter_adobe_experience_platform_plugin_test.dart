import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_adobe_experience_platform_plugin/flutter_adobe_experience_platform_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_adobe_experience_platform_plugin');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'configure') {
        return true;
      }
      if (methodCall.method == 'start') {
        return true;
      }
      if (methodCall.method == 'registerExtension') {
        return true;
      }
      if (methodCall.method == 'trackAction') {
        return true;
      }
      if (methodCall.method == 'trackState') {
        return true;
      }
      return false;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('Configure Core', () async {
    expect(await FlutterAdobeExperiencePlatformPlugin.configureAdobeCore(appId: '42'), true);
  });

  test('Start Core', () async {
    expect(await FlutterAdobeExperiencePlatformPlugin.startAdobeCore(), true);
  });

  test('Register Extension', () async {
    expect(await FlutterAdobeExperiencePlatformPlugin.registerExtension(AdobeExtension.Analytics), true);
  });

  test('Track action', () async {
    expect(await FlutterAdobeExperiencePlatformPlugin.trackAction("actionName", {"hello": "world"}), true);
  });

  test('Track state', () async {
    expect(await FlutterAdobeExperiencePlatformPlugin.trackState("stateName", {"hello": "world"}), true);
  });
}
