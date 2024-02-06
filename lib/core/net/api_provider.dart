import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/di/di_manager.dart';
import '../../../../core/errors/base_error.dart';
import '../../../../core/errors/cancel_error.dart';
import '../../../../core/errors/custom_error.dart';
import '../../../../core/errors/net_error.dart';
import '../../../../core/errors/not_found_error.dart';
import '../../../../core/errors/time_out_error.dart';
import '../../../../core/errors/unauthorized_error.dart';
import '../../../../core/errors/unexpected_error.dart';
import '../../../../core/net/http_method.dart';
import '../../../../core/results/result.dart';


class ApiProvider {

  static Future<Result<T>> sendObjectRequest<T>({
    T Function(dynamic)? converter,
    T Function(List<dynamic>)? converterList,
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    FormData? formData,
  }) async {
    try {
      print('[$method: $url ]');
      print('[formData: $formData ]');

      // Get the response from the server
      late Response response;
      final dio = DIManager.findDep<Dio>();

      switch (method) {
        case HttpMethod.GET:
          response = await dio.get(
            url,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.POST:
          response = await dio.post(
            url,
            data: data??formData,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.PATCH:
          response = await dio.patch(
            url,
            data: data??formData,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.PUT:
          response = await dio.put(
            url,
            data: data??formData,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.DELETE:
          response = await dio.delete(
            url,
            data: data,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
      }

      // Get the decoded json
      var decodedJson;
      if (response.data is String)
        if (response.data.toString().isEmpty) {
          decodedJson = {"status": true, "result":"success"};
        }else{
          decodedJson = json.decode(response.data);
        }
      else
        decodedJson = response.data;
      log("Response==> $decodedJson");

      // if (decodedJson['status'] == true) {
      if (converterList != null)
        return Result(data: converterList(decodedJson['data']));
      if (decodedJson['data'] == null && decodedJson['success'] == null)
        return Result(error: CustomError(message: 'No Data found'));

      final dataM;
      if (decodedJson['data'] is List) {
        dataM = {'data': decodedJson['data']};
      } else {
        dataM = decodedJson['data'];
      }
      return Result(data: (dataM != null) ? converter!(dataM) : converter!(''));
      // }
      throw decodedJson['error'];
    }

    // Handling errors
    on DioError catch (e) {
      return Result(error: _handleDioError(e));
    }

    // Couldn't reach out the server
    on SocketException catch (e, stacktrace) {
      print('hello saeed 2 -_- $e');
      print(e);
      print(stacktrace);
      return Result(error: CustomError(message: 'Socket Error'));
    } catch (e, stacktrace) {
      print('hello saeed 3 -_- $e stacktrace : $stacktrace');
      return Result(error: CustomError(message: stacktrace.toString()));
    }
  }



  static BaseError _handleDioError(DioError error) {
    if (error.type == DioErrorType.other ||
        error.type == DioErrorType.response) {
      if (error is SocketException) return NetError();
      if (error.type == DioErrorType.response) {
        switch (error.response!.statusCode) {

          case 401:
            if(error.response != null)
              return UnauthorizedError(
                  message: json.decode(json.encode(error.response!.data))['message']
              );
            return UnauthorizedError();
          case 400:
          case 422:
            if(error.response != null)
              return CustomError(
                  message: json.decode(json.encode(error.response!.data))["message"]
              );
            return CustomError(message: 'Bad Request', statusCode: 400);
          case 404:
            return NotFoundError();
          case 403:
          case 409:
          case 500:
            return CustomError(message: "Internal Server Error", statusCode: 500);
          default:
            return UnExpectedError();
        }
      }
      return NetError();
    } else if (error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.sendTimeout ||
        error.type == DioErrorType.receiveTimeout) {
      return TimeOutError();
    } else if (error.type == DioErrorType.cancel) {
      return CancelError();
    } else
      return UnExpectedError();
  }
}
