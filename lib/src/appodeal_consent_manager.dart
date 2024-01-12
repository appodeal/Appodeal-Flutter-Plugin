import 'package:flutter/services.dart';

class AppodealConsentForm {
  const AppodealConsentForm();

  final MethodChannel _consentManagerChannel =
      const MethodChannel('appodeal_flutter/consent_manager');

  /// Load consent form
  load(
      {required String appKey,
      Function(ConsentStatus)? onConsentFormLoadSuccess,
      Function(ConsentError)? onConsentFormLoadFailure}) {
    _consentManagerChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onConsentFormLoadSuccess':
          onConsentFormLoadSuccess
              ?.call(ConsentStatus._(call.arguments['status']));
          break;
        case 'onConsentFormLoadFailure':
          onConsentFormLoadFailure
              ?.call(ConsentError._(call.arguments['error']));
          break;
      }
    });
    _consentManagerChannel.invokeMethod('load', {'appKey': appKey});
  }

  /// Show the consent form to determine the user's consent
  show({Function(ConsentError error)? onConsentFormDismissed}) {
    _consentManagerChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onConsentFormDismissed':
          onConsentFormDismissed?.call(ConsentError._(call.arguments));
          break;
      }
    });
    _consentManagerChannel.invokeMethod('show');
  }

  /// Load and show the consent form to determine the user's consent if required
  loadAndShowConsentFormIfRequired(
      {required String appKey,
      Function(ConsentError error)? onConsentFormDismissed}) {
    _consentManagerChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onConsentFormDismissed':
          onConsentFormDismissed?.call(ConsentError._(call.arguments));
          break;
      }
    });
    _consentManagerChannel
        .invokeMethod('loadAndShowConsentFormIfRequired', {'appKey': appKey});
  }

  /// Revokes the user's consent
  revoke() {
    _consentManagerChannel.invokeMethod('revoke');
  }
}

/// Appodeal SDK Consent Error class.
///
/// This class declares errors during consent behavor.
///
class ConsentError {
  final String description;

  ConsentError._(this.description);
}

/// Appodeal SDK Consent Status class.
class ConsentStatus {
  final String description;

  ConsentStatus._(this.description);
}
