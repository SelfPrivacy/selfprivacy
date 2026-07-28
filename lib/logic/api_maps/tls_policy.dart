import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:selfprivacy/logic/get_it/developer_settings_model.dart';
import 'package:selfprivacy/utils/app_logger.dart';

const List<String> _stagingRootAssets = [
  'assets/certs/letsencrypt-stg-root-x1.pem',
  'assets/certs/letsencrypt-stg-root-x2.pem',
  'assets/certs/letsencrypt-stg-root-ye.pem',
  'assets/certs/letsencrypt-stg-root-yr.pem',
];

enum TlsPolicy { strict, allowUnverified }

class TlsContext {
  TlsContext(this._developerSettings);

  static final _log = const AppLogger(name: 'tls_context').log;

  final DeveloperSettingsModel _developerSettings;

  final List<Uint8List> _stagingRoots = [];
  HttpClient? _verifying;
  bool _verifyingTrustsStagingRoots = false;
  final Map<String, HttpClient> _permissive = {};

  Future<void> loadStagingRoots() async {
    for (final String asset in _stagingRootAssets) {
      try {
        final ByteData data = await rootBundle.load(asset);
        _stagingRoots.add(data.buffer.asUint8List());
      } catch (e) {
        _log('failed to load the staging ACME root $asset', error: e);
      }
    }
  }

  bool _isUnverified(final String host, final TlsPolicy policy) =>
      policy == TlsPolicy.allowUnverified ||
      _developerSettings.unverifiedTlsHost == host;

  HttpClient httpClientFor({
    required final String host,
    final TlsPolicy policy = TlsPolicy.strict,
  }) => _isUnverified(host, policy) ? _permissiveFor(host) : _verifyingClient();

  /// Wraps the shared [HttpClient] in the `http` package interface.
  ///
  /// Do not close the returned [IOClient]: it force-closes the wrapped
  /// [HttpClient], which every other request in the app also uses. A caller
  /// that closes its client, such as `HttpLink.dispose()`, needs its own.
  IOClient clientFor({
    required final String host,
    final TlsPolicy policy = TlsPolicy.strict,
  }) => IOClient(httpClientFor(host: host, policy: policy));

  HttpClient _permissiveFor(final String host) => _permissive.putIfAbsent(
    host,
    () => HttpClient()
      ..badCertificateCallback =
          (final X509Certificate cert, final String h, final int port) =>
              h == host,
  );

  HttpClient _verifyingClient() {
    final bool trustStagingRoots =
        _developerSettings.stagingAcme && _stagingRoots.isNotEmpty;
    if (_verifying != null &&
        _verifyingTrustsStagingRoots == trustStagingRoots) {
      return _verifying!;
    }
    _verifying?.close();
    _verifyingTrustsStagingRoots = trustStagingRoots;
    _verifying = HttpClient(
      context: trustStagingRoots ? _stagingContext() : null,
    );
    return _verifying!;
  }

  SecurityContext? _stagingContext() {
    final SecurityContext context = SecurityContext(withTrustedRoots: true);
    for (final Uint8List root in _stagingRoots) {
      try {
        context.setTrustedCertificatesBytes(root);
      } on TlsException catch (e) {
        _log('failed to trust a staging ACME root', error: e);
      }
    }
    return context;
  }

  void reset() {
    _verifying?.close();
    _verifying = null;
    for (final HttpClient client in _permissive.values) {
      client.close();
    }
    _permissive.clear();
  }
}
