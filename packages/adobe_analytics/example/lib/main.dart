import 'package:flutter/material.dart';

import 'package:adobe_analytics/adobe_analytics.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AdobeAnalytics _adobeAnalytics = AdobeAnalytics();

  String _experienceCloudId;

  Future<void> trackAction(String action, {Map<String, String> data}) async {
    final success = await _adobeAnalytics.trackAction(action, data: data);
    print("Action tracking result : ${success ? "success" : "failure"}");
  }

  Future<void> trackState(String state, {Map<String, String> data}) async {
    final success = await _adobeAnalytics.trackState(state, data: data);
    print("State tracking result : ${success ? "success" : "failure"}");
  }

  Future<void> getExperienceCloudId() async {
    final experienceCloudId = await _adobeAnalytics.getExperienceCloudId();
    print("Experience Cloud ID : $experienceCloudId");
    setState(() {
      _experienceCloudId = experienceCloudId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("Track action"),
                  onPressed: () => trackAction("New action", data: {"Action value": "Hello world"}),
                ),
                SizedBox(height: 8),
                RaisedButton(
                  child: Text("Track state"),
                  onPressed: () => trackState("New state", data: {"State value": "Hello world"}),
                ),
                SizedBox(height: 8),
                RaisedButton(
                  child: Text("Get Experience Cloud ID"),
                  onPressed: () => getExperienceCloudId(),
                ),
                Text("Experience Cloud ID : ${_experienceCloudId ?? "unknown"}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
