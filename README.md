# Appodeal Flutter
Appodeal Flutter Plugin for your Flutter application.

## Table of Contents
  - [Installation](#installation)
      - [iOS](#ios)
      - [Android](#android)
  - [Usage](#usage)
    - [Initialisation](#initialisation)
    - [Callbacks](#callbacks)
    - [Presentation](#presentation)
    - [Ad View](#ad-view)
  - [Privacy Policy and Consent](#privacy-policy-and-consent)
  - [App Tracking Transparency](#app-tracking-transparency)
  - [Changelog](CHANGELOG.md)

## Installation
Add the dependency to the `pubspec.yaml` file in your project:
```yaml
dependencies:
  stack_appodeal_flutter: 1.1.0
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
  pod 'APDAdColonyAdapter', '2.11.0.1'
  pod 'APDAmazonAdsAdapter', '2.11.0.1'
  pod 'APDAppLovinAdapter', '2.11.0.1'
  pod 'APDBidMachineAdapter', '2.11.0.1' # Required
  pod 'APDFacebookAudienceAdapter', '2.11.0.1'
  pod 'APDGoogleAdMobAdapter', '2.11.0.1'
  pod 'APDIronSourceAdapter', '2.11.0.1'
  pod 'APDMyTargetAdapter', '2.11.0.1'
  pod 'APDOguryAdapter', '2.11.0.1'
  pod 'APDUnityAdapter', '2.11.0.1'
  pod 'APDVungleAdapter', '2.11.0.1'
  pod 'APDYandexAdapter', '2.11.0.1'
end

target 'Runner' do
  use_frameworks!
  use_modular_headers!
  appodeal

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end
```

You can change following implementation to use custom mediation setup. See [docs](https://wiki.appodeal.com/en/ios/get-started#iOSSDK.GetStarted-Step1.ImportSDK).

> Note. Appodeal requires to use `use_frameworks!` . You need to remove Flipper dependency from Podfile and AppDelegate

3. Run `pod install`
4. Open `.xcworkspace`
5. Configfure `info.plist` . Press Add+ at the end of the name *App Transport Security Settings* key and choose *Allow Arbitrary Loads*. Set its type to *Boolean* and its value to *Yes*.

``` xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```

Add *GADApplicationIdentifier* key (if you use Admob adapter).

``` xml
<key>GADApplicationIdentifier</key>
<string>YOUR_ADMOB_APP_ID</string>
```

For more information about Admob sync check out our [FAQ](https://faq.appodeal.com/en/articles/4185565-how-do-i-link-my-admob-account).

6. Run your project (`Cmd+R`)

#### Android

1. Add Appodeal adapters.

Add dependencies into `build.gradle` (module: app)

``` groovy
dependencies {
    ...
    implementation 'com.appodeal.ads:sdk:2.11.0.+'
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

> Note. You can change following implementation to use custom mediation setup. See [Docs](https://wiki.appodeal.com/en/android/get-started)

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

In your *network_security_config.xml* file, add base-config that sets `cleartextTrafficPermitted` to `true` :

``` xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <base-config cleartextTrafficPermitted="true">
        <trust-anchors>
            <certificates src="system" />
            <certificates src="user" />
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

For more information about Admob sync check out our [FAQ](https://faq.appodeal.com/en/articles/4185565-how-do-i-link-my-admob-account).

5. Run your project (`Cmd+R`)

## Usage

Please, read iOS and Android docs at [wiki](https://wiki.appodeal.com/) to get deeper understanding how
Appodeal SDK works.
### Initialisation

1. Initialise Appodeal at application launch. To initialize Appodeal SDK use this following method:
```dart
Appodeal.initialize("YOUR_APPODEAL_APP_KEY", [ad_types], consentValue);
```
`consentValue` is bool, with 'false' meaning that the user declines to give the consent. [More information.](https://wiki.appodeal.com/en/android/get-started/data-protection/gdpr-and-ccpa)

> Note: Make sure to replace "YOUR_APPODEAL_APP_KEY" with the actual app key.

Use the type codes below to set the preferred ad format:
- `Appodeal.INTERSTITIAL` for interstitial.
- `Appodeal.REWARDED_VIDEO` for rewarded videos.
- `Appodeal.BANNER` for banners.
- `Appodeal.MREC` for 300*250 banners.

2. Configure SDK
* General configuration

``` dart
// Set ad auto caching enabled or disabled
// By default autocache is enabled for all ad types
// Call this method before or after initilisation
Appodeal.setAutoCache(Appodeal.INTERSTITIAL, false);
// Set testing mode
// Call this method before initilisation
Appodeal.setTesting(false);
// Set Appodeal SDK logging level
// Call this method before initilisation
Appodeal.setLogLevel(Appodeal.LogLevelVerbose);
// Enable or disable child direct threatment
// Call this method before initilisation
Appodeal.setChildDirectedTreatment(false);
// Disable network for specific ad type:
// Call this method before initilisation
Appodeal.disableNetwork("admob");
Appodeal.disableNetworkForSpecificAdType("vungle", Appodeal.INTERSTITIAL);
// Enable or disable triggering show for precache ads
// Call this method before or after initilisation
Appodeal.setTriggerOnLoadedOnPrecache(Appodeal.INTERSTITIAL, true);
```

* Segments and targeting.

``` dart
// Set user age
// Call this method before or after initilisation
Appodeal.setUserAge(25);
// Set user gender
// Supported values are male | female
// Call this method before of after initilisation
Appodeal.setUserGender(Appodeal.GENDER_FEMALE);
// Set specific user id from attribution system
// Call this method before initilisation
Appodeal.setUserId("some user ud");
// Set segment filter
// Call this method before of after initilisation
Appodeal.setCustomFilterString("levels_played": "levelsPlayed");
// Set extras
Appodeal.setExtraDataString("attribuition_id": "some value");
```
* Banner specific

``` dart
// Enable or disable tablet banners.
// Call this method before of after initilisation
Appodeal.setTabletBanners(false);
// Enable or disable smart banners.
// iOS smart banners are supported only
// for applications where autoration is disabled
// Call this method before of after initilisation
Appodeal.setSmartBanners(false);
// Enable or disable banner refresh animation
// Call this method before of after initilisation
Appodeal.setBannerAnimation(true);
```

* Android specific

``` dart
// Mute calls if calls muted on Android
// Call this method before initilisation
Appodeal.muteVideosIfCallsMuted(bool);
```
### Callbacks

Set callbacks listener to get track of ad lifecycle events.
1. Banner
```dart
Appodeal.setBannerCallbacks(
        (onBannerLoaded, isPrecache) => {},
        (onBannerFailedToLoad) => {},
        (onBannerShown) => {},
        (onBannerShowFailed) => {},
        (onBannerClicked) => {},
        (onBannerExpired) => {});
```

2. MREC

```dart
Appodeal.setMrecCallbacks(
        (onMrecLoaded, isPrecache) => {},
        (onMrecFailedToLoad) => {},
        (onMrecShown) => {},
        (onMrecShowFailed) => {},
        (onMrecClicked) => {},
        (onMrecExpired) => {});
```

3. Interstitial

```dart
Appodeal.setInterstitialCallbacks(
        (onInterstitialLoaded, isPrecache) => {},
        (onInterstitialFailedToLoad) => {},
        (onInterstitialShown) => {},
        (onInterstitialShowFailed) => {},
        (onInterstitialClicked) => {},
        (onInterstitialClosed) => {},
        (onInterstitialExpired) => {});
```

4. Rewarded video

```dart
Appodeal.setRewardedVideoCallbacks(
        (onRewardedVideoLoaded, isPrecache) => {},
        (onRewardedVideoFailedToLoad) => {},
        (onRewardedVideoShown) => {},
        (onRewardedVideoShowFailed) => {},
        (onRewardedVideoFinished, amount, reward) => {},
        (onRewardedVideoClosed, isFinished) => {},
        (onRewardedVideoExpired) => {},
        (onRewardedVideoClicked) => {});
```

### Presentation

> Note. All presentation specific methods are available only after SDK initialisation

1. Caching

If you disable autocache you should call `cache` method before trying to show any ad

``` dart
Appodeal.cache(Appodeal.INTERSTITIAL);
```

2. Check that ad is loaded and can be shown

``` javascript
// Check that interstitial
var isCanShow = await Appodeal.canShow(Appodeal.INTERSTITIAL);
// Check that interstitial is loaded
var isLoaded = await Appodeal.isLoaded(Appodeal.INTERSTITIAL);
```

3. Show advertising

``` dart
// Show interstitial
Appodeal.show(Appodeal.INTERSTITIAL);

// Show banner
Appodeal.show(Appodeal.BANNER_BOTTOM); // Display banner at the bottom of the screen
Appodeal.show(Appodeal.BANNER_TOP); // Display banner at the top of the screen
Appodeal.show(Appodeal.BANNER_LEFT); // Display banner at the left of the screen
Appodeal.show(Appodeal.BANNER_RIGHT); // Display banner at the right of the screen

// Show interstitial for specific pacement
Appodeal.showWithPlacement(Appodeal.INTERSTITIAL, “placementName”);
```

4. Hide

You can hide banner/MREC ad after it was shown. Call `hide` method with another ad types won't affect anything

``` dart
Appodeal.hide(Appodeal.BANNER_TOP); //Appodeal.MREC
```

5. Destroy

To free memory from hidden banner/MREC call the code below:

```dart
Appodeal.destroy(Appodeal.BANNER); //Appodeal.MREC
```

## Ad View

**Display banner/MREC ad view at a custom position**

To display a Banner view add widget:
```dart
child: AppodealBannerView(placementName: "default"))
```

To display a MREC view add widget:
```dart
child: AppodealMrecView(placementName: "default"))
```

## Privacy Policy and Consent
> Note: Keep in mind that it’s best to contact qualified legal professionals, if you haven’t done so already, to get more information and be well-prepared for compliance

The General Data Protection Regulation, better known as GDPR, took effect on May 25, 2018. It’s a set of rules designed to give EU citizens more control over their personal data. Any businesses established in the EU or with users based in Europe are required to comply with GDPR or risk facing heavy fines. The California Consumer Privacy Act (CCPA) went into effect on January 1, 2020. **We have put together some resources below to help publishers understand better the steps they need to take to be GDPR compliant.**

> Note: You can learn more about GDPR and CCPA and their differences [here](https://iapp.org/resources/article/ccpa-and-gdpr-comparison-chart/).

### Step 1: Update Privacy Policy
**1.1 Make sure your privacy policy includes information about advertising ID collection.**
Don’t forget to add information about IP address and advertising ID collection, as well as [the link to Appodeal’s privacy policy](https://www.appodeal.com/privacy-policy) to your app’s privacy policy in Google Play and App Store.

To speed up the process, you could use [privacy policy generators](https://app-privacy-policy-generator.firebaseapp.com/) —just insert advertising ID, IP address, and location (if you collect a user’ location) in the "Personally Identifiable Information you collect" field (in line with other information about your app) and [the link to Appodeal’s privacy policy](https://www.appodeal.com/privacy-policy) in "Link to the privacy policy of third party service providers used by the app".

**1.2 Add a privacy policy to your mobile app.**
You must add your explicit privacy policies in two places: your app’s Store Listing page and within your app.

You can find detailed instructions on adding your privacy policy to your app on legal service websites. For example, Iubenda, the solution tailored to legal compliance, provides a [comprehensive guide](https://www.iubenda.com/blog/privacy-policy-for-android-app/) on including a privacy policy in your app.

Make sure that your privacy policy website has an SSL-certificate—this point might seem to be obvious, but it’s still essential.

Here’s are two useful resources that you can utilize while working on your app compliance:
[Privacy, Security and Deception regulations (by Google Play)](https://play.google.com/intl/en-GB_ALL/about/privacy-security-deception/user-data/)
[Recommendations on Developing a Meaningful Privacy Policy (by Attorney General California Department of Justice)](https://oag.ca.gov/sites/all/files/agweb/pdfs/cybersecurity/making_your_privacy_practices_public.pdf)

> Note: Please note that although we’re always eager to back you up with valuable information, we’re not authorized to provide any legal advice. It’s important to address your questions to lawyers who work specifically in this area.

### Step 2: Stack Consent Manager
In order for Appodeal and our ad providers to deliver ads that are more relevant to your users, as a mobile app publisher, you need to collect explicit user consent in the regions covered by GDPR and CCPA.

To get consent for collecting personal data of your users, we suggest you use a ready-made solution - Stack Consent Manager.

Stack Consent Manager comes with a pre-made consent window that you can easily present to your users. That means you no longer need to create your own consent window.

> Note:Minimal requirements: Appodeal SDK 2.7.0 or higher.

**2.1. Update Consent Status**
When using the Consent SDK, it is recommended that you determine the status of a user's consent at every app launch.
Call the following code for determination the status of a user's consent:
```dart
ConsentManager.requestConsentInfoUpdate("YOUR_APP_KEY");
```

Now you can use use the following ConsentInfo callbacks:
```dart
ConsentManager.setConsentInfoUpdateListener(
        (onConsentInfoUpdated, consent) => {},
        (onFailedToUpdateConsentInfo, error) => {});
```

All returned errors are Exception instances with custom codes:
Code            | Description                                                           |
--------------- | ----------------------------------------------------------------------|
INTERNAL(1)     | Error on the SDK side. Includes JS-bridge or encoding/decoding errors |
NETWORKING(2)   | HTTP errors, parse request/response                                   |
INCONSISTENT(3) | Incorrect SDK API usage                                               |

> Note: Consent manager SDK can be synchronized at any moment of the application lifecycle. We recommend synchronizing it at the application launch. Multiple synchronization calls are allowed.

If the consent information is successfully updated, the updated consent is provided via the onConsentInfoUpdated() method of the ConsentInfoUpdateListener.

Now you can receive information about the previous user consent and regulation zone. Before request these parameters are undefined.
```dart
var consentStatus = await ConsentManager.getConsentStatus();
```

Consent Status      | Description                                                                                   |
------------------- | ----------------------------------------------------------------------------------------------|
UNKNOWN             | The user has neither granted nor declined consent for personalized or non-personalized ads.   |
NON_PERSONALIZED    | The user has granted consent for non-personalized ads.                                        |
PARTLY_PERSONALIZED | The user has granted partly(for a few Ad networks) consent for personalized ads.              |
PERSONALIZED        | The user has granted consent for personalized ads.                                            |

**2.2. Necessity of showing the consent window**
After the onConsentInfoUpdated method was called, you need to determine if your users are subject to the GDPR and CCPA and whether you should show the consent window for the collection of personal data.
You can check whether to show a Consent Dialog or not. Before request these parameters are undefined(Unknown status)
```dart
var shouldShow = await ConsentManager.shouldShowConsentDialog();
```
ShouldShow   | Description                                                                                              |
------------ | ---------------------------------------------------------------------------------------------------------|
TRUE         | The user is within the scope of the GDPR or CCPA laws, the consent window should be displayed.           |
FALSE        | The user is not within the scope of the GDPR or CCPA laws OR the consent window has already been shown.  |
UNKNOWN      | The value is undefined(the requestConsentInfoUpdate method was not called).                              |

**2.3. Show Consent window**
> Note: SDK allows calling consent window API only after request

After the SDK requests, you can build and load the consent window. Loading allowed in any regulation zone and independent from previous consent.
Use the following code for loading consent form
```dart
ConsentManager.loadConsentForm();
```

You can check that the consent window is ready or not
```dart
var isLoaded = await ConsentManager.consentFormIsLoaded();
```
After the consent window Is ready you can show it as Activity or Dialog
```dart
ConsentManager.showAsDialogConsentForm();
ConsentManager.showAsActivityConsentForm();
```
> Note: After the first display of the consent window, the shouldShowConsentDialog method will return the value of Consent.ShouldShow.FALSE in the next sessions

Handling presentation callbacks of Consent Form:
```dart
ConsentManager.setConsentFormListener(
      (onConsentFormLoaded) => {},
      (onConsentFormError, error) => {},
      (onConsentFormOpened) => {},
      (onConsentFormClosed, consent) => {}
);
```
## App Tracking Transparency
Starting in iOS 14, IDFA will be unavailable until an app calls the App Tracking Transparency framework to present the app-tracking authorization request to the end-user. If an app does not present this request, the IDFA will automatically be zeroed out which may lead to a significant loss in ad revenue.

To display the App Tracking Transparency authorization request for accessing the IDFA, update your Info.plist to add the NSUserTrackingUsageDescription key with a custom message describing the usage.
```
<key>NSUserTrackingUsageDescription</key>
<string>This identifier will be used to deliver personalized ads to you.</string>
```
If you are using StackConsentManager framework in your project there are no additional steps required. Authorization request will be shown for users under iOS 14.5.

Disable ATT request via Appodeal Unity Consent Manger:
```dart
ConsentManager.disableAppTrackingTransparencyRequest();
```