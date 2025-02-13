part of 'cloudflare_dns_info.dart';

CloudflareDnsRecord _fromDnsRecord(
  final DnsRecord dnsRecord,
  final String rootDomain,
) {
  final String type = dnsRecord.type;
  String name = dnsRecord.name ?? '';
  if (name != rootDomain && name != '@') {
    name = '$name.$rootDomain';
  }
  if (type == 'MX' && name == '@') {
    name = rootDomain;
  }
  if (type == 'CAA') {
    // Split the content string into parts
    // e.g. '0 issue "letsencrypt.org"' -> ['0', 'issue', 'letsencrypt.org']
    final List<String> parts = dnsRecord.content!.split(' ');
    if (parts.length != 3) {
      throw ArgumentError('Invalid CAA record content: ${dnsRecord.content}');
    }
    final data = <String, dynamic>{
      'flags': int.parse(parts[0]),
      'tag': parts[1],
      'value': parts[2].replaceAll('"', ''),
    };
    return CloudflareDnsRecord(
      content: null,
      name: name,
      type: type,
      id: null,
      ttl: dnsRecord.ttl,
      data: data,
    );
  }
  return CloudflareDnsRecord(
    content: dnsRecord.content,
    name: name,
    type: type,
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
