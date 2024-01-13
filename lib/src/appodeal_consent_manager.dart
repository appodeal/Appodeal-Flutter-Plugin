import 'package:flutter/services.dart';

/// Class representing the Appodeal Consent Form logic for IAB TCFv2 and Google UMP.
class AppodealConsentForm {
  const AppodealConsentForm();

  final MethodChannel _consentManagerChannel =
      const MethodChannel('appodeal_flutter/consent_manager');

  /// Load consent form to determine the user's consent preferences.
  ///
  /// Parameters:
  /// - `appKey`: The Appodeal application key.
  /// - `tagForUnderAgeOfConsent`: Flag to tag the user as under the age of consent.
  /// - `onConsentFormLoadSuccess`: Callback for successful consent form loading.
  /// - `onConsentFormLoadFailure`: Callback for failed consent form loading.
  void load({
    required String appKey,
    bool tagForUnderAgeOfConsent = false,
    Function(ConsentStatus)? onConsentFormLoadSuccess,
    Function(ConsentError)? onConsentFormLoadFailure,
  }) {
    _consentManagerChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onConsentFormLoadSuccess':
          onConsentFormLoadSuccess
              ?.call(_ConsentStatusExt._fromInt(call.arguments['status']));
          break;
        case 'onConsentFormLoadFailure':
          onConsentFormLoadFailure
              ?.call(ConsentError._(call.arguments['error']));
          break;
      }
    });
    _consentManagerChannel.invokeMethod('load', {
      'appKey': appKey,
      'tagForUnderAgeOfConsent': tagForUnderAgeOfConsent,
    });
  }

  /// Show the consent form to determine the user's consent.
  ///
  /// Parameters:
  /// - `onConsentFormDismissed`: Callback for when the consent form is dismissed.
  void show({Function(ConsentError? error)? onConsentFormDismissed}) {
    _consentManagerChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onConsentFormDismissed':
          final error = call.arguments?['error'];
          onConsentFormDismissed
              ?.call(error != null ? ConsentError._(error) : null);
          break;
      }
    });
    _consentManagerChannel.invokeMethod('show');
  }

  /// Load and show the consent form to determine the user's consent if required.
  ///
  /// Parameters:
  /// - `appKey`: The Appodeal application key.
  /// - `tagForUnderAgeOfConsent`: Flag to tag the user as under the age of consent.
  /// - `onConsentFormDismissed`: Callback for when the consent form is dismissed.
  void loadAndShowIfRequired({
    required String appKey,
    bool tagForUnderAgeOfConsent = false,
    Function(ConsentError? error)? onConsentFormDismissed,
  }) {
    _consentManagerChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onConsentFormDismissed':
          final error = call.arguments?['error'];
          onConsentFormDismissed
              ?.call(error != null ? ConsentError._(error) : null);
          break;
      }
    });
    _consentManagerChannel.invokeMethod('loadAndShowIfRequired', {
      'appKey': appKey,
      'tagForUnderAgeOfConsent': tagForUnderAgeOfConsent,
    });
  }

  /// Revokes the user's consent.
  void revoke() {
    _consentManagerChannel.invokeMethod('revoke');
  }
}

/// Appodeal SDK Consent Error class.
///
/// This class declares errors during consent behavior.
class ConsentError {
  final String description;

  ConsentError._(this.description);
}

/// Appodeal SDK Consent Status enum.
enum ConsentStatus {
  /// Represents an unknown consent status.
  unknown,

  /// Represents a required consent status.
  required,

  /// Represents a not required consent status.
  notRequired,

  /// Represents an obtained consent status.
  obtained
}

/// Extension on [ConsentStatus] for converting from integer values.
extension _ConsentStatusExt on ConsentStatus {
  static ConsentStatus _fromInt(int value) {
    switch (value) {
      case 0:
        return ConsentStatus.unknown;
      case 1:
        return ConsentStatus.required;
      case 2:
        return ConsentStatus.notRequired;
      case 3:
        return ConsentStatus.obtained;
      default:
        return ConsentStatus.unknown;
    }
  }
}
