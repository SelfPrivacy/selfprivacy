import 'dart:io';

import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:url_launcher/url_launcher.dart';

enum DnsRecordStatus { ok, waiting, nonexistent }

/// Check if DNS records were recognized.
///
/// Return pairs of full record name matched to its status.
///
/// If no record found, return just one pair of [domain] matched to critical non-existent status.
///
/// - [domain] - full domain delegated to SelfPrivacy (e.g. reimu.love)
/// - [subdomains] - list of all subdomains we want to validate recods of (e.g. api, cloud...)
/// - [ip4] - IP address of our server we want to validate DNS records by (e.g. 127.0.0.1)
Future<Map<String, DnsRecordStatus>> validateDnsMatch(
  final String domain,
  final List<String> subdomains,
  final String ip4,
) async {
  final Map<String, DnsRecordStatus> matches = <String, DnsRecordStatus>{};

  Future<void> lookup(final String address) async {
    await InternetAddress.lookup(address).then(
      (final records) {
        for (final record in records) {
          final bool isIpCorrect = record.address == ip4;
          matches[record.host] =
              isIpCorrect ? DnsRecordStatus.ok : DnsRecordStatus.waiting;
        }
      },
    );
  }

  try {
    await lookup(domain);
    for (final subdomain in subdomains) {
      await lookup('$subdomain.$domain');
    }
  } catch (e) {
    print(e);
  }

  if (matches.isEmpty) {
    matches[domain] = DnsRecordStatus.nonexistent;
  }

  return matches;
}

DnsRecord? extractDkimRecord(final List<DnsRecord> records) {
  DnsRecord? dkimRecord;

  for (final DnsRecord record in records) {
    if (record.type == 'TXT' && record.name == 'selector._domainkey') {
      dkimRecord = record;
    }
  }

  return dkimRecord;
}

String getHostnameFromDomain(final String domain) {
  // Replace all non-alphanumeric characters with an underscore
  String hostname =
      domain.split('.')[0].replaceAll(RegExp(r'[^a-zA-Z0-9]'), '-');
  if (hostname.endsWith('-')) {
    hostname = hostname.substring(0, hostname.length - 1);
  }
  if (hostname.startsWith('-')) {
    hostname = hostname.substring(1);
  }
  if (hostname.isEmpty) {
    hostname = 'selfprivacy-server';
  }

  return hostname;
}

void launchURL(final url) async {
  try {
    final Uri uri = Uri.parse(url);
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    print(e);
  }
}

List<DnsRecord> getProjectDnsRecords(
  final String? domainName,
  final String? ip4,
) {
  final DnsRecord domainA =
      DnsRecord(type: 'A', name: domainName, content: ip4);

  final DnsRecord mx = DnsRecord(type: 'MX', name: '@', content: domainName);
  final DnsRecord apiA = DnsRecord(type: 'A', name: 'api', content: ip4);
  final DnsRecord cloudA = DnsRecord(type: 'A', name: 'cloud', content: ip4);
  final DnsRecord gitA = DnsRecord(type: 'A', name: 'git', content: ip4);
  final DnsRecord meetA = DnsRecord(type: 'A', name: 'meet', content: ip4);
  final DnsRecord passwordA =
      DnsRecord(type: 'A', name: 'password', content: ip4);
  final DnsRecord socialA = DnsRecord(type: 'A', name: 'social', content: ip4);
  final DnsRecord vpn = DnsRecord(type: 'A', name: 'vpn', content: ip4);

  final DnsRecord txt1 = DnsRecord(
    type: 'TXT',
    name: '_dmarc',
    content: 'v=DMARC1; p=none',
    ttl: 18000,
  );

  final DnsRecord txt2 = DnsRecord(
    type: 'TXT',
    name: domainName,
    content: 'v=spf1 a mx ip4:$ip4 -all',
    ttl: 18000,
  );

  return <DnsRecord>[
    domainA,
    apiA,
    cloudA,
    gitA,
    meetA,
    passwordA,
    socialA,
    mx,
    txt1,
    txt2,
    vpn,
  ];
}
