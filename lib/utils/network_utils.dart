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
