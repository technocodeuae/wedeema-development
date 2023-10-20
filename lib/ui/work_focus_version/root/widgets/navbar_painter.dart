import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/di_manager.dart';

class NavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = DIManager.findDep<AppColorsController>().white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();

    path_0.moveTo(0, size.height);
    path_0.lineTo(0, size.height * 0.43);
    path_0.quadraticBezierTo(size.width * 0.19, size.height * 0.43,
        size.width * 0.25, size.height * 0.43);
    path_0.cubicTo(size.width * 0.35, size.height * 0.43, size.width * 0.37,
        size.height * 0.39, size.width * 0.39, size.height * 0.35);
    path_0.cubicTo(size.width * 0.48, size.height * 0.05, size.width * 0.52,
        size.height * 0.05, size.width * 0.61, size.height * 0.35);
    path_0.cubicTo(size.width * 0.63, size.height * 0.39, size.width * 0.65,
        size.height * 0.43, size.width * 0.75, size.height * 0.43);
    path_0.quadraticBezierTo(
        size.width * 0.81, size.height * 0.43, size.width, size.height * 0.43);
    path_0.lineTo(size.width, size.height);

    path_0.lineTo(0, size.height);

    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
