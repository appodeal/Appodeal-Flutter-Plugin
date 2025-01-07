# Appodeal Flutter

Official Appodeal Flutter Plugin for your Flutter application.

## Appodeal SDK 3.4.1

- **Google CMP and TCF v2 Support**
  - To enhance the relevance of ads for your users and comply with regulations like GDPR and CCPA,
    explicit user consent is required for collecting personal data.
  - We recommend using the Stack Consent Manager, built on Google User Messaging Platform (UMP),
    as a ready-made solution to obtain user consent.
  - Follow this [instruction](https://docs.appodeal.com/advanced/google-cmp-and-tcfv2-support) to
    configure Google UMP and set up a consent form.
  - If you have questions about Stack Consent Manager and Google UMP, please contact our support team.

- **AdMob Bidding Support**
  - Download our newest version of AdMob Sync tool from this [page](https://amsa-updates.appodeal.com/) and perform a sync.
  - Read more about AdMob Sync in our [guide](https://docs.appodeal.com/networks-setup/admob-sync).

- **Already included ready-made consent solution**
  - Starting from Appodeal SDK 3.0, during the **first initialization**, a ready-made consent window will be shown if the user is in regions
    covered by GDPR and CCPA. [See more about this behavior](#step-2-appodeal-consent-solution)

- **Support Monetization + UA + Analytics data services**
  - Get insights and find out if your active UA campaigns bring you revenue or make you lose money.
  - Track your metrics with Firebase Keywords. Analyze how product A/B test (via Firebase remote config) affects both
    your product and monetization. [See more about services](#services)

## Table of Contents

- [Installation](#installation)
    - [iOS](#ios)
    - [Android](#android)
    - [Admob configuration](#admob-configuration)
- [Services](#services)
    - [Adjust](#adjust)
    - [AppsFlyer](#appsflyer)
    - [Firebase](#firebase)
    - [Meta](#meta)
    - [Tracking In-App Purchases](#tracking-in-app-purchases)
    - [Event tracking](#event-tracking)
- [Usage](#usage)
    - [Initialisation](#initialisation)
    - [Callbacks](#callbacks)
    - [Presentation](#presentation)
    - [Ad View](#ad-view)
- [Privacy Policy and Consent](#privacy-policy-and-consent)
    - [Step 1: Update Privacy Policy](#step-1-update-privacy-policy)
    - [Step 2: Appodeal Consent Solution](#step-2-appodeal-consent-solution)
- [App-ads.txt](#app-adstxt)
- [App Tracking Transparency](#app-tracking-transparency)
- [Changelog](CHANGELOG.md)

## Installation

Add the dependency to the `pubspec.yaml` file in your project:

```yaml
dependencies:
  stack_appodeal_flutter: 3.4.1
```

Install the plugin by running the command below in the terminal:

```
$ flutter pub get
```

#### iOS

> [!IMPORTANT]
> - iOS 12.0 or higher. You still can integrate Appodeal SDK into a project with a lower value of minimum iOS version. However, on devices that don't support iOS 12.0+ our SDK will just be disabled.
> - Appodeal SDK is compatible with both ARC and non-ARC projects.
> - Use Xcode 14.3 or higher.

1. Go to `ios/` folder and open *Podfile*
2. Add Appodeal adapters. Add pods into `./ios/Podfile`:

```ruby
source 'https://cdn.cocoapods.org'
source 'https://github.com/appodeal/CocoaPods.git'
source 'https://github.com/bidon-io/CocoaPods_Specs.git'

platform :ios, '13.0'

use_frameworks!

def appodeal
  pod 'Appodeal', '3.4.1'
  pod 'APDAdjustAdapter', '3.4.1.0'
  pod 'APDAmazonAdapter', '3.4.1.0'
  pod 'APDAppLovinAdapter', '3.4.1.0'
  pod 'APDAppLovinMAXAdapter', '3.4.1.0'
  pod 'APDAppsFlyerAdapter', '3.4.1.0'
  pod 'APDBidMachineAdapter', '3.4.1.1'
  pod 'APDBidonAdapter', '3.4.1.0'
  pod 'APDBigoAdsAdapter', '3.4.1.0'
  pod 'APDDTExchangeAdapter', '3.4.1.1'
  pod 'APDFacebookAdapter', '3.4.1.0'
  pod 'APDFirebaseAdapter', '3.4.1.0'
  pod 'APDGoogleAdMobAdapter', '3.4.1.0'
  pod 'APDIABAdapter', '3.4.1.0'
  pod 'APDInMobiAdapter', '3.4.1.0'
  pod 'APDIronSourceAdapter', '3.4.1.0'
  pod 'APDMetaAudienceNetworkAdapter', '3.4.1.0'
  pod 'APDMintegralAdapter', '3.4.1.0'
  pod 'APDMyTargetAdapter', '3.4.1.0'
  pod 'APDPangleAdapter', '3.4.1.0'
  pod 'APDSentryAdapter', '3.4.1.0'
  pod 'APDSmaatoAdapter', '3.4.1.0'
  pod 'APDUnityAdapter', '3.4.1.0'
  pod 'APDVungleAdapter', '3.4.1.0'
  pod 'APDYandexAdapter', '3.4.1.0'
  pod 'AmazonPublisherServicesSDK', '4.10.1.0'
  pod 'AppLovinMediationAmazonAdMarketplaceAdapter', '4.10.1.0'
  pod 'AppLovinMediationBidMachineAdapter', '3.1.2.0.0'
  pod 'AppLovinMediationFacebookAdapter', '6.15.2.1'
  pod 'AppLovinMediationFyberAdapter', '8.3.4.0'
  pod 'AppLovinMediationGoogleAdManagerAdapter', '11.12.0.0'
  pod 'AppLovinMediationGoogleAdapter', '11.12.0.0'
  pod 'AppLovinMediationInMobiAdapter', '10.8.0.0'
  pod 'AppLovinMediationIronSourceAdapter', '8.5.0.0.0'
  pod 'AppLovinMediationMintegralAdapter', '7.7.3.0.0'
  pod 'AppLovinMediationMyTargetAdapter', '5.21.9.1'
  pod 'AppLovinMediationUnityAdsAdapter', '4.12.5.0'
  pod 'AppLovinMediationVungleAdapter', '7.4.1.1'
  pod 'AppLovinMediationYandexAdapter', '5.2.1.0'
  pod 'BidMachineAmazonAdapter', '3.1.0.0'
  pod 'BidMachineMetaAudienceAdapter', '3.1.0.2'
  pod 'BidMachineMintegralAdapter', '3.1.0.0'
  pod 'BidMachineMyTargetAdapter', '3.1.0.0'
  pod 'BidMachinePangleAdapter', '3.1.0.0'
  pod 'BidMachineVungleAdapter', '3.1.0.0'
  pod 'BidonAdapterAppLovin', '0.7.1.0'
  pod 'BidonAdapterBidMachine', '0.7.1.1'
  pod 'BidonAdapterBigoAds', '0.7.1.0'
  pod 'BidonAdapterChartboost', '0.7.1.0'
  pod 'BidonAdapterDTExchange', '0.7.1.1'
  pod 'BidonAdapterGoogleAdManager', '0.7.1.0'
  pod 'BidonAdapterGoogleMobileAds', '0.7.1.0'
  pod 'BidonAdapterInMobi', '0.7.1.0'
  pod 'BidonAdapterIronSource', '0.7.1.0'
  pod 'BidonAdapterMetaAudienceNetwork', '0.7.1.0'
  pod 'BidonAdapterMintegral', '0.7.1.0'
  pod 'BidonAdapterMyTarget', '0.7.1.0'
  pod 'BidonAdapterUnityAds', '0.7.1.0'
  pod 'BidonAdapterVungle', '0.7.1.0'
  pod 'BidonAdapterYandex', '0.7.1.0'
  pod 'bigo-ads-max-adapter', '4.5.1.1'
end

target 'Runner' do
  use_frameworks!
  use_modular_headers!
  appodeal

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end
```

You can change following implementation to use custom mediation setup.
See [docs](https://docs.appodeal.com/en/ios/get-started#getstarted-Step1.ImportSDK).

> Note: Appodeal requires to use `use_frameworks!`. You need to remove Flipper dependency from Podfile and AppDelegate.

3. Call `pod install`
4. Open `.xcworkspace`
5. Configfure `info.plist`.

##### SKAdNetworkIds

Ad networks used in Appodeal mediation support conversion tracking using Apple's `SKAdNetwork`,
which means ad networks are able to attribute an app install even when IDFA is unavailable. To
enable this functionality, you will need to update the `SKAdNetworkItems` key with an additional
dictionary in your `Info.plist`.

- Select **Info.plist** in the Project navigator in Xcode
- Right-click on **Info.plist** file → Open as → Source Code
- Copy the **SKAdNetworkItems** from below and paste it into your **Info.plist** file

<details>
  <summary>There is SKAdNetworks IDs in Info.plist format</summary>

```xml
<key>SKAdNetworkItems</key>
<array>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>22mmun2rn5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>238da6jt44.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>24t9a8vw3c.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>24zw6aqk47.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>252b5q8x7y.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>275upjj5gd.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>294l99pt4k.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>2fnua5tdw4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>2q884k2j68.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>2rq3zucswp.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>2tdux39lx8.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>2u9pt9hc89.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>32z4fx6l9h.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>33r6p7g8nc.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3cgn6rq224.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3l6bd9hu43.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3qcr597p9d.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3qy4746246.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3rd42ekr43.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3sh42y64q3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>424m5254lk.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4468km3ulz.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>44jx6755aq.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>44n7hlldy6.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>47vhws6wlr.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>488r3q3dtq.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4dzt52r2t5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4fzdc2evr5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4mn522wn87.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4pfyvq9l8r.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4w7y6s5ca2.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>523jb4fst2.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>52fl2v3hgk.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>54nzkqm89y.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>55644vm79v.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>55y65gfgn7.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>577p5t736z.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>578prtvx9j.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>5a6flpkh64.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>5f5u5tfb26.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>5ghnmfs3dh.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>5l3tpt7t6e.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>5lm9lj6jb7.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>5mv394q32t.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>5tjdwbrq8w.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>627r9wr2y5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>633vhxswh4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>67369282zy.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>6964rsfnh4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>6g9af3uyq4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>6p4ks3rnbw.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>6qx585k4p6.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>6rd35atwn8.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>6v7lgmsu45.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>6xzpu9s2p8.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>6yxyv74ff7.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>737z793b9f.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>74b6s63p6l.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>7953jerfzd.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>79pbpufp6p.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>79w64w269u.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>7bxrt786m8.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>7fbxrn65az.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>7fmhfwg9en.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>7k3cvf297u.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>7rz58n8ntl.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>7tnzynbdc7.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>7ug5zh24hu.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>84993kbrcf.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>866k9ut3g3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>88k8774x49.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>899vrgt9g8.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>89z7zv988g.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>8c4e2ghe7u.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>8m87ys6875.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>8qiegk9qfv.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>8r8llnkz5a.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>8s468mfl3y.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>8w3np9l82g.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>97r2b46745.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9b89h5y424.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9g2aggbj52.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9nlqeag3gk.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9rd848q2bz.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9t245vhmpl.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9vvzujtq5s.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9wsyqb3ku7.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9yg77x724h.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>a2p9lx4jpn.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>a7xqa6mtl2.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>a8cz6cu7e5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>au67k4efj4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>av6w8kgt66.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>axh5283zss.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>b55w3d8y8z.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>b9bk5wbcq9.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>bvpn9ufa9b.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>bxvub5ada5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>c3frkrj4fj.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>c6k4g5qg8m.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>c7g47wypnu.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>cad8qz2s3j.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ce8ybjwass.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>cg4yq2srnc.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>cj5566h2ga.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>cp8zw746q7.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>cs644xg564.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>cstr6suwn9.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>cwn433xbcr.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>d7g9azk84q.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>dbu4b84rxf.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>dd3a75yxkv.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>dkc879ngq3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>dmv22haz9p.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>dn942472g5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>dr774724x4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>dt3cjx1a9i.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>dticjx1a9i.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>dzg6xy7pwj.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>e5fvkxwrpn.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ecpz2srf59.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>eh6m2bh4zr.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ejvt5qm6ak.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>eqhxz8m8av.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>f38h382jlk.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>f73kdq92p3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>f7s53z58qe.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>feyaarzu9v.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>fkak3gfpt6.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>fz2k2k5tej.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>g28c52eehv.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>g2y4y55b64.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>g69uk9uh2b.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>g6gcrrvk4p.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>gfat3222tu.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ggvn48r87g.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>glqzh8vgby.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>gta8lk7p23.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>gta9lk7p23.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>gvmwg8q7h5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>h5jmj969g5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>h65wbv5k3f.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>h8vml93bkz.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>hb56zgv37p.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>hdw39hrw9y.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>hjevpa356n.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>hs6bdukanm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>jb7bn6koa5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>jk2fsx2rgz.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>k674qkevps.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>k6y4y55b64.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>kbd757ywx3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>kbmxgpxpgc.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>klf5c3l5u5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>krvm3zuq6h.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>l6nv3x923s.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>l93v5h6a4m.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ln5gz23vtd.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>lr83yxwka7.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ludvb6z3bs.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>m297p6643m.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>m5mvw97r93.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>m8dbw4sv7c.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>mj797d8u6f.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>mlmmfzh3r3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>mls7yz5dvl.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>mp6xlyr22a.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>mqn7fxpca7.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>mtkv5xtk9e.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>n38lu8286q.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>n66cz3y3bx.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>n6fk4nfna4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>n9x2a789qt.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>nfqy3847ph.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>nrt9jy4kw9.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>nu4557a4je.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>nzq8sh4pbs.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>p78axxw29g.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>pd25vrrwzn.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ppxm28t8ap.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>prcb7njmu6.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>pu4na253f3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>pwa73g5rt2.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>pwdxu55a5a.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>qlbq5gtkt8.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>qqp299437r.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>qu637u8glc.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>qwpu75vrh2.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>r26jy69rpl.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>r45fhb6rf7.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>r8lj5b58b5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>rvh3l7un93.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>rx5hdcabgc.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>s39g8k73mm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>s69wq72ugq.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>sczv5946wb.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>su67r6k2v3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>t38b2kh725.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>t3b3f7n3x8.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>t6d3zquu66.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>t7ky8fmwkd.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>tl55sbb4fm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>tmhh9296z4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>tvvz7th9br.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>u679fj5vs4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>uw77j35x4d.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>uzqba5354d.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>v4nxqhlyqp.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>v72qych5uu.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>v7896pgt74.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>v79kvwwj4g.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>v9wttpbfk9.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>vc83br9sjg.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>vcra2ehyfk.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>vhf287vqwu.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>vutu7akeur.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>w28pnjg2k4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>w7jznl3r6g.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>w9q455wk68.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>wg4vff78zm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>wzmmz9fp6w.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>x2jnk7ly8j.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>x44k69ngh6.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>x5854y7y24.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>x5l83yy675.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>x8jxxk4ff5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>x8uqf25wch.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>xga6mpmplv.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>xmn954pzmp.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>xx9sdjej2w.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>xy9t38ct57.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>y45688jllp.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>y5ghdn5j9k.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>y755zyxw56.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>yclnxrl5pm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ydx93a7ass.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>yrqqpx2mcb.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>z24wtl6j62.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>z4gj7hsk7h.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>z5b3gh5ugf.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>z959bm4gru.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>zh3b7bxvad.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>zmvfpc5aq8.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>zq492l623r.skadnetwork</string>
    </dict>
</array>
```
</details>

##### App Transport Security

In order to serve ads, the SDK requires you to allow arbitrary loads. Set up the following keys
in `Info.plist` of your app:

- Go to your **Info.plist** file, then press Add+ anywhere in the first column of the key list.
- Add **App Transport Security Settings** key and set its type to **Dictionary** in the second
  column.
- Press **Add+** at the end of the name **App Transport Security Settings** key and choose **Allow
  Arbitrary loads**. Set its type to **Boolean** and its value to **Yes**.

<details>
  <summary>There is App Transport Security settings in Info.plist format</summary>

``` xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```

</details>

##### Other feature usage descriptions

To improve ad performance the following entries should be added:

- **NSUserTrackingUsageDescription** - Starting from iOS 14, using IDFA requires permission from the user. The following
  entry must be added in order to improve ad performance.
- **NSLocationWhenInUseUsageDescription** - Entry is required if your application allows Appodeal SDK to use location
  data.
- **NSCalendarsUsageDescription** - Recommended by some ad networks.

<details>
  <summary>There is Other feature usage descriptions settings in Info.plist format</summary>

``` xml
<key>NSUserTrackingUsageDescription</key>
<string><App Name> needs your advertising identifier to provide personalised advertising experience tailored to you</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string><App Name> needs your location for analytics and advertising purposes</string>
<key>NSCalendarsUsageDescription</key>
<string><App Name> needs your calendar to provide personalised advertising experience tailored to you</string>
```

</details>

6. Build your project

#### Android

> [!IMPORTANT]
> - Android API level 21 (Android OS 5.0) or higher.

1. Add Appodeal adapters.

Add dependencies into `build.gradle` (module: app)

``` groovy
dependencies {
    // ... other project dependencies
    implementation ('com.appodeal.ads:sdk:3.4.1.0') {
        exclude group: 'com.appodeal.ads.sdk.services', module: 'adjust'
        exclude group: 'com.appodeal.ads.sdk.services', module: 'appsflyer'
        exclude group: 'com.appodeal.ads.sdk.services', module: 'firebase'
        exclude group: 'com.appodeal.ads.sdk.services', module: 'facebook_analytics'
    }
    ...
}
```

Add repository into `build.gradle` (module: project)

``` groovy
allprojects {
    repositories {
        ...
        jcenter()
        maven { url "https://artifactory.appodeal.com/appodeal" }
        ...
    }
}
```

> Note: You can change following implementation to use custom mediation setup.
> See [Docs](https://docs.appodeal.com/en/android/get-started#getstarted-ImportSDK).

2. Build your project

#### Admob configuration

> [!WARNING]  
> Admob Bidding is now available since Appodeal SDK 3.2.0.\
> Don't forget to download our newest version of Admob Sync tool from this page and perform sync.\
> You can read more about Admob Sync in
> our [guide](https://docs.appodeal.com/networks-setup/admob-sync).

- **How to add Admob Ad Network to your project:**

  Add your AdMob app id to `meta-data` tag:

  ```xml
  <manifest>
      <application>
          <!-- Add your AdMob App ID -->
          <meta-data
              android:name="com.google.android.gms.ads.APPLICATION_ID"
              android:value="ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"/>
      </application>
  </manifest>
  ```

  Add your AdMob app id to `Info.plist`.
  Use the key *GADApplicationIdentifier* with the value being your AdMob app ID:

  ```xml
  <key>GADApplicationIdentifier</key> 
  <string>YOUR_ADMOB_APP_ID</string>
  ```

- **How to remove Admob Ad Network from your project:**

  Change next dependencies into `build.gradle` (module: app)

  ```groovy
  dependencies {
      ...
      // ... other project dependencies
      implementation('com.appodeal.ads:sdk:3.4.1.0') {
          // ad networks
          exclude group: "com.appodeal.ads.sdk.networks", module: "admob"
          exclude group: "org.bidon", module: "admob-adapter"
          exclude group: "org.bidon", module: "gam-adapter"
          exclude group: "com.applovin.mediation", module: "google-adapter"
          exclude group: "com.applovin.mediation", module: "google-ad-manager-adapter"
          // services
          exclude group: 'com.appodeal.ads.sdk.services', module: 'adjust'
          exclude group: 'com.appodeal.ads.sdk.services', module: 'appsflyer'
          exclude group: 'com.appodeal.ads.sdk.services', module: 'firebase'
          exclude group: 'com.appodeal.ads.sdk.services', module: 'facebook_analytics'
      }
      ...
  }
  ```

  Remove next pods from `Podfile`:

  ```ruby
  pod 'APDGoogleAdMobAdapter', '3.4.1.0'
  pod 'BidonAdapterGoogleAdManager', '0.7.1.0'
  pod 'BidonAdapterGoogleMobileAds', '0.7.1.0'
  pod 'AppLovinMediationGoogleAdManagerAdapter', '11.12.0.0'
  pod 'AppLovinMediationGoogleAdapter', '11.12.0.0'
  ```

## Services

Please, read iOS and Android docs at [wiki](https://docs.appodeal.com/) to get deeper understanding how
Appodeal SDK Services works.

#### Adjust

Add dependencies into build.gradle (module: app)

```groovy
dependencies {
    // ... other project dependencies
    implementation 'com.appodeal.ads.sdk.services:adjust:3.4.1.0'
}
```

Add dependencies into _Podfile_

```ruby
def appodeal
  // ... other project pods
  pod 'APDAdjustAdapter', '3.4.1.0'
end
```

#### AppsFlyer

Add dependencies into build.gradle (module: app)

```groovy
dependencies {
    // ... other project dependencies
  implementation 'com.appodeal.ads.sdk.services:appsflyer:3.4.1.0'
}
```

Add dependencies into _Podfile_

```ruby
def appodeal
  // ... other project pods
  pod 'APDAppsFlyerAdapter', '3.4.1.0'
end
```

#### Firebase

Add dependencies into build.gradle (module: app)

```groovy
dependencies {
    // ... other project dependencies
    implementation 'com.appodeal.ads.sdk.services:firebase:3.4.1.0'
}
```

Add dependencies into _Podfile_

```ruby
def appodeal
  // ... other project pods
  pod 'APDFirebaseAdapter', '3.4.1.0'
end
```

#### Meta

Add dependencies into build.gradle (module: app)

```groovy
dependencies {
    // ... other project dependencies
    implementation 'com.appodeal.ads.sdk.services:facebook_analytics:3.4.1.0'
}
```

Add dependencies into _Podfile_

```ruby
def appodeal
  // ... other project pods
  pod 'APDFacebookAdapter', '3.4.1.0'
end
```

##### Tracking In-App Purchases

> Note: In-App purchase tracking will work only with connection with Adjust/Appsflyer.

It's possible to track in-app purchase information and send info to Appodeal servers for analytics. It allows to group
users by the fact of purchasing in-apps. This will help you to adjust the ads for such users or simply turn it off, if
needed. To make this setting work correctly, please submit the purchase info via the Appodeal SDK.

* For App Store:

```dart
final purchase = AppodealAppStorePurchase.nonConsumable(
    orderId: orderId,
    price: price,
    currency: currency,
    transactionId: transactionId,
    additionalParameters: {});
    
Appodeal.validateInAppPurchase(
    purchase: purchase,
    onInAppPurchaseValidateSuccess: (purchase, errors) {},
    onInAppPurchaseValidateFail: (purchase, errors) {});
```

| Parameter            | Description                                            | Usage                     |
|----------------------|--------------------------------------------------------|---------------------------|
| orderId              | Product purchased unique order id for the transaction. | Adjust/AppsFlyer          |
| price                | In-app event revenue.                                  | Adjust/AppsFlyer/Appodeal |
| currency             | In-app event currency.                                 | Adjust/AppsFlyer/Appodeal |
| transactionId        | Product purchased transaction id.                      | Adjust/AppsFlyer          |
| additionalParameters | Additional parameters of the in-app event.             |                           |

* For Play Store:

```dart
final purchase = AppodealPlayStorePurchase.inapp(
    orderId: orderId,
    price: price,
    currency: currency,
    additionalParameters: {})
  ..sku = sku
  ..publicKey = publicKey
  ..signature = signature
  ..purchaseData = purchaseData
  ..purchaseToken = purchaseToken
  ..purchaseTimestamp = purchaseTimestamp
  ..developerPayload = developerPayload
  
Appodeal.validateInAppPurchase(
    purchase: purchase,
    onInAppPurchaseValidateSuccess: (purchase, errors) {},
    onInAppPurchaseValidateFail: (purchase, errors) {});
```

| Parameter            | Description                                                                                                        | Usage                     |
|----------------------|--------------------------------------------------------------------------------------------------------------------|---------------------------|
| purchaseType         | Purchase type. Must be InAppPurchase.Type.InApp or InAppPurchase.Type.Subs                                         | Adjust/AppsFlyer          |
| publicKey            | [Public key from Google Developer Console.](https://support.google.com/googleplay/android-developer/answer/186113) | AppsFlyer                 |
| signature            | Transaction signature (returned from Google API when the purchase is completed).                                   | Adjust/AppsFlyer          |
| purchaseData         | Product purchased in JSON format (returned from Google API when the purchase is completed).                        | AppsFlyer                 |
| purchaseToken        | Product purchased token (returned from Google API when the purchase is completed).                                 | Adjust                    |
| purchaseTimestamp    | Product purchased timestamp (returned from Google API when the purchase is completed).                             | Adjust                    |
| developerPayload     | Product purchased developer payload (returned from Google API when the purchase is completed).                     | Adjust                    ||
| orderId              | Product purchased unique order id for the transaction (returned from Google API when the purchase is completed).   | Adjust                    |
| sku                  | Stock keeping unit id.                                                                                             | Adjust                    |
| price                | In-app event revenue.                                                                                              | Adjust/AppsFlyer/Appodeal |
| currency             | In-app event currency.                                                                                             | Adjust/AppsFlyer/Appodeal |
| additionalParameters | Additional parameters of the in-app event.                                                                         |                           |

##### Event tracking

Appodeal SDK allows you to send events to analytic services such as Firebase, AppsFlyer, Adjust and Meta using a single
method:

```dart
Appodeal.logEvent("example_event_name", {
  "example_param_1": "example_param_value_1",
  "example_param_2": 123
});
```

## Usage

Please, read iOS and Android docs at [wiki](https://docs.appodeal.com/) to get deeper understanding how
Appodeal SDK works.

### Initialisation

1. Initialise Appodeal at application launch. To initialize Appodeal SDK use this following method:

```dart
Appodeal.initialize(
    appKey: "YOUR_APPODEAL_APP_KEY",
    adTypes: [
      AppodealAdType.Interstitial,
      AppodealAdType.RewardedVideo,
      AppodealAdType.Banner,
      AppodealAdType.MREC
    ],
    onInitializationFinished: (errors) => {});
```

> Note: Make sure to replace "YOUR_APPODEAL_APP_KEY" with the actual app key.

Use the type codes below to set the preferred ad format:

- `AppodealAdType.Interstitial` for interstitial.
- `AppodealAdType.RewardedVideo` for rewarded videos.
- `AppodealAdType.Banner` for banners.
- `AppodealAdType.MREC` for 300*250 banners.

2. Configure SDK

* General configuration

> Call this method before initilisation

``` dart
// Set ad auto caching enabled or disabled
// By default autocache is enabled for all ad types
Appodeal.setAutoCache(AppodealAdType.Interstitial, false); //default - true

// Set testing mode
Appodeal.setTesting(false); //default - false

// Set Appodeal SDK logging level
Appodeal.setLogLevel(Appodeal.LogLevelVerbose); //default - Appodeal.LogLevelNone

// Enable or disable child direct threatment
Appodeal.setChildDirectedTreatment(false); //default - false

// Disable network for specific ad type
Appodeal.disableNetwork("admob");
Appodeal.disableNetwork("admob", AppodealAdType.Interstitial);
```

* Segments and targeting.

``` dart
// Set segment filter
Appodeal.setCustomFilter("levels_played", "levelsPlayed");

// Set extras
Appodeal.setExtraData("attribuition_id", "some value");
```

* Banner specific

``` dart
// Enable or disable tablet banners.
// SUPORTED ONLY FOR NON-VIEW DISPLAYING
// THIS METHOD DOES NOT WORK CORRECTLY FOR BANNER VIEW BECAUSE BANNER VIEW DOES NOT SUPPORT TABLET FORMAT
Appodeal.setTabletBanners(false); //default - false

// Enable or disable smart banners. 
// SUPORTED ONLY FOR NON-VIEW DISPLAYING
// iOS smart banners are supported only for applications where autorotation is disabled
Appodeal.setSmartBanners(false); //default - false

// Enable or disable banner refresh animation
Appodeal.setBannerAnimation(true); //default - true
```

* Android specific

``` dart
// Mute calls if calls muted on Android
Appodeal.muteVideosIfCallsMuted(bool); //default - false

// Enable or disable banner auto resume screen. 
// SUPORTED ONLY FOR NON-VIEW DISPLAYING
Appodeal.setAdViewAutoResume(true); //default - true
```

* Ad revenue information

```dart
// If you want to get revenue information you can use request callback.
// Called every time when SDK receives a revenue information for an ad.
Appodeal.setAdRevenueCallbacks(onAdRevenueReceive: (adRevenue) => {});
```

### Callbacks

Set callbacks listener to get track of ad lifecycle events.

1. Banner

```dart
Appodeal.setBannerCallbacks(
        onBannerLoaded: (isPrecache) => {},
        onBannerFailedToLoad: () => {},
        onBannerShown: () => {},
        onBannerShowFailed: () => {},
        onBannerClicked: () => {},
        onBannerExpired: () => {});
```

2. MREC

```dart
Appodeal.setMrecCallbacks(
        onMrecLoaded: (isPrecache) => {},
        onMrecFailedToLoad: () => {},
        onMrecShown: () => {},
        onMrecShowFailed: () => {},
        onMrecClicked: () => {},
        onMrecExpired: () => {});
```

3. Interstitial

```dart
Appodeal.setInterstitialCallbacks(
        onInterstitialLoaded: (isPrecache) => {},
        onInterstitialFailedToLoad: () => {},
        onInterstitialShown: () => {},
        onInterstitialShowFailed: () => {},
        onInterstitialClicked: () => {},
        onInterstitialClosed: () => {},
        onInterstitialExpired: () => {});
```

4. Rewarded video

```dart
Appodeal.setRewardedVideoCallbacks(
        onRewardedVideoLoaded: (isPrecache) => {},
        onRewardedVideoFailedToLoad: () => {},
        onRewardedVideoShown: () => {},
        onRewardedVideoShowFailed: () => {},
        onRewardedVideoFinished: (amount, reward) => {},
        onRewardedVideoClosed: (isFinished) => {},
        onRewardedVideoExpired: () => {},
        onRewardedVideoClicked: () => {});
```

### Presentation

> Note: All presentation specific methods are available only after SDK initialisation

1. Caching

If you disable autocache you should call `cache` method before trying to show any ad

``` dart
Appodeal.cache(AppodealAdType.Interstitial);
```

2. Check that ad is loaded and can be shown

``` dart
// Check that interstitial
var isCanShow = await Appodeal.canShow(AppodealAdType.Interstitial);
// Check that interstitial is loaded
var isLoaded = await Appodeal.isLoaded(AppodealAdType.Interstitial);
```

3. Show advertising

``` dart
// Show interstitial
Appodeal.show(AppodealAdType.Interstitial);

// Show banner
Appodeal.show(AppodealAdType.BannerBottom); // Display banner at the bottom of the screen
Appodeal.show(AppodealAdType.BannerTop); // Display banner at the top of the screen
Appodeal.show(AppodealAdType.BannerLeft); // Display banner at the left of the screen
Appodeal.show(AppodealAdType.BannerRight); // Display banner at the right of the screen

// Show interstitial for specific pacement
Appodeal.show(AppodealAdType.Interstitial, “placementName”);
```

4. Hide

You can hide banner/MREC ad after it was shown. Call `hide` method with another ad types won't affect anything

``` dart
Appodeal.hide(AppodealAdType.BannerTop); //AppodealAdType.MREC
```

5. Destroy

To free memory from hidden banner/MREC call the code below:

```dart
Appodeal.destroy(AppodealAdType.Banner); //AppodealAdType.MREC
```

## Ad View

**Display banner/MREC ad view at a custom position**

> Note: Ad View presentation support only fixed banners size - `320x50` and `300x250`.

To display a Banner view add widget:

```dart
child: AppodealBanner(adSize: AppodealBannerSize.BANNER, placement: "default");
```

To display a MREC view add widget:

```dart
child: AppodealBanner(adSize: AppodealBannerSize.MEDIUM_RECTANGLE, placement: "default");
```

## Privacy Policy and Consent

> Note: Keep in mind that it’s best to contact qualified legal professionals, if you haven’t done so already, to get
> more information and be well-prepared for compliance.

The General Data Protection Regulation, better known as GDPR, took effect on May 25, 2018. It’s a set of rules designed
to give EU citizens more control over their personal data. Any businesses established in the EU or with users based in
Europe are required to comply with GDPR or risk facing heavy fines. The California Consumer Privacy Act (CCPA) went into
effect on January 1, 2020. **We have put together some resources below to help publishers understand better the steps
they need to take to be GDPR compliant.**

> Note: You can learn more about GDPR and CCPA and their.
> differences [here](https://iapp.org/resources/article/ccpa-and-gdpr-comparison-chart/).

### Step 1: Update Privacy Policy

**1.1 Make sure your privacy policy includes information about advertising ID collection.**
Don’t forget to add information about IP address and advertising ID collection, as well
as [the link to Appodeal’s privacy policy](https://www.appodeal.com/privacy-policy) to your app’s privacy policy in
Google Play and App Store.

To speed up the process, you could
use [privacy policy generators](https://app-privacy-policy-generator.firebaseapp.com/) —just insert advertising ID, IP
address, and location (if you collect a user’ location) in the "Personally Identifiable Information you collect" field (
in line with other information about your app)
and [the link to Appodeal’s privacy policy](https://www.appodeal.com/privacy-policy) in "Link to the privacy policy of
third party service providers used by the app".

**1.2 Add a privacy policy to your mobile app.**
You must add your explicit privacy policies in two places: your app’s Store Listing page and within your app.

You can find detailed instructions on adding your privacy policy to your app on legal service websites. For example,
Iubenda, the solution tailored to legal compliance, provides
a [comprehensive guide](https://www.iubenda.com/blog/privacy-policy-for-android-app/) on including a privacy policy in
your app.

Make sure that your privacy policy website has an SSL-certificate—this point might seem to be obvious, but it’s still
essential.

Here’s are two useful resources that you can utilize while working on your app compliance:
[Privacy, Security and Deception regulations (by Google Play)](https://play.google.com/intl/en-GB_ALL/about/privacy-security-deception/user-data/)
[Recommendations on Developing a Meaningful Privacy Policy (by Attorney General California Department of Justice)](https://oag.ca.gov/sites/all/files/agweb/pdfs/cybersecurity/making_your_privacy_practices_public.pdf)

> Note: Please note that although we’re always eager to back you up with valuable information, we’re not authorized to
> provide any legal advice. It’s important to address your questions to lawyers who work specifically in this area.

### Step 2: Appodeal Consent Solution

In order for Appodeal and our ad providers to deliver ads that are more relevant to your users, as a
mobile app publisher, you need to collect explicit user consent in the regions covered by GDPR and
CCPA.

To get consent for collecting personal data of your users, we suggest you use a ready-made
solution - Stack Consent Manager based on Google User Messaging Platform (UMP).

> [!IMPORTANT]
> STARTING FROM APPODEAL SDK 3.0, STACK CONSENT MANAGER IS INCLUDED BY DEFAULT.
> Consent will be requested automatically on SDK initialization, and consent form will be shown if it is necessary without any additional calls.

**If you wish, you can manage and update consent manually using Stack Consent Manager calls.**

- Force Present Consent Form

```dart
// Load consent window
Appodeal.ConsentForm.load(
  appKey: exampleAppodealKey,
  onConsentFormLoadSuccess: (status) {},
  onConsentFormLoadFailure: (error) {},
);

// Show consent window
Appodeal.ConsentForm.show(
  onConsentFormDismissed: (error) {},
);
```

- Force Present Consent Form only when consent is required

```dart
Appodeal.ConsentForm.loadAndShowIfRequired(
  appKey: exampleAppodealKey,
  onConsentFormDismissed: (error) {},
);
```

- Revoke Consent

```dart
Appodeal.ConsentForm.revoke();
```


## App-ads.txt

The app-ads.txt file is a text file which provides a mechanism for publishers to declare their authorized digital sellers.

You can find detailed information [here](https://docs.appodeal.com/advanced/app-ads).

## App Tracking Transparency

Starting in iOS 14.5, IDFA will be unavailable until an app calls the App Tracking Transparency
framework to present the app-tracking authorization request to the end-user. If an app does not
present this request, the IDFA will automatically be zeroed out, which may lead to a significant
loss in ad revenue.

You can read more about App Tracking Transparency in our [guide](https://docs.appodeal.com/ios/next/data-protection/app-tracking-transparency).

To display the App Tracking Transparency authorization request for accessing the IDFA, update your
`Info.plist` to add the *NSUserTrackingUsageDescription* key with a custom message describing the usage.

```
<key>NSUserTrackingUsageDescription</key>
<string>This identifier will be used to deliver personalized ads to you.</string>
```
