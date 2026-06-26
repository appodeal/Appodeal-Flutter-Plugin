import 'package:flutter/services.dart';

/// Class representing the Appodeal Consent Form logic for IAB TCFv2 and Google UMP.
class AppodealConsentForm {
  /// Private method channel for communicating with native platform.
  final MethodChannel _consentManagerChannel =
      const MethodChannel('appodeal_flutter/consent_manager');

  const AppodealConsentForm();

  /// Load consent form to determine the user's consent preferences.
  ///
  /// Parameters:
  /// - [appKey]: The Appodeal application key.
  /// - [tagForUnderAgeOfConsent]: Flag to tag the user as under the age of consent.
  /// - [onConsentFormLoadSuccess]: Callback for successful consent form loading.
  /// - [onConsentFormLoadFailure]: Callback for failed consent form loading.
  void load({
    required String appKey,
    bool tagForUnderAgeOfConsent = false,
    void Function(ConsentStatus)? onConsentFormLoadSuccess,
    void Function(ConsentError)? onConsentFormLoadFailure,
  }) {
    _setHandler({
      'onConsentFormLoadSuccess': (arguments) {
        final status = _ConsentStatusExtension._fromInt(arguments['status']);
        onConsentFormLoadSuccess?.call(status);
      },
      'onConsentFormLoadFailure': (arguments) {
        final error = ConsentError._(arguments['error']);
        onConsentFormLoadFailure?.call(error);
      },
    });

    _invokeMethod('load', {
      'appKey': appKey,
      'tagForUnderAgeOfConsent': tagForUnderAgeOfConsent,
    });
  }

  /// Show the consent form to determine the user's consent.
  ///
  /// Parameters:
  /// - [onConsentFormDismissed]: Callback for when the consent form is dismissed.
  void show({
    void Function(ConsentError? error)? onConsentFormDismissed,
  }) {
    _setHandler({
      'onConsentFormDismissed': (arguments) {
        final error = arguments?['error'] != null
            ? ConsentError._(arguments['error'])
            : null;
        onConsentFormDismissed?.call(error);
      },
    });

    _invokeMethod('show');
  }

  /// Load and show the consent form to determine the user's consent if required.
  ///
  /// Parameters:
  /// - [appKey]: The Appodeal application key.
  /// - [tagForUnderAgeOfConsent]: Flag to tag the user as under the age of consent.
  /// - [onConsentFormDismissed]: Callback for when the consent form is dismissed.
  void loadAndShowIfRequired({
    required String appKey,
    bool tagForUnderAgeOfConsent = false,
    void Function(ConsentError? error)? onConsentFormDismissed,
  }) {
    _setHandler({
      'onConsentFormDismissed': (arguments) {
        final error = arguments?['error'] != null
            ? ConsentError._(arguments['error'])
            : null;
        onConsentFormDismissed?.call(error);
      },
    });

    _invokeMethod('loadAndShowIfRequired', {
      'appKey': appKey,
      'tagForUnderAgeOfConsent': tagForUnderAgeOfConsent,
    });
  }

  /// Revokes the user's consent.
  void revoke() {
    _invokeMethod('revoke');
  }

  /// Returns whether a Privacy Entry Point button must be surfaced in the app UI.
  ///
  /// US state privacy laws (CCPA, CPA, VCDPA, and others) follow an opt-out model:
  /// data processing is allowed by default, but users must be given a permanent way
  /// to opt out — typically a "Do Not Sell or Share My Personal Information" button.
  ///
  /// Returns [PrivacyOptionsRequirementStatus.required] for users in regulated US
  /// states and in the EEA (for GDPR re-consent), [PrivacyOptionsRequirementStatus.notRequired]
  /// elsewhere, and [PrivacyOptionsRequirementStatus.unknown] before
  /// [load] / [loadAndShowIfRequired] (i.e. requestConsentInfoUpdate) has completed.
  Future<PrivacyOptionsRequirementStatus>
      getPrivacyOptionsRequirementStatus() async {
    final value = await _consentManagerChannel
        .invokeMethod<int>('getPrivacyOptionsRequirementStatus');
    return _PrivacyOptionsRequirementStatusExtension._fromInt(value ?? 0);
  }

  /// Shows the US opt-out form (or the GDPR re-consent form in the EEA).
  ///
  /// Call this from the action handler of your Privacy Entry Point button. This is
  /// the only way to display the US opt-out form, and it must be triggered by an
  /// explicit user interaction — not at app launch. Available only after
  /// [load] / [loadAndShowIfRequired] (i.e. requestConsentInfoUpdate) has completed.
  ///
  /// Parameters:
  /// - [onConsentFormDismissed]: Callback for when the form is dismissed. A non-null
  ///   [ConsentError] means the form could not be presented.
  void showPrivacyOptionsForm({
    void Function(ConsentError? error)? onConsentFormDismissed,
  }) {
    _setHandler({
      'onConsentFormDismissed': (arguments) {
        final error = arguments?['error'] != null
            ? ConsentError._(arguments['error'])
            : null;
        onConsentFormDismissed?.call(error);
      },
    });

    _invokeMethod('showPrivacyOptionsForm');
  }

  /// Helper method to set a method call handler with specific callbacks.
  void _setHandler(Map<String, Function(dynamic arguments)> handlers) {
    _consentManagerChannel.setMethodCallHandler((call) async {
      final handler = handlers[call.method];
      if (handler != null) {
        handler(call.arguments);
      }
    });
  }

  /// Helper method to invoke a method on the platform channel.
  void _invokeMethod(String method, [Map<String, dynamic>? arguments]) {
    _consentManagerChannel.invokeMethod(method, arguments);
  }
}

/// Appodeal SDK Consent Error class.
///
/// This class declares errors during consent behavior.
class ConsentError {
  /// A description of the consent error.
  final String description;

  ConsentError._(this.description);

  @override
  String toString() => 'ConsentError(description: $description)';
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
extension _ConsentStatusExtension on ConsentStatus {
  /// Converts an integer to a [ConsentStatus] enum value.
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

/// Appodeal SDK Privacy Options Requirement Status enum.
///
/// Indicates whether a Privacy Entry Point button (US opt-out / GDPR re-consent)
/// must be surfaced in the app UI.
enum PrivacyOptionsRequirementStatus {
  /// Status is not yet known (requestConsentInfoUpdate has not completed).
  unknown,

  /// A Privacy Entry Point button is required (regulated US state or EEA re-consent).
  required,

  /// A Privacy Entry Point button is not required.
  notRequired
}

/// Extension on [PrivacyOptionsRequirementStatus] for converting from integer values.
extension _PrivacyOptionsRequirementStatusExtension
    on PrivacyOptionsRequirementStatus {
  /// Converts a normalized integer (sent by the native side) to an enum value.
  static PrivacyOptionsRequirementStatus _fromInt(int value) {
    switch (value) {
      case 1:
        return PrivacyOptionsRequirementStatus.required;
      case 2:
        return PrivacyOptionsRequirementStatus.notRequired;
      default:
        return PrivacyOptionsRequirementStatus.unknown;
    }
  }
}
