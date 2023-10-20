import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class HeaderLineWidget extends StatelessWidget {
  const HeaderLineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.w,height: 5.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3512),
        color: Color(0xffC7C7CC),
      ),
    );
  }
}
