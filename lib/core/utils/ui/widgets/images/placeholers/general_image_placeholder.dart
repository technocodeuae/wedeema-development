import 'package:flutter/material.dart';
class ImagePlaceHolder extends StatelessWidget {
  const ImagePlaceHolder();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        "AppAssets.general_placeholder_image",
        fit: BoxFit.cover,
      ),
    );
  }
}

class ImageError extends StatelessWidget {
  const ImageError();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        "AppAssets.general_error_image",
        fit: BoxFit.cover,
      ),
    );
  }
}
