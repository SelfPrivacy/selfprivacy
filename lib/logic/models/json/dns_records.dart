import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_settings.graphql.dart';

part 'dns_records.g.dart';

@JsonSerializable()
class DnsRecord extends Equatable {
  const DnsRecord({
    required this.type,
    required this.name,
    required this.content,
    this.displayName,
    this.ttl = 3600,
    this.priority = 10,
    this.proxied = false,
  });

  DnsRecord.fromGraphQL(final Fragment$fragmentDnsRecords record)
    : this(
        type: record.recordType,
        name: record.name,
        displayName: record.displayName,
        content: record.content,
        ttl: record.ttl,
        priority: record.priority ?? 10,
      );

  final String type;
  final String? displayName;
  final String? name;
  final String? content;
  final int ttl;
  final int priority;
  final bool proxied;

  Map<String, dynamic> toJson() => _$DnsRecordToJson(this);

  @override
  @JsonKey(includeToJson: false)
  List<Object?> get props => [type, name, content, ttl, priority];
}
