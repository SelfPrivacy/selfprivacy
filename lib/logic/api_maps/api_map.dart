// ignore_for_file: always_specify_types

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/message.dart';

abstract class ApiMap {
  Future<Dio> getClient() async {
    final Dio dio = Dio(await options);
    if (hasLogger) {
      dio.interceptors.add(PrettyDioLogger());
    }
    dio.interceptors.add(ConsoleInterceptor());
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (final HttpClient client) {
      client.badCertificateCallback =
          (final X509Certificate cert, final String host, final int port) => true;
      return client;
    };

    dio.interceptors.add(InterceptorsWrapper(onError: (final DioError e, final ErrorInterceptorHandler handler) {
      print(e.requestOptions.path);
      print(e.requestOptions.data);

      print(e.message);
      print(e.response);

      return handler.next(e);
    },),);
    return dio;
  }

  FutureOr<BaseOptions> get options;

  abstract final String rootAddress;
  abstract final bool hasLogger;
  abstract final bool isWithToken;

  ValidateStatus? validateStatus;

  void close(final Dio client) {
    client.close();
    validateStatus = null;
  }
}

class ConsoleInterceptor extends InterceptorsWrapper {
  void addMessage(final Message message) {
    getIt.get<ConsoleModel>().addMessage(message);
  }

  @override
  Future onRequest(
    final RequestOptions options,
    final RequestInterceptorHandler handler,
  ) async {
    addMessage(
      Message(
        text:
            'request-uri: ${options.uri}\nheaders: ${options.headers}\ndata: ${options.data}',
      ),
    );
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
    final Response response,
    final ResponseInterceptorHandler handler,
  ) async {
    addMessage(
      Message(
        text:
            'response-uri: ${response.realUri}\ncode: ${response.statusCode}\ndata: ${response.toString()}\n',
      ),
    );
    return super.onResponse(
      response,
      handler,
    );
  }

  @override
  Future onError(final DioError err, final ErrorInterceptorHandler handler) async {
    final Response? response = err.response;
    log(err.toString());
    addMessage(
      Message.warn(
        text:
            'response-uri: ${response?.realUri}\ncode: ${response?.statusCode}\ndata: ${response?.toString()}\n',
      ),
    );
    return super.onError(err, handler);
  }
}
