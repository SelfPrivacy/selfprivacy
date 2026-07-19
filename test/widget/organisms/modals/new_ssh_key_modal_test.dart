import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/ui/organisms/modals/new_ssh_key_modal.dart';

import '../../../helpers/widget_harness.dart';

const _validKey =
    'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+y1mUS1rFbuy2V5ndMWBwS4AavxjSt0JQGwUhddu1h user@host';

const _user = User.fake(login: 'alice', sshKeys: []);

class MockJobsCubit extends Mock implements JobsCubit {}

FilledButton _submitButton(final WidgetTester tester) => tester
    .widget<FilledButton>(find.widgetWithText(FilledButton, 'Add an SSH key'));

Future<void> _pumpModal(
  final WidgetTester tester, {
  required final JobsCubit jobsCubit,
  required final User user,
}) async {
  final controller = ScrollController();
  addTearDown(controller.dispose);

  await tester.runAsync(() async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        useFallbackTranslations: true,
        saveLocale: false,
        child: Builder(
          builder: (final context) => MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: Scaffold(
              body: Builder(
                builder: (final context) => TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (final _) => BlocProvider<JobsCubit>.value(
                        value: jobsCubit,
                        child: Scaffold(
                          body: NewSshKeyModal(
                            user: user,
                            scrollController: controller,
                          ),
                        ),
                      ),
                    ),
                  ),
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await Future<void>.delayed(Duration.zero);
  });
  await tester.pumpAndSettle();

  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() async {
    await setUpWidgetTestHarness();
    registerFallbackValue(CreateSSHKeyJob(user: _user, publicKey: _validKey));
  });

  late MockJobsCubit jobsCubit;

  setUp(() {
    jobsCubit = MockJobsCubit();
    when(() => jobsCubit.state).thenReturn(JobsStateEmpty());
    when(() => jobsCubit.stream).thenAnswer((_) => const Stream<JobsState>.empty());
  });

  group('NewSshKeyModal', () {
    testWidgets('renders the key text field', (final tester) async {
      await _pumpModal(tester, jobsCubit: jobsCubit, user: _user);

      expect(find.byType(ReactiveTextField<String>), findsOneWidget);
      expect(find.text('alice'), findsOneWidget);
    });

    testWidgets('keeps submit disabled for a key the user already has', (
      final tester,
    ) async {
      await _pumpModal(
        tester,
        jobsCubit: jobsCubit,
        user: const User.fake(login: 'alice', sshKeys: [_validKey]),
      );

      await tester.enterText(find.byType(ReactiveTextField<String>), _validKey);
      await tester.pumpAndSettle();

      expect(_submitButton(tester).onPressed, isNull);
      verifyNever(() => jobsCubit.addJob(any()));
    });

    testWidgets('valid submit adds a CreateSSHKeyJob and pops the modal', (
      final tester,
    ) async {
      await _pumpModal(tester, jobsCubit: jobsCubit, user: _user);

      await tester.enterText(find.byType(ReactiveTextField<String>), _validKey);
      await tester.pumpAndSettle();

      expect(_submitButton(tester).onPressed, isNotNull);

      await tester.tap(find.widgetWithText(FilledButton, 'Add an SSH key'));
      await tester.pumpAndSettle();

      verify(
        () => jobsCubit.addJob(
          any(
            that: isA<CreateSSHKeyJob>()
                .having((final j) => j.publicKey, 'publicKey', _validKey)
                .having((final j) => j.user.login, 'user.login', 'alice'),
          ),
        ),
      ).called(1);
      expect(find.byType(NewSshKeyModal), findsNothing);
    });
  });
}
