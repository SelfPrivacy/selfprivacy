import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/backblaze.dart';

import '../../../helpers/fixtures/backup_fixtures.dart';
import '../../../helpers/fixtures/credential_fixtures.dart';
import '../../../helpers/fixtures/json_fixture.dart';

void main() {
  setUp(() => getIt.registerSingleton<ConsoleModel>(ConsoleModel()));
  tearDown(getIt.reset);

  test(
    'bucket and key requests use the authorized account, not the key ID',
    () async {
      final requests = <RequestOptions>[];
      final bucket = loadJsonFixture('backups_providers/backblaze/bucket.json');
      final api = BackblazeApi(
        tokenId: 'application-key-id',
        token: 'application-key-secret',
        clientFactory: (final options) => Dio(options)
          ..interceptors.add(
            InterceptorsWrapper(
              onRequest: (final request, final handler) {
                requests.add(request);
                final data = switch (request.uri.path.split('/').last) {
                  'b2_authorize_account' => loadJsonFixture(
                    'backups_providers/backblaze/account.json',
                  ),
                  'b2_create_key' => loadJsonFixture(
                    'backups_providers/backblaze/key.json',
                  ),
                  'b2_list_buckets' => {
                    'buckets': [bucket],
                  },
                  _ => bucket,
                };
                handler.resolve(
                  Response<dynamic>(
                    requestOptions: request,
                    statusCode: 200,
                    data: data,
                  ),
                );
              },
            ),
          ),
      );
      expect(
        (await api.createBucket('selfprivacy-example-backups')).data,
        'bucket-test',
      );
      expect(
        (await api.createKey('bucket-test')).data.applicationKeyId,
        'restricted-key-id',
      );
      await api.fetchBucket(aBackupsCredential(), aBackupConfiguration());
      final accountRequests = requests
          .where(
            (final request) => !request.path.endsWith('b2_authorize_account'),
          )
          .toList();
      expect(accountRequests, hasLength(3));
      for (final request in accountRequests) {
        final arguments = request.method == 'GET'
            ? request.queryParameters
            : request.data as Map;
        expect(arguments['accountId'], 'authorized-account');
        expect(request.headers['Authorization'], 'test-auth-token');
      }
    },
  );
}
