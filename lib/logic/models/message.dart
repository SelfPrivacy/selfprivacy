import 'package:graphql/client.dart';
import 'package:intl/intl.dart';

/// TODO(misterfourtytwo): add equality override
class Message {
  Message({this.text, this.severity = MessageSeverity.normal})
      : time = DateTime.now();
  Message.warn({this.text})
      : severity = MessageSeverity.warning,
        time = DateTime.now();

  final String? text;
  final DateTime time;
  final MessageSeverity severity;

  static final DateFormat _formatter = DateFormat('hh:mm');
  String get timeString => _formatter.format(time);
}

enum MessageSeverity {
  normal,
  warning,
}

class RestApiRequestMessage extends Message {
  RestApiRequestMessage({
    this.method,
    this.uri,
    this.data,
    this.headers,
  }) : super(text: 'request-uri: $uri\nheaders: $headers\ndata: $data');

  final String? method;
  final Uri? uri;
  final String? data;
  final Map<String, dynamic>? headers;
}

class RestApiResponseMessage extends Message {
  RestApiResponseMessage({
    this.method,
    this.uri,
    this.statusCode,
    this.data,
  }) : super(text: 'response-uri: $uri\ncode: $statusCode\ndata: $data');

  final String? method;
  final Uri? uri;
  final int? statusCode;
  final String? data;
}

class GraphQlResponseMessage extends Message {
  GraphQlResponseMessage({
    this.data,
    this.errors,
    this.context,
  }) : super(text: 'GraphQL Response\ndata: $data');

  final Map<String, dynamic>? data;
  final List<GraphQLError>? errors;
  final Context? context;
}

class GraphQlRequestMessage extends Message {
  GraphQlRequestMessage({
    this.operation,
    this.variables,
    this.context,
  }) : super(text: 'GraphQL Request\noperation: $operation');

  final Operation? operation;
  final Map<String, dynamic>? variables;
  final Context? context;
}
