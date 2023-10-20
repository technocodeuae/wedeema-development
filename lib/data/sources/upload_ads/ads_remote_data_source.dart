import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:path/path.dart';

import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/net/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../data/endpoints/endpoints.dart';
import '../../../core/models/empty_model.dart';
import '../../../ui/work_focus_version/ads/args/argument_policy.dart';
import 'dart:ui' as ui;

class UploadAdsRemoteDataSourceImpl implements UploadAdsRemoteDataSource {
  const UploadAdsRemoteDataSourceImpl();

  Future<Result<EmptyModel>> storeAds(ArgumentPolicy args) async {
    FormData formData;

    args.dataMap!["currency_id"] = 1;
    // args.dataMap!["properties"] = [];
    if (args.images != null && args.images!.length > 0) {
      args.dataMap!["featured_image"] = await MultipartFile.fromFile(
        args.images![0].path! ?? "",
        filename: basename(args.images![0]?.path ?? ""),
      );
    }
    if (args.images != null && args.images!.length > 1) {
      for (int i = 1; i < args.images!.length; i++) {
        args.dataMap!["ad_image_${i - 1}"] = await MultipartFile.fromFile(
            args.images![i].path! ?? "",
            filename: basename(args.images![i]?.path ?? ""));
      }
    }

    print('dataMap: ${args.dataMap}');

    formData = FormData.fromMap(args.dataMap!);
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      headers: {RemoteDataSource.requiresToken: true},
      formData: formData,
      // data: args.dataMap,
      url: AppEndpoints.storeAds,
    );
  }
}

abstract class UploadAdsRemoteDataSource {
  const UploadAdsRemoteDataSource();

  Future<Result<EmptyModel>> storeAds(ArgumentPolicy arg);
}
