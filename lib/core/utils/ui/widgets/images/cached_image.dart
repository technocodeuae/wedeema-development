import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/ui/widgets/images/placeholers/general_image_placeholder.dart';
import '../../../../../../core/di/di_manager.dart';
import '../../../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../../../data/endpoints/endpoints.dart';


class CachedImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final Widget? placeholder;

  final double? height;
  final double? width;

  CachedImage(
      {required this.imageUrl,
      this.fit,
      this.placeholder,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    var token = DIManager.findDep<SharedPrefs>().getToken();
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      httpHeaders: {AppEndpoints.AuthorizationAPP: 'Bearer $token'},
      errorWidget: (BuildContext context, _, __) {
        return placeholder ?? ImageError();
      },
      placeholder: (BuildContext context, _) {

        return Container();
        // return placeholder ?? "MediaPlaceholderWidget()";
      },
    );
  }
}
