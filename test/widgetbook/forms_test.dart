import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/forms/checks/credential_check_state.dart';
import 'package:selfprivacy/logic/forms/user_form.dart';
import 'package:selfprivacy/ui/forms/credential_check_error.dart';
import 'package:selfprivacy/ui/forms/dns_provider_form_view.dart';
import 'package:selfprivacy/ui/forms/recovery_device_form_view.dart';
import 'package:selfprivacy/ui/forms/server_provider_form_view.dart';
import 'package:selfprivacy/ui/forms/user_form_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../tool/widgetbook/catalog_case.dart';
import '../../tool/widgetbook/main.dart';
import '../../tool/widgetbook/use_cases/forms/dns_provider_form_view.dart';
import '../../tool/widgetbook/use_cases/forms/recovery_device_form_view.dart';
import '../../tool/widgetbook/use_cases/forms/server_provider_form_view.dart';
import '../../tool/widgetbook/use_cases/forms/user_form_view.dart';
import 'behavior_test.dart' show pumpCase;

class _Context extends Mock implements BuildContext {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('prepared forms open inside the Widgetbook shell', (
    final tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(
      const CatalogApp(
        initialRoute: '/?path=forms/serverproviderformview/rejected',
      ),
    );
    for (
      var attempt = 0;
      attempt < 100 && find.byType(CredentialCheckError).evaluate().isEmpty;
      attempt++
    ) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 10)),
      );
      await tester.pump();
    }
    expect(find.byType(CredentialCheckError), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
    'credential rejection clears on edit and valid submission stays local',
    (final tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await pumpCase(
        tester,
        serverProviderFormViewRejected(_Context()) as CatalogCase,
      );
      expect(find.byType(CredentialCheckError), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'edited-token');
      await tester.pump();
      expect(find.byType(CredentialCheckError), findsNothing);
      await pumpCase(
        tester,
        serverProviderFormViewReady(_Context()) as CatalogCase,
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pump();
      expect(catalogActions.value, contains('Form submitted (preview)'));
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets('leaving a checking form cancels its pending preview work', (
    final tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await pumpCase(
      tester,
      serverProviderFormViewChecking(_Context()) as CatalogCase,
    );
    final checking = tester
        .widget<ServerProviderFormView>(find.byType(ServerProviderFormView))
        .serverProviderForm;
    expect(checking.credentialCheckState.value, isA<CredentialCheckRunning>());
    expect(checking.form.disabled, isTrue);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    await pumpCase(
      tester,
      serverProviderFormViewEmpty(_Context()) as CatalogCase,
    );
    final empty = tester
        .widget<ServerProviderFormView>(find.byType(ServerProviderFormView))
        .serverProviderForm;
    expect(empty.form.disabled, isFalse);
    expect(empty.form.control('apiKey').value, isNull);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('Porkbun credentials include both required fields', (
    final tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await pumpCase(
      tester,
      dnsProviderFormViewPorkbunRequired(_Context()) as CatalogCase,
    );
    final form = tester
        .widget<DnsProviderFormView>(find.byType(DnsProviderFormView))
        .dnsProviderForm;
    expect(form.form.controls.keys, unorderedEquals(['token', 'tokenId']));
    expect(form.form.valid, isFalse);
    expect(find.text('Required'), findsNWidgets(2));
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
    'recovery examples use valid mnemonics with the required word counts',
    (final tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      for (final entry in {
        recoveryDeviceFormViewRecoveryKey: 18,
        recoveryDeviceFormViewNewDeviceKey: 12,
      }.entries) {
        await pumpCase(tester, entry.key(_Context()) as CatalogCase);
        final form = tester
            .widget<RecoveryDeviceFormView>(find.byType(RecoveryDeviceFormView))
            .recoveryDeviceForm;
        expect(form.form.valid, isTrue);
        expect(
          (form.form.control('token').value as String).split(' '),
          hasLength(entry.value),
        );
      }
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets(
    'editing a user locks the login and group selection updates the real form',
    (final tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await pumpCase(tester, userFormViewEdit(_Context()) as CatalogCase);
      final form = tester
          .widget<UserFormView>(find.byType(UserFormView))
          .userForm;
      expect(form.form.control(UserForm.loginControlName).disabled, isTrue);
      expect(form.form.control(UserForm.groupsControlName).value, [
        'sp.admins',
      ]);
      await tester.tap(find.text('Full user'));
      await tester.pump();
      expect(form.form.control(UserForm.groupsControlName).value, [
        'sp.full_users',
      ]);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
}
