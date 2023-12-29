/// Controls staging environment for network
class TlsOptions {
  /// Whether we request for staging temprorary certificates.
  /// Hardcode to 'true' in the middle of testing to not
  /// get your domain banned by constant certificate renewal
  ///
  /// If set to 'true', the 'verifyCertificate' becomes useless
  static bool stagingAcme = false;

  /// Should we consider CERTIFICATE_VERIFY_FAILED code an error
  /// For now it's just a global variable and DNS API
  /// classes can change it at will
  ///
  /// Doesn't matter if 'statingAcme' is set to 'true'
  static bool verifyCertificate = false;

  static bool allowCustomSshKeyDuringSetup = false;
}
