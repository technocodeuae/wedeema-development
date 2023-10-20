import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/ui/work_focus_version/general/buttons/app_button.dart';

import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../argument/MapArgument.dart';
import '../locale/getLocation.dart';

class MapPage extends StatefulWidget {

  static const routeName = '/MapPage';

  MapPage();

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  static CameraPosition? startCameraPosition;
  GoogleMapController? controller;
  Set<Marker> markers = {};
  List<double> lanList = [20.5937, 78.9629];

  late LatLng _initialcameraposition;
  Location _location = Location();
  var _cancelToken = CancelToken();

  TextEditingController _streetController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  TextEditingController _postalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 0.02,
          ),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // token = arg.token!;
    // userInfo = arg.userInfo!;
    _initialcameraposition =
        LatLng(0!, 0);
  }

  Future<void> _onMapCreated(GoogleMapController? controller) async {
    this.controller = controller;
    this.controller!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(_initialcameraposition.latitude,
                    _initialcameraposition.longitude),
                zoom: 15),
          ),
        );
  }

  Future<void> getLocation() async {
    _location.onLocationChanged.listen((l) {
      this.controller!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(l.latitude!, l.longitude!), zoom: 15),
            ),
          );

      _initialcameraposition = LatLng(l.latitude!, l.longitude!);
      setState(() {
        markers.add(Marker(
            markerId: MarkerId('Home'),
            position: LatLng(l.latitude!, l.longitude!)));
      });
    });
  }

  Widget _buildBody() {

      return WillPopScope(
        onWillPop: () async {

          DIManager.findNavigator().pop(
          );
          // Navigator.of(context).pushReplacementNamed(Routes.homePage);
          return false;
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                markers: markers,
                initialCameraPosition:
                    CameraPosition(target: _initialcameraposition),
                //TODO chech this attribute not work after update need to change for this => zoomGesturesEnabled
                //zoomControlsEnabled: true,
                onMapCreated: _onMapCreated,
                onCameraMove: (CameraPosition position) {
                  print(
                      "Latitude: ${position.target.latitude}; Longitude: ${position.target.longitude}");
                  _initialcameraposition = LatLng(
                      position.target.latitude, position.target.longitude);
                  setState(() {
                    markers.add(Marker(
                        markerId: MarkerId('Home'),
                        position: LatLng(position.target.latitude,
                            position.target.longitude)));
                  });
                },

                onCameraIdle: () async {},
              ),
              Padding(
                padding: EdgeInsets.all(60.0),
                child: AppButton(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    translate("confirm_address"),
                    style: AppStyle.smallTitleTextStyle
                        .copyWith(color: AppColorsController().white),
                  ),
                  height: 55,

                  onPressed: () async {
                    String loc = await getLoc(_initialcameraposition.latitude,
                        _initialcameraposition.longitude);
                    var address = loc.split("-");
                    if(loc.length > 0) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),

            ],
          ),
        ),
      );
  }
}
