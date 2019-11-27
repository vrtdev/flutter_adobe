import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_adobe_experience_platform_plugin/flutter_adobe_experience_platform_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_adobe_experience_platform_plugin');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
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

  test('Track action', () async {
    expect(await AdobeExperiencePlatform.trackAction("actionName", {"hello": "world"}), true);
  });

  test('Track state', () async {
    expect(await AdobeExperiencePlatform.trackState("stateName", {"hello": "world"}), true);
  });
}
