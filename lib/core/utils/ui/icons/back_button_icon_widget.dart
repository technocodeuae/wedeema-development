import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackButtonIconWidget extends StatelessWidget {
  final Function onPressed;
  final Color? color;

  const BackButtonIconWidget({Key? key, required this.onPressed,  this.color,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onPressed();
      },
      color: color??Colors.white,
      icon: Icon(
        Icons.arrow_back_ios,
        size: 0.06.sw,
      ),
    );
  }
}
