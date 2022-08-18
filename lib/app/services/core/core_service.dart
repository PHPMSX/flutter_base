import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as get_x;

import 'constants/remote_constant.dart';
import 'models/core_response_error.dart';
import 'storage/core_storage_manager.dart';
import 'utilities/date_parser.dart';
import 'utilities/logger_service.dart';

class CoreService extends get_x.GetxService {
  ///Constructors
  static final CoreService _instance = CoreService._internal();

  CoreService._internal();

  factory CoreService() {
    return _instance;
  }

  late Dio _dio;
  VoidCallback? handleUnauthorizedError;

  @override
  void onInit() {
    super.onInit();
    LoggerService.log.i('Initializing core service');

    ///Init dio
    _dio = Dio(BaseOptions(
      baseUrl: CoreRemoteConstants.baseUrl,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      connectTimeout: CoreRemoteConstants.timeOutDurationInMilliseconds,
      receiveTimeout: CoreRemoteConstants.timeOutDurationInMilliseconds,
    ));

    ///
  }

  void setUpHeader(Map<String, dynamic> data) {
    ///Set headers
    data.forEach((key, value) {
      _dio.options.headers[key] = value;
    });

    ///
  }

  void setBaseURL() {
    _dio.options.baseUrl = CoreRemoteConstants.baseUrl;
  }

  Future<void> performRequest(
      {required String url,
        required String method,
        Map<String, dynamic>? query,
        dynamic body,
        bool shouldShowErrorSnackBar = false, //Show error snack bar when error occurs
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        required Function(Map<String, dynamic> responseData) onResponse,
        dynamic Function(CoreResponseError error)? onError}) async {
    ///Set accepts datetime in header
    _dio.options.headers[CoreRemoteConstants.acceptDatetimeHeaderKey] =
        DateParser().getCurrentDateWithTimeZone();

    LoggerService.log.i('Header: ${_dio.options.headers}');
    if (body is FormData) {
      LoggerService.log.i('$method -> ${_dio.options.baseUrl}$url \nquery: '
          '${query ?? 'empty'}');
    } else {
      LoggerService.log.i('$method -> ${_dio.options.baseUrl}$url \nquery: '
          '${query ?? 'empty'} \nbody: ${jsonEncode(body ?? '')}');
    }

    ///
    Response? response;
    try {
      response = await _requestApi(
        url,
        method,
        query,
        body,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == CoreHttpCode.TOKEN_EXPIRED) {
        final refreshSuccess = await requestRefreshToken();
        if (refreshSuccess) {
          ///If refresh token success
          ///Request api again
          Response? responseNext;
          try {
            responseNext = await _requestApi(url, method, query, body,
                onReceiveProgress: onReceiveProgress, onSendProgress: onSendProgress);
          } on DioError catch (e) {
            _handleDioError(e, onError, url);
            return;
          }
          await _handleResponse(url, method,
              response: responseNext,
              onResponse: onResponse,
              body: body,
              query: query,
              onError: onError,
              onReceiveProgress: onReceiveProgress,
              onSendProgress: onSendProgress,
              shouldShowErrorSnackBar: shouldShowErrorSnackBar);
        } else {
          ///Refresh token failed => handle unauthorized
          handleUnauthorizedError?.call();
          onError?.call(
              CoreResponseError(errorCode: CoreHttpCode.TOKEN_INVALID,
                  errorMessage: CoreRemoteConstants.sessionExpiredErrorMessage)
          );
        }
        return;
      } else {
        _handleDioError(e, onError, url);
        return;
      }
    }

    ///
    await _handleResponse(url, method,
        response: response,
        onResponse: onResponse,
        body: body,
        query: query,
        onError: onError,
        shouldShowErrorSnackBar: shouldShowErrorSnackBar);
  }

  void _handleDioError(DioError e, dynamic Function(CoreResponseError error)? onError, String url) async {
    switch (e.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        LoggerService.log.e('Timeout error!');
        final error =
        CoreResponseError(errorCode: HttpStatus.requestTimeout, errorMessage: e.message);
        onError?.call(error);
        break;
      case DioErrorType.response:
        LoggerService.log.i('${e.response?.statusCode}: ${_dio.options.baseUrl}$url');
        LoggerService.log.i(e.response?.data);

        var error = CoreResponseError();
        try {
          error = CoreResponseError(
            errorCode: e.response?.statusCode,
            errorMessage: '${e.response?.data[CoreRemoteConstants.errorMessageFieldKey]}',
          );
        } on Exception catch (_) {
          error = CoreResponseError(
            errorCode: e.response?.statusCode,
            errorMessage: e.response?.data,
          );
        }
        onError?.call(error);
        break;
      case DioErrorType.cancel:
        final error = CoreResponseError(errorCode: e.response?.statusCode, errorMessage: e.message);
        onError?.call(error);
        break;
      case DioErrorType.other:
        final error = CoreResponseError(errorCode: e.response?.statusCode, errorMessage: e.message);
        onError?.call(error);
        break;
    }
  }

  Future<Response?> _requestApi(
      String url,
      String method,
      Map<String, dynamic>? query,
      dynamic body, {
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    Response? response;
    switch (method) {
      case CoreHTTPMethod.get:
        response = await _dio.get(url, queryParameters: query, onReceiveProgress: onSendProgress);
        break;
      case CoreHTTPMethod.post:
        response = await _dio.post(url,
            data: body,
            queryParameters: query,
            onSendProgress: onSendProgress,
            onReceiveProgress: onSendProgress);
        break;
      case CoreHTTPMethod.put:
        response = await _dio.put(url,
            data: body,
            queryParameters: query,
            onSendProgress: onSendProgress,
            onReceiveProgress: onSendProgress);
        break;
      case CoreHTTPMethod.patch:
        response = await _dio.patch(url,
            data: body,
            queryParameters: query,
            onSendProgress: onSendProgress,
            onReceiveProgress: onSendProgress);
        break;
      case CoreHTTPMethod.delete:
        response = await _dio.delete(url, queryParameters: query);
        break;
      default:
        return null;
    }
    return response;
  }

  Future<void> _handleResponse(String url, String method,
      {Response? response,
        Map<String, dynamic>? query,
        dynamic body,
        bool shouldShowErrorSnackBar = false,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        required Function(Map<String, dynamic> responseData) onResponse,
        dynamic Function(CoreResponseError error)? onError}) async {
    if (response == null) {
      ///Always show snack bar when response is null
      handleErrorMessage('Request $url with method $method failed', true);
    } else {
      LoggerService.log.i('${response.statusCode}: ${_dio.options.baseUrl}$url');
      LoggerService.log.i(response.data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        ///when statusCode is between 200 and 299 ==> Success
        onResponse(response.data);
      } else if (response.statusCode! >= 500 && response.statusCode! <= 599) {
        ///Server error -> always show error snack bar
        handleErrorMessage('Cannot connect to server', true); //TODO - Localized
      } else if (response.statusCode == CoreHttpCode.TOKEN_INVALID) {
        ///Unauthorized - error code 401
        handleUnauthorizedError?.call();

        ///
      } else if (response.statusCode == CoreHttpCode.TOKEN_EXPIRED) {
        ///Session expired - error code 423
        final refreshSuccess = await requestRefreshToken();
        if (refreshSuccess) {
          ///If refresh token success
          ///Request api again
          Response? responseNext;
          try {
            responseNext = await _requestApi(url, method, query, body,
                onReceiveProgress: onReceiveProgress, onSendProgress: onSendProgress);
          } on DioError catch (e) {
            _handleDioError(e, onError, url);
            return;
          }
          await _handleResponse(url, method,
              response: responseNext,
              onResponse: onResponse,
              body: body,
              query: query,
              onError: onError,
              onReceiveProgress: onReceiveProgress,
              onSendProgress: onSendProgress,
              shouldShowErrorSnackBar: shouldShowErrorSnackBar);
        } else {
          ///Refresh token failed => handle unauthorized
          handleUnauthorizedError?.call();
          onError?.call(
              CoreResponseError(errorCode: CoreHttpCode.TOKEN_INVALID,
                  errorMessage: CoreRemoteConstants.sessionExpiredErrorMessage)
          );
        }
      } else {
        ///Get error message from response
        final errorMessage = _getErrorMessage(response);
        handleErrorMessage(errorMessage, shouldShowErrorSnackBar);

        ///Return error if defined
        if (onError != null) {
          ///Create error model with code and message
          final error =
          CoreResponseError(errorCode: response.statusCode, errorMessage: errorMessage);
          onError(error);
        }
      }
    }
  }

  //TODO - Implement request refresh token
  ///Return true if refresh success
  Future<bool> requestRefreshToken() async {
    final body = {
      CoreRemoteConstants.deviceTokenParamKey: CoreStorageManager().getFirebaseToken(),
      CoreRemoteConstants.refreshTokenParamKey: CoreStorageManager().getRefreshToken(),
    };
    try {
      LoggerService.log.i('Header: ${_dio.options.headers}');
      LoggerService.log
          .i('post -> ${_dio.options.baseUrl}${CoreRemoteConstants.refreshTokenEndPoint} '
          '\nbody: ${jsonEncode(body)}');
      Response? response = await _dio.post(CoreRemoteConstants.refreshTokenEndPoint, data: body);
      if ((response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) <= 299) {
        LoggerService.log.i('${response.statusCode}: '
            '${_dio.options.baseUrl}${CoreRemoteConstants.refreshTokenEndPoint}');
        LoggerService.log.i(response.data);

        final newAccessToken = response.data['data'][CoreRemoteConstants.accessTokenParamKey];
        // final newRefreshToken = response.data['data'][CoreRemoteConstants.refreshTokenParamKey];

        CoreStorageManager().setToken(newAccessToken);
        // CoreStorageManager().setRefreshToken(newRefreshToken);

        ///Set up token in header
        setUpHeader({CoreRemoteConstants.accessTokenHeaderKey: newAccessToken});

        ///
        return true;
      }
    } on DioError catch (e) {
      LoggerService.log.e('Refresh token error: ${e.response?.data}');
      return false;
    }
    return false;
  }

  String _getErrorMessage(Response response) {
    ///Get error message from response --- default field [ERROR_MESSAGE_FIELD_NAME]
    String? errorMessage = response.data[CoreRemoteConstants.errorMessageFieldKey];
    return errorMessage ??
        'Response with error code ${response.statusCode}'; //TODO - change to localized
  }

  void handleErrorMessage(String message, bool shouldShowError) {
    if (!shouldShowError) return;
  }
}
