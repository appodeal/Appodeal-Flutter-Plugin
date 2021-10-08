import Foundation
import StackConsentManager.Private

extension SwiftAppodealFlutterPlugin: STKConsentManagerDisplayDelegate {
    public func consentManagerWillShowDialog(_ consentManager: STKConsentManager) {
        channel?.invokeMethod("onConsentFormOpened", arguments: nil)
    }
    
    public func consentManager(_ consentManager: STKConsentManager, didFailToPresent error: Error) {
        let args: [String: Any] = ["error": error.localizedDescription as String]
        channel?.invokeMethod("onConsentFormError", arguments: args)
    }
    
    public func consentManagerDidDismissDialog(_ consentManager: STKConsentManager) {
        guard let consent = STKConsentManager.shared().consent as? STKConsentManagerJSONModel else {
            let args: [String: Any] = ["consnent": "not found consent"]
            channel?.invokeMethod("onConsentInfoUpdated", arguments: args)
            return
        }
        let json = consent.jsonRepresentation()
        let data = try? JSONSerialization.data(withJSONObject: json as Any, options: [])
        let consentSring = data.flatMap { String(data: $0, encoding: .utf8) }
        let args: [String: Any] = ["consent": consentSring! as String]
        channel?.invokeMethod("onConsentFormClosed", arguments: args)
    }
}
