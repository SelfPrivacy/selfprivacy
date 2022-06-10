import 'package:hive/hive.dart';

part 'backblaze_bucket.g.dart';

@HiveType(typeId: 6)
class BackblazeBucket {
  BackblazeBucket({
    required this.bucketId,
    required this.bucketName,
    required this.applicationKeyId,
    required this.applicationKey,
  });

  @HiveField(0)
  final String bucketId;

  @HiveField(1)
  final String applicationKeyId;

  @HiveField(2)
  final String applicationKey;

  @HiveField(3)
  final String bucketName;

  @override
  String toString() => bucketName;
}
