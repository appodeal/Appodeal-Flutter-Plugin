# Appodeal Flutter
## Step 1. Import SDK

1.1 Add the dependency to the pubspec.yaml file in your project:
```yaml
dependencies:
  stack_appodeal_flutter: 1.0.4-beta
```
1.2 Install the plugin by running the command below in the terminal:
```
$ flutter pub get
```
___
## Step 2. Project configuration
### 2.1 Android configuration
 **2.1.1 Configure AndroidManifest.xml**
For the Appodeal SDK to work correctly, you need to add permissions to AndroidManifest.
We distinguish 2 sets of permissions: required permissions, without which the Appodeal SDK cannot work, and optional permissions, which are needed to improve targeting.For more information about the purpose of each of the permissions, see the  [FAQ](https://faq.appodeal.com/en/articles/2658520-android-sdk-permissions)  section.
- Add required permissions to your AndroidManifest.xml file under manifest tag:
```xml
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.INTERNET" />
```
- Add optional permissions to your  AndroidManifest.xml  file under  manifest  tag to improve ad targeting:
```xml
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.VIBRATE" />
```
> Note: [According to  Google policy](https://support.google.com/googleplay/android-developer/answer/9857753?hl=en) , location permissions may only be requested to provide features beneficial to the user and relevant to the core functionality of the app. You cannot request access to location data for the sole purpose of advertising or analytics.
**If you are not using location for the main functions of your app**
 Remove location permission in your app by adding the following code to AndroidManifest.xml 
 <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"
	tools:node="remove" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"
	tools:node="remove" />
	Update the app on Google Play. During the publishing process, make sure there are no location warnings in Google Play Console.
	**If you are using location for the main functions of your app**
	Fill out the Location permissions declaration form in  [Google Play Console](https://play.google.com/console/u/0/developers/app/app-content/permission-declarations) . You can read more about the declaration form  [here](https://support.google.com/googleplay/android-developer/answer/9799150?hl=en#zippy=%2Cwhere-do-i-find-the-declaration).
	Update the app on Google Play. During the publishing process, make sure there are no location warnings in Google Play Console.
	
	
> Note:	Some networks and 3rd party dependencies (related to network dependencies) can include their own permissions to the manifest. If you want to force remove such permissions you can refer to [this guide](https://developer.android.com/studio/build/manifest-merge#node_markers).

 **2.1.2 Multidex support**
If you are using minSdkVersion 20 (Android 4.4) and versions below you need to add Multidex support to your project. Follow [this guide](https://developer.android.com/studio/build/multidex.html) to add Multidex.

**2.1.3 Configure Admob/A4G meta-data** 
Add your AdMob app id to meta-data tag:
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
You may find the AdMob app id in your personal account on the AdMob page:
![Alt-текст](https://wiki.appodeal.com/en/files/64226560/64226561/1/1612173800895/image2019-5-13_6-17-7.png "admob app id")
For more information about Admob sync check out our [FAQ](https://faq.appodeal.com/en/articles/4185565-how-do-i-link-my-admob-account).
___
### 2.1 iOS configuration
**2.1.1 Add SKAdNetworkIds**
Ad networks used in Appodeal mediation support conversion tracking using Apple's `SKAdNetwork` , which means ad networks are able to attribute an app install even when IDFA is unavailable. To enable this functionality, you will need to update the `SKAdNetworkItems` key with an additional dictionary in your  `Info.plist`.
1. Select Info.plist in the Project navigator in Xcode
2. Click the Add button (+) beside a key in the property list editor and press Return
3. Type the key name SKAdNetworkItems
4. Choose an Array  type
5. Add Key-Value pair where the key is SKAdNetworkIdentifier and the value is the ad network identifier

[There is SKAdNetworks IDs](https://wiki.appodeal.com/en/unity/get-started#:~:text=There%20is%20SKAdNetworks%20IDs%20in%C2%A0%20Info.plist%20format%3A)

**2.1.2 Configure App Transport Security Settings**
In order to serve ads, the SDK requires you to allow arbitrary loads. Set up the following keys in **info.plist** of your app:
1. Go to your info.plist  file, then press  Add+ anywhere in the first column of the key list.
2. Add App Transport Security Settings key  and set its type to  Dictionary in the second column.
3. Press Add+  at the end of the name  App Transport Security  Settingske y and choose  Allow Arbitrary loads . Set its type to  Boolean  and its value to  Yes .

You can also add the key to your info.plist directly, using this code:
```
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```
**2.1.4 Other feature usage descriptions**
To improve ad performance the the following entries should be added:
1. **GADApplicationIdentifier** - When including AdMob in your project you must also add your AdMob app ID to your info.plist . Use the key GADApplicationIdentifier with the value being your AdMob app ID. For more information about Admob sync check out our [FAQ](https://faq.appodeal.com/en/articles/4185565-how-do-i-link-my-admob-account).
2. **NSUserTrackingUsageDescription** - As of iOS 14 using IDFA requires permission from the user. The following entry must be added in order to improve ad performance.
3. **NSLocationWhenInUseUsageDescription** - Entry is required if your application allows Appodeal SDK to use location data.
4. **NSCalendarsUsageDescription** - Recommended by some ad networks.

```
<key>GADApplicationIdentifier</key> 
<string>YOUR_ADMOB_APP_ID</string>
<key>NSUserTrackingUsageDescription</key>
<string><App Name> needs your advertising identifier to provide personalised advertising experience tailored to you</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string><App Name> needs your location for analytics and advertising purposes</string>
<key>NSCalendarsUsageDescription</key>
<string><App Name> needs your calendar to provide personalised advertising experience tailored to you</string>
```
___
## Step 3. Initialize SDK
To initialize Appodeal SDK use this following method:
```dart
Appodeal.initialize(
        "YOUR_APPODEAL_APP_KEY", [ad_types], consentValue);
```
`consentValue` is bool, with 'false' meaning that the user declines to give the consent.

> Note: Make sure to replace "YOUR_APPODEAL_APP_KEY" with the actual app key.

Use the type codes below to set the preferred ad format:
- Appodeal.INTERSTITIAL for interstitial.
- Appodeal.REWARDED_VIDEO for rewarded videos.
- Appodeal.BANNER for banners.
- Appodeal.MREC for 300*250 banners.
___

## Interstitial

Interstitial ads are full-screen advertisements. In Appodeal, they are divided into two types - static interstitial and video interstitial.
Both types of ads are requested in parallel when caching and will be shown to be the most expensive of the two.
static interstitial - static full-screen banners.
video interstitial - these are videos that the user can close 5 seconds after the start of viewing.
### Initialize interstitial
Add the following code to initialize Interstitials
```dart
Appodeal.initialize(
        "YOUR_APPODEAL_APP_KEY", [Appodeal.INTERSTITIAL], consentValue);
```

**Manual caching**
If you need more control of interstitial ads loading use manual caching. Manual caching for Interstitial can be useful to improve [display rate](https://blog.appodeal.com/whats-display-rate/) or decrease SDK loads when several ad types are cached.

To disable automatic caching for Interstitials, use the code below before the SDK initialization:
```dart
Appodeal.setAutoCache(Appodeal.INTERSTITIAL, false);
```
To cache interstitial use:
```dart
Appodeal.cache(Appodeal.INTERSTITIAL);
```
To display interstitial, you need to call the following code:
```dart
Appodeal.show(Appodeal.INTERSTITIAL);
```
You can check the status of loading before showing. This method returns a bool value indicating whether the interstitial is loaded.
```dart
Appodeal.isLoaded(Appodeal.INTERSTITIAL);
```
**Interstitial placements**
Appodeal SDK allows you to tag each impression with different placement. For using placements you need to create placements in Appodeal Dashboard. [Read more](https://wiki.appodeal.com/enstag/segments-and-placements/appodeal-placements) about placements.
To show an interstitial ad with placement use the following code: 
```dart
Appodeal.showWithPlacement(Appodeal.INTERSTITIAL, “placementName”);
```
**Interstitial callbacks**
The callbacks are used to track different events in the lifecycle of an ad, e.g. when an ad was clicked on or closed. To implement them use the following code: 
```dart
Appodeal.setInterstitialCallbacks(
        (onInterstitialLoaded, isPrecache) => {},
        (onInterstitialFailedToLoad) => {},
        (onInterstitialShown) => {},
        (onInterstitialShowFailed) => {},
        (onInterstitialClicked) => {},
        (onInterstitialClosed) => {},
        (onInterstitialExpired) => {});
  }
```

**Get predicted eCPM**
This method return expected eCPM for cached ad. Amount is calculated based on historical data for the current ad unit.
```dart
    Appodeal.getPredictedEcpm(Appodeal.INTERSTITIAL);
```

**Mute video interstitials (Only for android platform)**
You can mute video ads if calls is muted on the device. For muting you need to call the following code before the initialization method:
```dart
    Appodeal.muteVideosIfCallsMuted(true);
```
## Rewarded video
Rewarded video - user-initiated ads where users can earn in-app rewards in exchange for viewing a video ad.
### Initialize Rewarded video
Add the following code to initialize Interstitials
```dart
Appodeal.initialize(
        "YOUR_APPODEAL_APP_KEY", [Appodeal.REWARDED_VIDEO], consentValue);
```
**Manual caching**
If you need more control of Rewarded video ads loading use manual caching. Manual caching for Rewarded video can be useful to improve [display rate](https://blog.appodeal.com/whats-display-rate/) or decrease SDK loads when several ad types are cached.
To disable automatic caching for Rewarded video, use the code below before the SDK initialization:
```dart
Appodeal.setAutoCache(Appodeal.REWARDED_VIDEO, false);
```
To cache Rewarded video use:
```dart
Appodeal.cache(Appodeal.REWARDED_VIDEO);
```
To display Rewarded video, you need to call the following code:
```dart
Appodeal.show(Appodeal.REWARDED_VIDEO);
```
You can check the status of loading before showing. This method returns a bool value indicating whether the Rewarded video is loaded.
```dart
Appodeal.isLoaded(Appodeal.REWARDED_VIDEO);
```
**Rewarded video placements**
Appodeal SDK allows you to tag each impression with different placement. For using placements you need to create placements in Appodeal Dashboard. [Read more](https://wiki.appodeal.com/enstag/segments-and-placements/appodeal-placements) about placements.
To show an rewarded video ad with placement use the following code: 
```dart
Appodeal.showWithPlacement(Appodeal.REWARDED_VIDEO, “placementName”);
```
**Rewarded video callbacks**
The callbacks are used to track different events in the lifecycle of an ad, e.g. when an ad was clicked on or closed. To implement them use the following code: 
```dart
 Appodeal.setRewardedVideoCallbacks(
      (onRewardedVideoLoaded, isPrecache) => {},
      (onRewardedVideoFailedToLoad) => {},
      (onRewardedVideoShown) => {},
      (onRewardedVideoShowFailed) => {},
      (onRewardedVideoFinished, amount, reward) => {},
      (onRewardedVideoClosed, isFinished) => {},
      (onRewardedVideoExpired) => {},
      (onRewardedVideoClicked) => {},
    );
```
**Get predicted eCPM**
This method return expected eCPM for cached ad. Amount is calculated based on historical data for the current ad unit.
```dart
    Appodeal.getPredictedEcpm(Appodeal.REWARDED_VIDEO);
```
___
## Banner
Banner ads are classic static banners, which are usually located at the bottom or top of the advertisement. Appodeal supports traditional 320x50 banners, tablet banners 728x90 and smart banners that adjust to the size and orientation of the device.
You can display only one view for banner on the screen.

### Initialize banner
Add the following code to initialize banners
```dart
Appodeal.initialize(
        "YOUR_APPODEAL_APP_KEY", [Appodeal.BANNER], consentValue);
```
**Display banner**
Banner ads are refreshed every 15 seconds automatically by default. To display banner, you need to call the following code:
```dart
Appodeal.show(Appodeal.BANNER_BOTTOM); // Display banner at the bottom of the screen
Appodeal.show(Appodeal.BANNER_TOP); // Display banner at the top of the screen
Appodeal.show(Appodeal.BANNER_LEFT); // Display banner at the left of the screen
Appodeal.show(Appodeal.BANNER_RIGHT); // Display banner at the right of the screen
```
**Display banner view at a custom position**
To display a banner view add widget AppodealBanner()
```dart
child: AppodealBannerView(placementName: "default"))
```
**Check if banner is loaded**
```dart
Appodeal.isLoaded(Appodeal.BANNER);
```
**Hide banner**
```dart
Appodeal.hide(Appodeal.BANNER);
```
**Destroy banner**
To free memory from hidden banner call the code below:
```dart
Appodeal.destroy(Appodeal.BANNER);
```
**Banner placements**
Appodeal SDK allows you to tag each impression with different placement. For using placements you need to create placements in Appodeal Dashboard. [Read more](https://wiki.appodeal.com/enstag/segments-and-placements/appodeal-placements) about placements.
To show an banner ad with placement use the following code: 
```dart
Appodeal.showWithPlacement(Appodeal.BANNER, “placementName”);
```
If the loaded ad can’t be shown for a specific placement, nothing will be shown. 
You can configure your impression logic for each placement.
If you have no placements, or call Appodeal.show with placement that do not exist, the impression will be tagged with 'default' placement and its settings will be applied.

**Banner callbacks**
The callbacks are used to track different events in the lifecycle of an ad, e.g. when an ad was clicked on or closed. To implement them use the following code: 
```dart
 Appodeal.setBannerCallbacks(
            (onBannerLoaded, isPrecache) => {},
            (onBannerFailedToLoad) => {},
            (onBannerShown) => {},
            (onBannerShowFailed) => {},
            (onBannerClicked) => {},
            (onBannerExpired) => {};
```
## MREC 
MREC is 300x250 banner. This type can be useful if the application has a large free area for placing a banner in the interface.

**Initialize MREC**
Add the following code to initialize mrecs
```dart
Appodeal.initialize(
        "YOUR_APPODEAL_APP_KEY", [Appodeal.MREC], consentValue);
```
**Display MREC**
Appodeal SDK allows you to tag each impression with different placement. For using placements you need to create placements in Appodeal Dashboard. [Read more](https://wiki.appodeal.com/enstag/segments-and-placements/appodeal-placements) about placements.
To display a mrec view add widget AppodealBanner()
```dart
child: AppodealMrecView(placementName: "default"))
```
**MREC callbacks**
The callbacks are used to track different events in the lifecycle of an ad, e.g. when an ad was clicked on or closed. To implement them use the following code: 
```dart
Appodeal.setMrecCallbacks(
            (onMrecLoaded, isPrecache) => {},
            (onMrecFailedToLoad) => {},
            (onMrecShown) => {},
            (onMrecShowFailed) => {},
            (onMrecClicked) => {},
            (onMrecExpired) => {};
  }
```
## GDPR and CCPA
> Note:Keep in mind that it’s best to contact qualified legal professionals, if you haven’t done so already, to get more information and be well-prepared for compliance

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

> Note:**Please note that although we’re always eager to back you up with valuable information, we’re not authorized to provide any legal advice. It’s important to address your questions to lawyers who work specifically in this area.**

## Step 2: Stack Consent Manager
In order for Appodeal and our ad providers to deliver ads that are more relevant to your users, as a mobile app publisher, you need to collect explicit user consent in the regions covered by GDPR and CCPA.

To get consent for collecting personal data of your users, we suggest you use a ready-made solution - Stack Consent Manager.

Stack Consent Manager comes with a pre-made consent window that you can easily present to your users. That means you no longer need to create your own consent window.

> Note:Minimal requirements: Appodeal SDK 2.7.0 or higher.

**2.1. Update Consent Status**
When using the Consent SDK, it is recommended that you determine the status of a user's consent at every app launch.
Call the following code for determinating the status of a user's consent:
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
Code | Description | 
------------ | ------------- | 
INTERNAL(1) | Error on the SDK side. Includes JS-bridge or encoding/decoding errors
NETWORKING(2) | HTTP errors, parse request/response 
INCONSISTENT(3) | Incorrect SDK API usage

> Note: Consent manager SDK can be synchronized at any moment of the application lifecycle. We recommend synchronizing it at the application launch. Multiple synchronization calls are allowed.

If the consent information is successfully updated, the updated consent is provided via the onConsentInfoUpdated() method of the ConsentInfoUpdateListener.

Now you can receive information about the previous user consent and regulation zone. Before request these parameters are undefined.
```dart 
var consentStatus = await ConsentManager.getConsentStatus();
```

Consent Status | Description | 
------------ | ------------- | 
UNKNOWN | The user has neither granted nor declined consent for personalized or non-personalized ads.
NON_PERSONALIZED | The user has granted consent for non-personalized ads.
PARTLY_PERSONALIZED | The user has granted partly(for a few Ad networks) consent for personalized ads.
PERSONALIZED | The user has granted consent for personalized ads.

**2.2. Necessity of showing the consent window**
After the onConsentInfoUpdated method was called, you need to determine if your users are subject to the GDPR and CCPA and whether you should show the consent window for the collection of personal data.
You can check whether to show a Consent Dialog or not. Before request these parameters are undefined(Unknown status)
```dart
var shouldShow = await ConsentManager.shouldShowConsentDialog();
```
ShouldShow | Description | 
------------ | ------------- | 
TRUE | The user is within the scope of the GDPR or CCPA laws, the consent window should be displayed.
FALSE | The user is not within the scope of the GDPR or CCPA laws OR the consent window has already been shown.
UNKNOWN | The value is undefined(the requestConsentInfoUpdate method was not called).

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
## Advanced

### Coppa 
For purposes of the [Children's Online Privacy Protection Act (COPPA)](http://business.ftc.gov/privacy-and-security/children%27s-privacy), there is a setting called childDirectedTreatment. If your app is designed for kids you can disable sending user data to ad networks by the method below.

Should be called before the SDK initialization:
```dart
Appodeal.setChildDirectedTreatment(bool value);
```

Using test mode allows you to get our test ad creatives with 100% fillrate. Use the following code for enable test mode (Should be called before the SDK initialization):
```dart
Appodeal.setTesting(true);
``` 

To enable verbose logging, use the code below (Should be called before the SDK initialization):
```dart
    Appodeal.setLogLevel(Appodeal.LogLevelVerbose);
```
Logs will be written to logcat using the `"Appodeal"` tag.
Available parameters:

 - `Appodeal.LogLevelNone` - logs off;
 - `Appodeal.LogLevelDebug` - debug messages;
 - `Appodeal.LogLevelVerbose` -  all SDK and ad network messages.
