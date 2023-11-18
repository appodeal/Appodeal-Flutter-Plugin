package com.appodeal.appodeal_flutter_example

import android.os.Bundle
import com.appodeal.ads.Appodeal
import com.appodeal.appodeal_flutter.nativeAdViewBinder
import com.appodeal.appodeal_flutter_example.native_ad.NativeAdViewBinderImpl
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Appodeal.nativeAdViewBinder = NativeAdViewBinderImpl(this)
    }
}