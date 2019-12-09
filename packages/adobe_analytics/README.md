# Adobe Analytics

Bridges Flutter to [Adobe's Analytics SDK](https://github.com/Adobe-Marketing-Cloud/acp-sdks).

# Installation

```yaml
dependencies:
  adobe_analytics: ^0.0.1
```
```shell script
flutter pub get
```
```dart
import 'package:adobe_analytics/adobe_analytics.dart';
```

## Getting Started

Adobe SDKs setup reference : https://aep-sdks.gitbook.io/docs/getting-started/initialize-the-sdk

### Android

Add the following code to your Application's `override fun onCreate()` :

```kotlin
// 1. Set ACPCore's log level
MobileCore.setLogLevel(LoggingMode.VERBOSE) // Optional

// 2. Configure ACPCore with your Adobe Environment ID
MobileCore.setApplication(application)
MobileCore.configureWithAppID("<Your Adobe Environment ID>")

// 3. Register Analytics & Identity extensions 
try {
    Analytics.registerExtension()
    Identity.registerExtension()
} catch (e: Exception) {
    Log.e("Error", e.message)
}

// 4. Start ACPCore
MobileCore.start(null)
```

### iOS

Add the following code to your AppDelegate's `application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)` :

```swift
// 1. Set ACPCore's log level
ACPCore.setLogLevel(.verbose)   // Optional

// 2. Configure ACPCore with your Adobe Environment ID
ACPCore.configure(withAppId: "<Your Adobe Environment ID>")

// 3. Register ACPAnalytics & ACPIdentity extensions
ACPAnalytics.registerExtension()
ACPIdentity.registerExtension()

// 4. Start ACPCore
ACPCore.start(nil)
```
