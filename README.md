# Appodeal Flutter

Official Appodeal Flutter Plugin for your Flutter application.

## Appodeal SDK 4.1.0

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
  stack_appodeal_flutter: 4.1.0
```

Install the plugin by running the command below in the terminal:

```
$ flutter pub get
```

#### iOS

> [!IMPORTANT]
> - iOS 13.0 or higher for using the Appodeal Flutter plugin (base SDK).
> - If you integrate the optional Firebase service (see [Firebase](#firebase)), your iOS deployment target must be 15.0 or higher.
> - Appodeal SDK is compatible with both ARC and non-ARC projects.
> - Use Xcode 15.3 or higher.

1. Go to `ios/` folder and open *Podfile*
2. Add Appodeal adapters. Add pods into `./ios/Podfile`:

<!-- appodeal-deps:ios:start -->
```ruby
platform :ios, '15.0'

source 'https://github.com/appodeal/CocoaPods.git'
source 'https://github.com/bidon-io/CocoaPods-Specs.git'
source 'https://cdn.cocoapods.org'

use_frameworks!

def appodeal
    pod 'Appodeal', '4.1.0'
    # AppLovin MAX
    pod 'AppLovinMediationAmazonAdMarketplaceAdapter', '5.3.2.0'
    pod 'AppLovinMediationBidMachineAdapter', '3.6.1.0.0'
    pod 'AppLovinMediationBigoAdsAdapter', '5.0.0.0'
    pod 'AppLovinMediationByteDanceAdapter', '7.7.0.7.0'
    pod 'AppLovinMediationChartboostAdapter', '9.10.1.0'
    pod 'AppLovinMediationFacebookAdapter', '6.20.1.0'
    pod 'AppLovinMediationFyberAdapter', '8.4.1.0'
    pod 'AppLovinMediationGoogleAdManagerAdapter', '12.13.0.0'
    pod 'AppLovinMediationGoogleAdapter', '12.13.0.0'
    pod 'AppLovinMediationInMobiAdapter', '11.1.0.0'
    pod 'AppLovinMediationIronSourceAdapter', '9.1.0.0.0'
    pod 'AppLovinMediationMintegralAdapter', '7.7.9.0.0'
    pod 'AppLovinMediationMobileFuseAdapter', '1.9.3.0'
    pod 'AppLovinMediationMolocoAdapter', '4.1.0.0'
    pod 'AppLovinMediationMyTargetAdapter', '5.36.2.0'
    pod 'AppLovinMediationOguryPresageAdapter', '5.1.1.0'
    pod 'AppLovinMediationPubMaticAdapter', '4.10.0.0'
    pod 'AppLovinMediationSmaatoAdapter', '23.1.0.0'
    pod 'AppLovinMediationUnityAdsAdapter', '4.16.3.0'
    pod 'AppLovinMediationVerveAdapter', '3.8.1.0'
    pod 'AppLovinMediationVungleAdapter', '7.6.2.0'
    pod 'AppLovinMediationYandexAdapter', '7.17.0.0'
    # Level Play
    pod 'IronSourceAdMobAdapter', '5.3.0.0'
    pod 'IronSourceAppLovinAdapter', '5.3.0.0'
    pod 'IronSourceBidMachineAdapter', '5.5.0.0'
    pod 'IronSourceBigoAdapter', '5.1.0.0'
    pod 'IronSourceFacebookAdapter', '5.0.0.0'
    pod 'IronSourceFyberAdapter', '5.2.0.0'
    pod 'IronSourceInMobiAdapter', '5.3.0.0'
    pod 'IronSourceMintegralAdapter', '5.1.0.0'
    pod 'IronSourceMobileFuseAdapter', '5.0.0.0'
    pod 'IronSourceMolocoAdapter', '5.2.0.0'
    pod 'IronSourceMyTargetAdapter', '5.3.0.0'
    pod 'IronSourceOguryAdapter', '5.0.0.0'
    pod 'IronSourcePangleAdapter', '5.5.0.0'
    pod 'IronSourceSmaatoAdapter', '5.2.0.0'
    pod 'IronSourceUnityAdsAdapter', '5.2.0.0'
    pod 'IronSourceVerveAdapter', '5.5.0.0'
    pod 'IronSourceVungleAdapter', '5.3.0.0'
    # Bidon
    pod 'BidonAdapterAmazon', '5.3.2.0'
    pod 'BidonAdapterAppLovin', '13.5.1.0'
    pod 'BidonAdapterBidMachine', '3.6.1.1'
    pod 'BidonAdapterBigoAds', '5.0.0.0'
    pod 'BidonAdapterChartboost', '9.10.1.0'
    pod 'BidonAdapterDTExchange', '8.4.1.0'
    pod 'BidonAdapterInMobi', '11.1.0.0'
    pod 'BidonAdapterIronSource', '9.1.0.0.0'
    pod 'BidonAdapterMetaAudienceNetwork', '6.20.1.0'
    pod 'BidonAdapterMintegral', '7.7.9.0'
    pod 'BidonAdapterMobileFuse', '1.9.3.0'
    pod 'BidonAdapterMoloco', '4.1.0.0'
    pod 'BidonAdapterMyTarget', '5.36.2.0'
    pod 'BidonAdapterStartIo', '4.13.0.0'
    pod 'BidonAdapterTaurusX', '1.15.0.0'
    pod 'BidonAdapterUnityAds', '4.16.3.0'
    pod 'BidonAdapterVungle', '7.6.2.0'
    pod 'BidonAdapterYandex', '7.17.0.0'
    pod 'BidonAdapterZmaticoo', '1.5.6.0'
    # Appodeal
    pod 'AppodealAdjustAdapter', '5.4.6.1'
    pod 'AppodealAmazonAdapter', '5.3.2.0'
    pod 'AppodealAppLovinAdapter', '13.5.1.0'
    pod 'AppodealAppLovinMAXAdapter', '13.5.1.1'
    pod 'AppodealAppsFlyerAdapter', '6.17.7.1'
    pod 'AppodealBidMachineAdapter', '3.6.1.0'
    pod 'AppodealBidonAdapter', '0.14.0.1'
    pod 'AppodealBigoAdsAdapter', '5.0.0.0'
    pod 'AppodealDTExchangeAdapter', '8.4.1.0'
    pod 'AppodealFacebookAdapter', '18.0.1.0'
    pod 'AppodealFirebaseAdapter', '12.4.0.1'
    pod 'AppodealGoogleAdMobAdapter', '12.13.0.0'
    pod 'AppodealIABAdapter', '3.4.7.0'
    pod 'AppodealInMobiAdapter', '11.1.0.0'
    pod 'AppodealIronSourceAdapter', '9.1.0.0.0'
    pod 'AppodealLevelPlayAdapter', '9.1.0.0.0'
    pod 'AppodealMetaAudienceNetworkAdapter', '6.20.1.0'
    pod 'AppodealMintegralAdapter', '7.7.9.0'
    pod 'AppodealMyTargetAdapter', '5.36.2.0'
    pod 'AppodealSentryAdapter', '8.57.2.1'
    pod 'AppodealUnityAdapter', '4.16.3.0'
    pod 'AppodealVungleAdapter', '7.6.2.0'
    pod 'AppodealYandexAdapter', '7.17.0.1'
end

target 'Sample' do
    project 'Sample/Sample.xcodeproj'
    appodeal
    use_modular_headers!

    flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end
```
<!-- appodeal-deps:ios:end -->

> [!TIP]
> Use the [Appodeal Dependencies Wizard](https://docs.appodeal.com/ios/advanced/configure-mediated-networks) to configure mediated networks and generate an always up-to-date dependency list for your Podfile.

> Note: Appodeal requires to use `use_frameworks!`. You need to remove Flipper dependency from Podfile and AppDelegate.

3. Call `pod install`
4. Open `.xcworkspace`
5. Configure `Info.plist`.

##### SKAdNetworkIds

Ad networks used in Appodeal mediation support conversion tracking using Apple's `SKAdNetwork`,
which means ad networks are able to attribute an app install even when IDFA is unavailable. To
enable this functionality, you will need to update the `SKAdNetworkItems` key with an additional
dictionary in your `Info.plist`.

The up-to-date list of SKAdNetworkIds is available in the [official documentation](https://docs.appodeal.com/ios/get-started#add-skadnetworkids).

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
> - Android API level 23 (Android OS 6.0) or higher.

1. Add Appodeal adapters.

Add dependencies into `build.gradle` (module: app)

<!-- appodeal-deps:android:start -->
``` groovy
dependencies {
    implementation "com.appodeal.ads.sdk:core:4.1.0"
    // Bidon
    implementation "org.bidon:amazon-adapter:11.3.0.0"
    implementation "org.bidon:applovin-adapter:13.5.1.0"
    implementation "org.bidon:bidmachine-adapter:3.7.1.0"
    implementation "org.bidon:bigoads-adapter:5.6.2.0"
    implementation "org.bidon:chartboost-adapter:9.10.2.0"
    implementation "org.bidon:dtexchange-adapter:8.4.1.0"
    implementation "org.bidon:inmobi-adapter:11.1.0.0"
    implementation "org.bidon:ironsource-adapter:9.1.0.0"
    implementation "org.bidon:meta-adapter:6.21.0.0"
    implementation "org.bidon:mintegral-adapter:17.1.61.0"
    implementation "org.bidon:mobilefuse-adapter:1.9.3.0"
    implementation "org.bidon:moloco-adapter:4.3.1.0"
    implementation "org.bidon:startio-adapter:5.2.4.1"
    implementation "org.bidon:taurusx-adapter:1.12.2.0"
    implementation "org.bidon:unityads-adapter:4.17.0.0"
    implementation "org.bidon:vkads-adapter:5.47.1.0"
    implementation "org.bidon:vungle-adapter:7.6.1.0"
    implementation "org.bidon:yandex-adapter:7.17.0.0"
    implementation "org.bidon:zmaticoo-adapter:2.0.5.1.0"
    // AppLovin MAX
    implementation "com.applovin.mediation:amazon-tam-adapter:11.3.0.0"
    implementation "com.applovin.mediation:bidmachine-adapter:3.7.1.0"
    implementation "com.applovin.mediation:bigoads-adapter:5.6.2.0"
    implementation "com.applovin.mediation:bytedance-adapter:7.7.0.2.0"
    implementation "com.applovin.mediation:chartboost-adapter:9.10.2.0"
    implementation "com.applovin.mediation:facebook-adapter:6.21.0.0"
    implementation "com.applovin.mediation:fyber-adapter:8.4.1.0"
    implementation "com.applovin.mediation:google-ad-manager-adapter:24.7.0.0"
    implementation "com.applovin.mediation:google-adapter:24.7.0.0"
    implementation "com.applovin.mediation:inmobi-adapter:11.1.0.0"
    implementation "com.applovin.mediation:ironsource-adapter:9.1.0.0.0"
    implementation "com.applovin.mediation:mintegral-adapter:17.1.61.0"
    implementation "com.applovin.mediation:mobilefuse-adapter:1.9.3.0"
    implementation "com.applovin.mediation:moloco-adapter:4.3.1.0"
    implementation "com.applovin.mediation:mytarget-adapter:5.47.1.0"
    implementation "com.applovin.mediation:ogury-presage-adapter:6.2.0.0"
    implementation "com.applovin.mediation:pubmatic-adapter:4.10.0.0"
    implementation "com.applovin.mediation:smaato-adapter:22.7.2.3"
    implementation "com.applovin.mediation:unityads-adapter:4.17.0.0"
    implementation "com.applovin.mediation:verve-adapter:3.7.1.0"
    implementation "com.applovin.mediation:vungle-adapter:7.6.1.0"
    implementation "com.applovin.mediation:yandex-adapter:7.17.0.0"
    // Level Play
    implementation "com.unity3d.ads-mediation:admob-adapter:5.2.0"
    implementation "com.unity3d.ads-mediation:applovin-adapter:5.2.0"
    implementation "com.unity3d.ads-mediation:bidmachine-adapter:5.7.0"
    implementation "com.unity3d.ads-mediation:bigo-adapter:5.3.0"
    implementation "com.unity3d.ads-mediation:facebook-adapter:5.2.0"
    implementation "com.unity3d.ads-mediation:fyber-adapter:5.2.0"
    implementation "com.unity3d.ads-mediation:inmobi-adapter:5.3.0"
    implementation "com.unity3d.ads-mediation:mintegral-adapter:5.14.0"
    implementation "com.unity3d.ads-mediation:mobilefuse-adapter:5.1.0"
    implementation "com.unity3d.ads-mediation:moloco-adapter:5.5.0"
    implementation "com.unity3d.ads-mediation:mytarget-adapter:5.4.0"
    implementation "com.unity3d.ads-mediation:ogury-adapter:5.2.0"
    implementation "com.unity3d.ads-mediation:pangle-adapter:5.3.0"
    implementation "com.unity3d.ads-mediation:smaato-adapter:5.0.0"
    implementation "com.unity3d.ads-mediation:unityads-adapter:5.6.0"
    implementation "com.unity3d.ads-mediation:verve-adapter:5.2.0"
    implementation "com.unity3d.ads-mediation:vungle-adapter:5.4.0"
    // Appodeal
    implementation "com.appodeal.ads.sdk.adapters:adjust:5.4.6.1"
    implementation "com.appodeal.ads.sdk.adapters:admob:24.7.0.0"
    implementation "com.appodeal.ads.sdk.adapters:amazon:11.3.0.0"
    implementation "com.appodeal.ads.sdk.adapters:applovin:13.5.1.0"
    implementation "com.appodeal.ads.sdk.adapters:applovin_max:13.5.1.1"
    implementation "com.appodeal.ads.sdk.adapters:appsflyer:6.17.3.1"
    implementation "com.appodeal.ads.sdk.adapters:bidmachine:3.7.1.0"
    implementation "com.appodeal.ads.sdk.adapters:bidon:0.13.0.0"
    implementation "com.appodeal.ads.sdk.adapters:bigo_ads:5.6.2.0"
    implementation "com.appodeal.ads.sdk.adapters:chartboost:9.10.2.0"
    implementation "com.appodeal.ads.sdk.adapters:dt_exchange:8.4.1.0"
    implementation "com.appodeal.ads.sdk.adapters:facebook_analytics:18.0.3.0"
    implementation "com.appodeal.ads.sdk.adapters:firebase:23.0.0.1"
    implementation "com.appodeal.ads.sdk.adapters:iab:1.8.1.0"
    implementation "com.appodeal.ads.sdk.adapters:inmobi:11.1.0.0"
    implementation "com.appodeal.ads.sdk.adapters:ironsource:9.1.0.0"
    implementation "com.appodeal.ads.sdk.adapters:level_play:9.1.0.0"
    implementation "com.appodeal.ads.sdk.adapters:meta:6.21.0.0"
    implementation "com.appodeal.ads.sdk.adapters:mintegral:17.1.61.0"
    implementation "com.appodeal.ads.sdk.adapters:mobilefuse:1.9.3.0"
    implementation "com.appodeal.ads.sdk.adapters:moloco:4.3.1.0"
    implementation "com.appodeal.ads.sdk.adapters:my_target:5.47.1.0"
    implementation "com.appodeal.ads.sdk.adapters:ogury:6.2.0.0"
    implementation "com.appodeal.ads.sdk.adapters:pangle:7.7.0.2.0"
    implementation "com.appodeal.ads.sdk.adapters:pubmatic:4.10.0.0"
    implementation "com.appodeal.ads.sdk.adapters:sentry_analytics:8.26.0.0"
    implementation "com.appodeal.ads.sdk.adapters:smaato:22.7.2.0"
    implementation "com.appodeal.ads.sdk.adapters:startio:5.2.4.0"
    implementation "com.appodeal.ads.sdk.adapters:taurusx:1.12.2.0"
    implementation "com.appodeal.ads.sdk.adapters:unity_ads:4.17.0.0"
    implementation "com.appodeal.ads.sdk.adapters:verve:3.7.1.0"
    implementation "com.appodeal.ads.sdk.adapters:vungle:7.6.1.0"
    implementation "com.appodeal.ads.sdk.adapters:yandex:7.17.0.0"
    // BidMachine
    implementation "io.bidmachine:ads.networks.amazon:11.3.0.2"
    implementation "io.bidmachine:ads.networks.meta_audience:6.21.0.1"
    implementation "io.bidmachine:ads.networks.mintegral:17.1.61.1"
    implementation "io.bidmachine:ads.networks.my_target:5.47.1.2"
    implementation "io.bidmachine:ads.networks.pangle:7.7.0.2.2"
    implementation "io.bidmachine:ads.networks.vungle:7.6.1.2"
}
```
<!-- appodeal-deps:android:end -->

Add repository into `build.gradle` (module: project)

``` groovy
allprojects {
    repositories {
        ...
        maven { url "https://artifactory.appodeal.com/appodeal" }
        ...
    }
}
```

> [!TIP]
> Starting from Appodeal SDK 4.1.0, Android uses individual adapter dependencies (same approach as iOS).
> Use the [Appodeal Dependencies Wizard](https://docs.appodeal.com/android/advanced/configure-mediated-networks) to configure mediated networks and generate an always up-to-date dependency list for your `build.gradle`.

2. Build your project

#### AdMob configuration

> [!WARNING]  
> AdMob Bidding is now available since Appodeal SDK 3.2.0.\
> Don't forget to download our newest version of AdMob Sync tool from this page and perform sync.\
> You can read more about AdMob Sync in
> our [guide](https://docs.appodeal.com/networks-setup/admob-sync).

- **How to add AdMob Ad Network to your project:**

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

- **How to remove AdMob Ad Network from your project:**

  Change next dependencies into `build.gradle` (module: app)

  Starting from Appodeal SDK 4.1.0, dependencies are added individually.
  Simply do not include AdMob-related adapters in your `build.gradle` / `Podfile`.
  Use the [Dependencies Wizard](https://docs.appodeal.com/android/advanced/configure-mediated-networks) to generate the correct dependency list without AdMob.

## Services

Please, read iOS and Android docs at [wiki](https://docs.appodeal.com/) to get deeper understanding how
Appodeal SDK Services works.

Appodeal SDK supports the following services: **Adjust**, **AppsFlyer**, **Firebase**, and **Meta**.

To add service adapters to your project, use the Dependencies Wizard:
- [Android](https://docs.appodeal.com/android/advanced/configure-mediated-networks)
- [iOS](https://docs.appodeal.com/ios/advanced/configure-mediated-networks)

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

Appodeal SDK allows you to send events to all analytic services such as Firebase, AppsFlyer, Adjust 
and Meta using a single method:

```dart
Appodeal.logEvent("example_event_name", {
  "example_param_1": "example_param_value_1",
  "example_param_2": 123
});
```

Use this method for send event for a specific service:

```dart
Appodeal.logEvent("example_event_name", { 
  "example_param_1": "example_param_value_1",
  "example_param_2": 123 
  },
  AppodealServices.APPSFLYER
);
```

You can use one or more of these values to select the service to send the event to:
- `AppodealServices.ADJUST` - for Adjust service;
- `AppodealServices.APPSFLYER` - for Appsflyer service;
- `AppodealServices.FACEBOOK` - for Facebook service;
- `AppodealServices.FIREBASE` - for Firebase service;
- `AppodealServices.ALL` - for ALl services;

or you may combine these values, for example, to sent event to Appsflyer and Firebase services:
- `AppodealServices.APPSFLYER | AppodealServices.FIREBASE`

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

> Call this method before initialization

``` dart
// Set ad auto caching enabled or disabled
// By default autocache is enabled for all ad types
Appodeal.setAutoCache(AppodealAdType.Interstitial, false); //default - true

// Set testing mode
Appodeal.setTesting(false); //default - false

// Set Appodeal SDK logging level
Appodeal.setLogLevel(Appodeal.LogLevelVerbose); //default - Appodeal.LogLevelNone

// Enable or disable child direct treatment
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

> Note: You can learn more about GDPR and CCPA and their differences.
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
