import Foundation
import Appodeal

extension SwiftAppodealFlutterPlugin: AppodealRewardedVideoDelegate {
    
    public func rewardedVideoDidLoadAdIsPrecache(_ precache: Bool) {
        let args: [String: Any] = [
            "isPrecache": precache
        ]
        channel?.invokeMethod("onRewardedVideoLoaded", arguments: args)
    }
    
    
    public func rewardedVideoDidFailToLoadAd() {
        channel?.invokeMethod("onRewardedVideoFailedToLoad", arguments: nil)
    }
    
    public func rewardedVideoDidFailToPresentWithError(_ error: Error) {
        channel?.invokeMethod("onRewardedVideoShowFailed", arguments: nil)
    }
    
    
    public func rewardedVideoDidPresent() {
        channel?.invokeMethod("onRewardedVideoShown", arguments: nil)
    }
    
    
    public func rewardedVideoWillDismissAndWasFullyWatched(_ wasFullyWatched: Bool) {
        let args: [String: Any] = [
            "isFinished": wasFullyWatched
        ]
        channel?.invokeMethod("onRewardedVideoClosed", arguments: args)
    }
    
    public  func rewardedVideoDidFinish(_ rewardAmount: Float, name rewardName: String?) {
        if(rewardName != nil){
            let args: [String: Any] = [
                "amount": rewardAmount,
                "reward": rewardName as Any
            ]
            channel?.invokeMethod("onRewardedVideoFinished", arguments: args)
        }else {
            let args: [String: Any] = [
                "amount": 0.0,
                "reward": "empty"
            ]
            channel?.invokeMethod("onRewardedVideoFinished", arguments: args)
        }
        
    }
    
    public func rewardedVideoDidClick() {
        channel?.invokeMethod("onRewardedVideoClicked", arguments: nil)
    }
    
    
    public func rewardedVideoDidExpired(){
        channel?.invokeMethod("onRewardedVideoExpired", arguments: nil)
    }
    
}
