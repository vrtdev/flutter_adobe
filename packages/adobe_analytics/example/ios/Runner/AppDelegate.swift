import UIKit
import Flutter
import ACPCore
import ACPAnalytics

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

  override func application(_ application: UIApplication,
                            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    GeneratedPluginRegistrant.register(with: self)

    ACPCore.setLogLevel(ACPMobileLogLevel.verbose)
    ACPCore.configure(withAppId: "<Your Adobe AppID>")
    ACPAnalytics.registerExtension()
    ACPIdentity.registerExtension()
    ACPCore.start(nil)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)

  }
}
