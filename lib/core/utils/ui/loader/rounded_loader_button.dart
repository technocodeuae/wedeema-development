// import 'package:flutter/material.dart';
// import 'package:saeed/core/di/di_manager.dart';import 'package:saeed/core/di/di_manager.dart';
// // import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:saeed/core/constants/app_style.dart';
// import 'package:saeed/core/utils/screen_utils/device_utils.dart';
// import 'package:saeed/core/constants/app_colors.dart';
//
// class RoundedLoaderButton extends StatefulWidget {
//   final String text;
//   // final RoundedLoadingButtonController controller;
//   final Function onPressed;
//   final double width;
//   final double height;
//
//
//   const RoundedLoaderButton({Key key, this.text,@required this.controller, this.onPressed,@required this.width, this.height}) : super(key: key);
//
//   @override
//   _RoundedLoaderButtonState createState() => _RoundedLoaderButtonState();
// }
//
// class _RoundedLoaderButtonState extends State<RoundedLoaderButton> {
//   // final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//
//           child: RoundedLoadingButton(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12.0),
//               child: Text(widget.text ?? '', style: AppStyle.titleStyle.copyWith(color: Colors.white)),
//             ),
//             height: widget.height,
//             color: DependencyInjectionManager.findDep<AppColorsController>().primaryColor,
//             controller: widget.controller,
//             width: widget.width,
//
//             borderRadius: ScreenHelper.fromWidth(10.0),
//             onPressed: ()async{
//               try {
//                 widget.onPressed();
//               } catch (e,s) {
//                 print(e);
//                 print(s);
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
