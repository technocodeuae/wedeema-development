import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';


class LocationManager {
  static final shared = LocationManager();
  LocationData? locationData;

  Future<bool> hasPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }


  Future<LocationData?> getUserLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      locationData = currentLocation;
    });

    return locationData;
  }

  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }
    return await location.getLocation();
  }

}
