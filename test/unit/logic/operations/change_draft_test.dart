import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/operations/change_draft.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

import '../../../helpers/widget_harness.dart';

void main() {
  setUpAll(setUpWidgetTestHarness);
  late ChangeDraft draft;
  var attached = true;
  setUp(() {
    attached = true;
    draft = ChangeDraft(isAttached: () => attached);
  });
  tearDown(() => draft.dispose());

  test('service replacement preserves changes for other services', () {
    final mail = ChangeServiceConfiguration(
      serviceId: 'mailserver',
      serviceDisplayName: 'Mail server',
      settings: const {'subdomain': 'mail'},
    );
    final nextcloud = ChangeServiceConfiguration(
      serviceId: 'nextcloud',
      serviceDisplayName: 'Nextcloud',
      settings: const {'subdomain': 'files'},
    );
    draft
      ..add(mail)
      ..add(nextcloud);
    final previous = draft.value;
    final replacement = ChangeServiceConfiguration(
      serviceId: 'mailserver',
      serviceDisplayName: 'Mail server',
      settings: const {'subdomain': 'post'},
    );
    draft.add(replacement);
    expect(draft.value, [nextcloud, replacement]);
    expect(previous, [mail, nextcloud]);
    expect(draft.value.clear, throwsUnsupportedError);
    expect(previous.clear, throwsUnsupportedError);
  });

  for (final status in [
    OperationStatus.notSent,
    OperationStatus.cancelled,
    OperationStatus.unknown,
    OperationStatus.rejected,
  ]) {
    test('$status restores only changes known not sent', () async {
      final submitted = ChangeServerTimezoneJob(timezone: 'UTC');
      draft.add(submitted);
      final held = Completer<OperationResult<void>>();
      var calls = 0;
      final applying = draft.apply((final changes) {
        calls++;
        expect(changes, [submitted]);
        expect(changes.clear, throwsUnsupportedError);
        return held.future;
      });
      await draft.apply((_) async {
        calls++;
        return const OperationResult(OperationStatus.succeeded);
      });
      expect(calls, 1);
      expect(draft.value, isEmpty);
      held.complete(OperationResult(status));
      await applying;
      expect(
        draft.value,
        status == OperationStatus.notSent || status == OperationStatus.cancelled
            ? [submitted]
            : isEmpty,
      );
    });
  }

  test('newer decisions win when a cancelled submission returns', () async {
    draft.add(ChangeServerTimezoneJob(timezone: 'UTC'));
    final held = Completer<OperationResult<void>>();
    final applying = draft.apply((_) => held.future);
    final newer = ChangeServerTimezoneJob(timezone: 'Europe/Berlin');
    draft.add(newer);
    held.complete(const OperationResult(OperationStatus.cancelled));
    await applying;
    expect(draft.value, [newer]);
  });

  for (final dispose in [false, true]) {
    test(
      'inactive draft does not restore a held submission: dispose=$dispose',
      () async {
        draft.add(ChangeServerTimezoneJob(timezone: 'UTC'));
        final held = Completer<OperationResult<void>>();
        final applying = draft.apply((_) => held.future);
        if (dispose) {
          draft.dispose();
        } else {
          attached = false;
        }
        held.complete(const OperationResult(OperationStatus.notSent));
        await applying;
        expect(draft.value, isEmpty);
        expect(draft.add(ChangeSshSettingsJob(enable: false)), isFalse);
      },
    );
  }
}
