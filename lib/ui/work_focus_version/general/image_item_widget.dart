// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/constants/app_assets.dart';
// import '../../../../core/di/di_manager.dart';
// import '../../../../core/utils/attachments/attachments_utils.dart';
// import '../../../../core/utils/screen_utils/device_utils.dart';
// import '../../../../core/utils/ui/widgets/images/custom_image.dart';
//
// class ImageItemWidget extends StatelessWidget {
//   final AppFile file;
//   final Function onDelete;
//
//   const ImageItemWidget({Key? key, required this.file, required this.onDelete})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: <Widget>[
//           ClipRRect(
//             borderRadius: BorderRadius.circular(ScreenHelper.fromWidth55(1.5)),
//             child: _buildThumbnail(file),
//           ),
//           Positioned(
//             height: 60.w,
//             width: 60.w,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(ScreenHelper.fromWidth55(2.5)),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
//                 child: Container(
//                   width: 60.w,
//                   height: 60.w,
//                 ),
//               ),
//             ),
//           ),
//           onDelete == null
//               ? Container()
//               : Positioned(
//             right:-6.w,
//             top: -6.w,
//             child: InkWell(
//               onTap: () {
//  onDelete();
//               },
//               child: CustomImage.rectangle(
//                 image: AppAssets.delete_icon_png,
//                 isNetworkImage: false,
//                 width: 18.w,
//                 height: 18.w,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildThumbnail(AppFile appFile) {
//     switch (appFile.type) {
//       case AppFileTypes.image:
//         return Image.file(
//           appFile.file,
//           width: 60.w,
//           height:60.w,
//           fit: BoxFit.cover,
//         );
//       case AppFileTypes.video:
//         return DIManager.findDep<AttachmentsUtils>().buildVideoThumbnail(file: appFile.file,
//           width: 60.w,);
//
//       case AppFileTypes.pdf:
//         return DIManager.findDep<AttachmentsUtils>().buildPdfThumbnail(file: appFile.file,
//           width: 60.w,);
//
//       case AppFileTypes.none:
//         return DIManager.findDep<AttachmentsUtils>().buildThumbnail(width:60.w,);
//     }
//   }
// }
