import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';

part 'api_token.g.dart';

@JsonSerializable()
class ApiToken extends Equatable {
  const ApiToken({
    required this.name,
    required this.date,
    required this.isCaller,
  });

  factory ApiToken.fromJson(final Map<String, dynamic> json) =>
      _$ApiTokenFromJson(json);

  ApiToken.fromGraphQL(final Query$GetApiTokens$api$devices device)
    : this(
        name: device.name,
        date: device.creationDate,
        isCaller: device.isCaller,
      );

  final String name;
  final DateTime date;
  @JsonKey(name: 'is_caller')
  final bool isCaller;

  @override
  List<Object?> get props => [name, date, isCaller];
}
