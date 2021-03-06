#import "AppodealFlutterPlugin.h"
#if __has_include(<stack_appodeal_flutter/stack_appodeal_flutter-Swift.h>)
#import <stack_appodeal_flutter/stack_appodeal_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "stack_appodeal_flutter-Swift.h"
#endif

@implementation AppodealFlutterPlugin
+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    [SwiftAppodealFlutterPlugin registerWithRegistrar:registrar];
}
@end
