import Flutter
import UIKit
import Appodeal
import StackConsentManager.Private
import AVFoundation

public class SwiftAppodealFlutterPlugin: NSObject, FlutterPlugin {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftAppodealFlutterPlugin(registrar: registrar)
        registrar.addMethodCallDelegate(instance, channel: instance.channel)
        registrar.addMethodCallDelegate(instance, channel: instance.interstitial.adChannel)
        registrar.addMethodCallDelegate(instance, channel: instance.rewardedVideo.adChannel)
        registrar.addMethodCallDelegate(instance, channel: instance.banner.adChannel)
        registrar.addMethodCallDelegate(instance, channel: instance.mrec.adChannel)
        registrar.register(AppodealAdViewFactory(mrecChannel: instance.mrec.adChannel,
                                                 bannerChannel: instance.banner.adChannel),
                           withId: "appodeal_flutter/banner_view")
    }

    let channel: FlutterMethodChannel

    private let interstitial: AppodealInterstitial
    private let rewardedVideo: AppodealRewarded
    private let banner: AppodealBanner
    private let mrec: AppodealMrec

    private init(registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: "appodeal_flutter", binaryMessenger: registrar.messenger())
        interstitial = AppodealInterstitial(registrar: registrar)
        rewardedVideo = AppodealRewarded(registrar: registrar)
        banner = AppodealBanner(registrar: registrar)
        mrec = AppodealMrec(registrar: registrar)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "updateConsent": updateConsent(call, result)
        case "initialize": initialize(call, result)
        case "isInitialized": isInitialized(call, result)
        case "setAutoCache": setAutoCache(call, result)
        case "isAutoCacheEnabled": isAutoCacheEnabled(call, result)
        case "cache": cache(call, result)
        case "isLoaded": isLoaded(call, result)
        case "isPrecache": isPrecache(call, result)
        case "canShow": canShow(call, result)
        case "getPredictedEcpm": getPredictedEcpm(call, result)
        case "show": show(call, result)
        case "hide": hide(call, result)
        case "setTesting": setTesting(call, result)
        case "setLogLevel": setLogLevel(call, result)
        case "setTriggerOnLoadedOnPrecache": setTriggerOnLoadedOnPrecache(call, result)
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
        case "setChildDirectedTreatment": setChildDirectedTreatment(call, result)
        case "setCustomFilter": setCustomFilter(call, result)
        case "setExtraData": setExtraData(call, result)
        case "getNativeSDKVersion": getNativeSDKVersion(call, result)
        case "setStorage": setStorage(call, result)
        case "setCustomVendor": setCustomVendor(call, result)
        case "getCustomVendor": getCustomVendor(call, result)
        case "getStorage": getStorage(result)
        case "shouldShowConsentDialog": shouldShowConsentDialog(result)
        case "getConsentZone": getConsentZone(result)
        case "getConsentStatus": getConsentStatus(result)
        case "getConsent": getConsent(result)
        case "consentFormIsLoaded": consentFormIsLoaded(result)
        case "consentFormIsShowing": consentFormIsShowing(result)
        case "requestConsentInfoUpdate": requestConsentInfoUpdate(call, result)
        case "loadConsentForm": loadConsentForm(result)
        case "showAsDialogConsentForm": showAsDialogConsentForm(result)
        case "disableAppTrackingTransparencyRequest": disableAppTrackingTransparencyRequest(result)
        default: result(FlutterMethodNotImplemented)
        }
    }

    private func updateConsent(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let hasConsent = args["hasConsent"] as! Bool
        Appodeal.updateConsent(hasConsent)
        result(nil)
    }

    private func initialize(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let appKey = args["appKey"] as! String
        let types = args["adTypes"] as! [Int]
        let adTypes = AppodealAdType(rawValue: types.reduce(0) {$0 | getAdType(adId: $1).rawValue})
        setCallbacks()
        Appodeal.setFramework(APDFramework.flutter, version: "1.2.1")
        if let consent = STKConsentManager.shared().consent {
            Appodeal.initialize(withApiKey: appKey, types: adTypes, consentReport: consent)
        } else if let hasConsent = args["hasConsent"] as? Bool {
            Appodeal.initialize(withApiKey: appKey, types: adTypes, hasConsent: hasConsent)
        } else {
            Appodeal.initialize(withApiKey: appKey, types: adTypes)
        }
        result(nil)
    }

    private func isInitialized(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)
        result(Appodeal.isInitalized(for: adType))
    }

    private func setAutoCache(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)
        let autoCache = args["autoCache"] as! Bool
        Appodeal.setAutocache(autoCache, types: adType)
        result(nil)
    }

    private func isAutoCacheEnabled(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)
        result(Appodeal.isAutocacheEnabled(_: adType))
    }

    private func cache(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)
        Appodeal.cacheAd(adType)
        result(nil)
    }

    private func isLoaded(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getShowStyle(adId: args["adType"] as! Int)
        result(Appodeal.isReadyForShow(with: adType))
    }

    private func isPrecache(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)
        result(Appodeal.isPrecacheAd(_: adType))
    }

    private func canShow(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)
        let placement = args["placement"] as! String
        result(Appodeal.canShow(adType, forPlacement: placement))
    }

    private func getPredictedEcpm(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)
        result(Appodeal.predictedEcpm(for: adType))
    }

    private func show(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getShowStyle(adId: args["adType"] as! Int)
        let placement = args["placement"] as! String
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        result(Appodeal.showAd(adType, forPlacement: placement, rootViewController: rootViewController))
    }

    private func hide(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        Appodeal.hideBanner();
        result(nil)
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

    private func setTriggerOnLoadedOnPrecache(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let onLoadedTriggerBoth = args["onLoadedTriggerBoth"] as! Bool
        Appodeal.setTriggerPrecacheCallbacks(onLoadedTriggerBoth)
        result(nil)
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
        } else {
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

    private func setChildDirectedTreatment(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let value = args["value"] as! Bool
        Appodeal.setChildDirectedTreatment(value)
        result(nil)
    }

    private func setCustomFilter(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let key = args["name"] as! String
        let value = args["value"]
        switch value {
        case is String:
            Appodeal.setCustomState([key: value as! String])
        case is Int:
            Appodeal.setCustomState([key: value as! Int])
        case is Double:
            Appodeal.setCustomState([key: value as! Double])
        case is Bool:
            Appodeal.setCustomState([key: value as! Bool])
        default:
            Appodeal.setCustomState([key: value as Any])
        }
        result(nil)
    }

    private func setExtraData(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let key = args["key"] as! String
        let value = args["value"]
        switch value {
        case is String:
            Appodeal.setCustomState([key: value as! String])
        case is Int:
            Appodeal.setCustomState([key: value as! Int])
        case is Double:
            Appodeal.setCustomState([key: value as! Double])
        case is Bool:
            Appodeal.setCustomState([key: value as! Bool])
        default:
            Appodeal.setCustomState([key: value as Any])
        }
        result(nil)
    }

    private func getNativeSDKVersion(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        result(Appodeal.getVersion())
    }

    private func setCallbacks() {
        Appodeal.setInterstitialDelegate(interstitial.adListener)
        Appodeal.setRewardedVideoDelegate(rewardedVideo.adListener)
        Appodeal.setBannerDelegate(banner.adListener)
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
        case 9: return .MREC
        case 10: return AppodealAdType(rawValue: 4095)
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
        default: return AppodealShowStyle(rawValue: 0)
        }
    }

    //Consent logic
    private func disableAppTrackingTransparencyRequest(_ result: @escaping FlutterResult) {
        STKConsentManager.shared().disableAppTrackingTransparencyRequest()
        result(nil)
    }

    private func showAsDialogConsentForm(_ result: @escaping FlutterResult) {
        guard let controller = UIApplication.shared.keyWindow?.rootViewController, STKConsentManager.shared().isConsentDialogReady
        else {
            channel.invokeMethod("onConsentFormError", arguments: "issue with controller" + "STKConsentManager.isConsentDialogReady - " + String(STKConsentManager.shared().isConsentDialogReady))
            return
        }
        STKConsentManager.shared().showConsentDialog(fromRootViewController: controller, delegate: self)
        result(nil)
    }

    private func loadConsentForm(_ result: @escaping FlutterResult) {
        STKConsentManager.shared().loadConsentDialog { [unowned self] error in
                    if let error = error {
                        let args: [String: Any] = ["error": error.localizedDescription as String]
                        channel.invokeMethod("onConsentFormError", arguments: args)
                    } else {
                        channel.invokeMethod("onConsentFormLoaded", arguments: nil)
                    }
                }
        result(nil)
    }

    private func requestConsentInfoUpdate(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let appKey = args["appKey"] as! String
        if (appKey.isEmpty) {
            let args: [String: Any] = ["error": "Appodeal key can't be null"]
            channel.invokeMethod("onFailedToUpdateConsentInfo", arguments: args)
            return;
        }

        STKConsentManager.shared().synchronize(withAppKey: appKey) { [unowned self] error in
                    if let error = error {
                        let args: [String: Any] = ["error": error.localizedDescription as String]
                        channel.invokeMethod("onFailedToUpdateConsentInfo", arguments: args)
                        print("Error while synchronising consent manager: \(error)")
                    } else {
                        guard let consent = STKConsentManager.shared().consent as? STKConsentManagerJSONModel else {
                            let args: [String: Any] = ["consnent": "not found consent"]
                            channel.invokeMethod("onConsentInfoUpdated", arguments: args)
                            return
                        }
                        let json = consent.jsonRepresentation()
                        let data = try? JSONSerialization.data(withJSONObject: json as Any, options: [])
                        let consentSring = data.flatMap {
                                    String(data: $0, encoding: .utf8)
                                }
                        let args: [String: Any] = ["consent": consentSring! as String]
                        channel.invokeMethod("onConsentInfoUpdated", arguments: args)
                    }
                }
        result(nil)
    }

    private func consentFormIsShowing(_ result: @escaping FlutterResult) {
        result(STKConsentManager.shared().isConsentDialogPresenting)
    }

    private func consentFormIsLoaded(_ result: @escaping FlutterResult) {
        result(STKConsentManager.shared().isConsentDialogReady)
    }

    private func getConsent(_ result: @escaping FlutterResult) {
        guard let consent = STKConsentManager.shared().consent as? STKConsentManagerJSONModel else {
            result("not found consent")
            return
        }
        let json = consent.jsonRepresentation()
        let data = try? JSONSerialization.data(withJSONObject: json as Any, options: [])
        let consentSring = data.flatMap {
                    String(data: $0, encoding: .utf8)
                }
        result(consentSring)
    }

    private func getConsentZone(_ result: @escaping FlutterResult) {
        switch (STKConsentManager.shared().regulation) {
        case .unknown:
            result(0)
            break
        case .none:
            result(0)
            break
        case .GDPR:
            result(1)
        case .CCPA:
            result(2)
        default:
            result(0)
        }
    }

    private func getConsentStatus(_ result: @escaping FlutterResult) {
        switch (STKConsentManager.shared().consentStatus) {
        case .unknown:
            result(0)
        case .nonPersonalized:
            result(3)
        case .partlyPersonalized:
            result(2)
        case .personalized:
            result(1)
        default:
            result(0)
        }
    }

    private func shouldShowConsentDialog(_ result: @escaping FlutterResult) {
        switch (STKConsentManager.shared().shouldShowConsentDialog) {
        case .unknown:
            result(0)
            break
        case .true:
            result(1)
            break
        case .false:
            result(2)
            break
        default:
            result(0)
            break
        }
    }

    private func getStorage(_ result: @escaping FlutterResult) {
        switch (STKConsentManager.shared().storage) {
        case STKConsentDialogStorage.none:
            result(0)
            break
        case STKConsentDialogStorage.userDefaults:
            result(1)
            break
        default:
            result(0)
            break
        }
    }

    private func getCustomVendor(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let bundle = args["bundle"] as! String
        if let vendors = STKConsentManager.shared().value(forKey: "customVendors") as? [STKConsentManagerJSONModel] {
            let vendor = vendors.first {
                        ($0.jsonRepresentation()["status"] as? String) == bundle
                    }
            if ((vendor?.jsonRepresentation().isEmpty) != nil) {
                let json = vendor?.jsonRepresentation()
                let data = try? JSONSerialization.data(withJSONObject: json!, options: [])
                let vendorSring = data.flatMap {
                            String(data: $0, encoding: .utf8)
                        }
                result(vendorSring)
                NSLog(vendorSring!)
            } else {
                result("not found vendor for bundle" + bundle)
            }
        }
    }

    private func setCustomVendor(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let name = args["name"] as! String
        let bundle = args["bundle"] as! String
        let policyUrl = args["policyUrl"] as! String
        let purposeIds = args["purposeIds"] as! [NSNumber]
        let featureIds = args["featureIds"] as! [NSNumber]
        let legitimateInterestPurposeIds = args["legitimateInterestPurposeIds"] as! [NSNumber]

        STKConsentManager.shared().registerCustomVendor { builder in
                    let _ = builder
                            .appendPolicyURL(URL(string: policyUrl)!)
                            .appendName(name)
                            .appendBundle(bundle)
                            .appendPurposesIds(purposeIds)
                            .appendFeaturesIds(featureIds)
                            .appendLegIntPurposeIds(legitimateInterestPurposeIds)
                }
        result(nil)
    }

    private func setStorage(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let storage = args["storage"] as! Int
        switch (storage) {
        case 0:
            STKConsentManager.shared().storage = STKConsentDialogStorage.none
            break;
        case 1:
            STKConsentManager.shared().storage = STKConsentDialogStorage.userDefaults
            break;
        default:
            STKConsentManager.shared().storage = STKConsentDialogStorage.none
            break;
        }
        result(nil)
    }
}
