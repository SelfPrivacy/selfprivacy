import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:uuid/uuid.dart';

part 'server.g.dart';

// TODO(inex): Make a constant type.
@HiveType(typeId: 9)
class Server {
  Server({
    required this.uuid,
    required this.hostingDetails,
    required this.domain,
  });

  factory Server.create({
    required final ServerHostingDetails hostingDetails,
    required final ServerDomain domain,
  }) => Server(
    uuid: const Uuid().v4(),
    hostingDetails: hostingDetails,
    domain: domain,
  );

  @HiveField(2, defaultValue: '')
  final String uuid;

  @HiveField(0)
  final ServerHostingDetails hostingDetails;

  @HiveField(1)
  final ServerDomain domain;
}
