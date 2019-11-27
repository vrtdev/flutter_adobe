# Flutter Adobe Experience Platform plugin
[![pub package](https://img.shields.io/pub/v/analytics.svg)](https://pub.dartlang.org/packages/flutter_adobe_experience_manager_analytics)
[![Build status](https://img.shields.io/cirrus/github/vrtdev/flutter_adobe_experience_platform/analytics/master)](https://cirrus-ci.com/github/vrtdev/flutter_adobe_experience_platform/analytics/)

This plugin allows bridging between Flutter and [Adobe's Experience Platform](https://github.com/Adobe-Marketing-Cloud/acp-sdks) Analytics extension.

# Requirements

### Android

The AEP SDK supports Android API 14 (Ice Cream Sandwich) and newer.

### iOS

The AEP SDK supports iOS 10 and newer.

# Installation

```yaml
dependencies:
  adobe_experience_platform_analytics: ^0.0.1
```
```shell script
flutter pub get
```
```dart
import 'package:adobe_experience_platform_analytics/adobe_experience_platform_analytics.dart';
```

# Setup

Follow [Adobe's setup guide](https://aep-sdks.gitbook.io/docs/using-mobile-extensions/adobe-analytics).


# Send analytics events

* Track *actions* by calling

`AdobeExperiencePlatform.trackAction(String action, Map<String, String> data)`

* Track *states* by calling

`AdobeExperiencePlatform.trackState(String state, Map<String, String> data)`
  
