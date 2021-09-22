//
//  AppodealBannerView.swift
//  appodeal_flutter
//
//  Created by Artyom Kul on 27.08.21.
//

import Appodeal
import Flutter
import Foundation

class AppodealBannerView: NSObject, FlutterPlatformViewFactory, APDBannerViewDelegate {
    var instance: SwiftAppodealFlutterPlugin
    
    init(instance: SwiftAppodealFlutterPlugin) {
        self.instance = instance
    }
    
    func create(withFrame _: CGRect, viewIdentifier _: Int64, arguments args: Any?) -> FlutterPlatformView {
        var placementName: String?
        if let argsDict = args as? [String: Any] {
            placementName = argsDict["placementName"] as? String
        }
        
        return AppodealBannerView(instance: instance, placementName: placementName)
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        FlutterStandardMessageCodec.sharedInstance()
    }
    
    
    class AppodealBannerView: NSObject, FlutterPlatformView, APDBannerViewDelegate {
        var instance: SwiftAppodealFlutterPlugin
        var placementName: String?
        
        init(instance: SwiftAppodealFlutterPlugin, placementName: String?) {
            self.instance = instance
            self.placementName = placementName
        }
        
        func view() -> UIView {
            let banner = APDBannerView()
            banner.delegate = self;
            banner.placement = placementName
            banner.frame = CGRect(x: 0, y: 0, width: 320, height: 50)
            banner.loadAd()
            return banner
        }
    }
    
    func bannerViewDidLoadAd(_ bannerView: APDBannerView, isPrecache precache: Bool) {
        let args: [String: Any] = ["isPrecache": precache]
        if (bannerView.adSize == kAPDAdSize728x90 || bannerView.adSize == kAPDAdSize320x50) {
            instance.channel?.invokeMethod("onBannerLoaded", arguments: args)
        }
    }
    
    func bannerViewDidShow(_ bannerView: APDBannerView) {
        if (bannerView.adSize == kAPDAdSize728x90 || bannerView.adSize == kAPDAdSize320x50) {
            instance.channel?.invokeMethod("onBannerShown", arguments: nil)
        }
    }
    
    func bannerViewExpired(_ bannerView: APDBannerView) {
        if (bannerView.adSize == kAPDAdSize728x90 || bannerView.adSize == kAPDAdSize320x50) {
            instance.channel?.invokeMethod("onBannerExpired", arguments: nil)
        }
    }
    
    func bannerViewDidInteract(_ bannerView: APDBannerView) {
        if (bannerView.adSize == kAPDAdSize728x90 || bannerView.adSize == kAPDAdSize320x50) {
            instance.channel?.invokeMethod("onBannerClicked", arguments: nil)
        }
    }
    
    func bannerView(_ bannerView: APDBannerView, didFailToLoadAdWithError error: Error) {
        if (bannerView.adSize == kAPDAdSize728x90 || bannerView.adSize == kAPDAdSize320x50) {
            instance.channel?.invokeMethod("onBannerFailedToLoad", arguments: nil)
        }
    }
    
}
