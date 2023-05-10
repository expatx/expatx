import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:expatx/core/cache/cache_helper_impl.dart';

import '../../features/authentication/presentation/bloc/auth/auth_bloc.dart';
import '../environment/configurations.dart/prod_config.dart';
import '../environment/environment.dart';
import '../error/exceptions.dart';
import '../global.dart';
import '../logger.dart';

class RestClient {
  final String _baseUrl;
  late Dio _dio;

  final Duration connectTimeout = const Duration(seconds: 30);

  RestClient(this._baseUrl) {
    var options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: const Duration(seconds: 30),
    );

    _dio = Dio(options);
  }

  void setRequestTimeout(Duration timeout) {
    _dio.options.connectTimeout = timeout;
  }

  void resetRequestTimeout() {
    _dio.options.connectTimeout = connectTimeout;
  }

  Future<Response<dynamic>> get(
    //Public or Protected
    PublicOrProtected publicOrProtected,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    _setDioInterceptorList(publicOrProtected);

    final standardHeaders = await _getOptions(publicOrProtected);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .get(path, queryParameters: data, options: standardHeaders)
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> post(
    PublicOrProtected publicOrProtected,
    String path,
    String data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList(publicOrProtected);

    final standardHeaders = await _getOptions(publicOrProtected);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .post(path,
            data: data, options: standardHeaders, queryParameters: queryParams)
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> put(
    PublicOrProtected publicOrProtected,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    _setDioInterceptorList(publicOrProtected);

    final standardHeaders = await _getOptions(publicOrProtected);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .put(path, data: data, options: standardHeaders)
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> delete(
    PublicOrProtected publicOrProtected,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList(publicOrProtected);

    final standardHeaders = await _getOptions(publicOrProtected);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .delete(path,
            data: data, queryParameters: queryParams, options: standardHeaders)
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Options> _getOptions(PublicOrProtected publicOrProtected) async {
    switch (publicOrProtected) {
      case PublicOrProtected.public:
        return PublicApiOptions().options;
      case PublicOrProtected.protected:
        String accessToken = await CacheHelperImpl().getAccessToken();
        return ProtectedApiOptions(accessToken).options;
    }
  }

  dynamic _getDioException(error) {
    if (error is DioError) {
      Log.error(
          'DIO ERROR: ${error.type} ENDPOINT: ${error.requestOptions.baseUrl} - ${error.requestOptions.path} ERROR RESPONSE: ${error.response}');
      switch (error.type) {
        case DioErrorType.cancel:
          throw RequestCancelledException(
              001, 'Something went wrong. Please try again.');
        case DioErrorType.connectionTimeout:
          throw RequestTimeoutException(
              408, 'Could not connect to the server.');
        case DioErrorType.receiveTimeout:
          throw ReceiveTimeoutException(
              004, 'Could not connect to the server.');
        case DioErrorType.sendTimeout:
          throw RequestTimeoutException(
              408, 'Could not connect to the server.');
        case DioErrorType.badCertificate:
          break;
        case DioErrorType.connectionError:
          break;
        case DioErrorType.unknown:
          break;
        case DioErrorType.badResponse:
          final errorMessage = error.response?.data['message'];
          switch (error.response?.statusCode) {
            case 400:
              throw CustomException(
                  400, jsonEncode(error.response?.data), "Bad Request We Have");
            case 403:
              final message = errorMessage ?? '${error.response?.data}';
              throw UnauthorisedException(error.response?.statusCode, message);
            case 401:
              final message = errorMessage ?? '${error.response?.data}';
              throw UnauthorisedException(error.response?.statusCode, message);
            case 404:
              throw NotFoundException(
                  404, errorMessage ?? error.response?.data.toString());
            case 408:
              throw RequestTimeoutException(
                  408, 'Could not connect to the server.');
            case 431:
              throw CustomException(431, jsonEncode(error.response?.data), "");
            case 437:
              throw CustomException(437, jsonEncode(error.response?.data), "");
            case 438:
              throw CustomException(438, jsonEncode(error.response?.data), "");
            case 500:
              throw InternalServerException(
                  500, 'Something went wrong. Please try again.');
            default:
              throw DefaultException(0002,
                  errorMessage ?? 'Something went wrong. Please try again.');
          }
      }
    } else {
      throw UnexpectedException(000, 'Something went wrong. Please try again.');
    }
  }

  void _setDioInterceptorList(PublicOrProtected publicOrProtected) {
    List<Interceptor> interceptorList = [];

    _dio.interceptors.clear();

    //If environment is not Prod, we will print incoming and outgoing requests to console using Pretty Dio Logger package
    if (Environment().config is! ProdConfig) {
      interceptorList.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
    }

    interceptorList.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options); //modify your request
    }, onResponse: (response, handler) {
      return handler.next(response); //modify your response
    }, onError: (DioError e, handler) async {
      // print(e.response!.statusCode);
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          // If any request ever returns unauthorized, we will log out the user.
          if (GlobalVariable.navState.currentContext != null) {
      
            GlobalVariable.navState.currentContext!.read<AuthBloc>().add(
                  AuthLogoutUser(),
                );
          }
        }
      }

      return handler.next(e); //continue
    }));

    _dio.interceptors.addAll(interceptorList);

    if (publicOrProtected == PublicOrProtected.protected) {
      interceptorList.add(_getInterceptorForProtectedApi());
    }
  }

  Interceptor _getInterceptorForProtectedApi() {
    return InterceptorsWrapper(onRequest: (request, handler) async {});
  }
}

abstract class ApiOptions {
  Options options = Options();
}

// Public API options without Bearer Token
class PublicApiOptions extends ApiOptions {
  PublicApiOptions() {
    super.options.headers = <String, dynamic>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
}

// Protected API options that need Bearer Token
class ProtectedApiOptions extends ApiOptions {
  ProtectedApiOptions(String accessToken) {
    debugPrint(accessToken, wrapWidth: 1024);
    super.options.headers = <String, dynamic>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': accessToken,
    };
  }
}

enum PublicOrProtected { public, protected }
