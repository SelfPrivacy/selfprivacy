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

  String get encodedApiKey => encodedBackblazeKey(keyId, applicationKey);

  @override
  String toString() => '$keyId: $encodedApiKey';
}

String encodedBackblazeKey(final String? keyId, final String? applicationKey) {
  final String apiKey = '$keyId:$applicationKey';
  final String encodedApiKey = base64.encode(utf8.encode(apiKey));
  return encodedApiKey;
}
