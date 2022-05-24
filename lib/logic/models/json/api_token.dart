import 'package:json_annotation/json_annotation.dart';

part 'api_token.g.dart';

@JsonSerializable()
class ApiToken {
  ApiToken({
    required this.name,
    required this.date,
    required this.isCaller,
  });

  final String name;
  final DateTime date;
  @JsonKey(name: 'is_caller')
  final bool isCaller;

  factory ApiToken.fromJson(Map<String, dynamic> json) =>
      _$ApiTokenFromJson(json);
}
