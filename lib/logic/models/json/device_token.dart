import 'package:json_annotation/json_annotation.dart';

part 'device_token.g.dart';

@JsonSerializable()
class DeviceToken {

  factory DeviceToken.fromJson(final Map<String, dynamic> json) =>
      _$DeviceTokenFromJson(json);
  DeviceToken({
    required this.device,
    required this.token,
  });

  final String device;
  final String token;
}
