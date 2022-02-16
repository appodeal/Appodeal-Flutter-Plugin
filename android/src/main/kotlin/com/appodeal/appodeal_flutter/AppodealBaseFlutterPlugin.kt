package com.appodeal.appodeal_flutter

import android.app.Activity
import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel
import java.lang.ref.WeakReference

internal abstract class AppodealBaseFlutterPlugin :
    FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {

    private var activityReference = WeakReference<Activity>(null)
    private var contextReference = WeakReference<Context>(null)
    internal val activity: Activity get() = checkNotNull(activityReference.get())
    internal val applicationContext: Context
        get() = checkNotNull(contextReference.get() ?: activity.applicationContext)

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        contextReference = WeakReference(binding.applicationContext)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityReference = WeakReference(binding.activity)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activityReference.clear()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activityReference = WeakReference(binding.activity)
    }

    override fun onDetachedFromActivity() {
        activityReference.clear()
    }
}