import 'package:dio/dio.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/rest_api_map.dart';
import 'package:sp_vcr/sp_vcr.dart';

import '../../cassettes/provider_censors.dart';

RestApiClientFactory vcrRestApiClientFactory({
  required final Cassette cassette,
  required final Mode mode,
  required final CensorPolicy censorPolicy,
  final RestApiClientFactory? liveClientFactory,
}) {
  final vcr = VCR(
    advancedOptions: AdvancedOptions(censors: providerCensors(censorPolicy)),
  )..insert(cassette);

  switch (mode) {
    case Mode.auto:
      vcr.recordIfNeeded();
    case Mode.record:
      vcr.record();
    case Mode.replay:
      vcr.replay();
    case Mode.bypass:
      vcr.pause();
  }

  final RestApiClientFactory createLiveClient = liveClientFactory ?? Dio.new;
  return (final options) {
    final dio = createLiveClient(options);
    vcr.attach(dio);
    return dio;
  };
}
