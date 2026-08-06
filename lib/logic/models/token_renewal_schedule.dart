enum TokenRenewalState { noToken, dueNow, scheduled }

class TokenRenewalSchedule {
  const TokenRenewalSchedule._({required this.state, this.renewalAt});

  factory TokenRenewalSchedule.fromToken({
    required final String? token,
    required final DateTime? rotatedAt,
  }) {
    if (token == null || token.isEmpty) {
      return const TokenRenewalSchedule._(state: TokenRenewalState.noToken);
    }
    if (rotatedAt == null) {
      return const TokenRenewalSchedule._(state: TokenRenewalState.dueNow);
    }
    return TokenRenewalSchedule._(
      state: TokenRenewalState.scheduled,
      renewalAt: rotatedAt.add(interval),
    );
  }

  static const Duration interval = Duration(days: 30);

  final TokenRenewalState state;
  final DateTime? renewalAt;

  bool shouldRefreshAutomatically({
    required final bool enabled,
    required final DateTime now,
  }) =>
      enabled &&
      switch (state) {
        TokenRenewalState.noToken => false,
        TokenRenewalState.dueNow => true,
        TokenRenewalState.scheduled => !renewalAt!.isAfter(now),
      };
}
