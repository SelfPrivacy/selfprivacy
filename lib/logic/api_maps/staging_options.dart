/// Controls staging environment for network, is used during manual
/// integration testing and such
class StagingOptions {
  /// Whether we request for staging temprorary certificates.
  /// Hardcode to 'true' in the middle of testing to not
  /// get your domain banned by constant certificate renewal
  static bool get stagingAcme => true;
}
