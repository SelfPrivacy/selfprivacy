import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/models/token_renewal_schedule.dart';

void main() {
  final now = DateTime.utc(2026, 8, 6, 12);

  test('there is no renewal without a token', () {
    final schedule = TokenRenewalSchedule.fromToken(
      token: null,
      rotatedAt: null,
    );

    expect(schedule.state, TokenRenewalState.noToken);
    expect(
      schedule.shouldRefreshAutomatically(enabled: true, now: now),
      isFalse,
    );
  });

  test('a token without a timestamp is due now', () {
    final schedule = TokenRenewalSchedule.fromToken(
      token: 'token',
      rotatedAt: null,
    );

    expect(schedule.state, TokenRenewalState.dueNow);
    expect(
      schedule.shouldRefreshAutomatically(enabled: true, now: now),
      isTrue,
    );
  });

  test('a fresh token is due 30 days after rotation', () {
    final rotatedAt = now.subtract(const Duration(days: 12));
    final schedule = TokenRenewalSchedule.fromToken(
      token: 'token',
      rotatedAt: rotatedAt,
    );

    expect(schedule.state, TokenRenewalState.scheduled);
    expect(schedule.renewalAt, rotatedAt.add(const Duration(days: 30)));
    expect(
      schedule.shouldRefreshAutomatically(enabled: true, now: now),
      isFalse,
    );
  });

  test('an overdue token refreshes automatically', () {
    final schedule = TokenRenewalSchedule.fromToken(
      token: 'token',
      rotatedAt: now.subtract(const Duration(days: 31)),
    );

    expect(
      schedule.shouldRefreshAutomatically(enabled: true, now: now),
      isTrue,
    );
  });

  test('the developer setting disables an overdue refresh', () {
    final schedule = TokenRenewalSchedule.fromToken(
      token: 'token',
      rotatedAt: now.subtract(const Duration(days: 31)),
    );

    expect(
      schedule.shouldRefreshAutomatically(enabled: false, now: now),
      isFalse,
    );
  });
}
