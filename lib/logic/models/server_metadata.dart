enum MetadataType {
  id,
  status,
  cpu,
  ram,
  cost,
  location,

  other,
}

class ServerMetadataEntity {
  ServerMetadataEntity({
    required this.name,
    required this.value,
    this.type = MetadataType.other,
  });
  final MetadataType type;
  final String name;
  final String value;
}
