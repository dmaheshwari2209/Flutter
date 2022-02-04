package com.example.jideshtest

import android.content.Context
import android.util.Log
import com.clevertap.android.sdk.ActivityLifecycleCallback
import com.clevertap.android.sdk.CleverTapAPI
import com.clevertap.android.sdk.pushnotification.CTPushNotificationListener
import com.clevertap.clevertap_plugin.CleverTapPlugin
import io.flutter.app.FlutterApplication
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
//import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService
import io.flutter.view.FlutterMain
import java.util.*


class MainApplication: FlutterApplication(), PluginRegistrantCallback  {
    var channel: MethodChannel? = null
    private val CHANNEL = "myChannel"
    override fun onCreate() {
        ActivityLifecycleCallback.register(this)
        //<--- Add this before super.onCreate()
      //  GetMethodChannel(this)
        super.onCreate()

  //     FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this);
FlutterMain.startInitialization(this)
        val cleverTapAPI = CleverTapAPI.getDefaultInstance(applicationContext)

    }
    fun GetMethodChannel(context: Context, r: Map<String, String>) {
        FlutterMain.startInitialization(context)
        FlutterMain.ensureInitializationComplete(context, arrayOfNulls(0))
        val engine = FlutterEngine(context.applicationContext)
        val entrypoint = DartExecutor.DartEntrypoint("lib/main.dart", "main")
        engine.dartExecutor.executeDartEntrypoint(entrypoint)

         MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL).invokeMethod("methodNameItz", r, object : MethodChannel.Result {
             override fun success(o: Any?) {
                 Log.d("Results", o.toString())
             }

             override fun error(s: String, s1: String?, o: Any?) {
                 Log.d("No result as error", o.toString())
             }

             override fun notImplemented() {

                 Log.d("No result as error", "cant find ")
             }
         })


    }
    fun runfunct(context: Context, r: Map<String, String>) {
       // GetMethodChannel(context, r)
    }
 override fun registerWith(registry: PluginRegistry?) {
     
    }

}
