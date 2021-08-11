import Flutter
import UIKit
import Appodeal

public class SwiftAppodealFlutterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "appodeal_flutter", binaryMessenger: registrar.messenger())
        let instance = SwiftAppodealFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialize": initialize(call, result)
        case "updateConsent": updateConsent(call, result)
        case "isInitialized": isInitialized(call, result)
        case "isAutoCacheEnabled": isAutoCacheEnabled(call, result)
        case "show": show(call, result)
            
            
            
        case "setTesting": setTesting(call, result)
        case "setLogLevel": setLogLevel(call, result)
            
        default: result(FlutterMethodNotImplemented)
        }
    }
    
    
    private func initialize(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        
        let appKey = args["appKey"] as! String
        let types = args["adTypes"] as! [Int]
        let hasConsent = args["hasConsent"] as! Bool
       
       
        let adTypes = AppodealAdType(rawValue: types.reduce(0) { $0 | getAdType(adId: $1).rawValue })
        
        //setCallbacks()
        
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

