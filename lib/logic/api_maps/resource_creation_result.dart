import 'package:selfprivacy/logic/api_maps/generic_result.dart';

class ResourceCreationResult<T> extends GenericResult<T?> {
  ResourceCreationResult({
    required super.success,
    required super.data,
    required this.wasCreated,
    this.resourceId,
    super.message,
    super.code,
  });

  final bool wasCreated;
  final String? resourceId;
}
