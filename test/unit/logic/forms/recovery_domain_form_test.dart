import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/forms/recovery_domain_form.dart';

void main() {
  group('RecoveryDomainForm', () {
    test('requires a domain', () async {
      final form = RecoveryDomainForm(
        validateDomain: (final _) async => true,
        onSubmit: (final _) async {},
      );
      addTearDown(form.dispose);

      await form.submit();

      expect(form.form.valid, isFalse);
      expect(
        form.form.control(RecoveryDomainForm.domainControlName).touched,
        isTrue,
      );
    });

    test('does not submit an unreachable domain', () async {
      final validatedDomains = <String>[];
      final submittedDomains = <String>[];
      final form = RecoveryDomainForm(
        validateDomain: (final domain) async {
          validatedDomains.add(domain);
          return false;
        },
        onSubmit: (final domain) async => submittedDomains.add(domain),
      );
      addTearDown(form.dispose);
      form.form.control(RecoveryDomainForm.domainControlName).value =
          'Example.COM';

      await form.submit();

      expect(validatedDomains, equals(['Example.COM']));
      expect(submittedDomains, isEmpty);
      expect(
        form.form
            .control(RecoveryDomainForm.domainControlName)
            .errors
            .containsKey(RecoveryDomainForm.errDomainNotFound),
        isTrue,
      );
      expect(form.isSubmitting.value, isFalse);
    });

    test('submits the lowercase domain after it is reachable', () async {
      final validatedDomains = <String>[];
      final submittedDomains = <String>[];
      final form = RecoveryDomainForm(
        validateDomain: (final domain) async {
          validatedDomains.add(domain);
          return true;
        },
        onSubmit: (final domain) async => submittedDomains.add(domain),
      );
      addTearDown(form.dispose);
      form.form.control(RecoveryDomainForm.domainControlName).value =
          'Example.COM';

      await form.submit();

      expect(validatedDomains, equals(['Example.COM']));
      expect(submittedDomains, equals(['example.com']));
    });

    test(
      'prevents concurrent submissions and clears its remote error',
      () async {
        final submittedDomains = <String>[];
        final completer = Completer<void>();
        final form = RecoveryDomainForm(
          validateDomain: (final _) async => true,
          onSubmit: (final domain) {
            submittedDomains.add(domain);
            return completer.future;
          },
        );
        addTearDown(form.dispose);
        final control = form.form.control(RecoveryDomainForm.domainControlName)
        ..value = 'example.com';
        form..showDomainNotFoundError()
        ..clearDomainNotFoundError();
        final firstSubmit = form.submit();
        final secondSubmit = form.submit();

        await Future<void>.delayed(Duration.zero);

        expect(
          control.errors.containsKey(RecoveryDomainForm.errDomainNotFound),
          isFalse,
        );
        expect(form.isSubmitting.value, isTrue);
        expect(control.disabled, isTrue);
        expect(submittedDomains, equals(['example.com']));

        completer.complete();
        await Future.wait([firstSubmit, secondSubmit]);

        expect(form.isSubmitting.value, isFalse);
        expect(control.disabled, isFalse);
        expect(submittedDomains, hasLength(1));
      },
    );

    test('keeps a capability error reported during submission', () async {
      final completer = Completer<void>();
      late final RecoveryDomainForm form;
      form = RecoveryDomainForm(
        validateDomain: (final _) async => true,
        onSubmit: (final _) {
          form.showDomainNotFoundError();
          return completer.future;
        },
      );
      addTearDown(form.dispose);
      final control = form.form.control(RecoveryDomainForm.domainControlName)
      ..value = 'example.com';

      final submit = form.submit();
      await Future<void>.delayed(Duration.zero);
      completer.complete();
      await submit;

      expect(
        control.errors.containsKey(RecoveryDomainForm.errDomainNotFound),
        isTrue,
      );
    });
  });
}
