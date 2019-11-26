#import "FlutterAdobeExperiencePlatformPlugin.h"
#import <flutter_adobe_experience_platform_plugin/flutter_adobe_experience_platform_plugin-Swift.h>

@implementation FlutterAdobeExperiencePlatformPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAdobeExperiencePlatformPlugin registerWithRegistrar:registrar];
}
@end
