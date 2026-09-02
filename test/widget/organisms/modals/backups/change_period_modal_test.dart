import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/ui/organisms/modals/backups/change_period_modal.dart';

import '../../../../helpers/widget_harness.dart';

class _MockApiConnectionRepository extends Mock
    implements ApiConnectionRepository {}

class _MockBackupsBloc extends Mock implements BackupsBloc {}

void main() {
  setUpAll(setUpWidgetTestHarness);

  late _MockBackupsBloc backupsBloc;

  setUp(() async {
    await getIt.reset();
    getIt.registerSingleton<ApiConnectionRepository>(
      _MockApiConnectionRepository(),
    );
    backupsBloc = _MockBackupsBloc();
    when(() => backupsBloc.state).thenReturn(BackupsInitial());
    when(
      () => backupsBloc.stream,
    ).thenAnswer((_) => const Stream<BackupsState>.empty());
  });

  tearDown(getIt.reset);

  testWidgets('enables every automatic-backup period option', (
    final tester,
  ) async {
    final ScrollController scrollController = ScrollController();
    addTearDown(scrollController.dispose);

    await pumpForTest(
      tester,
      BlocProvider<BackupsBloc>.value(
        value: backupsBloc,
        child: ChangeAutobackupsPeriodModal(scrollController: scrollController),
      ),
    );

    final Finder periodOptions = find.byType(RadioListTile<Duration?>);
    expect(find.byType(RadioGroup<Duration?>), findsOneWidget);
    expect(periodOptions, findsNWidgets(6));

    for (var index = 0; index < 6; index++) {
      final Finder listTile = find.descendant(
        of: periodOptions.at(index),
        matching: find.byType(ListTile),
      );
      expect(tester.widget<ListTile>(listTile).enabled, isTrue);
    }

    await tester.tap(periodOptions.at(1));
    await tester.pump();

    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNotNull,
    );
  });
}
