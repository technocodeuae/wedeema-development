import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_consts.dart';
import '../../../core/constants/app_style.dart';
import '../../../core/utils/localization/app_localizations.dart';

class DownloadPdfWidget extends StatefulWidget {
  final String url;
  final String name;

  DownloadPdfWidget({required this.name, required this.url});

  @override
  _DownloadPdfWidgetState createState() => _DownloadPdfWidgetState();
}

class _DownloadPdfWidgetState extends State<DownloadPdfWidget> {
  late Uri _pdfUrl;

  String? _pdfPath;

  late String _localPath;
  late bool _permissionReady;
  late TargetPlatform? platform;

  @override
  void initState() {
    _pdfUrl = Uri.parse(AppConsts.IMAGE_URL + "/" + widget.url);
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
    super.initState();
  }

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/sdcard/download/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'Download';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () async {
          _permissionReady = await _checkPermission();

          final dio = Dio();
          _requestPermission();
          if (await Permission.storage.request().isGranted) {
            await _prepareSaveDir();

            var pdfUrl = AppConsts.IMAGE_URL + "/" + widget.url;
            final downloadPath = await getExternalStorageDirectory();
            final f = File("${downloadPath?.path!}/${widget.name}.pdf");
            String fileName = pdfUrl.substring(pdfUrl.lastIndexOf("/") + 1);
            dio
                .download(pdfUrl, "${_localPath!}$fileName",
                    onReceiveProgress: (rec, total) {})
                .then((value) {
              Fluttertoast.showToast(
                msg: translate('download_file'),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
              );
              dio.close();
            }).catchError((Object e) {
              Fluttertoast.showToast(msg: e.toString(), timeInSecForIosWeb: 1);
            });
          }
        },
        child: Text(
          widget.name,
          style: AppStyle.defaultStyle.copyWith(
            color: AppColorsController().black,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Future<void> _requestPermission() async {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final result = await Permission.storage.request();
      if (result != PermissionStatus.granted) {
        print('Permission not granted to access external storage');
      }
    }
  }

  Future<String?> getDownloadDirectory() async {
    final directory = await getExternalStorageDirectory();
    return directory?.path!;
  }
}
