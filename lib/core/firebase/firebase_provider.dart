//import 'package:saeed/core/errors/base_error.dart';
//import 'package:saeed/core/errors/firebase_error/auth_error_const.dart';
//import 'package:saeed/core/errors/firebase_error/document_not_found_error.dart';
//import 'package:saeed/core/errors/firebase_error/duplicated_credintcial.dart';
//import 'package:saeed/core/errors/firebase_error/email_already_in_use_error.dart';
//import 'package:saeed/core/errors/firebase_error/not_valid_email_error.dart';
//import 'package:saeed/core/errors/firebase_error/operation_not_allawed_error.dart';
//import 'package:saeed/core/errors/firebase_error/too_many_requests_error.dart';
//import 'package:saeed/core/errors/firebase_error/user_disabled_error.dart';
//import 'package:saeed/core/errors/firebase_error/user_not_found_error.dart';
//import 'package:saeed/core/errors/firebase_error/wrong_password_error.dart';
//import 'package:saeed/core/errors/forbidden_error.dart';
//import 'package:saeed/core/errors/net_error.dart';
//import 'package:saeed/core/errors/unexpected_error.dart';
//import 'package:saeed/core/results/result.dart';
//import 'package:data_connection_checker/data_connection_checker.dart';
//import 'package:flutter/foundation.dart';
//import 'package:flutter/services.dart';
//
//class FirebaseProvider {
//  static Future<Result<MODEL>> requestDataList<MODEL>({
//    @required Future<QuerySnapshot> Function() firebaseCallback,
//    @required MODEL Function(QuerySnapshot snapshot) convert,
//  }) async {
//    try {
//      await _hasConnection();
//      final snapshot = await firebaseCallback();
//
//      return Result(data: convert(snapshot));
//    } catch (e, s) {
//
//      return Result(error: _handleFirebaseError(e.toString(), e));
//    }
//  }
//
//  static Future<Result<MODEL>> requestDataObject<MODEL>({
//    @required Future<DocumentSnapshot> Function() firebaseCallback,
//    @required MODEL Function(DocumentSnapshot snapshot) convert,
//  }) async {
//    try {
//      await _hasConnection();
//      final snapshot = await firebaseCallback();
//      return Result(data: convert(snapshot));
//    } catch (e, s) {
//      print('_______________________ EXCEPTION ______________________');
//      print('$e');
//      print('$s');
//      return Result(error: _handleFirebaseError(e.toString(), e));
//    }
//  }
//
//  static Future<Result<MODEL>>  RemoteDataSource.request<MODEL>({
//    @required Future<MODEL> Function() firebaseCallback,
//  }) async {
//    try {
//      await _hasConnection();
//      return Result(data: await firebaseCallback());
//    } catch (e, s) {
//      print('_______________________ EXCEPTION ______________________');
//      print('$e');
//      print('$s');
//      return Result(error: _handleFirebaseError(e.toString(), e));
//    }
//  }
//
//  static BaseError _handleFirebaseError(String errorAsString, dynamic error) {
//    if (errorAsString.contains(ERROR_INVALID_EMAIL) || errorAsString.contains(ERROR_BAD_EMAIL_FORMAT)) {
//      return NotValidEmailError();
//    }
//    else if (errorAsString.contains(ERROR_EMAIL_ALREADY_IN_USE)) {
//      return EmailAlreadyInUseError();
//    }
//    else if (errorAsString.contains(ERROR_NETWORK_REQUEST_FAILED)) {
//      return NetError();
//    } else if (errorAsString.contains(ERROR_TOO_MANY_REQUESTS)) {
//      return TooManyRequestError();
//    } else if (errorAsString.contains(ERROR_OPERATION_NOT_ALLOWED)) {
//      return OperationNotAllowedError();
//    } else if (errorAsString.contains(ERROR_USER_DISABLED)) {
//      return UserDisabledError();
//    } else if (errorAsString.contains(ERROR_USER_NOT_FOUND)) {
//      return UserNotFoundError();
//    } else if (errorAsString.contains('403')) {
//      return ForbiddenError();
//    } else if (errorAsString.contains('cloud_firestore/not-found')) {
//      return DocumentNotFoundError();
//    } else if (errorAsString.contains(ERROR_WRONG_PASSWORD)) {
//      return WrongPasswordError();
//    } else if (errorAsString.contains('account-exists-with-different-credential')) {
//      return DuplicatedCredinationalError(error);
//    } else
//      return UnExpectedError();
//  }
//
//  static Future<bool> _hasConnection() async {
//    bool result = await DataConnectionChecker().hasConnection;
//    if (result == true) {
//      print(' DataConnectionChecker().hasConnection;');
//      return true;
//    } else {
//      print(' DataConnectionChecker().hasConnection; false');
//      throw Exception(ERROR_NETWORK_REQUEST_FAILED);
//    }
//  }
//}
