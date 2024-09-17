import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import 'end_points.dart';

abstract class AppDio {
  //? singleton dio object
  static final _dio = _getDio();
  static Dio get instance => _dio;

  //? name to be display in console log
  static const _loggerName = " AppDio ";
  static bool isRefreshTokenRequested = false;
  static Dio _getDio() {
    // auth dio object
    final options = BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: Endpoints.connectionTimeout,
      receiveTimeout:  Endpoints.receiveTimeout,
    );
    var _dio = Dio(options);

    final interceptor = InterceptorsWrapper(
      //? on request
      onRequest: (request, handler) async {
        final headers = {
          "Authorization":
              ""
        };
        request.headers.addAll(headers);

        log("🌎 🌎 🌎 🌎 🌎 🌎 # API # 🌎 🌎 🌎 🌎 🌎 🌎");
        try {
          log(
            '${request.uri} || ${request.headers} || ${json.encode(request.data)}',
            name: _loggerName,
          );
        } catch (e) {
          log(
            '${request.uri} || ${request.headers}',
            name: _loggerName,
          );
        }

        handler.next(request);
      },

      //? on response
      onResponse: (response, handler) async {
        log("💀 💀 💀 💀 💀 * RESPONSE * 💀 💀 💀 💀 💀");
        log(
          ' API CALL: ${response.requestOptions.uri} \n STATUS: ${response.statusCode} \n RESPONSE: ${json.encode(response.data)}',
          name: _loggerName,
        );
       if ((response.statusCode ?? 0) >= 200 &&
            (response.statusCode ?? 0) < 400) {
          handler.next(response);
        }
       else if(response.statusCode == 401){
         handler.next(response);
       }
       else {
          handler.reject(
            DioError(
              requestOptions: response.requestOptions,
              error: "Something went wrong",
            ),
          );
        }
      },

      //? on error
      onError: (error, handler) {
        log(
          '🚨 🚨 🚨 🚨 🚨 🚨 🚨 🚨 🚨 🚨',
          error: """
              error: ${error.error},
              error.type: ${error.type},
              error.message: ${error.message},
              error.response: ${error.response},
              """,
          name: _loggerName,
        );
        handler.next(error);
      },
    );

    //? return dio object with interceptor and base config
    _dio.interceptors.add(interceptor);
    return _dio;  }

}
