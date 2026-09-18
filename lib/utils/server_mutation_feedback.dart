import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';

String serverMutationMessage<T>(
  final ServerMutationResult<T> result, {
  final bool sensitive = false,
}) {
  final message = sensitive || result.message?.trim().isNotEmpty != true
      ? null
      : result.message;
  final payload = result.payload.value;
  return switch (result.outcome) {
    ServerMutationOutcome.indeterminate =>
      'server_mutation.outcome_unknown'.tr(),
    ServerMutationOutcome.rejected =>
      message ?? 'server_mutation.rejected'.tr(),
    ServerMutationOutcome.confirmed
        when result.payload.status == ServerMutationPayloadStatus.missing ||
            result.payload.status == ServerMutationPayloadStatus.unreadable ||
            (sensitive &&
                payload is String &&
                nonEmptySecret(payload) == null) =>
      'server_mutation.payload_unavailable'.tr(),
    ServerMutationOutcome.confirmed => message ?? 'basis.done'.tr(),
  };
}
