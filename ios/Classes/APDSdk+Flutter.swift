import Appodeal
import Flutter
import Foundation
import StackFoundation


extension APDSdk {
    
    private static var channelKey: UInt8 = 0
    
    var channel: FlutterMethodChannel? {
        get { objc_getAssociatedObject(self, &APDSdk.channelKey) as? FlutterMethodChannel }
        set { objc_setAssociatedObject(self, &APDSdk.channelKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
    
    static func swizzle() {
        let originalSelector = NSSelectorFromString("trackImpression:customInfo:adQueueRequest:")
        let swizzledSelector = #selector(fl_trackImpression(trackImpression:customInfo:adQueueRequest:))
        
        let originalMethod = class_getInstanceMethod(APDSdk.self, originalSelector)!
        let swizzledMethod = class_getInstanceMethod(APDSdk.self, swizzledSelector)!
        
        
        let didAddMethod: Bool = class_addMethod(
            APDSdk.self,
            originalSelector,
            method_getImplementation(swizzledMethod),
            method_getTypeEncoding(swizzledMethod)
        )
        
        if didAddMethod {
            class_replaceMethod(
                APDSdk.self,
                swizzledSelector,
                method_getImplementation(originalMethod),
                method_getTypeEncoding(originalMethod)
            )
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    @objc dynamic func fl_trackImpression(
        trackImpression: AnyObject,
        customInfo: [String: Any],
        adQueueRequest: Int
    ) {
        fl_trackImpression(
            trackImpression: trackImpression,
            customInfo: customInfo,
            adQueueRequest: adQueueRequest
        )
        
        let eCPM = trackImpression.value(forKey: "eCPM") as? Double ?? 0.0
        let networkName = trackImpression.value(forKey: "networkName") as? String
        let adUnitName = trackImpression.value(forKey:"adItemName") as? String
        var adType = "unknown"
        if adQueueRequest == 1 {
            adType = "banner"
        } else if adQueueRequest == 2 {
            adType = "mrec"
        } else if adQueueRequest == 3 {
            adType = "interstitial"
        } else if adQueueRequest == 4 {
            adType = "rewarded"
        } else if adQueueRequest == 5 {
            adType = "native"
        }
        
        channel?.invokeMethod(
            "onImpression",
            arguments: [
                "adType": adType,
                "networkName" : networkName,
                "adUnitName" : adUnitName,
                "loadedEcpm" : eCPM
            ]
        )
    }
    
}


extension Appodeal {
    static func registerForAdRevenueTracking() {
        APDSdk.swizzle()
    }
}
