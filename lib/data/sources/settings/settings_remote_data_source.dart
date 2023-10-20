import 'package:dio/dio.dart';
import 'package:path/path.dart';

import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/net/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../data/endpoints/endpoints.dart';
import '../../../core/models/empty_model.dart';
import '../../../ui/work_focus_version/ads/args/argument_policy.dart';
import '../../models/ads/ads_model.dart';
import '../../models/ads_details/ads_details_model.dart';
import '../../models/settings/settings_model.dart';
import '../../models/share_link/share_link_model.dart';

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  const SettingsRemoteDataSourceImpl();

  Future<Result<ShareLinkModel>> getShareLink(String url) async {

    return await RemoteDataSource.request<ShareLinkModel>(
      converter: (model) => ShareLinkModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      url:  url ,
    );
  }
  Future<Result<ItemsSettingsModel>> getAboutApp() async {

    return await RemoteDataSource.request<ItemsSettingsModel>(
      converter: (model) => ItemsSettingsModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      url:  AppEndpoints.aboutApp ,
    );
  }
  Future<Result<ItemsSettingsModel>> getPrivacyPolicy() async {

    return await RemoteDataSource.request<ItemsSettingsModel>(
      converter: (model) => ItemsSettingsModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      url:  AppEndpoints.privacyPolicy ,
    );
  }
  Future<Result<ItemsSettingsModel>> getTerms() async {

    return await RemoteDataSource.request<ItemsSettingsModel>(
      converter: (model) => ItemsSettingsModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      url:  AppEndpoints.terms ,
    );
  }
  Future<Result<FAQModel>> getFAQ(int page) async {

    return await RemoteDataSource.request<FAQModel>(
      converter: (model) =>
          FAQModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      url:  AppEndpoints.allFaq + "?page=${page}" ,
    );
  }


}

abstract class SettingsRemoteDataSource {
  const SettingsRemoteDataSource();

  Future<Result<ShareLinkModel>> getShareLink(String url);
  Future<Result<ItemsSettingsModel>> getAboutApp();
  Future<Result<ItemsSettingsModel>> getPrivacyPolicy();
  Future<Result<ItemsSettingsModel>> getTerms();
  Future<Result<FAQModel>> getFAQ(int page);

}
