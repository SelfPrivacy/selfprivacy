import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/users.graphql.dart';

part 'email_password_metadata.g.dart';

@HiveType(typeId: 10)
class EmailPasswordMetadata extends Equatable {
  const EmailPasswordMetadata({
    required this.uuid,
    required this.displayName,
    this.createdAt,
    this.expiresAt,
    this.lastUsed,
  });

  EmailPasswordMetadata.fromGraphQL(
    final Fragment$userFields$emailPasswordMetadata metadata,
  ) : this(
        uuid: metadata.uuid,
        displayName: metadata.displayName,
        createdAt: metadata.createdAt,
        expiresAt: metadata.expiresAt,
        lastUsed: metadata.lastUsed,
      );

  @HiveField(0)
  final String uuid;

  @HiveField(1)
  final String displayName;

  @HiveField(2)
  final DateTime? createdAt;

  @HiveField(3)
  final DateTime? expiresAt;

  @HiveField(4)
  final DateTime? lastUsed;

  @override
  List<Object?> get props => [
    uuid,
    displayName,
    createdAt,
    expiresAt,
    lastUsed,
  ];
}
