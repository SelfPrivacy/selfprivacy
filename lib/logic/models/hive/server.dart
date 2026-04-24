import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

part 'server.g.dart';

// TODO(inex): Make a constant type.
@HiveType(typeId: 9)
class Server {
  Server({required this.hostingDetails, required this.domain});

  @HiveField(0)
  final ServerHostingDetails hostingDetails;

  @HiveField(1)
  final ServerDomain domain;
}
