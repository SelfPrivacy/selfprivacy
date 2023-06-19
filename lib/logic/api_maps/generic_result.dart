class GenericResult<T> {
  GenericResult({
    required this.success,
    required this.data,
    this.message,
    this.code,
  });

  /// Whether was a response successfully received,
  /// doesn't represent success of the request if `data<T>` is `bool`
  final bool success;
  final String? message;
  final T data;
  final int? code;
}
