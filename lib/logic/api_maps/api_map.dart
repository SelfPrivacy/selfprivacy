import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/get_it/console.dart';
import 'package:selfprivacy/logic/models/message.dart';

abstract class ApiMap {
  String rootAddress;

  // Dio client = Dio();

  Dio loggedClient = Dio()..interceptors.add(ConsoleInterceptor());

  void close() {
    loggedClient.close();
  }
}

class ConsoleInterceptor extends InterceptorsWrapper {
  void addMessage(Message message) {
    getIt.get<ConsoleModel>().addMessage(message);
  }

  @override
  Future onRequest(RequestOptions options) async {
    addMessage(
      Message(
        text:
            'request-uri: ${options.uri}\nheaders: ${options.headers}\ndata: ${options.data}',
      ),
    );
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) async {
    addMessage(
      Message(
        text:
            'response-uri: ${response.request.uri}\ncode: ${response.statusCode}\ndata: ${response.data.toString()}\n',
      ),
    );
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) async {
    return super.onError(err);
  }
}
