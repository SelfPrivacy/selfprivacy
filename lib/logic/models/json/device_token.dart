import 'package:json_annotation/json_annotation.dart';

part 'device_token.g.dart';

@JsonSerializable()
class DeviceToken {
  DeviceToken({required this.device, required this.token});

  factory DeviceToken.fromJson(final Map<String, dynamic> json) =>
      _$DeviceTokenFromJson(json);

  final String device;
  final String token;
}
