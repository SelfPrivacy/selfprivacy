import 'package:flutter/foundation.dart';

/// internal app configuration
const config = InternalConfig(shouldDebugPrint: kDebugMode);

class InternalConfig {
  const InternalConfig({required this.shouldDebugPrint});

  final bool shouldDebugPrint;

  // example of other possible fields
  // final String appVersion;
  //
}
