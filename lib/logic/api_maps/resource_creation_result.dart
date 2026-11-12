import 'package:selfprivacy/logic/api_maps/generic_result.dart';

enum ResourceCreationOutcome { confirmed, rejected, indeterminate }

ResourceCreationOutcome resourceCreationOutcomeForStatus(
  final int? statusCode,
) => switch (statusCode) {
  final code? when code >= 200 && code < 300 =>
    ResourceCreationOutcome.confirmed,
  400 ||
  401 ||
  403 ||
  404 ||
  409 ||
  422 ||
  429 => ResourceCreationOutcome.rejected,
  _ => ResourceCreationOutcome.indeterminate,
};

class ResourceCreationResult<T> extends GenericResult<T?> {
  ResourceCreationResult({
    required super.success,
    required super.data,
    required this.outcome,
    this.resourceId,
    super.message,
    super.code,
  });

  final ResourceCreationOutcome outcome;
  final String? resourceId;

  bool get wasCreated => outcome == ResourceCreationOutcome.confirmed;
}
