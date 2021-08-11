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
            
        case "setLogLevel": setLogLevel(call, result)
            
        default: result(FlutterMethodNotImplemented)
        }
    }
    
    
    private func initialize(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        
        let appKey = args["appKey"] as! String
        let adType = args["adTypes"] as! [Int]   
        let hasConsent = args["hasConsent"] as! Bool
        let adTypes = AppodealAdType(rawValue: adType.reduce(0) { $0 | getAdType(adId: $1).rawValue })
        
        //setCallbacks()
        
        Appodeal.initialize(withApiKey: appKey, types: adTypes, hasConsent: hasConsent)
        
        result(nil)
    }
    
    private func updateConsent(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let hasConsent = args["hasConsent"] as! Bool
        if (hasConsent) {
            Appodeal.updateConsent(hasConsent)
        }
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
        case 2: return .nativeAd
        case 3: return .interstitial
        case 4: return .rewardedVideo
        case 5: return .nonSkippableVideo
        default: return AppodealAdType(rawValue: 0)
        }
    }
    
    private func getShowStyle(adType: AppodealAdType) -> AppodealShowStyle {
        switch adType {
        case .interstitial: return .interstitial
        case .rewardedVideo: return .rewardedVideo
        case .nonSkippableVideo: return .nonSkippableVideo
        default: return AppodealShowStyle(rawValue: 0)
        }
    }
    
}

