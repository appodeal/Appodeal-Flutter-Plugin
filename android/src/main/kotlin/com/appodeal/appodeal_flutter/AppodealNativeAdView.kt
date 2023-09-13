package com.appodeal.appodeal_flutter

import android.app.Activity
import android.content.Context
import android.view.View
import android.view.ViewGroup
import com.appodeal.ads.nativead.NativeAdView
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import java.lang.ref.WeakReference


class AppodealNativeAdView(activity: Activity, arguments: HashMap<*, *>)  : PlatformView {
    private val placement: String = arguments["placement"] as? String ?: "default"
    private val adView: View = getAdView(activity)

    init {
        (adView.parent as? ViewGroup)?.removeView(adView)
        arguments.parseNativeParams()
    }

    private fun getAdView(context: Context): NativeAdView {
        return NativeAdView(context)
    }

    override fun getView(): View = adView

    override fun dispose() {}
}

private var refNativeAdView = WeakReference<View>(null)

fun HashMap<*, *>.parseNativeParams() {
    println(this.toString())
}

//Map<String, dynamic> get toMap => <String, dynamic>{
//    'templateType' : templateType,
//    'templateOptions': options?.toMap,
//};

//Map<String, dynamic> get toMap => <String, dynamic>{
//    'nativeBanner' : nativeBanner.toMap,
//    'nativeFullOptions': options.toMap,
//};

//Map<String, dynamic> get toMap => <String, dynamic>{
//    'native_banner_options': options.toMap,
//    'adChoicePosition': adChoicePosition
//};

//Map<String, dynamic> get toMap => <String, dynamic>{
//    'iconSize' : iconSize,
//    'titleTextSize': titleTextSize,
//    'ctaTextSize': ctaTextSize,
//    'ctaTextSize': ctaTextSize,
//    'descriptionViewTextSize': descriptionViewTextSize,
//    'adAttributionBackgroundColor': adAttributionBackgroundColor?.value,
//    'adAttributionTextColor': adAttributionTextColor?.value,
//};

//Map<String, dynamic> get toMap => <String, dynamic>{
//    'mediaViewPosition': mediaViewPosition,
//};

//Map<String, dynamic> get toMap => <String, dynamic>{
//    'viewPosition' : viewPosition,
//    'containerMargin': containerMargin,
//    'iconSize': iconSize,
//    'iconMargin': iconMargin,
//    'titleMargin': titleMargin,
//    'descriptionSize': descriptionSize,
//    'descriptionMargin': descriptionMargin,
//    'ctaTextSize': ctaTextSize,
//    'ctaMargin': ctaMargin,
//    'titleColor': titleColor?.value,
//    'descriptionColor': descriptionColor?.value,
//    'ctaBackground': ctaBackground?.value,
//    'ctaTextColor': ctaTextColor?.value,
//};