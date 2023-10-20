import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {

  // compress file and get file.
  static Future<File> compressFile(
      File file,
      ) async {

    String extension = file.path.split('.').last;
    debugPrint('extension: $extension');

    final dir = await getTemporaryDirectory();
    final tmpDir = dir.path;
    final target =
        "$tmpDir/${DateTime.now().millisecondsSinceEpoch}.$extension";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      target,
      quality: 30,
      minWidth: 1024,
      minHeight: 1024,
      rotate: 0,
    );

    debugPrint('${file.lengthSync()}');
    debugPrint('${result?.lengthSync()}');

    return result!;
  }

}
