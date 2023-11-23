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

internal var nativeAdViewBinders: [String: NativeAdViewBinder] = [:]

public extension Appodeal {
    @objc class func registerNativeAdBinder(binderId: String,
                                            nativeAdViewBinder: NativeAdViewBinder) -> Bool {
        if nativeAdViewBinders[binderId] != nil {
            NSLog("A NativeAdViewBinder with the following binderId already exists: %@", binderId)
            return false
        }
        
        nativeAdViewBinders[binderId] = nativeAdViewBinder
        return true
    }
    
    @objc class func unregisterNativeAdBinder(binderId: String) -> NativeAdViewBinder? {
        let binder = nativeAdViewBinders[binderId]
        if binder != nil {
            nativeAdViewBinders.removeValue(forKey: binderId)
        }
        return binder
    }
}
