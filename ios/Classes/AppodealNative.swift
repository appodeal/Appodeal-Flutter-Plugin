import Flutter
import Foundation
import Appodeal

internal final class AppodealNative {
    
    internal let adChannel: FlutterMethodChannel
    internal let adListener: Listener
    
    init(registrar: FlutterPluginRegistrar) {
        adChannel = FlutterMethodChannel(name: "appodeal_flutter/native", binaryMessenger: registrar.messenger())
        adListener = Listener(adChannel: adChannel)
    }
    
    internal final class Listener: NSObject, APDNativeAdQueueDelegate, APDNativeAdPresentationDelegate {
        
        private let adChannel: FlutterMethodChannel
        
        fileprivate init(adChannel: FlutterMethodChannel) {
            self.adChannel = adChannel
        }
        
        func adQueueAdIsAvailable(_ adQueue: APDNativeAdQueue, ofCount count: UInt) {
            adChannel.invokeMethod("onNativeLoaded", arguments: nil)
        }
        
        func adQueue(_ adQueue: APDNativeAdQueue, failedWithError error: Error) {
            adChannel.invokeMethod("onNativeFailedToLoad", arguments: nil)
        }
        
        func nativeAdWillLogImpression(_ nativeAd: APDNativeAd) {
            adChannel.invokeMethod("onNativeShown", arguments: nil)
        }
        
        func nativeAdWillLogUserInteraction(_ nativeAd: APDNativeAd) {
            adChannel.invokeMethod("onNativeClicked", arguments: nil)
        }
        
        func nativeAdDidExpired(_ nativeAd: APDNativeAd) {
            adChannel.invokeMethod("onNativeExpired", arguments: nil)
        }
    }
}
