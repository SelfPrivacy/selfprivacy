import 'package:bip39_mnemonic/bip39_mnemonic.dart';

final referenceTime = DateTime.utc(2026, 1, 15, 12);
DateTime fixedNow() => referenceTime;
final demoMnemonic = Mnemonic(
  List<int>.generate(16, (final index) => index),
  Language.english,
).sentence;
final demoBackupKey = List<String>.filled(
  8,
  'Q2F0YWxvZyBvbmx5IGJhY2t1cCBlbmNyeXB0aW9uIGtleS4=',
).join();
const demoKey =
    'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+y1mUS1rFbuy2V5ndMWBwS4AavxjSt0JQGwUhddu1h alice@example.org';
const demoSvg =
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path fill="currentColor" d="M3 3h18v8H3zm0 10h18v8H3z"/></svg>';
