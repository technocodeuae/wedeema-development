
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class FileManagerCamera {

  File? newImage ;

  XFile? image ;

  final picker = ImagePicker();

  Future<XFile?> imagePickerFromGallery ({
    required XFile image,
  })async {

    image = image;
    // image = (await picker.pickImage(source: ImageSource.camera))!;

    final bytes = await image.readAsBytes();
    final kb = bytes.length / 1024;
    final mb = kb / 1024;

    if (kDebugMode) {
      print('original image size:' + mb.toString());
    }

    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/temp.jpg';



    // converting original image to compress it
    final result = await FlutterImageCompress.compressAndGetFile(
      image.path,
      targetPath,
      minHeight: 1080, //you can play with this to reduce siz
      minWidth: 1080,
      quality: 35, // keep this high to get the original quality of image
    );

    final data = await result!.readAsBytes();
    final newKb = data.length / 1024;
    final newMb = newKb / 1024;

    if (kDebugMode) {
      print('compress image size:' + newMb.toString());
    }

    return XFile(result.path);
  }

  // Future<void> convertImageToAVIF(File sourceImageFile, File outputAVIFFile) async {
  //   // قراءة الصورة الأصلية باستخدام مكتبة "image"
  //   final image = img.decodeImage(sourceImageFile.readAsBytesSync());
  //
  //   // تحويل الصورة إلى مصفوفة باستخدام "image"
  //   List<int> imageAsList = img.encodeJpg(image!);
  //
  //   // ضغط الصورة إلى صيغة AVIF باستخدام Flutter Image Compress
  //   final compressedImage = await FlutterImageCompress.compressWithList(
  //     imageAsList,
  //     format: CompressFormat.,
  //   );
  //
  //   // كتابة الصورة المضغوطة إلى ملف AVIF
  //   await outputAVIFFile.writeAsBytes(compressedImage);
  // }



}