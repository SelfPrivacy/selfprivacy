part of 'digital_ocean_dns_info.dart';

DigitalOceanDnsRecord _fromDnsRecord(
  final DnsRecord dnsRecord,
  final String rootDomain,
) {
  String convert(final String entry) => (entry == rootDomain) ? '@' : entry;
  String name = dnsRecord.name ?? '';
  String content = dnsRecord.content ?? '';
  name = convert(name);
  content = convert(content);

  if (dnsRecord.type == 'CAA') {
    // Split the content string into parts
    // e.g. '0 issue "letsencrypt.org"' -> ['0', 'issue', 'letsencrypt.org']
    final List<String> parts = dnsRecord.content!.split(' ');
    if (parts.length != 3) {
      throw ArgumentError('Invalid CAA record content: ${dnsRecord.content}');
    }
    return DigitalOceanDnsRecord(
      name: name,
      data: parts[2].replaceAll('"', ''),
      ttl: dnsRecord.ttl,
      type: dnsRecord.type,
      priority: dnsRecord.priority,
      id: null,
      flags: int.parse(parts[0]),
      tag: parts[1],
    );
  }

  return DigitalOceanDnsRecord(
    name: name,
    data: content,
    ttl: dnsRecord.ttl,
    type: dnsRecord.type,
    priority: dnsRecord.priority,
    id: null,
  );
}

DnsRecord _toDnsRecord(
  final DigitalOceanDnsRecord digitalOceanRecord,
  final String rootDomain,
) {
  final String type = digitalOceanRecord.type;
  String convert(final String entry) => (entry == '@') ? rootDomain : entry;
  String name = digitalOceanRecord.name;
  final String content = convert(digitalOceanRecord.data);
  name = (name == '@') ? rootDomain : name;
  return DnsRecord(
    name: name,
    content: content,
    ttl: digitalOceanRecord.ttl,
    type: type,
    priority: digitalOceanRecord.priority ?? 10,
  );
}

ServerDomain _toServerDomain(final DigitalOceanDomain digitalOceanDomain) =>
    ServerDomain(
      domainName: digitalOceanDomain.name,
      provider: DnsProviderType.digitalOcean,
    );

DigitalOceanDomain _fromServerDomain(final ServerDomain serverDomain) =>
    DigitalOceanDomain(name: serverDomain.domainName);
