import 'package:gql/language.dart';
import 'package:graphql/client.dart';
import 'package:intl/intl.dart';

enum ConsoleLogSeverity {
  normal,
  warning,
}

/// Base entity for console logs.
///
/// TODO(misterfourtytwo): should we add?
///
/// * equality override
/// * translations of theese strings
sealed class ConsoleLog {
  ConsoleLog({
    final String? customTitle,
    this.severity = ConsoleLogSeverity.normal,
  })  : title = customTitle ??
            (severity == ConsoleLogSeverity.warning ? 'Error' : 'Log'),
        time = DateTime.now();

  final DateTime time;
  final ConsoleLogSeverity severity;
  bool get isError => severity == ConsoleLogSeverity.warning;

  /// title for both in listing and in dialog
  final String title;

  /// formatted data to be shown in listing
  String get content;

  /// data available for copy in dialog
  String? get shareableData => '$title\n'
      '{\n$content\n}';

  static final DateFormat _formatter = DateFormat('hh:mm:ss');
  String get timeString => _formatter.format(time);
}

class ManualConsoleLog extends ConsoleLog {
  ManualConsoleLog({
    required this.content,
    super.customTitle,
    super.severity,
  });

  ManualConsoleLog.warning({
    required this.content,
    super.customTitle,
  }) : super(severity: ConsoleLogSeverity.warning);

  @override
  String content;
}

class RestApiRequestConsoleLog extends ConsoleLog {
  RestApiRequestConsoleLog({
    this.method,
    this.uri,
    this.headers,
    this.data,
    super.severity,
  });

  final String? method;
  final Uri? uri;
  final Map<String, dynamic>? headers;
  final String? data;

  @override
  String get title => 'Rest API Request';
  @override
  String get content => 'method: $method\n'
      'uri: $uri';
}

class RestApiResponseConsoleLog extends ConsoleLog {
  RestApiResponseConsoleLog({
    this.method,
    this.uri,
    this.statusCode,
    this.data,
    super.severity,
  });

  final String? method;
  final Uri? uri;
  final int? statusCode;
  final String? data;

  @override
  String get title => 'Rest API Response';
  @override
  String get content => 'method: $method | status code: $statusCode\n'
      'uri: $uri';
}

class GraphQlRequestConsoleLog extends ConsoleLog {
  GraphQlRequestConsoleLog({
    this.operation,
    this.variables,
    this.context,
    super.severity,
  });

  final Context? context;
  final Operation? operation;
  final Map<String, dynamic>? variables;

  @override
  String get title => 'GraphQL Request';
  @override
  String get content => 'name: ${operation?.operationName}\n'
      'document: ${operation?.document != null ? printNode(operation!.document) : null}';
  String get stringifiedOperation => operation == null
      ? 'null'
      : 'Operation{\n'
          '\tname: ${operation?.operationName},\n'
          '\tdocument: ${operation?.document != null ? printNode(operation!.document) : null}\n'
          '}';
}

class GraphQlResponseConsoleLog extends ConsoleLog {
  GraphQlResponseConsoleLog({
    this.data,
    this.errors,
    this.context,
    super.severity,
  });

  final Context? context;
  final Map<String, dynamic>? data;
  final List<GraphQLError>? errors;

  @override
  String get title => 'GraphQL Response';
  @override
  String get content => 'data: $data';
}
