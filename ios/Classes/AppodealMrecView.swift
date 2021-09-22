//
//  AppodealMrecView.swift
//  appodeal_flutter
//
//  Created by Artyom Kul on 27.08.21.
//

import Appodeal
import Flutter
import Foundation

class AppodealMrecView: NSObject, FlutterPlatformViewFactory {
    
    var instance: SwiftAppodealFlutterPlugin

    init(instance: SwiftAppodealFlutterPlugin) {
        self.instance = instance
    }

    func create(withFrame _: CGRect, viewIdentifier _: Int64, arguments args: Any?) -> FlutterPlatformView {
        var placementName: String?
        if let argsDict = args as? [String: Any] {
            placementName = argsDict["placementName"] as? String
        }

        return AppodealMrecView(instance: instance, placementName: placementName)
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        FlutterStandardMessageCodec.sharedInstance()
    }

    class AppodealMrecView: NSObject, FlutterPlatformView, APDBannerViewDelegate {
        var instance: SwiftAppodealFlutterPlugin
        var placementName: String?

        init(instance: SwiftAppodealFlutterPlugin, placementName: String?) {
            self.instance = instance
            self.placementName = placementName
        }

        func view() -> UIView {
            let mrec = APDMRECView()
            mrec?.delegate = self;
            mrec?.placement = placementName
            mrec?.frame = CGRect(x: 0, y: 0, width: 300, height: 250)
            mrec?.loadAd()

            return mrec ?? UIView()
        }
        
        func bannerViewDidLoadAd(_ bannerView: APDBannerView, isPrecache precache: Bool) {
            let args: [String: Any] = ["isPrecache": precache]
            if (bannerView.adSize == kAPDAdSize300x250) {
                instance.channel?.invokeMethod("onMrecLoaded", arguments: args)
            }
        }
        
        func bannerViewDidShow(_ bannerView: APDBannerView) {
            if (bannerView.adSize == kAPDAdSize300x250) {
                instance.channel?.invokeMethod("onMrecShown", arguments: nil)
            }
        }
        
        func bannerViewExpired(_ bannerView: APDBannerView) {
            if (bannerView.adSize == kAPDAdSize300x250) {
                instance.channel?.invokeMethod("onMrecExpired", arguments: nil)
            }
        }
        
        func bannerViewDidInteract(_ bannerView: APDBannerView) {
            if (bannerView.adSize == kAPDAdSize300x250) {
                instance.channel?.invokeMethod("onMrecClicked", arguments: nil)
            }
        }
        
        func bannerView(_ bannerView: APDBannerView, didFailToLoadAdWithError error: Error) {
            if (bannerView.adSize == kAPDAdSize300x250) {
                instance.channel?.invokeMethod("onMrecFailedToLoad", arguments: nil)
            }
        }
    }
}
