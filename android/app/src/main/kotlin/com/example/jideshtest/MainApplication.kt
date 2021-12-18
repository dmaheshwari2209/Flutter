package com.example.jideshtest

import com.clevertap.android.sdk.ActivityLifecycleCallback
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.MethodChannel

class MainApplication: FlutterApplication() {
    var channel: MethodChannel? = null
    override fun onCreate() {
        ActivityLifecycleCallback.register(this) //<--- Add this before super.onCreate()
        super.onCreate()
    }

}
