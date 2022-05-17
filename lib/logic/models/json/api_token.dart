import 'package:json_annotation/json_annotation.dart';

part 'api_token.g.dart';

@JsonSerializable()
class ApiToken {
  ApiToken({
    required this.name,
    required this.date,
    required this.is_caller,
  });

  final String name;
  final DateTime date;
  final bool is_caller;

  factory ApiToken.fromJson(Map<String, dynamic> json) =>
      _$ApiTokenFromJson(json);
}
