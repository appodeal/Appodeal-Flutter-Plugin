import Foundation
import StackConsentManager.Private
import Appodeal

extension SwiftAppodealFlutterPlugin: AppodealInitializationDelegate, STKConsentManagerDisplayDelegate {
    
    public func appodealSDKDidInitialize() {
        channel.invokeMethod("onInitializationFinished", arguments: nil)
    }
    
    public func consentManagerWillShowDialog(_ consentManager: STKConsentManager) {
        channel.invokeMethod("onConsentFormOpened", arguments: nil)
    }
    
    public func consentManager(_ consentManager: STKConsentManager, didFailToPresent error: Error) {
        let args: [String: [String]] = ["errors": [error.localizedDescription]]
        channel.invokeMethod("onConsentFormShowFailed", arguments: args)
    }
    
    public func consentManagerDidDismissDialog(_ consentManager: STKConsentManager) {
        channel.invokeMethod("onConsentFormClosed", arguments: nil)
    }
}
