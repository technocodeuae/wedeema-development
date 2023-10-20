import 'package:get/get.dart';

import 'package:geocoding/geocoding.dart';


Future<String> getLoc(double? lat,double? lan) async
{

  List<Placemark> placemark = [];
  try {
     placemark = await placemarkFromCoordinates(lat!, lan!);
      placemark = await GeocodingPlatform.instance.placemarkFromCoordinates(lat!,lan!,localeIdentifier: "en");


  } catch (e) {
    await Future.delayed(Duration(milliseconds: 300));
      placemark = await placemarkFromCoordinates(lat!, lan!);

    try {
      placemark = await placemarkFromCoordinates(lat!, lan!,localeIdentifier: "en");
    } catch (e) {
      print(" HELLLLLLLLLL" + e.toString());
    }
  }

  String address="";
  print("Length: " + placemark.length.toString());
  if ( placemark.length > 0) {

    address =    placemark[0].country!+"-"+ placemark[0].name!+"-"+ placemark[0].street!+"-"+placemark[0].locality!+"-"+placemark[0].postalCode!;



    // Use the placemark information
  }



  return  address;


}