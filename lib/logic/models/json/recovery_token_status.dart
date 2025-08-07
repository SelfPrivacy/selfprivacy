import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';

part 'recovery_token_status.g.dart';

@JsonSerializable()
class RecoveryKeyStatus extends Equatable {
  const RecoveryKeyStatus({
    required this.exists,
    required this.valid,
    this.date,
    this.expiration,
    this.usesLeft,
  });

  factory RecoveryKeyStatus.fromJson(final Map<String, dynamic> json) =>
      _$RecoveryKeyStatusFromJson(json);

  RecoveryKeyStatus.fromGraphQL(
    final Query$RecoveryKey$api$recoveryKey recoveryKey,
  ) : this(
        exists: recoveryKey.exists,
        date: recoveryKey.creationDate,
        expiration: recoveryKey.expirationDate,
        usesLeft: recoveryKey.usesLeft,
        valid: recoveryKey.valid,
      );

  final bool exists;
  final DateTime? date;
  final DateTime? expiration;
  @JsonKey(name: 'uses_left')
  final int? usesLeft;
  final bool valid;

  @override
  List<Object?> get props => [exists, date, expiration, usesLeft, valid];
}
