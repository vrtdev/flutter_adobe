import 'package:flutter/material.dart';

import 'package:flutter_adobe_experience_platform_plugin/flutter_adobe_experience_platform_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: MaterialButton(
            child: Text("Setup analytics"),
            onPressed: () =>
                FlutterAdobeExperiencePlatformPlugin.configureAdobeCore(
                    appId: '42'),
          ),
        ),
      ),
    );
  }
}
