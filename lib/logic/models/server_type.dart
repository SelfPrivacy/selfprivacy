import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';

class ServerType {
  ServerType({
    required this.title,
    required this.identifier,
    required this.ram,
    required this.cores,
    required this.disk,
    required this.price,
    required this.location,
  });
  final String title;
  final String identifier;
  final double ram; // GB !!
  final DiskSize disk;
  final int cores;
  final Price price;
  final ServerProviderLocation location;
}
