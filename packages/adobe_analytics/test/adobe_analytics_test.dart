import 'package:flutter_test/flutter_test.dart';
import 'package:adobe_analytics/adobe_analytics.dart';
import 'package:mockito/mockito.dart';
import 'mocks/adobe_analytics_mock.dart';

void main() {
  MethodChannelMock methodChannelMock;
  AdobeAnalytics sut;

  setUp(() {
    methodChannelMock = MethodChannelMock();
    sut = AdobeAnalytics.testable(methodChannelMock);
  });

  group('Tracking', () {
    test('Track action with context data', () async {
      final actionName = "testAction";
      final actionData = {"testData": "testDataValue"};
      await sut.trackAction(actionName, data: actionData);
      verify(methodChannelMock.invokeMethod("track", {"type": "action", "key": actionName, "data": actionData}));
    });

    test('Track action without context data', () async {
      final actionName = "testAction";
      await sut.trackAction(actionName);
      verify(methodChannelMock.invokeMethod("track", {"type": "action", "key": actionName, "data": null}));
    });

    test('Track state with context data', () async {
      final stateName = "testState";
      final stateData = {"testData": "testDataValue"};
      await sut.trackState(stateName, data: stateData);
      verify(methodChannelMock.invokeMethod("track", {"type": "state", "key": stateName, "data": stateData}));
    });

    test('Track state without context data', () async {
      final stateName = "testState";
      await sut.trackState(stateName);
      verify(methodChannelMock.invokeMethod("track", {"type": "state", "key": stateName, "data": null}));
    });
  });

  group('Experience Cloud ID', () {
    test('Get Experience Cloud ID', () async {
      await sut.getExperienceCloudId();
      verify(methodChannelMock.invokeMethod("getExperienceCloudId"));
    });
  });

  group('Visitor info', () {
    test('Append visitor info to URL', () async {
      final url = "https://flutter.dev";
      await sut.appendVisitorInfo(url);
      verify(methodChannelMock.invokeMethod("appendVisitorInfo", {"url": url}));
    });
  });
}
