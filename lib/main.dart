import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:uni_links/uni_links.dart';
import 'package:wadeema/ui/work_focus_version/home/arg/items_args.dart';
import 'package:wadeema/ui/work_focus_version/home/pages/items_details_page.dart';
import 'package:wadeema/ui/work_focus_version/profile/pages/client_account_page.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/errors/app_error_handler/app_error_handler.dart';
import 'blocs/bloc_observer.dart';
import 'blocs/setting/settings_bloc.dart';
import 'core/shared_prefs/shared_prefs.dart';
import 'data/models/notifications/notifications_model.dart';
import 'ui/work_focus_version/app.dart';
// import 'package:timezone/data/latest.dart' as tzdata;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/standalone.dart' as tz;
//


final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

// Initialize the Firebase SDK
Future<void> _initFirebaseMessaging() async {

  await firebaseMessaging.getToken().then((token){
    print("token is $token");
    DIManager.findDep<SharedPrefs>()..setDeviceToken(token);
  });
  // Request permission to receive notifications
  NotificationSettings settings = await firebaseMessaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
}

// Handle the received notification when the app is in the background
Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  // ...
  print("mymessage"+message.data["notification"].toString());
  final json = jsonDecode(message.data["notification"].toString());
  final notification = ItemsNotificationsModel.fromJson(json);
  print(notification.type.toString());
  if (notification.type == "Evaluation User" ||
      notification.type  == "Follow") {
    DIManager.findNavigator().pushNamed(ClientAccountPage.routeName,
        arguments: int.parse(notification.user_id.toString()) );
  }
  else if(
  notification.type == "Approve Ad" ||
      notification.type == "Add Ad" ||
      notification.type == "Evaluation Ad" ||
      notification.type  == "Like"
  ){
    DIManager.findNavigator().pushNamed(
      ItemsDetailsPage.routeName,
      arguments: ItemsArgs(
        id: int.parse(notification.ad_id.toString()),
      ),
    );
  }
}
// Set up a notification listener
void _configureFirebaseMessaging() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // // Handle the received notification when the app is in the foreground

    print("mymessage"+message.data["notification"].toString());
    final json = jsonDecode(message.data["notification"].toString());
    final notification = ItemsNotificationsModel.fromJson(json);
    print(notification.type.toString());

  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Handle the received notification when the app is in the background

    print("mymessage"+message.data["notification"].toString());
    final json = jsonDecode(message.data["notification"].toString());
    final notification = ItemsNotificationsModel.fromJson(json);
    print(notification.type.toString());
    if (notification.type == "Evaluation User" ||
        notification.type  == "Follow") {
      DIManager.findNavigator().pushNamed(ClientAccountPage.routeName,
          arguments: int.parse(notification.user_id.toString()) );
    }
    else if(
    notification.type == "Approve Ad" ||
        notification.type == "Add Ad" ||
        notification.type == "Evaluation Ad" ||
        notification.type  == "Like"
    ){
      DIManager.findNavigator().pushNamed(
        ItemsDetailsPage.routeName,
        arguments: ItemsArgs(
          id: int.parse(notification.ad_id.toString()),
        ),
      );
    }
    // ...
  });

  FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
}


// void main() async {
//   Bloc.observer = MyBlocObserver();
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//   await DIManager.initDI();
//   await Firebase.initializeApp(
//
//   );
//
//   // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
//
//   await _initFirebaseMessaging();
//   _configureFirebaseMessaging();
//
//
//        // runApp(App());
//
// //
//   AppErrorHandler.dartErrorCatcher(
//
//
//         () => runApp(
// // DevicePreview(
// //             enabled: true,
// //             // tools: [
// //             //   ...DevicePreview.defaultTools,
// //             // ],
// //             builder: (context) =>App(),)
//             App()
//
//     ),
//   );
//
//
// }
void processIncomingLink(String url , SettingsCubit settingsCubit) async{
  // Process the incoming URL
  print('Incoming URL: $url');
  await settingsCubit.getShareLink(url);
}

void initUniLinks(SettingsCubit settingsCubit) async {
  print("initUniLinks");
  // Check if the app was launched from a deep link
  try {
    // Listen for incoming links

    uriLinkStream.listen((Uri? uri) {
      print("Listeeeeeeeeeeeeennnn $uri");
      if (uri?.path != "https://wadeema.syria5.com/api/mobile/")
        processIncomingLink(uri.toString() , settingsCubit);
      // handleDeepLink(uri!.path);
    },onError: (err){
      print("Error in listen $err");
    },onDone: () {
      print("========= Success in listen =========");
    },);
  } on PlatformException {
    print("Platform Exception");
    // Handle exception if unable to retrieve initial link
  }
}

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    // tz.initializeTimeZones();
    // var easternTimeZone = tz.getLocation('America/New_York');
    // var utcTime = DateTime.utc(2023, 4, 1, 12); // 12:00 PM UTC
    // var easternTime = tz.TZDateTime.from(utcTime, easternTimeZone);
    //
    // print(easternTime);
    // print(timeInDubai);
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = MyBlocObserver();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    await DIManager.initDI();
    await Firebase.initializeApp(

    );
    await _initFirebaseMessaging();
    _configureFirebaseMessaging();
    final settingsBloc = DIManager.findDep<SettingsCubit>();
    initUniLinks(settingsBloc);
    // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    runApp(App());




/*
    AppErrorHandler.dartErrorCatcher(


          () => runApp(
// DevicePreview(
//             enabled: true,
//             // tools: [
//             //   ...DevicePreview.defaultTools,
//             // ],
//             builder: (context) =>App(),)
          App()

      ),
    );
*/

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };
    // ErrorWidget.builder = (FlutterErrorDetails details) {
    //   return Center(child: Text(details.toString()));
    // };
  }, (error, stack) {
    debugPrint(error.toString());
  });
}

/*
 - package:get_version
 - package:connection_verify
 - package:package_info
   - package:carousel_slider
 - package:modal_progress_hud
 - package:icon_shadow
 - package:flutter_link_preview
 - package:gbk2utf8

 */
enum SlowMotionSpeedSetting { normal, slow, slower, slowest }

extension AnimationSpeedSettingExtension on SlowMotionSpeedSetting {
  double get value {
    switch (this) {
      case SlowMotionSpeedSetting.normal:
        return 1.0;
      case SlowMotionSpeedSetting.slow:
        return 5.0;
      case SlowMotionSpeedSetting.slower:
        return 10.0;
      case SlowMotionSpeedSetting.slowest:
        return 15.0;
    }
  }
}

/// adb tcpip 42263
/// adb connect 10.240.142.42:42263
