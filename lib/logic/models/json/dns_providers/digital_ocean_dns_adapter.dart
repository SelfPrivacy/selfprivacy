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
  if (type != 'MX') {
    name = convert(name);
  }
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
