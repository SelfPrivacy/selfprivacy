import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(createFactory: false)
class ServerInfo {
  final String id;
  final String name;
  final ServerStatus status;
  final DateTime created;

  ServerInfo(this.id, this.name, this.status, this.created);
}

enum ServerStatus {
  running,
  initializing,
  starting,
  stopping,
  off,
  deleting,
  migrating,
  rebuilding,
  unknown,
}
