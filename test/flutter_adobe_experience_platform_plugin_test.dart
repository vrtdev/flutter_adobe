import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_adobe_experience_platform_plugin/flutter_adobe_experience_platform_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_adobe_experience_platform_plugin');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterAdobeExperiencePlatformPlugin.platformVersion, '42');
  });
}
