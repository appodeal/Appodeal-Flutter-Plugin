# Changelog

## develop

### Internal fix
- APDM-324: Disabled smart banners

## 3.3.2

### Updated SDKs

- Updated Appodeal iOS SDK to [3.3.2](https://docs.appodeal.com/ios/changelog)
- Updated Appodeal Android SDK to [3.3.2](https://docs.appodeal.com/android/changelog)

## 3.3.1

### Updated SDKs

- Updated Appodeal iOS SDK to [3.3.1](https://docs.appodeal.com/ios/changelog)
- Updated Appodeal Android SDK to [3.3.1](https://docs.appodeal.com/android/changelog)

## 3.3.0

### Updated SDKs

- Updated Appodeal iOS SDK to [3.3.0](https://docs.appodeal.com/ios/changelog)
- Updated Appodeal Android SDK to [3.3.0](https://docs.appodeal.com/android/changelog)

## 3.3.0-beta.3

### Updated SDKs

- Updated Appodeal iOS SDK to [3.3.0-beta.3](https://docs.appodeal.com/ios/changelog)
- Updated Appodeal Android SDK to [3.3.0-beta.3](https://docs.appodeal.com/android/changelog)

## 3.3.0-beta.2

### Updated SDKs

- Updated Appodeal iOS SDK to [3.3.0-beta.2](https://docs.appodeal.com/ios/changelog)
- Updated Appodeal Android SDK to [3.3.0-beta.2](https://docs.appodeal.com/android/changelog)

## 3.3.0-beta.1

### Updated SDKs

- Updated Appodeal iOS SDK to [3.3.0-beta.1](https://docs.appodeal.com/ios/changelog)
- Updated Appodeal Android SDK to [3.3.0-beta.1](https://docs.appodeal.com/android/changelog)

## 3.2.1

### Promoted the beta release to the stable version

### Updated SDKs

- Updated Appodeal iOS SDK to [3.2.1](https://docs.appodeal.com/ios/changelog)
- Updated Appodeal Android SDK to [3.2.1](https://docs.appodeal.com/android/changelog)

## 3.2.1-beta.1

### Features

* **💥 Google CMP and TCF v2 Support**
    - To enhance the relevance of ads for your users and comply with regulations like GDPR and CCPA,
      explicit user consent is required for collecting personal data.
    - We recommend using the Stack Consent Manager, built on Google User Messaging Platform (UMP),
      as a ready-made solution to obtain user consent.
    - Follow this [instruction](https://docs.appodeal.com/advanced/google-cmp-and-tcfv2-support) to
      configure Google UMP and set up a consent form.
    - If you have a question about Stack Consent Manager and Google UMP, please contact our support
      team.

* **Major Consent Api changes**

### Updated SDKs

- Updated Appodeal iOS SDK to [3.2.1-beta.1](https://docs.appodeal.com/ios/changelog)
- Updated Appodeal Android SDK to [3.2.1-beta.1](https://docs.appodeal.com/android/changelog)

### Removed

- Removed `AppodealUserConsent` class.
- Removed `GDPRUserConsent` class.
- Removed `CCPAUserConsent` class.
- Removed `ApdConsentError` class.
- Removed `Appodeal.updateGDPRUserConsent` method.
- Removed `Appodeal.updateCCPAUserConsent` method.
- Removed `Appodeal.loadConsentForm` method.
- Removed `Appodeal.showConsentForm` method.
- Removed `Appodeal.setCustomVendor` method.
- Removed `Appodeal.disableAppTrackingTransparencyRequest` method.

### Added

- Added `AppodealConsent` class.
- Added `ConsentStatus` class.
- Added `ConsentError` class.
- Added `AppodealConsent.load` method.
- Added `AppodealConsent.show` method.
- Added `AppodealConsent.loadAndShowIfRequired` method.
- Added `AppodealConsent.revoke` method.

## 3.2.0+1

* Simplified Android Core Plugin dependencies

## 3.2.0

* Updated Appodeal iOS SDK to [3.2.0](https://docs.appodeal.com/ios/changelog)
* Updated Appodeal Android SDK to [3.2.0](https://docs.appodeal.com/android/changelog)
* **💥 AdMob Bidding Support**
  - Download our newest version of AdMob Sync tool from this [page](https://amsa-updates.appodeal.com/) and perform sync.
  - You can read more about AdMob Sync in our [guide](https://docs.appodeal.com/networks-setup/admob-sync).

## 3.2.0-beta.3

* Updated Kotlin to 1.8.10 and use bom for align all kotlin versions
* Added android namespace for AGP version > 8;

## 3.2.0-beta.2

* Updated Appodeal iOS SDK to [3.2.0-beta.2](https://docs.appodeal.com/ios/changelog)
* Updated Appodeal Android SDK to [3.2.0.1-beta.2](https://docs.appodeal.com/android/changelog)

## 3.2.0-beta.1

* Updated Gradle Plugin version to 7.3.1
* Updated iOS Deployment Target version to 13.0
* Updated Appodeal iOS SDK to 3.2.0-beta.1
* Updated Appodeal Android SDK to 3.2.0-beta.1

## 3.1.3

* Promoted the beta release to the stable version
* Updated Appodeal iOS SDK to 3.1.3 stable
* Updated Appodeal Android SDK to 3.1.3 stable

## 3.1.3-beta.3

* Fixed issue with repeating consent window.
* Updated Appodeal Android SDK to 3.1.3.2-beta.2

## 3.1.3-beta.2

* Updated Appodeal iOS SDK to 3.1.3-beta.2
* Updated Appodeal Android SDK to 3.1.3-beta.2
* Minor fixes and stability improvements.

## 3.1.3-beta.1

* Updated Appodeal iOS SDK to 3.1.3-beta.1
* Updated Appodeal Android SDK to 3.1.3-beta.1
* Removed method `Appodeal.setRequestCallbacks(...)`. Removed removed request callback logic.

## 3.0.2

* Updated Appodeal iOS SDK to 3.0.2
* Updated Appodeal Android SDK to 3.0.2

## 3.0.1

* Updated Appodeal iOS SDK to 3.0.1
* Updated Appodeal Android SDK to 3.0.1
* Started support `AdRevenueCallbacks` for notified about ad revenue events.
* Reverted methods `Appodeal.setUserId(...)` `Appodeal.getUserId()` for analytics.

## 3.0.0

* **Major Api changes**
* Updated Appodeal iOS SDK to 3.0.0
* Updated Appodeal Android SDK to 3.0.0
* Started support Monetization + UA + Analytics data services.
* Added new api for in-app purchases and event tracking.
* Internal Api improvements
* Internal View Ad improvements

## 1.2.2

* **Smart banners disable by default.**
* Changed View Ad smart banner behavor.
* Minor fixes and stability improvements.
* Deprecated consent logic behavor.
* Deprecated methods: `Appodeal.updateConsent(...)`, `Appodeal.setTriggerOnLoadedOnPrecache(...)`,
  `Appodeal.setSharedAdsInstanceAcrossActivities(...)`, `Appodeal.trackInAppPurchase(...)`,
  `Appodeal.setUserId(...)`, `Appodeal.setUserAge(...)`, `Appodeal.setUserGender(...)`.

## 1.2.1

* Started support for Flutter 3.0
* Updated kotlin and gradle versions

## 1.2.0

* Updated Appodeal iOS SDK adapters for to 2.11.1
* Updated Appodeal Android SDK adapters for to 2.11.0
* Added Appodeal class api dart doc comments
* Added obtain placement name logic for method `show` in Android side
* Synchronized left/right banner display logic between iOS and Android

## 1.1.0

* **Major Api changes**:
  * `Appodeal.initializeWithConsent` - removed, use `Appodeal.initialize` without boolConsent:
    > example: `Appodeal.initialize(appodealKey, [Appodeal.REWARDED_VIDEO])`
  * `Appodeal.canShowWithPlacement` - removed, use `Appodeal.canShow` with placement - second param:
    > example: `Appodeal.canShow(Appodeal.INTERSTITIAL, "default")`
  * `Appodeal.showWithPlacement` - removed, use `Appodeal.show` with placement - second param:
    > example: `Appodeal.show(Appodeal.INTERSTITIAL, "default")`
  * `Appodeal.disableNetworkForSpecificAdType` - removed, use `Appodeal.disableNetwork` with adtype - second param (default it's all ad types):
    > example: `Appodeal.disableNetwork("admob", Appodeal.INTERSTITIAL)`
  * `Appodeal.setExtra` - instead `setExtraDataBool, setExtraDataInt, setExtraDataDouble, setExtraDataString`
  * `Appodeal.setCustomFilter` - instead `setCustomFilterBool, setCustomFilterInt, setCustomFilterDouble, setCustomFilter`
  * **Callbacks** Now, we can use only neded callback method:
    > example:
    > ```
    > Appodeal.setBannerCallbacks(
    >     onBannerLoaded: (isPrecache) => log('onBannerLoaded')
    >     onBannerShown: () => log('onBannerShown')
    > );
    > ```
  * **Banner View / Mrec View** Got a new api:
    > example:
    > ```
    > AppodealBanner(
    >     adSize: AppodealBannerSize.BANNER,
    >     //or adSize: AppodealBannerSize.MEDIUM_RECTANGLE for MREC
    >     placement: "default"
    > );
    > ```
* Updated Appodeal iOS SDK to 2.11.1
* Internal Api improvements
* Internal View Ad improvements

## 1.0.5

* Updated Appodeal Android SDK to 2.11.0
* Updated Appodeal iOS SDK to 2.11.0
* Changed dependencies logic for iOS/Android module
* Updated LICENSE
* Updated README.md

## 1.0.4-beta

* Updated initialize methods

## 1.0.3-beta

* Updated Appodeal Android SDK to 2.10.3
* Updated Appodeal iOS SDK to 2.10.3

## 1.0.2-beta

* Updated initializeWithConsent() method 

## 1.0.1-beta

* Minor changes

## 1.0.0-beta

* Update Appodeal iOS to 2.8.2
* Update Appodeal Android to 2.8.2.2
