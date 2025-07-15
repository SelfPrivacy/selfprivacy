import 'package:flutter/material.dart';

enum MetadataType {
  id(icon: Icons.numbers_outlined),
  status(icon: Icons.mode_standby_outlined),
  cpu(icon: Icons.memory_outlined),
  ram(icon: Icons.memory_outlined),
  cost(icon: Icons.payments_outlined),
  location(icon: Icons.location_on_outlined),

  other(icon: Icons.info_outlined);

  const MetadataType({required this.icon});

  final IconData icon;
}

class ServerMetadataEntity {
  ServerMetadataEntity({
    required this.trId,
    required this.value,
    this.type = MetadataType.other,
  });
  final MetadataType type;
  final String trId;
  final String value;
}
