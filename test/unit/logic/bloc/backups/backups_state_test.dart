import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/backups.graphql.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/logic/models/backup.dart';

import '../../../../helpers/fixtures/backup_fixtures.dart';
import '../../../../helpers/fixtures/json_fixture.dart';

void main() {
  test('state retains its supplied snapshot and sorts without mutation', () {
    final backups = Query$AllBackupSnapshots.fromJson(
      loadJsonFixture('graphql/domain_reads.json')['AllBackupSnapshots']
          as Map<String, dynamic>,
    ).backup.allSnapshots.map(Backup.fromGraphQL).toList();
    final original = List<Backup>.of(backups);
    final config = aBackupConfiguration();
    final state = BackupsInitialized(backups: backups, backupConfig: config);
    expect(state.backups, hasLength(original.length));
    expect(backups, original);
    backups.clear();
    expect(state.backups, hasLength(original.length));
    expect(state.autobackupQuotas, config.autobackupQuotas);
    expect(() => state.backups.clear(), throwsUnsupportedError);
    expect(BackupsBusy.fromState(state).backups, state.backups);
  });
}
