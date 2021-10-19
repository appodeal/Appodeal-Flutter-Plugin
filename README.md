# Appodeal Flutter
## Step 1. Import SDK

1.1 Add the dependency to the pubspec.yaml file in your project:
```yaml
dependencies:
  appodeal_flutter: 1.0.0
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
If you are using minSdkVersion 20 (Android 4.4) and versions below you need to add Multidex support to your project. Follow this guide to add Multidex.

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
