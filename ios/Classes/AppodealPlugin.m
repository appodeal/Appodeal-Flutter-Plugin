#import "AppodealPlugin.h"
#if __has_include(<appodeal/appodeal-Swift.h>)
#import <appodeal/appodeal-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "appodeal-Swift.h"
#endif

@implementation AppodealPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAppodealPlugin registerWithRegistrar:registrar];
}
@end
