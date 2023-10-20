// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/constants/app_font.dart';
// import '../../../../core/di/di_manager.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/duration_consts.dart';
// import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
//
// class AppProgressIndicator extends StatefulWidget {
//   final double? radius;
//   final double? percent;
//   final bool withCenter;
//   final Color? color;
//   final String? footerText;
//
//   final double? lineWidth;
//
//   final double? indicatorRadius;
//
//   final TextStyle? footerTextStyle;
//
//   const AppProgressIndicator({Key? key, this.radius, this.percent, this.withCenter = true, this.color, this.footerText, this.lineWidth, this.indicatorRadius, this. footerTextStyle})
//       : super(key: key);
//
//   @override
//   _AppProgressIndicatorState createState() => _AppProgressIndicatorState();
// }
//
// class _AppProgressIndicatorState extends State<AppProgressIndicator> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           child: CircularPercentIndicator(
//             radius: this.widget.radius ?? 88.w,
//             percent: widget.percent ?? 0.05,
//
//             center: !widget.withCenter
//                 ? Container()
//                 : AutoSizeText(
//                 "${_getReadablePercentage()} %",
//                     style: TextStyle(
//                         fontSize: AppFontSize.fontSize_14,
//                         color: DIManager.findDep<AppColorsController>().primaryColor,
//                         fontWeight: AppFontWeight.bold)),
//             startAngle: 0.0,
//             lineWidth: widget.lineWidth??3.9.w,
//             animation: true,
//             animateFromLastPercent: true,
//             animationDuration: DurationConsts.LONG_ANIMATION_DURATION,
//             curve: Curves.easeOut,
//             // restartAnimation: true,
//             progressColor: widget.color ?? DIManager.findDep<AppColorsController>().primaryColor,
//             widgetIndicator: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Stack(
//                   children: [
//                     Container(
//                       height: widget.indicatorRadius??14.w,
//                       width: widget.indicatorRadius??14.w,
//                       decoration: BoxDecoration(
//                           color: widget.color ?? DIManager.findDep<AppColorsController>().primaryColor,
//                           borderRadius: BorderRadius.circular(100)),
//                       child: Center(
//                         child: Container(
//                           height: (widget.indicatorRadius??14.w) - 4.5.w,
//                           width: (widget.indicatorRadius??14.w) - 4.5.w,
//                           decoration: BoxDecoration(
//                               color: Colors.grey.shade700.withOpacity(0.5), borderRadius: BorderRadius.circular(100)),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         if(widget.footerText != null)
//         VerticalPadding(1.0),
//         if(widget.footerText != null)
//           Expanded(
//             child: Text(widget.footerText ?? '',
//               textAlign: TextAlign.center,
//               overflow: TextOverflow.ellipsis,
//               style:widget.footerTextStyle?? TextStyle(
//                 fontSize: AppFontSize.fontSize_14,
//                   color: DIManager.findDep<AppColorsController>().red,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//       ],
//     );
//   }
//
//   int _getReadablePercentage() {
//     if (widget.percent != null) {
//       return (widget.percent! * 100).toInt();
//     } else {
//       return 5;
//     }
//   }
// }
