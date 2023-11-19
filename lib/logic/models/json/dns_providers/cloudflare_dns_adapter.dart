part of 'cloudflare_dns_info.dart';

CloudflareDnsRecord _fromDnsRecord(
  final DnsRecord dnsRecord,
  final String rootDomain,
) {
  String name = dnsRecord.name ?? '';
  if (name != rootDomain) {
    name = '$name.$rootDomain';
  }
  return CloudflareDnsRecord(
    content: dnsRecord.content,
    name: name,
    type: dnsRecord.type,
    zoneName: rootDomain,
    id: null,
    ttl: dnsRecord.ttl,
  );
}

DnsRecord _toDnsRecord(final CloudflareDnsRecord cloudflareRecord) => DnsRecord(
      content: cloudflareRecord.content,
      name: cloudflareRecord.name,
      type: cloudflareRecord.type,
      ttl: cloudflareRecord.ttl,
    );

ServerDomain _toServerDomain(final CloudflareZone cloudflareZone) =>
    ServerDomain(
      domainName: cloudflareZone.name,
      provider: DnsProviderType.cloudflare,
    );
