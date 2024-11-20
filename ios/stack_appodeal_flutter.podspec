#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint stack_appodeal_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'stack_appodeal_flutter'
  s.version          = '3.3.2'
  s.summary          = 'Appodeal flutter plugin'
  s.description      = <<-DESC
  Flutter plugin for Appodeal SDK. It supports interstitial, rewarded video and banner ads.
  DESC
  s.homepage         = 'http://appodeal.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { "author" => "appodeal.com" }
  s.platform         = :ios, "10.0"
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'

  s.requires_arc     = true
  s.static_framework = true

  s.dependency 'Flutter'
  s.dependency "Appodeal", "3.4.0-beta.2"
  s.dependency "APDIABAdapter", "3.4.0.0-beta.2"

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
