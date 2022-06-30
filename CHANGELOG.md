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