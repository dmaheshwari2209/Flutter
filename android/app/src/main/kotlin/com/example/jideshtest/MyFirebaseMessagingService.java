package com.example.jideshtest;

import android.app.ActivityManager;
import android.app.KeyguardManager;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Process;
import android.util.Log;

import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import com.clevertap.android.sdk.CleverTapAPI;

import com.clevertap.android.sdk.pushnotification.NotificationInfo;
import com.google.firebase.messaging.RemoteMessage;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingService;


public class MyFirebaseMessagingService extends FlutterFirebaseMessagingService {
    MethodChannel channel;
    final String ENGINE_ID = "1";
    @Override
    public void onMessageReceived(RemoteMessage message) {
Context context=this;
        try {
            if (message.getData().size() > 0) {
                Bundle extras = new Bundle();
                for (Map.Entry<String, String> entry : message.getData().entrySet()) {
                    extras.putString(entry.getKey(), entry.getValue());
                }

                NotificationInfo info = CleverTapAPI.getNotificationInfo(extras);

                if (info.fromCleverTap) {
                    CleverTapAPI.getDefaultInstance(this).pushNotificationViewedEvent(extras);

                   //
                } else {


                }
                Handler handler = new Handler(Looper.getMainLooper());
                handler.post(new Runnable() {
                    @Override
                    public void run() {

                        MainApplication m=new MainApplication();
                        m.runfunct(context,bundleToMap(extras));}


                });


            }
        } catch (Throwable t) {
            Log.d("MYFCMLIST", "Error parsing FCM message", t);
        }
    }
    @Override
    public void onNewToken(String token) {
        //Log.d(TAG, "Refreshed token: " + token);

        //String token = FirebaseInstanceId.getInstance().getToken();
        CleverTapAPI.getDefaultInstance(this).pushFcmRegistrationId(token,true);

        // If you want to send messages to this application instance or
        // manage this apps subscriptions on the server side, send the
        // Instance ID token to your app server.
        //sendRegistrationToServer(token);
    }

    private static boolean isApplicationForeground(Context context) {
        KeyguardManager keyguardManager =
                (KeyguardManager) context.getSystemService(Context.KEYGUARD_SERVICE);

        if (keyguardManager.isKeyguardLocked()) {
            return false;
        }
        int myPid = Process.myPid();

        ActivityManager activityManager =
                (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);

        List<ActivityManager.RunningAppProcessInfo> list;

        if ((list = activityManager.getRunningAppProcesses()) != null) {
            for (ActivityManager.RunningAppProcessInfo aList : list) {
                ActivityManager.RunningAppProcessInfo info;
                if ((info = aList).pid == myPid) {
                    return info.importance == ActivityManager.RunningAppProcessInfo.IMPORTANCE_FOREGROUND;
                }
            }
        }
        return false;
    }
    public static Map<String, String> bundleToMap(Bundle extras) {
        Map<String, String> map = new HashMap<String, String>();

        Set<String> ks = extras.keySet();
        Iterator<String> iterator = ks.iterator();
        while (iterator.hasNext()) {
            String key = iterator.next();
            map.put(key, extras.getString(key));
        }/*from   w ww .j  a  v  a 2s .c  o m*/
        return map;
    }
}