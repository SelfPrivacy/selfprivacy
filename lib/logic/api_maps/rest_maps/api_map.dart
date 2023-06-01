import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/message.dart';

abstract class ApiMap {
  Future<Dio> getClient({final BaseOptions? customOptions}) async {
    final Dio dio = Dio(customOptions ?? (await options));
    if (hasLogger) {
      dio.interceptors.add(PrettyDioLogger());
    }
    dio.interceptors.add(ConsoleInterceptor());
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (final HttpClient client) {
      client.badCertificateCallback =
          (final X509Certificate cert, final String host, final int port) =>
              true;
      return client;
    };

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (final DioError e, final ErrorInterceptorHandler handler) {
          print(e.requestOptions.path);
          print(e.requestOptions.data);

          print(e.message);
          print(e.response);

          return handler.next(e);
        },
      ),
    );
    return dio;
  }

  FutureOr<BaseOptions> get options;

  String get rootAddress;

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
  Future<void> onRequest(
    final RequestOptions options,
    final RequestInterceptorHandler handler,
  ) async {
    addMessage(
      RestApiRequestMessage(
        method: options.method,
        data: options.data.toString(),
        headers: options.headers,
        uri: options.uri,
      ),
    );
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
    final Response response,
    final ResponseInterceptorHandler handler,
  ) async {
    addMessage(
      RestApiResponseMessage(
        method: response.requestOptions.method,
        statusCode: response.statusCode,
        data: response.data.toString(),
        uri: response.realUri,
      ),
    );
    return super.onResponse(
      response,
      handler,
    );
  }

  @override
  Future<void> onError(
    final DioError err,
    final ErrorInterceptorHandler handler,
  ) async {
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
