// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:point_in_polygon/point_in_polygon.dart';
// import '../../../../core/constants/app_style.dart';
// import '../../../../core/di/di_manager.dart';
// import '../../../../core/utils/localization/app_localizations.dart';
// import '../../../../core/utils/ui/dialogs/custom_dialogs.dart';
// import 'package:utm/utm.dart';
//
// /// Determine the current position of the device.
// ///
// /// When the location services are not enabled or permissions
// /// are denied the `Future` will return an error.
// class AppLocation {
//   // Future<double> determinePosition() async {
//   //   bool serviceEnabled;
//   //   LocationPermission permission;
//   //
//   //   // Test if location services are enabled.
//   //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   //   // if (!serviceEnabled) {
//   //   //   // Location services are not enabled don't continue
//   //   //   // accessing the position and request users of the
//   //   //   // App to enable the location services.
//   //   //   return Future.error('Location services are disabled.');
//   //   // }
//   //
//   //   permission = await Geolocator.checkPermission();
//   //   if (permission == LocationPermission.denied) {
//   //     permission = await Geolocator.requestPermission();
//   //     if (permission == LocationPermission.denied) {
//   //       // Permissions are denied, next time you could try
//   //       // requesting permissions again (this is also where
//   //       // Android's shouldShowRequestPermissionRationale
//   //       // returned true. According to Android guidelines
//   //       // your App should show an explanatory UI now.
//   //       return Future.error('Location permissions are denied');
//   //     }
//   //   }
//   //
//   //   if (permission == LocationPermission.deniedForever) {
//   //     // Permissions are denied forever, handle appropriately.
//   //     return Future.error(
//   //         'Location permissions are permanently denied, we cannot request permissions.');
//   //   }
//   //
//   //   // When we reach here, permissions are granted and we can
//   //   // continue accessing the position of the device.
//   //   final result = await Geolocator.getCurrentPosition();
//   //   return Future.value(Geolocator.distanceBetween(
//   //     25.105090,
//   //     55.199490,
//   //     result.latitude,
//   //     result.longitude,
//   //   ));
//   // }
//
//
//   /// Determine the current position of the device.
//   ///
//   /// When the location services are not enabled or permissions
//   /// are denied the `Future` will return an error.
//   Future<Position?> getCurrentPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         Fluttertoast.showToast(toastLength:Toast.LENGTH_LONG, msg: "Location permissions are denied",);
//         return null;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       CustomDialogs.showTowButtonsDialog(
//         context: Get.context!,
//         children: [
//           Text(
//             translate('confirm_enable_location'),
//             style: AppStyle.defaultStyle,
//           ),
//         ],
//         firstButtonString: translate('no'),
//         secondButtonString: translate('yes'),
//         firstButtonFunction: () {
//           Fluttertoast.showToast(toastLength:Toast.LENGTH_LONG, msg: 'Location permissions are permanently denied, we cannot request permissions.',);
//
//             DIManager.findNavigator().pop();
//
//         },
//         secondButtonFunction: () async {
//             DIManager.findNavigator().pop();
//           await Geolocator.openAppSettings();
//           await Geolocator.openLocationSettings();
//         },
//       );
//       return null;
//     }
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       Fluttertoast.showToast(toastLength:Toast.LENGTH_LONG, msg: 'Location services are disabled.',);
//       return null;
//     }
//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition();
//   }
//
//   UtmCoordinate convertUtmToLatLong(double east, double north){
//     final latlon = UTM.fromUtm(
//       easting: east,
//       northing: north,
//       zoneNumber: 40,
//       zoneLetter: "R",
//     );
//     return latlon;
//   }
//
//
//   List<Point> extractPolygonFromJsonObject(String json){
//     try {
//       List<Point> polygon = [];
//       List<double> list = json.replaceAll("POLYGON ((", "").replaceAll("))", "").replaceAll(",", "").split(" ").
//       map((e) => double.parse(e)).toList();
//       for(int i = 0; i < list.length; i=i+2){
//         UtmCoordinate latLong = convertUtmToLatLong(list[i], list[i+1]);
//         polygon.add(Point(x: latLong.lat, y: latLong.lon));
//       }
//       return polygon;
//     } catch (e) {
//       return [];
//     }
//   }
//
//
//
//   /// how to test it
//   /// 1- go to https://www.keene.edu/campus/maps/tool/
//   /// 2- paste the coordinates of the polygon in the text box
//   /// 54.49229616466367,24.414443757871318
//   ///
//   /// 54.49010213674438, 24.413515690227676
//   ///
//   /// 54.49022312869318,24.41261671647998
//   ///
//   /// 54.49217617868369, 24.413073688356285
//   ///
//   /// 54.49229616466367,24.414443757871318
//   ///
//   /// 3- get any point from map inside or out side the polygon
//   /// 4- call the method below and pass the point with the polygon to see if it is inside or outside
//   ///
//   /// lat: 24.41454, long: 54.49210 is outside
//   /// lat: 24.41436, long: 54.49219 is outside
//   bool checkIfUserCurrentLocationIsInPolygon(List<Point> polygon, double lat, double lon){
//     return Poly.isPointInPolygon(Point(x: lat,y: lon), polygon);
//   }
//
// }
