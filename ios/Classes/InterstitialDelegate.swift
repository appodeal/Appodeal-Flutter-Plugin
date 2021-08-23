//
//  InterstitialDelegate.swift
//  appodeal_flutter
//
//  Created by Artyom Kul on 13.08.21.
//

import Foundation
import Appodeal

extension SwiftAppodealFlutterPlugin: AppodealInterstitialDelegate {
    public func interstitialDidLoadAdIsPrecache(_ precache: Bool) {
        let args: [String: Any] = [
                "isPrecache": precache
            ]
        channel?.invokeMethod("onInterstitialLoaded", arguments: args)
        
    }

    public func interstitialDidFailToLoadAd() {
        channel?.invokeMethod("onInterstitialFailedToLoad", arguments: nil)
    }

    public func interstitialWillPresent() {
        channel?.invokeMethod("onInterstitialShown", arguments: nil)
    }

    public func interstitialDidFailToPresent() {
        channel?.invokeMethod("onInterstitialShowFailed", arguments: nil)
    }

    public func interstitialDidClick() {
        channel?.invokeMethod("onInterstitialClicked", arguments: nil)
    }

    public func interstitialDidDismiss() {
        channel?.invokeMethod("onInterstitialClosed", arguments: nil)
    }

    public func interstitialDidExpired() {
        channel?.invokeMethod("onInterstitialExpired", arguments: nil)
    }
}
