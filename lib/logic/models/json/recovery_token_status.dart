import 'package:json_annotation/json_annotation.dart';

part 'recovery_token_status.g.dart';

@JsonSerializable()
class RecoveryTokenStatus {
  RecoveryTokenStatus({
    required this.exists,
    required this.valid,
    this.date,
    this.expiration,
    this.uses_left,
  });

  final bool exists;
  final DateTime? date;
  final DateTime? expiration;
  final int? uses_left;
  final bool valid;

  factory RecoveryTokenStatus.fromJson(Map<String, dynamic> json) =>
      _$RecoveryTokenStatusFromJson(json);
}
