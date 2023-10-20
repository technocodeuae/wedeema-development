
import 'package:location/location.dart';

class MapArgument {
  final String? token;
  final int? numCart;
  final String? userInfo;
  final LocationData myLocation;

  MapArgument(this.token,this.numCart,this.userInfo,this.myLocation);
}