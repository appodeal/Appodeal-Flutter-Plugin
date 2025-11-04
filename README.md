# Appodeal Flutter

Official Appodeal Flutter Plugin for your Flutter application.

## Appodeal SDK 3.10.0

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
  stack_appodeal_flutter: 3.10.0
```

Install the plugin by running the command below in the terminal:

```
$ flutter pub get
```

#### iOS

> [!IMPORTANT]
> - iOS 13.0 or higher. You still can integrate Appodeal SDK into a project with a lower value of minimum iOS version. However, on devices that don't support iOS 12.0+ our SDK will just be disabled.
> - Appodeal SDK is compatible with both ARC and non-ARC projects.
> - Use Xcode 15.3 or higher.

1. Go to `ios/` folder and open *Podfile*
2. Add Appodeal adapters. Add pods into `./ios/Podfile`:

```ruby
source 'https://cdn.cocoapods.org'
source 'https://github.com/appodeal/CocoaPods.git'
source 'https://github.com/bidon-io/CocoaPods_Specs.git'

platform :ios, '13.0'

use_frameworks!

def appodeal
   pod 'Appodeal', '3.10.0'
   pod 'APDAmazonAdapter', '3.10.0.0'
   pod 'APDAppLovinAdapter', '3.10.0.0'
   pod 'APDAppLovinMAXAdapter', '3.10.0.0'
   pod 'APDBidMachineAdapter', '3.10.0.0'
   pod 'APDBidonAdapter', '3.10.0.0'
   pod 'APDBigoAdsAdapter', '3.10.0.0'
   pod 'APDDTExchangeAdapter', '3.10.0.0'
   pod 'APDGoogleAdMobAdapter', '3.10.0.0'
   pod 'APDIABAdapter', '3.10.0.0'
   pod 'APDInMobiAdapter', '3.10.0.0'
   pod 'APDIronSourceAdapter', '3.10.0.0'
   pod 'APDLevelPlayAdapter', '3.10.0.0'
   pod 'APDMetaAudienceNetworkAdapter', '3.10.0.0'
   pod 'APDMintegralAdapter', '3.10.0.0'
   pod 'APDMyTargetAdapter', '3.10.0.0'
   pod 'APDSentryAdapter', '3.10.0.0'
   pod 'APDUnityAdapter', '3.10.0.0'
   pod 'APDVungleAdapter', '3.10.0.0'
   pod 'APDYandexAdapter', '3.10.0.0'
   pod 'AppLovinMediationAmazonAdMarketplaceAdapter', '5.3.0.0'
   pod 'AppLovinMediationBidMachineAdapter', '3.4.0.0.0'
   pod 'AppLovinMediationBidonAdapter', '0.11.0.0'
   pod 'AppLovinMediationBigoAdsAdapter', '4.9.0.0'
   pod 'AppLovinMediationByteDanceAdapter', '7.4.1.1.0'
   pod 'AppLovinMediationChartboostAdapter', '9.9.2.1'
   pod 'AppLovinMediationFacebookAdapter', '6.20.1.0'
   pod 'AppLovinMediationFyberAdapter', '8.3.8.0'
   pod 'AppLovinMediationGoogleAdManagerAdapter', '12.8.0.0'
   pod 'AppLovinMediationGoogleAdapter', '12.8.0.0'
   pod 'AppLovinMediationInMobiAdapter', '10.8.6.0'
   pod 'AppLovinMediationIronSourceAdapter', '8.10.0.0.0'
   pod 'AppLovinMediationMintegralAdapter', '7.7.9.0.0'
   pod 'AppLovinMediationMobileFuseAdapter', '1.9.2.1'
   pod 'AppLovinMediationMolocoAdapter', '3.12.0.0'
   pod 'AppLovinMediationMyTargetAdapter', '5.33.0.0'
   pod 'AppLovinMediationOguryPresageAdapter', '5.0.2.0'
   pod 'AppLovinMediationPubMaticAdapter', '4.8.0.0'
   pod 'AppLovinMediationSmaatoAdapter', '22.9.3.1'
   pod 'AppLovinMediationUnityAdsAdapter', '4.16.0.0'
   pod 'AppLovinMediationVerveAdapter', '3.6.0.0'
   pod 'AppLovinMediationVungleAdapter', '7.5.2.0'
   pod 'AppLovinMediationYandexAdapter', '7.14.1.0'
   pod 'BidMachineAmazonAdapter', '3.4.0.0'
   pod 'BidMachineIronSourceCustomAdapter', '3.4.0.0'
   pod 'BidMachineMetaAudienceAdapter', '3.4.0.0'
   pod 'BidMachineMintegralAdapter', '3.4.0.0'
   pod 'BidMachineMyTargetAdapter', '3.4.0.0'
   pod 'BidMachinePangleAdapter', '3.4.0.0'
   pod 'BidMachineVungleAdapter', '3.4.0.0'
   pod 'BidonAdapterAmazon', '0.11.0.0'
   pod 'BidonAdapterBidMachine', '0.11.0.0'
   pod 'BidonAdapterBigoAds', '0.11.0.0'
   pod 'BidonAdapterChartboost', '0.11.0.0'
   pod 'BidonAdapterDTExchange', '0.11.0.0'
   pod 'BidonAdapterInMobi', '0.11.0.0'
   pod 'BidonAdapterIronSource', '0.11.0.0'
   pod 'BidonAdapterMetaAudienceNetwork', '0.11.0.0'
   pod 'BidonAdapterMintegral', '0.11.0.0'
   pod 'BidonAdapterMobileFuse', '0.11.0.0'
   pod 'BidonAdapterMoloco', '0.11.0.0'
   pod 'BidonAdapterMyTarget', '0.11.0.0'
   pod 'BidonAdapterUnityAds', '0.11.0.0'
   pod 'BidonAdapterVungle', '0.11.0.0'
   pod 'BidonAdapterYandex', '0.11.0.0'
   pod 'ISBidonCustomAdapter', '0.11.0.0'
   pod 'IronSourceAPSAdapter', '4.3.21.0'
   pod 'IronSourceAdMobAdapter', '4.3.69.0'
   pod 'IronSourceAppLovinAdapter', '4.3.56.0'
   pod 'IronSourceBidMachineAdapter', '4.3.20.0'
   pod 'IronSourceBigoAdapter', '4.3.8.0'
   pod 'IronSourceFacebookAdapter', '4.3.51.0'
   pod 'IronSourceFyberAdapter', '4.3.44.0'
   pod 'IronSourceInMobiAdapter', '4.3.30.0'
   pod 'IronSourceMintegralAdapter', '4.3.37.0'
   pod 'IronSourceMobileFuseAdapter', '4.3.8.1'
   pod 'IronSourceMolocoAdapter', '4.3.22.0'
   pod 'IronSourceMyTargetAdapter', '4.3.6.0'
   pod 'IronSourceOguryAdapter', '4.3.3.1'
   pod 'IronSourcePangleAdapter', '4.3.51.0'
   pod 'IronSourceSmaatoAdapter', '4.3.17.1'
   pod 'IronSourceUnityAdsAdapter', '4.3.54.0'
   pod 'IronSourceVerveAdapter', '4.3.6.1'
   pod 'IronSourceVungleAdapter', '4.3.46.0'
   pod 'IronSourceYandexAdapter', '4.3.21.0'
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
5. Configure `Info.plist`.

##### SKAdNetworkIds

Ad networks used in Appodeal mediation support conversion tracking using Apple's `SKAdNetwork`,
which means ad networks are able to attribute an app install even when IDFA is unavailable. To
enable this functionality, you will need to update the `SKAdNetworkItems` key with an additional
dictionary in your `Info.plist`.

- Select **Info.plist** in the Project navigator in Xcode
- Right-click on **Info.plist** file → Open as → Source Code
- Add *SKAdNetworkIds* according to [doc](https://docs.appodeal.com/ios/get-started#add-skadnetworkids)

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

``` groovy
dependencies {
    // ... other project dependencies
    implementation ('com.appodeal.ads:sdk:3.10.0.0') {
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

  ```groovy
  dependencies {
      ...
      // ... other project dependencies
      implementation('com.appodeal.ads:sdk:3.10.0.0') {
          // ad networks
          exclude group: "com.appodeal.ads.sdk.networks", module: "admob"
          exclude group: "com.applovin.mediation", module: "google-adapter"
          exclude group: "com.applovin.mediation", module: "google-ad-manager-adapter"
          exclude group: "com.unity3d.ads-mediation", module: "admob-adapter"
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
  pod 'APDGoogleAdMobAdapter', '3.10.0.0'
  pod 'AppLovinMediationGoogleAdManagerAdapter', '12.8.0.0'
  pod 'AppLovinMediationGoogleAdapter', '12.8.0.0'
  pod 'IronSourceAdMobAdapter', '4.3.69.0'
  ```

## Services

Please, read iOS and Android docs at [wiki](https://docs.appodeal.com/) to get deeper understanding how
Appodeal SDK Services works.

#### Adjust

Add dependencies into build.gradle (module: app)

```groovy
dependencies {
    // ... other project dependencies
    implementation 'com.appodeal.ads.sdk.services:adjust:3.10.0.0'
}
```

Add dependencies into _Podfile_

```ruby
def appodeal
  // ... other project pods
  pod 'APDAdjustAdapter', '3.10.0.0'
end
```

#### AppsFlyer

Add dependencies into build.gradle (module: app)

```groovy
dependencies {
    // ... other project dependencies
  implementation 'com.appodeal.ads.sdk.services:appsflyer:3.10.0.0'
}
```

Add dependencies into _Podfile_

```ruby
def appodeal
  // ... other project pods
  pod 'APDAppsFlyerAdapter', '3.10.0.0'
end
```

#### Firebase

Add dependencies into build.gradle (module: app)

```groovy
dependencies {
    // ... other project dependencies
    implementation 'com.appodeal.ads.sdk.services:firebase:3.10.0.0'
}
```

Add dependencies into _Podfile_

```ruby
def appodeal
  // ... other project pods
  pod 'APDFirebaseAdapter', '3.10.0.0'
end
```

#### Meta

Add dependencies into build.gradle (module: app)

```groovy
dependencies {
    // ... other project dependencies
    implementation 'com.appodeal.ads.sdk.services:facebook_analytics:3.10.0.0'
}
```

Add dependencies into _Podfile_

```ruby
def appodeal
  // ... other project pods
  pod 'APDFacebookAdapter', '3.10.0.0'
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
