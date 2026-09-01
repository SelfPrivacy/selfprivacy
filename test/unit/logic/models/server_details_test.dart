import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';

import '../../../helpers/fixtures/server_fixtures.dart';

void main() {
  test('provider association preserves the GraphQL token age', () {
    final rotatedAt = DateTime.utc(2026, 8, 1);
    final details = aServerHostingDetails(apiTokenRotatedAt: rotatedAt);

    final updated = details.copyWith(
      providerId: '42',
      ip4: '198.51.100.42',
      createTime: DateTime.utc(2026, 7, 1),
      volume: aServerProviderVolume(id: 42, serverId: '42'),
      provider: ServerProviderType.digitalOcean,
      serverLocation: 'ams1',
    );

    expect(updated.providerId, '42');
    expect(updated.provider, ServerProviderType.digitalOcean);
    expect(updated.apiToken, details.apiToken);
    expect(updated.apiTokenRotatedAt, rotatedAt);
  });

  test('provider IDs remain opaque strings', () {
    final details = aServerHostingDetails(providerId: 'provider-server-uuid');
    final volume = aServerProviderVolume(serverId: 'provider-server-uuid');

    expect(details.providerId, 'provider-server-uuid');
    expect(volume.serverId, 'provider-server-uuid');
  });
}
