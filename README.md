# Appodeal Flutter

Official Appodeal Flutter Plugin for your Flutter application.

## ❗❗ Breaking changes when updating to 3.x.x❗❗

- **Appodeal SDK 3.0 already included ready-made consent solution**
    - Appodeal SDK 3.0 in **first initialization** shows a ready-made consent window if the user is in the regions
      covered by GDPR and CCPA. [See more about this behavior](#step-2-appodeal-consent-new-breaking-changes)

- **Major Api changes**
    - initialize
    - update consent logic
    - ad type logic
    - support impression information

- **Support Monetization + UA + Analytics data services**
    - Get insights and find out if your active UA campaigns bring you revenue or make you lose money.
    - Track your metrics with Firebase Keywords. Analyze how product A/B test (via Firebase remote config) affects both
      your product & monetization.Track your metrics with Firebase Keywords. Analyze how product A/B test (via Firebase
      remote config) affects both your product & monetization. [See more about services](#services)

If you have used one of the removed/changed APIs, please check the integration guide for the updated instructions.

## Table of Contents

- [Installation](#installation)
    - [iOS](#ios)
    - [Android](#android)
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
    - [Step 2: Appodeal Consent Behavior (_**New Breaking Changes**_)](#step-2-appodeal-consent-new-breaking-changes)
- [App Tracking Transparency](#app-tracking-transparency)
- [Changelog](CHANGELOG.md)

## Installation

Add the dependency to the `pubspec.yaml` file in your project:

```yaml
dependencies:
  stack_appodeal_flutter: 3.0.1
```

Install the plugin by running the command below in the terminal:

```
$ flutter pub get
```

#### iOS

1. Go to `ios/` folder and open *Podfile*
2. Add Appodeal adapters. Add pods into `./ios/Podfile`:

```ruby
def appodeal
  pod 'APDAdColonyAdapter', '3.0.1.1'
  pod 'BDMAdColonyAdapter', '~> 1.9.5'
  pod 'APDAppLovinAdapter', '3.0.1.1'
  pod 'APDBidMachineAdapter', '3.0.1.1' # Required
  pod 'BDMCriteoAdapter', '~> 1.9.5'
  pod 'BDMPangleAdapter', '~> 1.9.5'
  pod 'BDMAmazonAdapter', '~> 1.9.5'
  pod 'BDMSmaatoAdapter', '~> 1.9.5'
  pod 'BDMNotsyAdapter', '~> 1.9.5'
  pod 'BDMTapjoyAdapter', '~> 1.9.5'
  pod 'APDGoogleAdMobAdapter', '3.0.1.1'
  pod 'APDIABAdapter', '3.0.1.1' # Required
  pod 'BDMIABAdapter', '~> 1.9.5'
  pod 'APDIronSourceAdapter', '3.0.1.1'
  pod 'APDMetaAudienceNetworkAdapter', '3.0.1.1'
  pod 'BDMMetaAudienceAdapter', '~> 1.9.5'
  pod 'APDMyTargetAdapter', '3.0.1.1'
  pod 'BDMMyTargetAdapter', '~> 1.9.5'
  pod 'APDStackAnalyticsAdapter', '3.0.1.1' # Required
  pod 'APDUnityAdapter', '3.0.1.1'
  pod 'APDVungleAdapter', '3.0.1.1'
  pod 'BDMVungleAdapter', '~> 1.9.5'
  pod 'APDYandexAdapter', '3.0.1.1'
end

target 'Runner' do
  use_frameworks!
  use_modular_headers!
  appodeal

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end
```

You can change following implementation to use custom mediation setup.
See [docs](https://wiki.appodeal.com/en/ios/get-started#getstarted-Step1.ImportSDK).

> Note: Appodeal requires to use `use_frameworks!`. You need to remove Flipper dependency from Podfile and AppDelegate.

3. Run `pod install`
4. Open `.xcworkspace`
5. Configfure `info.plist`.

##### SKAdNetworkIds

Ad networks used in Appodeal mediation support conversion tracking using Apple's *SKAdNetwork*, which means ad networks
are able to attribute an app install even when **IDFA** is unavailable. To enable this functionality, you will need to
update the *SKAdNetworkItems* key with an additional dictionary in your `Info.plist`.

- Select `Info.plist` in the Project navigator in Xcode
- Click the Add button (+) beside a key in the property list editor and press Return
- Type the key name *SKAdNetworkItems*
- Choose an Array type
- Add Key-Value pair where the key is *SKAdNetworkIdentifier* and the value is the ad network identifier

<details>
  <summary>There is SKAdNetworks IDs in Info.plist format:</summary>

``` xml
<key>SKAdNetworkItems</key>
<array>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4pfyvq9l8r.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>6g9af3uyq4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4fzdc2evr5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>2fnua5tdw4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ydx93a7ass.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>cg4yq2srnc.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>v72qych5uu.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>mlmmfzh3r3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>pwdxu55a5a.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>c6k4g5qg8m.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>wg4vff78zm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>g28c52eehv.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>523jb4fst2.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>294l99pt4k.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>hs6bdukanm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>prcb7njmu6.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>m8dbw4sv7c.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9nlqeag3gk.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>cj5566h2ga.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>u679fj5vs4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>a7xqa6mtl2.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>g2y4y55b64.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>wzmmz9fp6w.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>yclnxrl5pm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4468km3ulz.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>t38b2kh725.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>7ug5zh24hu.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>rx5hdcabgc.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>5lm9lj6jb7.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9rd848q2bz.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>n6fk4nfna4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>7rz58n8ntl.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ejvt5qm6ak.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>275upjj5gd.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>kbd757ywx3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9t245vhmpl.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>n9x2a789qt.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>44jx6755aq.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>tl55sbb4fm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>2u9pt9hc89.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>8s468mfl3y.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>klf5c3l5u5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ppxm28t8ap.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>74b6s63p6l.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>kbmxgpxpgc.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>44n7hlldy6.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>5l3tpt7t6e.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>uw77j35x4d.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>6964rsfnh4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>84993kbrcf.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>pwa73g5rt2.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>mtkv5xtk9e.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>e5fvkxwrpn.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>gta9lk7p23.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>r45fhb6rf7.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3rd42ekr43.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ludvb6z3bs.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>737z793b9f.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>mls7yz5dvl.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>w9q455wk68.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>p78axxw29g.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>6xzpu9s2p8.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ggvn48r87g.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3sh42y64q3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>f38h382jlk.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>24t9a8vw3c.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>cstr6suwn9.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>zmvfpc5aq8.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>feyaarzu9v.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>5a6flpkh64.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>glqzh8vgby.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>424m5254lk.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>av6w8kgt66.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>s39g8k73mm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>lr83yxwka7.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>22mmun2rn5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>su67r6k2v3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4w7y6s5ca2.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>dzg6xy7pwj.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>y45688jllp.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>hdw39hrw9y.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4dzt52r2t5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>5tjdwbrq8w.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>32z4fx6l9h.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>xy9t38ct57.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>54nzkqm89y.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9b89h5y424.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>79pbpufp6p.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>s69wq72ugq.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>k674qkevps.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>578prtvx9j.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>f73kdq92p3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>x44k69ngh6.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>mp6xlyr22a.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>qqp299437r.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3qcr597p9d.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>97r2b46745.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>6p4ks3rnbw.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>rvh3l7un93.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>zq492l623r.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>x8uqf25wch.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>b9bk5wbcq9.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>bxvub5ada5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>krvm3zuq6h.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>c3frkrj4fj.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>a2p9lx4jpn.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>v9wttpbfk9.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>n38lu8286q.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>cp8zw746q7.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3qy4746246.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>v4nxqhlyqp.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>y5ghdn5j9k.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>47vhws6wlr.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ecpz2srf59.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>8c4e2ghe7u.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>r26jy69rpl.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>8m87ys6875.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>488r3q3dtq.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>52fl2v3hgk.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>m5mvw97r93.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>89z7zv988g.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>hb56zgv37p.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>6v7lgmsu45.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>m297p6643m.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3l6bd9hu43.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>vcra2ehyfk.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>238da6jt44.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>f7s53z58qe.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>v79kvwwj4g.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>gta8lk7p23.skadnetwork</string>
    </dict>
</array>
```

</details>

##### App Transport Security

In order to serve ads, the SDK requires you to allow arbitrary loads. Set up the following keys in `Info.plist` of your
app:

- Select `Info.plist` in the Project navigator in Xcode
- Click the Add button (+) anywhere in the first column of the key list.
- Add *App Transport Security Settings key* and set its type to **Dictionary** in the second column.
- Press Add button (+) at the end of the name *App Transport Security Settings key* and choose **Allow Arbitrary loads**
- Set its type to Boolean and its value to **Yes**.

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

- **GADApplicationIdentifier** - When including AdMob in your project, you must also add your AdMob app ID to
  your `Info.plist`. Use the key *GADApplicationIdentifier* with the value being your AdMob app ID.
  For more information about Admob sync check out
  our [FAQ](https://faq.appodeal.com/en/articles/4185565-how-do-i-link-my-admob-account).
- **NSUserTrackingUsageDescription** - Starting from iOS 14, using IDFA requires permission from the user. The following
  entry must be added in order to improve ad performance.
- **NSLocationWhenInUseUsageDescription** - Entry is required if your application allows Appodeal SDK to use location
  data.
- **NSCalendarsUsageDescription** - Recommended by some ad networks.

<details>
  <summary>There is Other feature usage descriptions settings in Info.plist format</summary>

``` xml
<key>GADApplicationIdentifier</key> 
<string>YOUR_ADMOB_APP_ID</string>
<key>NSUserTrackingUsageDescription</key>
<string><App Name> needs your advertising identifier to provide personalised advertising experience tailored to you</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string><App Name> needs your location for analytics and advertising purposes</string>
<key>NSCalendarsUsageDescription</key>
<string><App Name> needs your calendar to provide personalised advertising experience tailored to you</string>
```

</details>

6. Build your project (`Cmd+B`)

#### Android

1. Add Appodeal adapters.

Add dependencies into `build.gradle` (module: app)

``` groovy
dependencies {
    ...
    // ... other project dependencies
    implementation ('com.appodeal.ads:sdk:3.0.1.+') {
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
> See [Docs](https://wiki.appodeal.com/en/android/get-started#getstarted-ImportSDK).

2. Network security configuration

Add the Network Security Configuration file to your AndroidManifest.xml:

``` xml
<?xml version="1.0" encoding="utf-8"?>
<manifest>
    <application
		...
        android:networkSecurityConfig="@xml/network_security_config">
    </application>
</manifest>
```

In your *network_security_config.xml* file, add `base-config` that sets `cleartextTrafficPermitted` to `true` :

``` xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <base-config cleartextTrafficPermitted="true">
        <trust-anchors>
            <certificates src="system" />
        </trust-anchors>
    </base-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">127.0.0.1</domain>
    </domain-config>
</network-security-config>
```

3. Admob Configuration (if you use Admob adapter)

``` xml
<manifest>
    <application>
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="[ADMOB_APP_ID]"/>
    </application>
</manifest>
```

For more information about Admob sync check out
our [FAQ](https://faq.appodeal.com/en/articles/4185565-how-do-i-link-my-admob-account).

5. Run your project (`Cmd+R`)

## Services

Please, read iOS and Android docs at [wiki](https://wiki.appodeal.com/) to get deeper understanding how
Appodeal SDK Services works.

#### Adjust

Add dependencies into build.gradle (module: app)

```groovy
dependencies {
    // ... other project dependencies
    implementation 'com.appodeal.ads.sdk.services:adjust:3.0.1.+'
}
```

Add dependencies into _Podfile_

```ruby
def appodeal
  // ... other project pods
  pod 'APDAdjustAdapter', '3.0.1.1'
end
```

#### AppsFlyer

Add dependencies into build.gradle (module: app)

```groovy
dependencies {
    // ... other project dependencies
    implementation 'com.appodeal.ads.sdk.services:appsflyer:3.0.1.+'
}
```

Add dependencies into _Podfile_

```ruby
def appodeal
  // ... other project pods
  pod 'APDAppsFlyerAdapter', '3.0.1.1'
end
```

#### Firebase

Add dependencies into build.gradle (module: app)

```groovy
dependencies {
    // ... other project dependencies
    implementation 'com.appodeal.ads.sdk.services:firebase:3.0.1.+'
}
```

Add dependencies into _Podfile_

```ruby
def appodeal
  // ... other project pods
  pod 'APDFirebaseAdapter', '3.0.1.1'
end
```

#### Meta

Add dependencies into build.gradle (module: app)

```groovy
dependencies {
    // ... other project dependencies
    implementation 'com.appodeal.ads.sdk.services:facebook_analytics:3.0.1.+'
}
```

Add dependencies into _Podfile_

```ruby
def appodeal
  // ... other project pods
  pod 'APDFacebookAdapter', '3.0.1.1'
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

Please, read iOS and Android docs at [wiki](https://wiki.appodeal.com/) to get deeper understanding how
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

* Ad impression information

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

### Step 2: Appodeal Consent (_**New Breaking Changes**_)

In order for Appodeal and our ad providers to deliver ads that are more relevant to your users, as a mobile app
publisher, you need to collect explicit user consent in the regions covered by GDPR and CCPA.

To get consent to the collection of personal data of your users, we suggest you use a ready-made solution that is
already included in Appodeal SDK 3.0.

Appodeal SDK 3.0 in **first initialization** shows a ready-made consent window if the user is in the regions covered by
GDPR and CCPA.

**If you want to change the behavior use the following ways:**

- You can update consent based on your data before initialization:

```dart
// For users is GDPR region
Appodeal.updateGDPRUserConsent(GDPRUserConsent.Personalized); 

// For users is CCPA region
Appodeal.updateCCPAUserConsent(CCPAUserConsent.OptIn);
```

- You can show consent window based on your data before initialization:

```dart
// Load consent window
Appodeal.loadConsentForm(
    appKey: "YOUR_APPODEAL_APP_KEY",
    onLoaded: () {},
    onLoadFailed: (error) {});

// Show consent window
Appodeal.showConsentForm(
    onOpened: () {},
    onShowFailed: (error) {},
    onClosed: () {});
```

## App Tracking Transparency

Starting in iOS 14, IDFA will be unavailable until an app calls the App Tracking Transparency framework to present the
app-tracking authorization request to the end-user. If an app does not present this request, the IDFA will automatically
be zeroed out which may lead to a significant loss in ad revenue.

To display the App Tracking Transparency authorization request for accessing the IDFA, update your `Info.plist` to add
the
NSUserTrackingUsageDescription key with a custom message describing the usage.

```
<key>NSUserTrackingUsageDescription</key>
<string>This identifier will be used to deliver personalized ads to you.</string>
```

If you are using Appodeal SDK 3.x.x in your project there are no additional steps required.
Authorization request will be shown for users under iOS 14.5.

Disable ATT request via Appodeal:

```dart
Appodeal.disableAppTrackingTransparencyRequest();
```