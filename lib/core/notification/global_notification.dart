// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import '../../../../core/di/di_manager.dart';
// import '../../../../core/shared_prefs/shared_prefs.dart';
//
// class GlobalNotification {
//
//   static final GlobalNotification instance = GlobalNotification._internal();
//
//
//   factory GlobalNotification._() {
//     return instance;
//   }
//
//   GlobalNotification._internal();
//
//
//
//   String? currentVersion;
//
//   String get osType{
//    if(Platform.isAndroid) return "Android";
//    return "IOS";
//   }
//
//   static final ValueNotifier<bool> onNotificationClick =
//   ValueNotifier(false);
//
//   static final StreamController<Map<String, dynamic>> _onMessageStreamController =
//   StreamController.broadcast();
//
//   late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
//   static FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   void deleteFCMToken(){
//     messaging.deleteToken();
//     DIManager.findDep<SharedPrefs>().fcmToken.val = null;
//   }
//
//
//  Future<void> setupNotification()async{
//     _flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();
//     const android = AndroidInitializationSettings("@mipmap/ic_launcher");
//     const ios =IOSInitializationSettings();
//     const initSettings =InitializationSettings(android: android, iOS: ios);
//     _flutterLocalNotificationsPlugin.initialize(
//       initSettings,
//       onSelectNotification: flutterNotificationClick,
//     );
//     await Firebase.initializeApp();
//     final settings = await messaging.requestPermission(provisional: true);
//     if (kDebugMode) {
//       print('User granted permission: ${settings.authorizationStatus}');
//     }
//     if(settings.authorizationStatus==AuthorizationStatus.authorized){
//
//     }
//     final packageInfo = await PackageInfo.fromPlatform();
//     messaging.getToken().then((token) {
//       if (kDebugMode) {
//       print("token ======> $token");
//       }
//       DIManager.findDep<SharedPrefs>().setFCMToken(token);
//       /// get version
//       currentVersion = "${packageInfo.version}-${packageInfo.buildNumber}";
//
//     });
//     messaging.setForegroundNotificationPresentationOptions();
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (kDebugMode) {
//         print("_____________________Message data:${message.data}");
//         print("_____________________notification:${message.notification?.title}");
//       }
//       _showLocalNotification(message);
//       _onMessageStreamController.add(message.data);
//
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('AonMessageOpenedApp event was published!');
//       flutterNotificationClick(json.encode(message.data));
//     });
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }
//
//   static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     print("Handling a background message: ${message.messageId}");
//     await Firebase.initializeApp();
//     // flutterNotificationClick(json.encode(message.data));
//   }
//
//   StreamController<Map<String, dynamic>> get notificationSubject {
//     return _onMessageStreamController;
//   }
//
//  void _showLocalNotification(RemoteMessage? message) async {
//     if (message == null) return;
//     final android = AndroidNotificationDetails(
//       "ae.saeed.notification",
//       "Default",
//       priority: Priority.high,
//       importance: Importance.max,
//       shortcutId: DateTime.now().toIso8601String(),
//     );
//     const ios = IOSNotificationDetails();
//     final _platform = NotificationDetails(android: android, iOS: ios);
//     _flutterLocalNotificationsPlugin.show(
//         DateTime.now().microsecond, "${message.notification?.title}", "${message.notification?.body}", _platform,
//         payload: json.encode(message.data));
//   }
//
//   static Future flutterNotificationClick(String? payload) async {
//     // final _data = json.decode("$payload");
//    // var context = GetIt.I<AppRouter>().navigatorKey.currentContext!;
//     onNotificationClick.value = true;
//   }
//   static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     /// Create a [AndroidNotificationChannel] for heads up notifications
//     AndroidNotificationChannel channel;
//
//     /// Initialize the [FlutterLocalNotificationsPlugin] package.
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//     await Firebase.initializeApp();
//     channel = const AndroidNotificationChannel(
//       "ae.saeed.notification",
//       "Default",
//       importance: Importance.max,
//       enableLights: true,
//       playSound: true,
//       enableVibration: true,
//       showBadge: true,
//       sound: RawResourceAndroidNotificationSound('notification'),
//     );
//
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//     /// Create an Android Notification Channel.
//     ///
//     /// We use this channel in the `AndroidManifest.xml` file to override the
//     /// default FCM channel to enable heads up notifications.
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//
//     /// Update the iOS foreground notification presentation options to allow
//     /// heads up notifications.
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
// }
