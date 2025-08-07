import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

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
    await InternetAddress.lookup(address).then((final records) {
      for (final record in records) {
        final bool isIpCorrect = record.address == ip4;
        matches[record.host] =
            isIpCorrect ? DnsRecordStatus.ok : DnsRecordStatus.waiting;
      }
    });
  }

  try {
    await lookup(domain);
    for (final subdomain in subdomains) {
      await lookup('$subdomain.$domain');
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
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
  String hostname = domain
      .split('.')[0]
      .replaceAll(RegExp('[^a-zA-Z0-9]'), '-');
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

List<DnsRecord> getProjectDnsRecords({
  required final bool isCreating,
  final String? domainName,
  final String? ip4,
}) {
  final DnsRecord domainA = DnsRecord(
    type: 'A',
    name: domainName,
    content: ip4,
  );

  final DnsRecord mx = DnsRecord(type: 'MX', name: '@', content: domainName);
  final DnsRecord apiA = DnsRecord(type: 'A', name: 'api', content: ip4);
  final DnsRecord kanidmA = DnsRecord(type: 'A', name: 'auth', content: ip4);
  final DnsRecord cloudA = DnsRecord(type: 'A', name: 'cloud', content: ip4);

  const DnsRecord txt1 = DnsRecord(
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

  /// We never create this record!
  /// This declaration is only for removal
  /// as we need to compare by 'type' and 'name'
  const DnsRecord txt3 = DnsRecord(
    type: 'TXT',
    name: 'selector._domainkey',
    content: 'v=DKIM1; k=rsa; p=none',
    ttl: 18000,
  );

  return <DnsRecord>[
    domainA,
    apiA,
    kanidmA,
    cloudA,
    mx,
    txt1,
    txt2,
    if (!isCreating) txt3,
  ];
}
