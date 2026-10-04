enum RotationStatus { idle, waiting, rotating, suppressed }

enum RotationOutcome {
  succeeded,
  rejected,
  unknown,
  suppressed,
  cancelled,
  detached,
}

class RotationState {
  const RotationState(this.status);
  final RotationStatus status;
  bool get canCancel => status == RotationStatus.waiting;
}

class TokenRotationHistory {
  final suppressedTokens = <String?>{};
  String? unsavedToken;
  (String?, DateTime)? lastAttempt;

  void acceptCredential(final String? token) {
    if (!suppressedTokens.contains(token)) {
      suppressedTokens.clear();
      unsavedToken = null;
    }
  }
}
