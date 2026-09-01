import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:uuid/uuid.dart';

import '../../../helpers/fixtures/server_fixtures.dart';

void main() {
  test('Server.create assigns a unique UUID v4', () {
    final Server first = Server.create(
      hostingDetails: aServerHostingDetails(),
      domain: aServerDomain(),
    );
    final Server second = Server.create(
      hostingDetails: aServerHostingDetails(),
      domain: aServerDomain(),
    );

    expect(Uuid.isValidUUID(fromString: first.uuid), isTrue);
    expect(first.uuid[14], '4');
    expect(second.uuid, isNot(first.uuid));
  });
}
