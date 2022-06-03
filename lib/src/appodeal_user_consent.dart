class _UserConsent {
  final int rawValue;

  const _UserConsent._({required this.rawValue});
}

class GDPRUserConsent extends _UserConsent {
  static const Unknown = GDPRUserConsent._(rawValue: 0);
  static const Personalized = GDPRUserConsent._(rawValue: 1);
  static const NonPersonalized = GDPRUserConsent._(rawValue: -1);

  const GDPRUserConsent._({required int rawValue})
      : super._(rawValue: rawValue);
}

class CCPAUserConsent extends _UserConsent {
  static const Unknown = CCPAUserConsent._(rawValue: 0);
  static const OptIn = CCPAUserConsent._(rawValue: 1);
  static const OptOut = CCPAUserConsent._(rawValue: -1);

  const CCPAUserConsent._({required int rawValue})
      : super._(rawValue: rawValue);
}
