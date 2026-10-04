import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/operations_cubit.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/ui/molecules/cards/server_job_card.dart';
import 'package:selfprivacy/ui/organisms/jobs/jobs_content.dart';
import 'package:selfprivacy/ui/organisms/jobs/operation_card.dart';
import 'package:selfprivacy/utils/show_jobs_modal.dart';

import '../../../tool/widgetbook/fixtures/catalog_fixtures.dart';
import '../../../tool/widgetbook/fixtures/models.dart';
import '../../helpers/fixtures/backup_fixtures.dart';
import '../../helpers/widget_harness.dart';

void main() {
  setUpAll(setUpWidgetTestHarness);
  testWidgets('section headings share padding independently of card actions', (
    final tester,
  ) async {
    final fixtures = CatalogFixtures('Postponed', (_) {});
    addTearDown(fixtures.dispose);
    fixtures
      ..bind(
        fixtures.operations,
        OperationsState(operations: [demoOperation('Finished')], focusId: 1),
      )
      ..bind(
        fixtures.serverJobs,
        ServerJobsListWithJobsState(
          serverJobList: [aBackupJob(status: JobStatusEnum.finished)],
        ),
      );
    final controller = ScrollController();
    addTearDown(controller.dispose);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.view.devicePixelRatio = 1;
    for (final width in [390.0, 560.0]) {
      tester.view.physicalSize = Size(width, 1200);
      await pumpForTest(
        tester,
        fixtures.wrap(JobsContent(controller: controller)),
      );
      for (final title in [
        'Unsent changes',
        'Operations',
        'Jobs on the server',
      ]) {
        expect(tester.getTopLeft(find.text(title)).dx, 24);
      }
      expect(tester.getCenter(find.byIcon(Icons.clear_all)).dx, width - 48);
      expect(find.byIcon(Icons.close), findsNWidgets(2));
      final card = find.byType(ServerJobCard);
      final status = find.descendant(
        of: card,
        matching: find.byIcon(Icons.check_circle_outline),
      );
      final remove = find.descendant(
        of: card,
        matching: find.byIcon(Icons.close),
      );
      final button = find.descendant(
        of: card,
        matching: find.byType(IconButton),
      );
      expect(tester.getCenter(status).dy, tester.getCenter(remove).dy);
      expect(tester.getCenter(remove), tester.getCenter(button));
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets(
    'swipe requests deletion but retains the job until state confirms it',
    (final tester) async {
      final fixtures = CatalogFixtures('Empty', (_) {});
      addTearDown(fixtures.dispose);
      fixtures.bind(
        fixtures.serverJobs,
        ServerJobsListWithJobsState(
          serverJobList: [
            aBackupJob(uid: 'finished', status: JobStatusEnum.finished),
          ],
        ),
      );
      final controller = ScrollController();
      fixtures.serverJobs.record = null;
      addTearDown(controller.dispose);
      await pumpForTest(
        tester,
        fixtures.wrap(JobsContent(controller: controller)),
      );
      await tester.drag(find.byType(ServerJobCard), const Offset(-600, 0));
      await tester.pumpAndSettle();
      verify(
        () => fixtures.serverJobs.add(const RemoveServerJob('finished')),
      ).called(1);
      expect(find.byType(ServerJobCard), findsOneWidget);
    },
  );

  testWidgets('related jobs appear only inside their operation', (
    final tester,
  ) async {
    final fixtures = CatalogFixtures('Empty', (_) {});
    addTearDown(fixtures.dispose);
    fixtures.bind(
      fixtures.serverJobs,
      ServerJobsListWithJobsState(
        serverJobList: [
          aBackupJob(uid: 'related'),
          aBackupJob(uid: 'standalone'),
        ],
      ),
    );
    final queue = OperationQueue(serverId: 'server');
    addTearDown(queue.dispose);
    final operations = OperationsCubit(
      queue: queue,
      remove: (_) async => false,
      showMessage: (_) {},
    );
    addTearDown(operations.close);
    await queue
        .submit(
          OperationKind.createBackups,
          () async {},
          describe: (_) =>
              OperationReport(OperationStatus.accepted, jobIds: {'related'}),
        )
        .result;
    await tester.pump();
    final controller = ScrollController();
    addTearDown(controller.dispose);
    await pumpForTest(
      tester,
      fixtures.wrap(
        BlocProvider.value(
          value: operations,
          child: JobsContent(controller: controller),
        ),
      ),
    );
    expect(find.byType(OperationCard), findsOneWidget);
    final grouped = find.descendant(
      of: find.byType(OperationCard),
      matching: find.byType(ServerJobCard),
    );
    expect(tester.widget<ServerJobCard>(grouped).serverJob.uid, 'related');
    expect(find.byType(ServerJobCard), findsNWidgets(2));
  });

  testWidgets(
    'opening progress twice uses one sheet and retains its providers',
    (final tester) async {
      final fixtures = CatalogFixtures('Empty', (_) {});
      addTearDown(fixtures.dispose);
      await pumpForTest(
        tester,
        fixtures.wrap(
          Builder(
            builder: (final context) => TextButton(
              onPressed: () {
                unawaited(showModalJobsSheet(context: context));
                unawaited(showModalJobsSheet(context: context));
              },
              child: const Text('Open'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.byType(JobsContent), findsOneWidget);
      expect(fixtures.operations.sheetOpen, isTrue);
      Navigator.of(tester.element(find.byType(JobsContent))).pop();
      await tester.pumpAndSettle();
      expect(fixtures.operations.sheetOpen, isFalse);
    },
  );
}
