// import 'dart:io';
//
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import '../../../../core/constants/app_assets.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/di/di_manager.dart';
// import '../../../../core/shared_prefs/shared_prefs.dart';
// import '../../../../core/utils/attachments/pdf_viewer_page.dart';
// import '../../../../core/utils/loading_helper.dart';
// import '../../../../core/utils/ui/bottom_sheet/custom_bottom_sheetts.dart';
// import '../../../../data/endpoints/endpoints.dart';
// import 'package:thumbnailer/thumbnailer.dart';
//
// class AttachmentsUtils {
//   final _picker = ImagePicker();
//
//   Future<List<File>?> getGalleryImage() async {
//     final pickedFile = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//     );
//     if (pickedFile != null) {
//       return pickedFile.files.map((e) => File(e.path!)).toList();
//     }
//     return null;
//   }
//
//   Future<File?> getOneImage(ImageTypeEnum imageTypeEnum) async {
//     File? pickedFile;
//     if (imageTypeEnum == ImageTypeEnum.GALLERY)
//       pickedFile = await _getOneImageFromGallery();
//     else
//       pickedFile = await _getOneImageFromCamera();
//     if (pickedFile != null) return File(pickedFile.path);
//     return null;
//   }
//
//   Future<File?> _getOneImageFromGallery() async {
//     final pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//     );
//
//     if (pickedFile != null) {
//       return File(pickedFile.path);
//     }
//     return null;
//   }
//
//   Future<File?> _getOneImageFromCamera() async {
//     final pickedFile = await _picker.getImage(
//       source: ImageSource.camera,
//     );
//
//     if (pickedFile != null) {
//       return File(pickedFile.path);
//     }
//     return null;
//   }
//
//   // Future<void> getCameraImage() async {
//   //  return await ImagePicker().getImage(
//   //    source: ImageSource.camera,
//   //  );
//   // }
//
//   Thumbnail buildPdfThumbnail({
//     required File file,
//     required double width,
//   }) {
//     return Thumbnail(
//       widgetSize: width,
//       mimeType: 'application/pdf',
//       dataResolver: () => file.readAsBytes(),
//     );
//   }
//
//   Widget buildPdfThumbnailFromURL({
//     required PDFPage pageOne,
//     required double width,
//   }) {
//     return PDFPage(pageOne.imgPath, 1);
//   }
//
//   Future<File> copyAsset() async {
//     Directory tempDir = await getTemporaryDirectory();
//     String tempPath = tempDir.path;
//     File tempFile = File('$tempPath/copy.pdf');
//     ByteData bd = await rootBundle.load(AppAssets.the_law_of_success_FILE_PDF);
//     await tempFile.writeAsBytes(bd.buffer.asUint8List(), flush: true);
//     return tempFile;
//   }
//
//   Future<PDFPage> copyAssetFromUrl(String fileUrl) async {
//     print('helllllllllllllllloo');
//     PDFDocument doc = await PDFDocument.fromURL(fileUrl);
//     print('doc is  doc  doc $doc');
//
//     // Load specific page
//     PDFPage pageOne = await doc.get(page: 0);
//     print('pageOne is  pageOne  pageOne $pageOne');
//     return Future.value(pageOne);
//   }
//
//   Thumbnail buildThumbnail({
//     required double width,
//   }) {
//     return Thumbnail(
//       widgetSize: width,
//       mimeType: 'default',
//     );
//   }
//
//   Widget buildVideoThumbnail({
//     required File file,
//     double? width,
//   }) {
//     return Container(
//       width: width,
//       height: width,
//       color: DIManager.findDep<AppColorsController>()
//           .primaryColor
//           .withOpacity(0.1),
//       child: Icon(
//         Icons.play_circle_outline_outlined,
//         size: (width ?? 100) * 0.3,
//         color: DIManager.findDep<AppColorsController>().primaryColor,
//       ),
//     );
//   }
//
//   Future<List<File>> getMultiImages({
//     bool allowMultiple = true,
//   }) async {
//     final pickedFile = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowMultiple: allowMultiple,
//     );
//     if (pickedFile != null) {
//       return pickedFile.files.map((e) => File(e.path!)).toList();
//     }
//     return [];
//   }
//
//   Future<List<AppFile>> pickPostAttachments() async {
//     final pickedFile = await FilePicker.platform.pickFiles(
//       type: FileType.any,
//       // allowedExtensions: [
//       //   // 'jpg',
//       //   // 'svg',
//       //   // 'png',
//       //   // 'jpeg',
//       //
//       //   'pdf',
//       //   // '.mp4',
//       //
//       // ],
//       allowMultiple: true,
//     );
//     if (pickedFile != null) {
//       return pickedFile.files
//           .map((e) =>
//               AppFile(File(e.path!), mapExtensionToFileType(e.extension ?? '')))
//           .toList();
//     }
//     return [];
//   }
//
//   AppFileTypes mapExtensionToFileType(String extension) {
//     print('extension.. $extension');
//     final videoTypes = [
//       'mp4',
//     ];
//
//     final imageTypes = [
//       'jpg',
//       'svg',
//       'png',
//       'jpeg',
//     ];
//     if (videoTypes.contains(extension)) return AppFileTypes.video;
//     if (imageTypes.contains(extension)) return AppFileTypes.image;
//     if (extension == 'pdf') return AppFileTypes.pdf;
//     return AppFileTypes.none;
//   }
//
//   Future<PDFDocument> openPdfUrlFile(String url) async {
//     var token = DIManager.findDep<SharedPrefs>().getToken();
//     PDFDocument doc = await PDFDocument.fromURL(
//       url,
//       headers: {
//         AppEndpoints.Authorization: 'Bearer $token',
//         "Content-Type": "application/octet-stream"
//       },
//     );
//     DIManager.findNavigator().pushNamed(
//       AppPdfViewer.routeName,
//       arguments: doc,
//     );
//     return doc;
//   }
//
//   Future downloadPdf({required String url, required String name, required bool isPdf}) async {
//     try {
//       LoadingHelper.showLoadingDialog();
//       final dio = DIManager.findDep<Dio>();
//       var token = DIManager.findDep<SharedPrefs>().getToken();
//       Response response = await dio.get(
//         url,
//         options: Options(
//             headers: {
//               AppEndpoints.Authorization: 'Bearer $token',
//               "Content-Type": "application/octet-stream"
//             },
//             responseType: ResponseType.bytes,
//             followRedirects: false,
//             validateStatus: (status) { return status! < 500; }
//         ),
//       );
//       var tempDir = await getTemporaryDirectory();
//       var file = File(tempDir.path + "/$name").openSync(mode: FileMode.write);
//       file.writeFromSync(response.data);
//       await file.close();
//       LoadingHelper.dismissDialog();
//       OpenFile.open(file.path);
//
//       // if (isPdf) {
//       //   openPdfAssetFile(File(file.path));
//       // }else{
//       //   OpenFile.open(file.path);
//       // }
//     } catch (e) {
//       LoadingHelper.dismissDialog();
//       print(e);
//     }
//   }
//
//   Future<PDFDocument> openPdfAssetFile(File pdf) async {
//     PDFDocument doc = await PDFDocument.fromFile(pdf);
//     DIManager.findNavigator().pushNamed(
//       AppPdfViewer.routeName,
//       arguments: doc,
//     );
//     return doc;
//   }
// }
//
// class AppFile {
//   final File file;
//   final AppFileTypes type;
//
//   AppFile(this.file, this.type);
// }
//
// enum AppFileTypes { image, video, pdf, none }
