import 'dart:developer';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/get_it/console.dart';
import 'package:selfprivacy/logic/models/message.dart';

abstract class ApiMapOld {
  ApiMapOld() {
    var client = Dio()..interceptors.add(ConsoleInterceptor());
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    loggedClient = client;
  }
  String? rootAddress;

  late Dio loggedClient;

  void close() {
    loggedClient.close();
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
