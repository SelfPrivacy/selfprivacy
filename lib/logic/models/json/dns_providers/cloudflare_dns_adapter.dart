part of 'cloudflare_dns_info.dart';

CloudflareDnsRecord _fromDnsRecord(
  final DnsRecord dnsRecord,
  final String rootDomain,
) {
  String name = dnsRecord.name ?? '';
  if (name != rootDomain && name != '@') {
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

DnsRecord _toDnsRecord(
  final CloudflareDnsRecord cloudflareRecord,
  final String domainName,
) {
  String? name = cloudflareRecord.name;
  if (name != null && name.endsWith('.$domainName')) {
    // e.g. 'api.example.com -> [api] [example] [com] -> [api]'
    name = name.split('.')[0];
  }

  return DnsRecord(
    content: cloudflareRecord.content,
    type: cloudflareRecord.type,
    ttl: cloudflareRecord.ttl,
    name: name,
  );
}

ServerDomain _toServerDomain(final CloudflareZone cloudflareZone) =>
    ServerDomain(
      domainName: cloudflareZone.name,
      provider: DnsProviderType.cloudflare,
    );
