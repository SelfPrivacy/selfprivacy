import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sp_vcr/sp_vcr.dart';

import '../../../helpers/vcr/vcr_rest_api_client_factory.dart';

const _censorPolicy = CensorPolicy(
  headerKeys: <String>['Authorization'],
  jsonBodyKeys: <String>['authorizationToken'],
);

class _ResponseAdapter implements HttpClientAdapter {
  _ResponseAdapter(this.body);

  final String body;
  int fetchCount = 0;
  bool wasClosed = false;

  @override
  Future<ResponseBody> fetch(
    final RequestOptions options,
    final Stream<Uint8List>? requestStream,
    final Future<void>? cancelFuture,
  ) async {
    fetchCount++;
    await requestStream?.drain<void>();
    return ResponseBody.fromString(
      body,
      HttpStatus.ok,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  }

  @override
  void close({final bool force = false}) {
    wasClosed = true;
  }
}

void main() {
  late Directory temporaryDirectory;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'selfprivacy_vcr_factory_',
    );
  });

  tearDown(() async {
    await temporaryDirectory.delete(recursive: true);
  });

  test(
    'records censored traffic and replays it without a live request',
    () async {
      final cassette = Cassette(temporaryDirectory.path, 'provider');
      final recordAdapter = _ResponseAdapter(
        jsonEncode(<String, String>{
          'authorizationToken': 'response-secret',
          'accountId': 'safe-account-id',
        }),
      );
      final recordFactory = vcrRestApiClientFactory(
        cassette: cassette,
        mode: Mode.record,
        censorPolicy: _censorPolicy,
        liveClientFactory: (final options) =>
            Dio(options)..httpClientAdapter = recordAdapter,
      );
      final recordClient = recordFactory(
        BaseOptions(
          baseUrl: 'https://provider.example',
          headers: <String, String>{'Authorization': 'Bearer request-secret'},
        ),
      );

      final liveResponse = await recordClient.get<Map<String, dynamic>>('/me');
      recordClient.close();

      expect(dioResponseCameFromRecording(liveResponse), isFalse);
      expect(recordAdapter.fetchCount, 1);
      expect(recordAdapter.wasClosed, isTrue);
      final rawCassette = await File(
        '${temporaryDirectory.path}/provider.json',
      ).readAsString();
      expect(rawCassette, isNot(contains('request-secret')));
      expect(rawCassette, isNot(contains('response-secret')));
      expect(rawCassette, contains('safe-account-id'));

      final replayAdapter = _ResponseAdapter('must not be used');
      final replayFactory = vcrRestApiClientFactory(
        cassette: cassette,
        mode: Mode.replay,
        censorPolicy: _censorPolicy,
        liveClientFactory: (final options) =>
            Dio(options)..httpClientAdapter = replayAdapter,
      );
      final replayClient = replayFactory(
        BaseOptions(
          baseUrl: 'https://provider.example',
          headers: <String, String>{'Authorization': 'Bearer another-secret'},
        ),
      );

      final replayedResponse = await replayClient.get<Map<String, dynamic>>(
        '/me',
      );
      replayClient.close();

      expect(dioResponseCameFromRecording(replayedResponse), isTrue);
      expect(replayedResponse.data?['accountId'], 'safe-account-id');
      expect(replayAdapter.fetchCount, 0);
      expect(replayAdapter.wasClosed, isTrue);

      final autoAdapter = _ResponseAdapter('must not be used');
      final autoFactory = vcrRestApiClientFactory(
        cassette: cassette,
        mode: Mode.auto,
        censorPolicy: _censorPolicy,
        liveClientFactory: (final options) =>
            Dio(options)..httpClientAdapter = autoAdapter,
      );
      final autoClient = autoFactory(
        BaseOptions(
          baseUrl: 'https://provider.example',
          headers: <String, String>{'Authorization': 'Bearer auto-secret'},
        ),
      );

      final autoResponse = await autoClient.get<Map<String, dynamic>>('/me');
      autoClient.close();

      expect(dioResponseCameFromRecording(autoResponse), isTrue);
      expect(autoAdapter.fetchCount, 0);
      expect(autoAdapter.wasClosed, isTrue);
    },
  );

  test('bypass uses the live client without creating a cassette', () async {
    final cassette = Cassette(temporaryDirectory.path, 'bypass');
    final liveAdapter = _ResponseAdapter('{}');
    final factory = vcrRestApiClientFactory(
      cassette: cassette,
      mode: Mode.bypass,
      censorPolicy: _censorPolicy,
      liveClientFactory: (final options) =>
          Dio(options)..httpClientAdapter = liveAdapter,
    );
    final client = factory(BaseOptions(baseUrl: 'https://provider.example'));

    final response = await client.get<Map<String, dynamic>>('/me');
    client.close();

    expect(dioResponseCameFromRecording(response), isFalse);
    expect(liveAdapter.fetchCount, 1);
    expect(liveAdapter.wasClosed, isTrue);
    expect(
      File('${temporaryDirectory.path}/bypass.json').existsSync(),
      isFalse,
    );
  });
}
