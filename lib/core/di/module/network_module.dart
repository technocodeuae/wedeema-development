import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/di/module/rest_client.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/ui/dialogs/custom_dialogs.dart';
import '../../../../data/endpoints/endpoints.dart';
import '../../../../data/models/auth/auth_model.dart';

import '../di_manager.dart';

abstract class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Dio provideDio(SharedPrefs sharedPrefHelper, RestClient restClient) {
    final dio = Dio();

    dio
      ..options.baseUrl = AppEndpoints.BASE_URL
      ..options.connectTimeout = AppEndpoints.connectionTimeout
      ..options.receiveTimeout = AppEndpoints.receiveTimeout;
    dio.interceptors.clear();
    // ..options.headers = {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    // }
    dio
      ..interceptors.addAll([
        AuthInterceptor(dio, restClient),
        LogInterceptor(
          request: true,
          responseBody: true,
          requestBody: true,
          requestHeader: true,
          error: true,
          responseHeader: true,
        ),
        // add this line before LogInterceptor
      ]);

    return dio;
  }

}

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final RestClient restClient;
  final sharedPrefHelper = DIManager.findDep<SharedPrefs>();
  int counter = 0;
  String? accessToken;

  bool isInvalidSession = false;

  // helper class to access your local storage

  AuthInterceptor(this._dio, this.restClient);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // getting token
    var token = sharedPrefHelper.getToken();
    options.headers.putIfAbsent('Content-Type', () => 'application/json');
    options.headers.putIfAbsent('Accept', () => 'application/json');
    if (token != null && token.isNotEmpty) {
      options.headers
          .putIfAbsent(AppEndpoints.AuthorizationAPP, () => 'Bearer $token');
      String uuid = await FlutterUdid.udid;
      options.headers.putIfAbsent(RemoteDataSource.deviceId, () => '$uuid');
      options.headers.putIfAbsent(RemoteDataSource.osType, () => Platform.isIOS ? 'IOS':'Android');
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        options.headers.putIfAbsent(RemoteDataSource.deviceType, () => packageInfo.version);
      });
    } else {
      print('Auth token is null');
    }
    print('options.headers ${options.headers}');
    isInvalidSession = false;
    return handler.next(options);
  }

  @override
  void onError(
    DioError error,
    ErrorInterceptorHandler handler,
  ) async {
    print('onError in AuthInterceptor $error');
    print('onError in AuthInterceptor isInvalidSession $isInvalidSession');
    if (error.response?.statusCode == 403 ||
        error.response?.statusCode == 401) {
      final result = await refreshToken();
      if (result) {
        final result = await _retry(error, handler);
        if (result)
          return;
        else {
          if (error.requestOptions.headers[RemoteDataSource.requiresToken] == true && isInvalidSession) CustomDialogs.showInvalidSession();
          isInvalidSession = true;
        }
      } else {
        if (error.requestOptions.headers[RemoteDataSource.requiresToken] ==
                true &&
            isInvalidSession) CustomDialogs.showInvalidSession();
        isInvalidSession = true;
      }
    }
    handler.next(error);

    return;
  }

  Future<bool> refreshToken() async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final refreshToken = sharedPrefHelper.getRefreshToken();
      final resistanceAccessToken = sharedPrefHelper.getToken();

      if(accessToken != null && refreshToken != null){
        // final response = await this.restClient.post(
        //   AppEndpoints.REFRESH_TOKEN,
        //   body: {
        //     'accessToken': resistanceAccessToken,
        //     'refreshToken': refreshToken,
        //   },
        //   headers: headers,
        // );
        // print('refreshToken in AuthInterceptor response : $response');
        //
        // if (response['result'] != null &&
        //     ((response['result'] as String?)?.isNotEmpty ?? false)) {
        //   accessToken = response['result'];
          if (accessToken != null && (accessToken?.isNotEmpty ?? false)) {
            sharedPrefHelper.setToken(accessToken);
            sharedPrefHelper.setRefreshToken(refreshToken);
            // sharedPrefHelper.setAuth(
            //   AuthenticateModel(
            //     refreshToken: refreshToken,
            //     accessToken: accessToken,
            //   ),
            // );
            return Future.value(true);
          //}
        }
        return Future.value(false);
      }
      return Future.value(false);
    } catch (error, s) {
      print('refreshToken in AuthInterceptor error $error | s $s');
      return Future.value(false);
    }
  }

  Future<bool> _retry(
    DioError dioError,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final resistanceAccessToken = sharedPrefHelper.getToken();

      dioError.requestOptions.headers["Authorization"] =
          "Bearer " + resistanceAccessToken!;

      //create request with new access token
      final opts = new Options(
        method: dioError.requestOptions.method,
        headers: dioError.requestOptions.headers,
      );
      print('opts.headers ${opts.headers}');

      final cloneReq = await _dio.request(dioError.requestOptions.path,
          options: opts,
          data: dioError.requestOptions.data,
          queryParameters: dioError.requestOptions.queryParameters);

      handler.resolve(cloneReq);
      return Future.value(true);
    } catch (e) {
      print(
          'error happened in _retry and then we will logout from the application');
      return Future.value(false);
    }
  }
}
