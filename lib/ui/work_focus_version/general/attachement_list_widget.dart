// import 'package:flutter/material.dart';
// import '../../../../core/utils/attachments/attachments_utils.dart';
// import '../../../../core/utils/screen_utils/device_utils.dart';
// import '../../../../ui/work_focus_version/general/image_item_widget.dart';
//
// class AttachmentsListWidget extends StatefulWidget {
//   final List<AppFile> selectedFiles;
//
//   const AttachmentsListWidget({Key? key, required this.selectedFiles})
//       : super(key: key);
//
//   @override
//   _AttachmentsListWidgetState createState() => _AttachmentsListWidgetState();
// }
//
// class _AttachmentsListWidgetState extends State<AttachmentsListWidget> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: <Widget>[
//         widget.selectedFiles.isEmpty
//             ? Container()
//             : LimitedBox(
//           maxWidth: ScreenHelper.width55!,
//           maxHeight: ScreenHelper.fromWidth55(25),
//           child: ListView.builder(
//              physics: BouncingScrollPhysics(),
//              scrollDirection: Axis.horizontal,
//             itemCount: widget.selectedFiles.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Row(
//                 children: <Widget>[
//                     ImageItemWidget(
//                       file: widget.selectedFiles[index],
//                       onDelete: () {
//                         widget.selectedFiles.removeAt(index);
//                         setState(() {});
//                       },),
//                   SizedBox(
//                     width: ScreenHelper.fromWidth55(6),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }}
