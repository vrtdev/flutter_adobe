import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adobe_analytics/adobe_analytics.dart';

void main() {
  const MethodChannel channel = MethodChannel('adobe_analytics');

  _MethodCallHandler callHandler;
  AdobeAnalytics sut;

  setUp(() {
    sut = AdobeAnalytics();
    callHandler = _MethodCallHandler();
    channel.setMockMethodCallHandler(callHandler.handler);
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  group('Tracking', () {
    test('Track action', () async {
      final actionName = "testAction";
      final actionData = {"testData": "testDataValue"};
      await sut.trackAction(actionName, actionData);
      expect(callHandler.lastMethodCall.method, "track");
      expect(callHandler.lastMethodCall.arguments, {"type": "action", "key": actionName, "data": actionData});
    });

    test('Track state', () async {
      final stateName = "testState";
      final stateData = {"testData": "testDataValue"};
      await sut.trackState(stateName, stateData);
      expect(callHandler.lastMethodCall.method, "track");
      expect(callHandler.lastMethodCall.arguments, {"type": "state", "key": stateName, "data": stateData});
    });
  });
}

class _MethodCallHandler {
  MethodCall _lastMethodCall;

  MethodCall get lastMethodCall => _lastMethodCall;

  Future<dynamic> handler(MethodCall call) {
    _lastMethodCall = call;
    return Future.value(true);
  }
}
