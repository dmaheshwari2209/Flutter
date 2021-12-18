package com.example.jideshtest;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.ArrayList;
import java.util.List;

import io.flutter.Log;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    MethodChannel channel;
    final String ENGINE_ID = "1";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
//        channel = new MethodChannel(getFlutterView(), "myChannel");
//        channel.invokeMethod("methodNameItz", null, new MethodChannel.Result() {
//            @Override
//            public void success(Object o) {
//                Log.d("Results", o.toString());
//            }
//            @Override
//            public void error(String s, String s1, Object o) {
//                Log.d("Error Results", o.toString());
//            }
//            @Override
//            public void notImplemented() {
//                Log.d("Not implemented","nop");
//            }
//
//        });
    }




}