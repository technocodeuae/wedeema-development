// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
//
// class BasePlaceholderWidget extends StatelessWidget {
//   final Widget child;
//   final Color? highlightColor;
//   final Color? baseColor;
//
//   const BasePlaceholderWidget(
//       {required this.child, this.baseColor, this.highlightColor});
//
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: baseColor ?? Colors.grey.shade200,
//       highlightColor: highlightColor ?? Colors.grey.shade50,
//       child: child,
//       period: const Duration(milliseconds: 1000),
//     );
//   }
// }
