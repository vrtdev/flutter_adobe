#import "AdobeAnalyticsPlugin.h"
#import <adobe_analytics/adobe_analytics-Swift.h>

@implementation AdobeAnalyticsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAdobeAnalyticsPlugin registerWithRegistrar:registrar];
}
@end
