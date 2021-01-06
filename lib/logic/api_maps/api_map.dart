import 'package:dio/dio.dart';

abstract class ApiMap {
  String rootAddress;

  Dio client = Dio();

  void close() {
    client.close();
  }
}
