import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAn9YNjwzOzayKKhFgUs4_vGWDlsA8Tu3M',
      appId: '1:531495931694:android:34fa3544c6d3d1053ab4bf',
      messagingSenderId: '531495931694',
      projectId: 'com.example.fcm',
    ));
  runApp(MyApp());
 
}
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
void showNotification(String nm, String nt) async {
    //{notification: {title: title, body: test}, data: {notification_type: Welcome, body: body, badge: 1, sound: , title: farhana mam, click_action: FLUTTER_NOTIFICATION_CLICK, message: H R U, category_id: 2, product_id: 1, img_url: }}
    print(nm);

    var title = nt;
    var msge = nm;

    var android = new AndroidNotificationDetails(
        'fluttertest', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.max, importance: Importance.max);

    var platform = new NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.show(0, title, msge, platform,
        payload: msge);
  }
 Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
  showNotification(message.data["nm"],message.data["nt"]);
  CleverTapPlugin.createNotification(jsonEncode(message.data));
  print('on message'+message.data["nm"]+"working");
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  static const platform = const MethodChannel("myChannel");
  void _incrementCounter() {


    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      var eventData = {
        // Key:    Value
        'first': 'partridge',
        'second': 'turtledoves',
        'number': 1
      };
      CleverTapPlugin.recordEvent("Flutter Event",eventData);

    });
  }
  @override
  void initState() { CleverTapPlugin.setDebugLevel(3);
  CleverTapPlugin.createNotificationChannel("fluttertest", "Flutter Test", "Flutter Test", 3, true);
    platform.setMethodCallHandler(nativeMethodCallHandler);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher'); // <- default icon name is @mipmap/ic_launcher
 // var initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  
    super.initState();
FirebaseMessaging.instance.getToken();
       FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      CleverTapPlugin.createNotification(jsonEncode(message.data));
    });
    
  }
 
  Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
   
    //notification renderer
    /*******************************************IMPORTANT*****************************************************/
    showNotification(methodCall.arguments["nm"],methodCall.arguments["nt"]);//Iam using flutterlocalnotification for demostration purposes, here you can check
    //if notification is from clevertap by searching for the key "wzrk_cid" if its present you can put a condition to let clevertap handle the notification by calling createnotification method ,
    //else use your logic to render the push.

    switch (methodCall.method) {
      case "methodNameItz" :
        return "This is from android!!";
        break;
      default:
        return "Nothing";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  
  



}
