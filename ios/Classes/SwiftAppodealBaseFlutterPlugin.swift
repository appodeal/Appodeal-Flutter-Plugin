import Foundation
import Appodeal

extension SwiftAppodealFlutterPlugin: AppodealInitializationDelegate {
    
    public func appodealSDKDidInitialize() {
        channel.invokeMethod("onInitializationFinished", arguments: nil)
    }
}
