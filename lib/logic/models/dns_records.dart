import 'package:json_annotation/json_annotation.dart';

part 'dns_records.g.dart';

@JsonSerializable(createToJson: true, createFactory: false)
class DnsRecords {
  DnsRecords({
    required this.type,
    required this.name,
    required this.content,
    this.ttl = 3600,
    this.priority = 10,
    this.proxied = false,
  });

  final String type;
  final String? name;
  final String? content;
  final int ttl;
  final int priority;
  final bool proxied;

  toJson() => _$DnsRecordsToJson(this);
}
