part of 'desec_dns_info.dart';

DesecDnsRecord _fromDnsRecord(final DnsRecord dnsRecord) {
  final String type = dnsRecord.type;
  String content = dnsRecord.content ?? '';
  String name = dnsRecord.name ?? '';
  if (type == 'MX') {
    name = (name == '@') ? '' : name;
    content = '${dnsRecord.priority} $content';
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

DnsRecord _toDnsRecord(final DesecDnsRecord desecRecord) {
  final String type = desecRecord.type;
  String content = desecRecord.records.isEmpty ? '' : desecRecord.records[0];
  String name = desecRecord.subname;
  int? priority;
  if (type == 'MX') {
    name = name.isEmpty ? '@' : name;
    final contentBulk = content.split(' ');
    content = contentBulk[1];
    priority = int.parse(contentBulk[0]);
  }
  if (type == 'TXT' && content.isNotEmpty && content.startsWith('"')) {
    content = content.substring(1, content.length); // cut away quotes
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

ServerDomain _toServerDomain(final DesecDomain desecDomain) => ServerDomain(
      domainName: desecDomain.name,
      provider: DnsProviderType.desec,
    );
