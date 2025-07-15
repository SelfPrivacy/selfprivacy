import 'package:hive_ce/hive.dart';

part 'backblaze_bucket.g.dart';

@HiveType(typeId: 6)
class BackblazeBucket {
  BackblazeBucket({
    required this.bucketId,
    required this.bucketName,
    required this.applicationKeyId,
    required this.applicationKey,
    required this.encryptionKey,
  });

  @HiveField(0)
  final String bucketId;

  @HiveField(1)
  final String applicationKeyId;

  @HiveField(2)
  final String applicationKey;

  @HiveField(3)
  final String bucketName;

  @HiveField(4)
  final String encryptionKey;

  @override
  String toString() => bucketName;

  BackblazeBucket copyWith({
    final String? bucketId,
    final String? applicationKeyId,
    final String? applicationKey,
    final String? bucketName,
    final String? encryptionKey,
  }) => BackblazeBucket(
    bucketId: bucketId ?? this.bucketId,
    applicationKeyId: applicationKeyId ?? this.applicationKeyId,
    applicationKey: applicationKey ?? this.applicationKey,
    bucketName: bucketName ?? this.bucketName,
    encryptionKey: encryptionKey ?? this.encryptionKey,
  );
}
