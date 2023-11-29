import 'dart:async';

import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wadeema/core/utils/localization/app_localizations.dart';
import 'package:wadeema/core/utils/location_manager.dart';
import 'package:wadeema/ui/work_focus_version/home/widget/app_bar_app.dart';

import '../../core/constants/app_colors.dart';
import '../../core/di/di_manager.dart';
import '../work_focus_version/general/app_bar/app_bar.dart';
import '../work_focus_version/general/icons/back_icon.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _selectedLocation;

  final Completer<GoogleMapController> _mapController = Completer();


  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    if(LocationManager.shared.locationData == null) {
      LocationManager.shared.getUserLocation().then((value) async {
        if (value != null) {
          _selectedLocation = LatLng(value.latitude!, value.longitude!);
          (await _mapController.future).animateCamera(CameraUpdate.newLatLng(_selectedLocation!));
        } else {
          _selectedLocation = LatLng(24.466667, 54.366667);
        }
      });
    }else{
      _selectedLocation = LatLng(LocationManager.shared.locationData!.latitude!, LocationManager.shared.locationData!.longitude!);
      (await _mapController.future).animateCamera(CameraUpdate.newLatLng(_selectedLocation!));
    }

  }

  void _onMapTapped(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarApp(context, text: translate('select_location'),
      isNeedBack: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 15.sp,),
          // AppBarWidget(
          //   name: translate('select_location'),
          //   child: InkWell(
          //     onTap: () {
          //       DIManager.findNavigator().pop();
          //     },
          //     child: BackIcon(
          //       width: 26.sp,
          //       height: 18.sp,
          //       color: AppColorsController().iconColor,
          //     ),
          //   ),
          // ),
          Expanded(
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(24.466667, 54.366667),
                zoom: 14,
              ),
              onTap: _onMapTapped,
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
              markers: _selectedLocation != null
                  ? Set.from([
                      Marker(
                        markerId: MarkerId('selected-location'),
                        position: _selectedLocation!,
                      ),
                    ])
                  : {},
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColorsController().primaryColor,
        onPressed: () {
          Navigator.of(context).pop(_selectedLocation);
        },
        child: Icon(Icons.check),
      ),
    );
  }


}
