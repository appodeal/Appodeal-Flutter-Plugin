import Foundation
import Appodeal

extension SwiftAppodealFlutterPlugin: AppodealBannerDelegate {
    
    public func bannerDidLoadAdIsPrecache(_ precache: Bool) {
        let args: [String: Any] = [
            "isPrecache": precache]
        channel?.invokeMethod("onBannerLoaded", arguments: args)
    }
    
    public func bannerDidShow() {
        channel?.invokeMethod("onBannerShown", arguments: nil)
    }
    
    public func bannerDidFailToLoadAd() {
        channel?.invokeMethod("onBannerFailedToLoad", arguments: nil)
    }
    
    public func bannerDidClick() {
        channel?.invokeMethod("onBannerClicked", arguments: nil)
    }
    
    public func bannerDidExpired() {
        channel?.invokeMethod("onBannerExpired", arguments: nil)
    }
    
}
