part of 'desec_dns_info.dart';

DesecDnsRecord _fromDnsRecord(
  final DnsRecord dnsRecord,
  final String domainName,
) {
  final String type = dnsRecord.type;
  String content = dnsRecord.content ?? '';
  String name = dnsRecord.name ?? '';
  if (name == '@' || name == domainName) {
    name = '';
  }
  if (type == 'MX') {
    content = '${dnsRecord.priority} $content.';
  }
  if (type == 'TXT' && content.isNotEmpty && !content.startsWith('"')) {
    content = '"$content"';
  }

  return DesecDnsRecord(
    subname: name,
    type: type,
    ttl: dnsRecord.ttl,
    records: [content],
  );
}

DnsRecord _toDnsRecord(
  final DesecDnsRecord desecRecord,
  final String domainName,
) {
  final String type = desecRecord.type;
  String content = desecRecord.records.isEmpty ? '' : desecRecord.records[0];
  String name = desecRecord.subname;
  int? priority;
  if (type == 'MX') {
    name = name.isEmpty ? domainName : name;
    final contentBulk = content.split(' ');
    content = contentBulk[1];
    if (content.contains(domainName)) {
      content = content.substring(
        0,
        content.length - 1,
      ); // cut away trailing dot
    }
    priority = int.parse(contentBulk[0]);
  }
  if (type == 'TXT' && content.isNotEmpty && content.startsWith('"')) {
    content = content.substring(1, content.length - 1); // cut away quotes
  }
  if (name.isEmpty) {
    name = domainName;
  }

  return DnsRecord(
    name: name,
    type: type,
    ttl: desecRecord.ttl,
    content: content,
    priority: priority ?? 10,
  );
}

DesecDomain _fromServerDomain(final ServerDomain serverDomain) =>
    DesecDomain(name: serverDomain.domainName);

ServerDomain _toServerDomain(final DesecDomain desecDomain) =>
    ServerDomain(domainName: desecDomain.name, provider: DnsProviderType.desec);
