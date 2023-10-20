// import 'package:flutter/material.dart';
// import '../../../../core/utils/screen_utils/device_utils.dart';
//
// import 'base_placeholder_widget.dart';
//
// // ignore: must_be_immutable
// class TextPlaceholderWidget extends StatelessWidget {
//   double width = ScreenHelper.fromWidth55(15);
//   double height = ScreenHelper.fromHeight55(1.8);
//
//   TextPlaceholderWidget({Key? key, widthPercentage, heightPercentage})
//       : super(key: key) {
//     if (widthPercentage != null) {
//       width *= widthPercentage;
//     }
//     if (heightPercentage != null) {
//       height *= heightPercentage;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BasePlaceholderWidget(
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: MediaQuery.of(context).size.width / 2 * 0.01,
//             vertical: 5),
//         child: Container(
//             width: this.width,
//             height: this.height,
//             decoration: BoxDecoration(
//                 color: Colors.red, borderRadius: BorderRadius.circular(5))),
//       ),
//     );
//   }
// }
