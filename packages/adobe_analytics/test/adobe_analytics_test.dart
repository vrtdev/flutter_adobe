import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adobe_analytics/adobe_analytics.dart';
import 'package:meta/meta.dart';

void main() {
  const MethodChannel channel = MethodChannel('adobe_analytics');

  _MethodCallHandler callHandler;
  AdobeAnalytics sut;

  setUp(() {
    sut = AdobeAnalytics();
  });

  setupMockMethodCallHandler({@required final dynamic returnValue}) {
    callHandler = _MethodCallHandler(returnValue: returnValue);
    channel.setMockMethodCallHandler(callHandler.handler);
  }

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  group('Tracking', () {
    test('Track action with context data', () async {
      setupMockMethodCallHandler(returnValue: true);
      final actionName = "testAction";
      final actionData = {"testData": "testDataValue"};
      await sut.trackAction(actionName, data: actionData);
      expect(callHandler.lastMethodCall.method, "track");
      expect(callHandler.lastMethodCall.arguments, {"type": "action", "key": actionName, "data": actionData});
    });

    test('Track action without context data', () async {
      setupMockMethodCallHandler(returnValue: true);
      final actionName = "testAction";
      await sut.trackAction(actionName);
      expect(callHandler.lastMethodCall.method, "track");
      expect(callHandler.lastMethodCall.arguments, {"type": "action", "key": actionName, "data": null});
    });

    test('Track state with context data', () async {
      setupMockMethodCallHandler(returnValue: true);
      final stateName = "testState";
      final stateData = {"testData": "testDataValue"};
      await sut.trackState(stateName, data: stateData);
      expect(callHandler.lastMethodCall.method, "track");
      expect(callHandler.lastMethodCall.arguments, {"type": "state", "key": stateName, "data": stateData});
    });

    test('Track state without context data', () async {
      setupMockMethodCallHandler(returnValue: true);
      final stateName = "testState";
      await sut.trackState(stateName);
      expect(callHandler.lastMethodCall.method, "track");
      expect(callHandler.lastMethodCall.arguments, {"type": "state", "key": stateName, "data": null});
    });
  });

  group('Experience Cloud ID', () {
    test('Get Experience Cloud ID', () async {
      setupMockMethodCallHandler(returnValue: "42");
      await sut.getExperienceCloudId();
      expect(callHandler.lastMethodCall.method, "getExperienceCloudId");
      expect(callHandler.lastMethodCall.arguments, null);
    });
  });
}

class _MethodCallHandler {
  final dynamic returnValue;

  MethodCall _lastMethodCall;

  _MethodCallHandler({this.returnValue});

  MethodCall get lastMethodCall => _lastMethodCall;

  Future<dynamic> handler(MethodCall call) {
    _lastMethodCall = call;
    return Future.value(returnValue);
  }
}
