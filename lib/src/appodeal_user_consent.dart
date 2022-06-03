class _UserConsent {
  final int rawValue;

  const _UserConsent._({required this.rawValue});
}

/// An additional consent object containing zone as GDPR
class GDPRUserConsent extends _UserConsent {
  /// Unknown status - the user has neither granted nor declined consent for personalized or non-personalized ads.
  static const Unknown = GDPRUserConsent._(rawValue: 0);

  /// Personalized status - the user has granted consent for personalized ads.
  static const Personalized = GDPRUserConsent._(rawValue: 1);

  /// NonPersonalized status - the user has not granted consent for personalized ads.
  static const NonPersonalized = GDPRUserConsent._(rawValue: -1);

  const GDPRUserConsent._({required int rawValue})
      : super._(rawValue: rawValue);
}

/// An additional consent object containing zone as CCPA
class CCPAUserConsent extends _UserConsent {
  /// Unknown status - the user has neither granted nor declined consent for personalized or non-personalized ads
  static const Unknown = CCPAUserConsent._(rawValue: 0);

  /// OptIn status - the user has granted consent for personalized ads.
  static const OptIn = CCPAUserConsent._(rawValue: 1);

  /// OptOut status - the user has not granted consent for personalized ads.
  static const OptOut = CCPAUserConsent._(rawValue: -1);

  const CCPAUserConsent._({required int rawValue})
      : super._(rawValue: rawValue);
}
