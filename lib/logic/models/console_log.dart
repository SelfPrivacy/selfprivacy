import 'dart:convert';

import 'package:gql/language.dart' as gql;
import 'package:graphql/client.dart' as gql_client;
import 'package:intl/intl.dart';

enum ConsoleLogSeverity { normal, warning }

/// Base entity for console logs.
sealed class ConsoleLog {
  ConsoleLog({
    final String? customTitle,
    this.severity = ConsoleLogSeverity.normal,
  }) : title =
           customTitle ??
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
  String? get shareableData =>
      '{"title": "$title",\n'
      '"timestamp": "$fullUTCString",\n'
      '"data":{\n$content\n}'
      '\n}';

  static final DateFormat _formatter = DateFormat('HH:mm:ss');
  String get timeString => _formatter.format(time);

  String get fullUTCString => time.toUtc().toIso8601String();
}

abstract class LogWithRawResponse {
  String get rawResponse;
}

/// entity for manually created logs, as opposed to automated ones coming
/// from requests / responses
class ManualConsoleLog extends ConsoleLog {
  ManualConsoleLog({required this.content, super.customTitle, super.severity});

  ManualConsoleLog.warning({required this.content, super.customTitle})
    : super(severity: ConsoleLogSeverity.warning);

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

  /// headers thath should not be included into clipboard buffer, as opposed to
  /// `[[ConsoleLogItemDialog]]` `_KeyValueRow.hideList` which filters values,
  /// that should be accessible from UI, but hidden in screenshots
  static const blacklistedHeaders = ['Authorization'];

  final String? method;
  final Uri? uri;
  final Map<String, dynamic>? headers;
  final String? data;

  @override
  String get title => 'Rest API Request';

  Map<String, dynamic> get filteredHeaders => Map.fromEntries(
    headers?.entries.where(
          (final entry) => !blacklistedHeaders.contains(entry.key),
        ) ??
        const [],
  );

  @override
  String get content =>
      '"method": "$method",\n'
      '"uri": "$uri",\n'
      '"headers": ${jsonEncode(filteredHeaders)},\n' // censor header to not expose API keys
      '"data": $data';
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
  String get content =>
      '"method": "$method",\n'
      '"status_code": $statusCode,\n'
      '"uri": "$uri",\n'
      '"data": $data';
}

/// there is no actual getter for context fields outside of its class
/// one can extract unique entries by their type, which implements
/// `ContextEntry` class, I'll leave the code here if in the future
/// some entries will actually be needed.
// extension ContextEncoder on gql_client.Context {
//   String get encode {
//     return '""';
//   }
// }

class GraphQlRequestConsoleLog extends ConsoleLog {
  GraphQlRequestConsoleLog({
    required this.operationType,
    required this.operation,
    required this.variables,
    // this.context,
    super.severity,
  });

  // final gql_client.Context? context;
  final String operationType;
  final gql_client.Operation? operation;
  String get operationDocument =>
      operation != null ? gql.printNode(operation!.document) : 'null';
  final Map<String, dynamic>? variables;

  @override
  String get title => 'GraphQL Request';
  @override
  String get content =>
      // '"context": ${context?.encode},\n'
      '"variables": ${jsonEncode(variables)},\n'
      '"type": "$operationType",\n'
      '"name": "${operation?.operationName}",\n'
      '"document": ${jsonEncode(operationDocument)}';
}

class GraphQlResponseConsoleLog extends ConsoleLog
    implements LogWithRawResponse {
  GraphQlResponseConsoleLog({
    required this.rawResponse,
    // this.context,
    this.data,
    this.errors,
    super.severity,
  });

  @override
  final String rawResponse;
  // final gql_client.Context? context;
  final Map<String, dynamic>? data;
  final List<gql_client.GraphQLError>? errors;

  @override
  String get title => 'GraphQL Response';
  @override
  String get content =>
      // '"context": ${context?.encode},\n'
      '"data": ${jsonEncode(data)},\n'
      '"errors": $errors';
}
