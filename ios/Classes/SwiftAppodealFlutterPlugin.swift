import Flutter
import UIKit
import Appodeal

public class SwiftAppodealFlutterPlugin: NSObject, FlutterPlugin {
    
    internal var channel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftAppodealFlutterPlugin()
        instance.channel = FlutterMethodChannel(name: "appodeal_flutter", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: instance.channel!)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialize": initialize(call, result)
        case "updateConsent": updateConsent(call, result)
        case "isInitialized": isInitialized(call, result)
        case "isAutoCacheEnabled": isAutoCacheEnabled(call, result)
        case "show": show(call, result)
        case "showWithPlacement": showWithPlacement(call, result)
        case "setTesting": setTesting(call, result)
        case "setLogLevel": setLogLevel(call, result)
        case "setAutoCache": setAutoCache(call, result)
        case "cache": cache(call, result)
        case "hide": hide(call, result)
        case "setTriggerOnLoadedOnPrecache": setTriggerOnLoadedOnPrecache(call, result)
        case "isLoaded": isLoaded(call, result)
        case "isPrecache": isPrecache(call, result)
        case "setSmartBanners": setSmartBanners(call, result)
        case "setTabletBanners": setTabletBanners(call, result)
        case "setBannerAnimation": setBannerAnimation(call, result)
        case "setBannerRotation": setBannerRotation(call, result)
        case "trackInAppPurchase": trackInAppPurchase(call, result)
        case "disableNetwork": disableNetwork(call, result)
        case "disableNetworkForSpecificAdType": disableNetworkForSpecificAdType(call, result)
        case "setUserId": setUserId(call, result)
        case "setUserAge": setUserAge(call, result)
        case "setUserGender": setUserGender(call, result)
        case "setCustomFilterString": setCustomFilterString(call, result)
        case "setCustomFilterBool": setCustomFilterBool(call, result)
        case "setCustomFilterInt": setCustomFilterInt(call, result)
        case "setCustomFilterDouble": setCustomFilterDouble(call, result)
        case "canShow": canShow(call, result)
        case "canShowWithPlacement": canShow(call, result)
        case "setChildDirectedTreatment": setChildDirectedTreatment(call, result)
        case "setExtraDataString": setExtraDataString(call, result)
        case "setExtraDataDouble": setExtraDataDouble(call, result)
        case "setExtraDataInt": setExtraDataInt(call, result)
        case "setExtraDataBool": setExtraDataBool(call, result)
        case "getPredictedEcpm": getPredictedEcpm(call, result)
        case "getNativeSDKVersion": getNativeSDKVersion(call, result)
        default: result(FlutterMethodNotImplemented)
        }
    }
    
    private func initialize(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let appKey = args["appKey"] as! String
        let types = args["adTypes"] as! [Int]
        let hasConsent = args["hasConsent"] as! Bool
        let adTypes = AppodealAdType(rawValue: types.reduce(0) { $0 | getAdType(adId: $1).rawValue })
        setCallbacks()
        Appodeal.initialize(withApiKey: appKey, types: adTypes, hasConsent: hasConsent)
        result(nil)
    }
    
    private func updateConsent(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let hasConsent = args["hasConsent"] as! Bool
        Appodeal.updateConsent(hasConsent)
        result(nil)
    }
    
    
    private func isInitialized(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)
        result(Appodeal.isInitalized(for:adType))
    }
    
    private func isAutoCacheEnabled(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)
        result(Appodeal.isAutocacheEnabled(_:adType))
    }
    
    private func show(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        result(Appodeal.showAd(getShowStyle(adId: args["adType"] as! Int), rootViewController: rootViewController))
    }
    
    private func showWithPlacement(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        let placement = args["placement"] as! String
        result(Appodeal.showAd(getShowStyle(adId: args["adType"] as! Int), forPlacement: placement, rootViewController: rootViewController))
    }
    
    private func setTesting(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let testMode = args["testMode"] as! Bool
        Appodeal.setTestingEnabled(testMode)
        result(nil)
    }
    
    private func setLogLevel(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let logLevel = args["logLevel"] as! Int
        switch logLevel {
        case 1:
            Appodeal.setLogLevel(APDLogLevel.debug)
        case 2:
            Appodeal.setLogLevel(APDLogLevel.verbose)
        default:
            Appodeal.setLogLevel(APDLogLevel.off)
        }
        result(nil)
    }
    
    private func setAutoCache(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)
        let autoCache = args["autoCache"] as! Bool
        Appodeal.setAutocache(autoCache, types: adType)
        result(nil)
    }
    
    private func cache(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)
        Appodeal.cacheAd(adType)
        result(nil)
    }
    
    private func hide(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        Appodeal.hideBanner();
        result(nil)
    }
    
    private func setTriggerOnLoadedOnPrecache(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let onLoadedTriggerBoth = args["onLoadedTriggerBoth"] as! Bool
        Appodeal.setTriggerPrecacheCallbacks(onLoadedTriggerBoth)
        result(nil)
    }
    
    private func isLoaded(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        result(Appodeal.isReadyForShow(with:getShowStyle(adId: args["adType"] as! Int)))
    }
    
    private func isPrecache(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)
        result(Appodeal.isPrecacheAd(_:adType))
    }
    
    private func setSmartBanners(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let smartBannerEnabled = args["smartBannerEnabled"] as! Bool
        Appodeal.setSmartBannersEnabled(smartBannerEnabled)
        result(nil)
    }
    
    private func setTabletBanners(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let tabletBannerEnabled = args["tabletBannerEnabled"] as! Bool
        
        if (tabletBannerEnabled) {
            Appodeal.setPreferredBannerAdSize(kAppodealUnitSize_728x90)
        }else {
            Appodeal.setPreferredBannerAdSize(kAPDAdSize320x50)
        }
        
        result(nil)
    }
    
    private func setBannerAnimation(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let bannerAnimationEnabled = args["bannerAnimationEnabled"] as! Bool
        Appodeal.setBannerAnimationEnabled(bannerAnimationEnabled)
        result(nil)
    }
    
    private func setBannerRotation(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let leftBannerRotation = args["leftBannerRotation"] as! Int
        let rightBannerRotation = args["rightBannerRotation"] as! Int
        Appodeal.setBannerLeftRotationAngleDegrees(CGFloat(leftBannerRotation), rightRotationAngleDegrees: CGFloat(rightBannerRotation))
        result(nil)
    }
    
    private func trackInAppPurchase(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let amount = args["amount"] as! Double
        let currency = args["currency"] as! String
        Appodeal.track(inAppPurchase: NSNumber.init(value: amount), currency: currency)
        result(nil)
    }
    
    private func disableNetwork(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let network = args["network"] as! String
        Appodeal.disableNetwork(network)
        result(nil)
    }
    
    private func disableNetworkForSpecificAdType(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let network = args["network"] as! String
        let adType = getAdType(adId: args["adType"] as! Int)
        Appodeal.disableNetwork(for: adType, name: network)
        result(nil)
    }
    
    private func setUserId(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let userId = args["userId"] as! String
        Appodeal.setUserId(userId)
        result(nil)
    }
    
    private func setUserAge(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let age = args["age"] as! Int
        Appodeal.setUserAge(UInt(age))
        result(nil)
    }
    
    private func setUserGender(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let age = args["gender"] as! Int
        switch age {
        case 0:
            Appodeal.setUserGender(AppodealUserGender.other)
        case 1:
            Appodeal.setUserGender(AppodealUserGender.male)
        case 2:
            Appodeal.setUserGender(AppodealUserGender.female)
        default:
            Appodeal.setUserGender(AppodealUserGender.other)
        }
        result(nil)
    }
    
    private func setCustomFilterString(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let key = args["name"] as! String
        let value = args["value"] as! String
        let customFilters: [AnyHashable: Any] = [
            "key": key as String,
            "value": value as String,
        ]
        Appodeal.setCustomState(customFilters)
        result(nil)
    }
    
    private func setCustomFilterBool(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let name = args["name"] as! String
        let value = args["value"] as! Bool
        let customFilters: [AnyHashable: Any] = [
            "key" : name as String,
            "value" : value as Bool,
        ]
        Appodeal.setCustomState(customFilters)
        result(nil)
    }
    
    private func setCustomFilterInt(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let name = args["name"] as! String
        let value = args["value"] as! Int
        let customFilters: [AnyHashable: Any] = [
            "key" : name as String,
            "value" : value as Int,
        ]
        Appodeal.setCustomState(customFilters)
        result(nil)
    }
    
    private func setCustomFilterDouble(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let name = args["name"] as! String
        let value = args["value"] as! Double
        let customFilters: [AnyHashable: Any] = [
            "key" : name as String,
            "value" : value as Double,
        ]
        Appodeal.setCustomState(customFilters)
        result(nil)
    }
    
    private func canShow(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)
        result(Appodeal.canShow(adType, forPlacement: "default"))
    }
    
    private func canShowWithPlacement(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)
        let placement = args["placement"] as! String
        result(Appodeal.canShow(adType, forPlacement: placement))
    }
    
    private func setChildDirectedTreatment(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let value = args["value"] as! Bool
        Appodeal.setChildDirectedTreatment(value)
        result(nil)
    }
    
    
    private func setExtraDataString(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let key = args["key"] as! String
        let value = args["value"] as! String
        let customFilters: [String: Any] = [
            "key" : key as String,
            "value" : value as String,
        ]
        Appodeal.setExtras(customFilters)
        result(nil)
    }
    
    private func setExtraDataDouble(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let key = args["key"] as! String
        let value = args["value"] as! Double
        let customFilters: [String: Any] = [
            "key" : key as String,
            "value" : value as Double,
        ]
        Appodeal.setExtras(customFilters)
        result(nil)
    }
    
    private func setExtraDataInt(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let key = args["key"] as! String
        let value = args["value"] as! Int
        let customFilters: [String: Any] = [
            "key" : key as String,
            "value" : value as Int,
        ]
        Appodeal.setExtras(customFilters)
        result(nil)
    }
    
    private func setExtraDataBool(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let key = args["key"] as! String
        let value = args["value"] as! Bool
        let customFilters: [String: Any] = [
            "key" : key as String,
            "value" : value as Bool,
        ]
        Appodeal.setExtras(customFilters)
        result(nil)
    }
    
    private func getPredictedEcpm(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)
        result(Appodeal.predictedEcpm(for: adType))
    }
    
    
    private func getNativeSDKVersion(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        result(Appodeal.getVersion())
    }
    
    private func setCallbacks() {
        Appodeal.setInterstitialDelegate(self)
        Appodeal.setBannerDelegate(self)
        Appodeal.setRewardedVideoDelegate(self)
    }
    
    private func getAdType(adId: Int) -> AppodealAdType {
        switch adId {
        case 1: return .banner
        case 2: return .banner
        case 3: return .banner
        case 4: return .banner
        case 5: return .banner
        case 6: return .nativeAd
        case 7: return .interstitial
        case 8: return .rewardedVideo
        case 9: return.nonSkippableVideo
        default: return AppodealAdType(rawValue: 0)
        }
    }
    
    private func getShowStyle(adId: Int) -> AppodealShowStyle {
        switch adId {
        case 1: return .bannerBottom
        case 2: return .bannerRight
        case 3: return .bannerTop
        case 4: return .bannerLeft
        case 5: return .bannerBottom
        case 7: return .interstitial
        case 8: return .rewardedVideo
        case 9: return.nonSkippableVideo
        default: return AppodealShowStyle(rawValue: 0)
        }
    }
    
}

