import 'package:flutter/material.dart';

import 'package:flutter_adobe_experience_platform_plugin/flutter_adobe_experience_platform_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<void> trackAction(String action, Map<String, String> data, {@required BuildContext context}) async {
    final success = await FlutterAdobeExperiencePlatformPlugin.trackAction(action, data);
    print("Action tracking result : ${success ? "success" : "failure"}");
  }

  Future<void> trackState(String state, Map<String, String> data, {@required BuildContext context}) async {
    final success = await FlutterAdobeExperiencePlatformPlugin.trackState(state, data);
    print("State tracking result : ${success ? "success" : "failure"}");
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
                  onPressed: () => trackAction("New action", {"Action value": "Hello world"}, context: context),
                ),
                SizedBox(height: 8),
                RaisedButton(
                  child: Text("Track state"),
                  onPressed: () => trackState("New state", {"State value": "Hello world"}, context: context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
