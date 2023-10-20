import 'package:flutter/cupertino.dart';

import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/net/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../data/endpoints/endpoints.dart';
import '../../../../data/models/auth/auth_model.dart';
import '../../models/ads/ads_model.dart';
import '../../models/categories/categories_model.dart';
import '../../models/properties/properties_model.dart';
import '../../models/sponsors/sponsors_model.dart';

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  const CategoriesRemoteDataSourceImpl();

  Future<Result<List<CategoriesModel>>> getMainCategories() async {
    return await RemoteDataSource.request<List<CategoriesModel>>(
      converterList: (list) =>
      list?.map((e) => CategoriesModel.fromJson(e)).toList() ?? [],
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      url: AppEndpoints.categories,

    );
  }

  Future<Result<List<CategoriesModel>>> getSubCategories(int id) async {
    return await RemoteDataSource.request<List<CategoriesModel>>(
      converterList: (list) =>
      list?.map((e) => CategoriesModel.fromJson(e)).toList() ?? [],
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      url: AppEndpoints.subCategories+"/${id}",
    );
  }


  Future<Result<List<PropertiesModel>>> getPropertiesCategories(int id) async {
    return await RemoteDataSource.request<List<PropertiesModel>>(
      converterList: (list) =>
      list?.map((e) => PropertiesModel.fromJson(e)).toList() ?? [],
      method: HttpMethod.POST,
      data: {"category_id":id},
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.properties,
    );
  }

}

abstract class CategoriesRemoteDataSource {
  const CategoriesRemoteDataSource();

  Future<Result<List<CategoriesModel>>> getMainCategories();
  Future<Result<List<CategoriesModel>>> getSubCategories(int id);
  Future<Result<List<PropertiesModel>>> getPropertiesCategories(int id);
}
