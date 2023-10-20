// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/di/di_manager.dart';
//
// class AppPdfViewer extends StatefulWidget {
//   static const routeName = '/AppPdfViewer';
//   final PDFDocument document;
//
//   const AppPdfViewer({Key? key, required this.document}) : super(key: key);
//
//   @override
//   _AppPdfViewerState createState() => _AppPdfViewerState();
// }
//
// class _AppPdfViewerState extends State<AppPdfViewer> {
//   // Future<PDFDocument> _document;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         systemOverlayStyle: SystemUiOverlayStyle.light,
//         backgroundColor: DIManager.findDep<AppColorsController>().primaryColor,
//       ),
//       body: PDFViewer(
//         document: widget.document,
//         enableSwipeNavigation: true,
//       ),
//     );
//   }
// }
