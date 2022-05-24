import 'dart:convert';

import 'package:hive/hive.dart';

part 'backblaze_credential.g.dart';

@HiveType(typeId: 4)
class BackblazeCredential {
  BackblazeCredential({required this.keyId, required this.applicationKey});

  @HiveField(0)
  final String keyId;

  @HiveField(1)
  final String applicationKey;

  get encodedApiKey => encodedBackblazeKey(keyId, applicationKey);

  @override
  String toString() {
    return '$keyId: $encodedApiKey';
  }
}

String encodedBackblazeKey(String? keyId, String? applicationKey) {
  String apiKey = '$keyId:$applicationKey';
  String encodedApiKey = base64.encode(utf8.encode(apiKey));
  return encodedApiKey;
}
