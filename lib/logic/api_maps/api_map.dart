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
    var dio = Dio(await options);
    if (hasLoger) {
      dio.interceptors.add(PrettyDioLogger());
    }
    dio.interceptors.add(ConsoleInterceptor());
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    dio.interceptors.add(InterceptorsWrapper(onError: (DioError e, handler) {
      print(e.requestOptions.path);
      print(e.requestOptions.data);

      print(e.message);
      print(e.response);

      return handler.next(e);
    }));
    return dio;
  }

  FutureOr<BaseOptions> get options;

  abstract final String rootAddress;
  abstract final bool hasLoger;
  abstract final bool isWithToken;

  ValidateStatus? validateStatus;

  void close(Dio client) {
    client.close();
    validateStatus = null;
  }
}

class ConsoleInterceptor extends InterceptorsWrapper {
  void addMessage(Message message) {
    getIt.get<ConsoleModel>().addMessage(message);
  }

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler requestInterceptorHandler,
  ) async {
    addMessage(
      Message(
        text:
            'request-uri: ${options.uri}\nheaders: ${options.headers}\ndata: ${options.data}',
      ),
    );
    return super.onRequest(options, requestInterceptorHandler);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler requestInterceptorHandler,
  ) async {
    addMessage(
      Message(
        text:
            'response-uri: ${response.realUri}\ncode: ${response.statusCode}\ndata: ${response.toString()}\n',
      ),
    );
    return super.onResponse(
      response,
      requestInterceptorHandler,
    );
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    var response = err.response;
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
