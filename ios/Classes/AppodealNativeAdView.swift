import Appodeal
import Flutter
import Foundation

internal final class AppodealNativeAdView: NSObject, FlutterPlatformView {
    
    private let frame: CGRect
    private let viewId: Int64
    private let args: [String: Any]
    
    private var nativeAdView: UIView?
    
    init(frame: CGRect,viewId: Int64,args: [String: Any]) {
        self.frame = frame
        self.viewId = viewId
        self.args = args
    }
    
    func view() -> UIView {
        getOrSetupNativeAdView()
    }
    
    private func getOrSetupNativeAdView() -> UIView {
        if let nativeAdView = nativeAdView {
            return nativeAdView
        }
        if let binderId = args["binderId"] as? String,
           let binder = nativeAdViewBinders[binderId] {
            return binder.bind()
        } else {
            assertionFailure("Native Ad type doesn't support or missing binder")
            return UIView()
        }
    }
    
    func dispose() {
        nativeAdView = nil
    }
}
