#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint appodeal_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'appodeal_flutter'
  s.version          = '1.0.0'
  s.summary          = 'Appodeal flutter plugin'

  s.homepage         = 'http://appodeal.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Appodeal' => 'kul@appodeal.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '10.0'
  s.static_framework = true

   s.dependency 'APDAdColonyAdapter', '2.10.2.1'
   s.dependency 'APDAmazonAdsAdapter', '2.10.2.1'
   s.dependency 'APDAppLovinAdapter', '2.10.2.1'
   s.dependency 'APDBidMachineAdapter', '2.10.2.1'
   s.dependency 'APDFacebookAudienceAdapter', '2.10.2.1'
   s.dependency 'APDGoogleAdMobAdapter', '2.10.2.1'
   s.dependency 'APDIronSourceAdapter', '2.10.2.1'
   s.dependency 'APDMyTargetAdapter', '2.10.2.1'
   s.dependency 'APDOguryAdapter', '2.10.2.1'
   s.dependency 'APDSmaatoAdapter', '2.10.2.1'
   s.dependency 'APDStartAppAdapter', '2.10.2.1'
   s.dependency 'APDUnityAdapter', '2.10.2.1'
   s.dependency 'APDVungleAdapter', '2.10.2.1'
   s.dependency 'APDYandexAdapter', '2.10.2.1'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
