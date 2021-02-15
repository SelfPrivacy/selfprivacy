import 'dart:io';

import 'package:dio/dio.dart';

import 'api_map.dart';

class ServerApi extends ApiMap {
  ServerApi(String domainName) {
    loggedClient.options = BaseOptions(
      baseUrl: 'https://api.$domainName',
    );
  }

  Future<bool> isHttpServerWorking() async {
    bool res;

    Response response;
    try {
      response = await loggedClient.get('/serviceStatus');
      res = response.statusCode == HttpStatus.ok;
    } catch (e) {
      res = false;
    }

    return res;
  }

  // Future<String> getDkim(String domainName) async {
  //   var response = await loggedClient.get(
  //     '/getDKIM',
  //     options: Options(responseType: ResponseType.plain),
  //   );
  //   return _decodeAndCutData(response.data, domainName);
  // }
}

// String _decodeAndCutData(String text, String domainName) {
//   var decodedTextString = text.substring(1, text.length - 1);
//   var stringToBase64 = utf8.fuse(base64);

//   return stringToBase64
//       .decode(decodedTextString)
//       .replaceAll("selector._domainkey	IN	TXT	( ", "")
//       .replaceAll("\"\n	  \"", "")
//       .replaceAll(' )  ; ----- DKIM key selector for $domainName\n', '');
// }
