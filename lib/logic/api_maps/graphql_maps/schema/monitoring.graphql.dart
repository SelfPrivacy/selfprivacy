import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:selfprivacy/utils/scalars.dart';

class Fragment$MonitoringMetrics {
  Fragment$MonitoringMetrics({
    required this.metrics,
    this.$__typename = 'MonitoringMetrics',
  });

  factory Fragment$MonitoringMetrics.fromJson(Map<String, dynamic> json) {
    final l$metrics = json['metrics'];
    final l$$__typename = json['__typename'];
    return Fragment$MonitoringMetrics(
      metrics:
          (l$metrics as List<dynamic>)
              .map(
                (e) => Fragment$MonitoringMetrics$metrics.fromJson(
                  (e as Map<String, dynamic>),
                ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$MonitoringMetrics$metrics> metrics;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$metrics = metrics;
    _resultData['metrics'] = l$metrics.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$metrics = metrics;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$metrics.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$MonitoringMetrics ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$metrics = metrics;
    final lOther$metrics = other.metrics;
    if (l$metrics.length != lOther$metrics.length) {
      return false;
    }
    for (int i = 0; i < l$metrics.length; i++) {
      final l$metrics$entry = l$metrics[i];
      final lOther$metrics$entry = lOther$metrics[i];
      if (l$metrics$entry != lOther$metrics$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$MonitoringMetrics
    on Fragment$MonitoringMetrics {
  CopyWith$Fragment$MonitoringMetrics<Fragment$MonitoringMetrics>
  get copyWith => CopyWith$Fragment$MonitoringMetrics(this, (i) => i);
}

abstract class CopyWith$Fragment$MonitoringMetrics<TRes> {
  factory CopyWith$Fragment$MonitoringMetrics(
    Fragment$MonitoringMetrics instance,
    TRes Function(Fragment$MonitoringMetrics) then,
  ) = _CopyWithImpl$Fragment$MonitoringMetrics;

  factory CopyWith$Fragment$MonitoringMetrics.stub(TRes res) =
      _CopyWithStubImpl$Fragment$MonitoringMetrics;

  TRes call({
    List<Fragment$MonitoringMetrics$metrics>? metrics,
    String? $__typename,
  });
  TRes metrics(
    Iterable<Fragment$MonitoringMetrics$metrics> Function(
      Iterable<
        CopyWith$Fragment$MonitoringMetrics$metrics<
          Fragment$MonitoringMetrics$metrics
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Fragment$MonitoringMetrics<TRes>
    implements CopyWith$Fragment$MonitoringMetrics<TRes> {
  _CopyWithImpl$Fragment$MonitoringMetrics(this._instance, this._then);

  final Fragment$MonitoringMetrics _instance;

  final TRes Function(Fragment$MonitoringMetrics) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? metrics = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Fragment$MonitoringMetrics(
          metrics:
              metrics == _undefined || metrics == null
                  ? _instance.metrics
                  : (metrics as List<Fragment$MonitoringMetrics$metrics>),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  TRes metrics(
    Iterable<Fragment$MonitoringMetrics$metrics> Function(
      Iterable<
        CopyWith$Fragment$MonitoringMetrics$metrics<
          Fragment$MonitoringMetrics$metrics
        >
      >,
    )
    _fn,
  ) => call(
    metrics:
        _fn(
          _instance.metrics.map(
            (e) => CopyWith$Fragment$MonitoringMetrics$metrics(e, (i) => i),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Fragment$MonitoringMetrics<TRes>
    implements CopyWith$Fragment$MonitoringMetrics<TRes> {
  _CopyWithStubImpl$Fragment$MonitoringMetrics(this._res);

  TRes _res;

  call({
    List<Fragment$MonitoringMetrics$metrics>? metrics,
    String? $__typename,
  }) => _res;

  metrics(_fn) => _res;
}

const fragmentDefinitionMonitoringMetrics = FragmentDefinitionNode(
  name: NameNode(value: 'MonitoringMetrics'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(
      name: NameNode(value: 'MonitoringMetrics'),
      isNonNull: false,
    ),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'metrics'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FieldNode(
              name: NameNode(value: 'metricId'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'values'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(
                selections: [
                  FieldNode(
                    name: NameNode(value: 'timestamp'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'value'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: '__typename'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                ],
              ),
            ),
            FieldNode(
              name: NameNode(value: '__typename'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
          ],
        ),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentMonitoringMetrics = DocumentNode(
  definitions: [fragmentDefinitionMonitoringMetrics],
);

extension ClientExtension$Fragment$MonitoringMetrics on graphql.GraphQLClient {
  void writeFragment$MonitoringMetrics({
    required Fragment$MonitoringMetrics data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'MonitoringMetrics',
        document: documentNodeFragmentMonitoringMetrics,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Fragment$MonitoringMetrics? readFragment$MonitoringMetrics({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'MonitoringMetrics',
          document: documentNodeFragmentMonitoringMetrics,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$MonitoringMetrics.fromJson(result);
  }
}

class Fragment$MonitoringMetrics$metrics {
  Fragment$MonitoringMetrics$metrics({
    required this.metricId,
    required this.values,
    this.$__typename = 'MonitoringMetric',
  });

  factory Fragment$MonitoringMetrics$metrics.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$metricId = json['metricId'];
    final l$values = json['values'];
    final l$$__typename = json['__typename'];
    return Fragment$MonitoringMetrics$metrics(
      metricId: (l$metricId as String),
      values:
          (l$values as List<dynamic>)
              .map(
                (e) => Fragment$MonitoringMetrics$metrics$values.fromJson(
                  (e as Map<String, dynamic>),
                ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String metricId;

  final List<Fragment$MonitoringMetrics$metrics$values> values;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$metricId = metricId;
    _resultData['metricId'] = l$metricId;
    final l$values = values;
    _resultData['values'] = l$values.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$metricId = metricId;
    final l$values = values;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$metricId,
      Object.hashAll(l$values.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$MonitoringMetrics$metrics ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$metricId = metricId;
    final lOther$metricId = other.metricId;
    if (l$metricId != lOther$metricId) {
      return false;
    }
    final l$values = values;
    final lOther$values = other.values;
    if (l$values.length != lOther$values.length) {
      return false;
    }
    for (int i = 0; i < l$values.length; i++) {
      final l$values$entry = l$values[i];
      final lOther$values$entry = lOther$values[i];
      if (l$values$entry != lOther$values$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$MonitoringMetrics$metrics
    on Fragment$MonitoringMetrics$metrics {
  CopyWith$Fragment$MonitoringMetrics$metrics<
    Fragment$MonitoringMetrics$metrics
  >
  get copyWith => CopyWith$Fragment$MonitoringMetrics$metrics(this, (i) => i);
}

abstract class CopyWith$Fragment$MonitoringMetrics$metrics<TRes> {
  factory CopyWith$Fragment$MonitoringMetrics$metrics(
    Fragment$MonitoringMetrics$metrics instance,
    TRes Function(Fragment$MonitoringMetrics$metrics) then,
  ) = _CopyWithImpl$Fragment$MonitoringMetrics$metrics;

  factory CopyWith$Fragment$MonitoringMetrics$metrics.stub(TRes res) =
      _CopyWithStubImpl$Fragment$MonitoringMetrics$metrics;

  TRes call({
    String? metricId,
    List<Fragment$MonitoringMetrics$metrics$values>? values,
    String? $__typename,
  });
  TRes values(
    Iterable<Fragment$MonitoringMetrics$metrics$values> Function(
      Iterable<
        CopyWith$Fragment$MonitoringMetrics$metrics$values<
          Fragment$MonitoringMetrics$metrics$values
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Fragment$MonitoringMetrics$metrics<TRes>
    implements CopyWith$Fragment$MonitoringMetrics$metrics<TRes> {
  _CopyWithImpl$Fragment$MonitoringMetrics$metrics(this._instance, this._then);

  final Fragment$MonitoringMetrics$metrics _instance;

  final TRes Function(Fragment$MonitoringMetrics$metrics) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? metricId = _undefined,
    Object? values = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$MonitoringMetrics$metrics(
      metricId:
          metricId == _undefined || metricId == null
              ? _instance.metricId
              : (metricId as String),
      values:
          values == _undefined || values == null
              ? _instance.values
              : (values as List<Fragment$MonitoringMetrics$metrics$values>),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes values(
    Iterable<Fragment$MonitoringMetrics$metrics$values> Function(
      Iterable<
        CopyWith$Fragment$MonitoringMetrics$metrics$values<
          Fragment$MonitoringMetrics$metrics$values
        >
      >,
    )
    _fn,
  ) => call(
    values:
        _fn(
          _instance.values.map(
            (e) =>
                CopyWith$Fragment$MonitoringMetrics$metrics$values(e, (i) => i),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Fragment$MonitoringMetrics$metrics<TRes>
    implements CopyWith$Fragment$MonitoringMetrics$metrics<TRes> {
  _CopyWithStubImpl$Fragment$MonitoringMetrics$metrics(this._res);

  TRes _res;

  call({
    String? metricId,
    List<Fragment$MonitoringMetrics$metrics$values>? values,
    String? $__typename,
  }) => _res;

  values(_fn) => _res;
}

class Fragment$MonitoringMetrics$metrics$values {
  Fragment$MonitoringMetrics$metrics$values({
    required this.timestamp,
    required this.value,
    this.$__typename = 'MonitoringValue',
  });

  factory Fragment$MonitoringMetrics$metrics$values.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$timestamp = json['timestamp'];
    final l$value = json['value'];
    final l$$__typename = json['__typename'];
    return Fragment$MonitoringMetrics$metrics$values(
      timestamp: dateTimeFromJson(l$timestamp),
      value: (l$value as String),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime timestamp;

  final String value;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$timestamp = timestamp;
    _resultData['timestamp'] = dateTimeToJson(l$timestamp);
    final l$value = value;
    _resultData['value'] = l$value;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$timestamp = timestamp;
    final l$value = value;
    final l$$__typename = $__typename;
    return Object.hashAll([l$timestamp, l$value, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$MonitoringMetrics$metrics$values ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$timestamp = timestamp;
    final lOther$timestamp = other.timestamp;
    if (l$timestamp != lOther$timestamp) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$MonitoringMetrics$metrics$values
    on Fragment$MonitoringMetrics$metrics$values {
  CopyWith$Fragment$MonitoringMetrics$metrics$values<
    Fragment$MonitoringMetrics$metrics$values
  >
  get copyWith =>
      CopyWith$Fragment$MonitoringMetrics$metrics$values(this, (i) => i);
}

abstract class CopyWith$Fragment$MonitoringMetrics$metrics$values<TRes> {
  factory CopyWith$Fragment$MonitoringMetrics$metrics$values(
    Fragment$MonitoringMetrics$metrics$values instance,
    TRes Function(Fragment$MonitoringMetrics$metrics$values) then,
  ) = _CopyWithImpl$Fragment$MonitoringMetrics$metrics$values;

  factory CopyWith$Fragment$MonitoringMetrics$metrics$values.stub(TRes res) =
      _CopyWithStubImpl$Fragment$MonitoringMetrics$metrics$values;

  TRes call({DateTime? timestamp, String? value, String? $__typename});
}

class _CopyWithImpl$Fragment$MonitoringMetrics$metrics$values<TRes>
    implements CopyWith$Fragment$MonitoringMetrics$metrics$values<TRes> {
  _CopyWithImpl$Fragment$MonitoringMetrics$metrics$values(
    this._instance,
    this._then,
  );

  final Fragment$MonitoringMetrics$metrics$values _instance;

  final TRes Function(Fragment$MonitoringMetrics$metrics$values) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? timestamp = _undefined,
    Object? value = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$MonitoringMetrics$metrics$values(
      timestamp:
          timestamp == _undefined || timestamp == null
              ? _instance.timestamp
              : (timestamp as DateTime),
      value:
          value == _undefined || value == null
              ? _instance.value
              : (value as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$MonitoringMetrics$metrics$values<TRes>
    implements CopyWith$Fragment$MonitoringMetrics$metrics$values<TRes> {
  _CopyWithStubImpl$Fragment$MonitoringMetrics$metrics$values(this._res);

  TRes _res;

  call({DateTime? timestamp, String? value, String? $__typename}) => _res;
}

class Fragment$MonitoringValues {
  Fragment$MonitoringValues({
    required this.values,
    this.$__typename = 'MonitoringValues',
  });

  factory Fragment$MonitoringValues.fromJson(Map<String, dynamic> json) {
    final l$values = json['values'];
    final l$$__typename = json['__typename'];
    return Fragment$MonitoringValues(
      values:
          (l$values as List<dynamic>)
              .map(
                (e) => Fragment$MonitoringValues$values.fromJson(
                  (e as Map<String, dynamic>),
                ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$MonitoringValues$values> values;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$values = values;
    _resultData['values'] = l$values.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$values = values;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$values.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$MonitoringValues ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$values = values;
    final lOther$values = other.values;
    if (l$values.length != lOther$values.length) {
      return false;
    }
    for (int i = 0; i < l$values.length; i++) {
      final l$values$entry = l$values[i];
      final lOther$values$entry = lOther$values[i];
      if (l$values$entry != lOther$values$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$MonitoringValues
    on Fragment$MonitoringValues {
  CopyWith$Fragment$MonitoringValues<Fragment$MonitoringValues> get copyWith =>
      CopyWith$Fragment$MonitoringValues(this, (i) => i);
}

abstract class CopyWith$Fragment$MonitoringValues<TRes> {
  factory CopyWith$Fragment$MonitoringValues(
    Fragment$MonitoringValues instance,
    TRes Function(Fragment$MonitoringValues) then,
  ) = _CopyWithImpl$Fragment$MonitoringValues;

  factory CopyWith$Fragment$MonitoringValues.stub(TRes res) =
      _CopyWithStubImpl$Fragment$MonitoringValues;

  TRes call({
    List<Fragment$MonitoringValues$values>? values,
    String? $__typename,
  });
  TRes values(
    Iterable<Fragment$MonitoringValues$values> Function(
      Iterable<
        CopyWith$Fragment$MonitoringValues$values<
          Fragment$MonitoringValues$values
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Fragment$MonitoringValues<TRes>
    implements CopyWith$Fragment$MonitoringValues<TRes> {
  _CopyWithImpl$Fragment$MonitoringValues(this._instance, this._then);

  final Fragment$MonitoringValues _instance;

  final TRes Function(Fragment$MonitoringValues) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? values = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Fragment$MonitoringValues(
          values:
              values == _undefined || values == null
                  ? _instance.values
                  : (values as List<Fragment$MonitoringValues$values>),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  TRes values(
    Iterable<Fragment$MonitoringValues$values> Function(
      Iterable<
        CopyWith$Fragment$MonitoringValues$values<
          Fragment$MonitoringValues$values
        >
      >,
    )
    _fn,
  ) => call(
    values:
        _fn(
          _instance.values.map(
            (e) => CopyWith$Fragment$MonitoringValues$values(e, (i) => i),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Fragment$MonitoringValues<TRes>
    implements CopyWith$Fragment$MonitoringValues<TRes> {
  _CopyWithStubImpl$Fragment$MonitoringValues(this._res);

  TRes _res;

  call({List<Fragment$MonitoringValues$values>? values, String? $__typename}) =>
      _res;

  values(_fn) => _res;
}

const fragmentDefinitionMonitoringValues = FragmentDefinitionNode(
  name: NameNode(value: 'MonitoringValues'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(
      name: NameNode(value: 'MonitoringValues'),
      isNonNull: false,
    ),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'values'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FieldNode(
              name: NameNode(value: 'value'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'timestamp'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: '__typename'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
          ],
        ),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentMonitoringValues = DocumentNode(
  definitions: [fragmentDefinitionMonitoringValues],
);

extension ClientExtension$Fragment$MonitoringValues on graphql.GraphQLClient {
  void writeFragment$MonitoringValues({
    required Fragment$MonitoringValues data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'MonitoringValues',
        document: documentNodeFragmentMonitoringValues,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Fragment$MonitoringValues? readFragment$MonitoringValues({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'MonitoringValues',
          document: documentNodeFragmentMonitoringValues,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$MonitoringValues.fromJson(result);
  }
}

class Fragment$MonitoringValues$values {
  Fragment$MonitoringValues$values({
    required this.value,
    required this.timestamp,
    this.$__typename = 'MonitoringValue',
  });

  factory Fragment$MonitoringValues$values.fromJson(Map<String, dynamic> json) {
    final l$value = json['value'];
    final l$timestamp = json['timestamp'];
    final l$$__typename = json['__typename'];
    return Fragment$MonitoringValues$values(
      value: (l$value as String),
      timestamp: dateTimeFromJson(l$timestamp),
      $__typename: (l$$__typename as String),
    );
  }

  final String value;

  final DateTime timestamp;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$value = value;
    _resultData['value'] = l$value;
    final l$timestamp = timestamp;
    _resultData['timestamp'] = dateTimeToJson(l$timestamp);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$value = value;
    final l$timestamp = timestamp;
    final l$$__typename = $__typename;
    return Object.hashAll([l$value, l$timestamp, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$MonitoringValues$values ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
      return false;
    }
    final l$timestamp = timestamp;
    final lOther$timestamp = other.timestamp;
    if (l$timestamp != lOther$timestamp) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$MonitoringValues$values
    on Fragment$MonitoringValues$values {
  CopyWith$Fragment$MonitoringValues$values<Fragment$MonitoringValues$values>
  get copyWith => CopyWith$Fragment$MonitoringValues$values(this, (i) => i);
}

abstract class CopyWith$Fragment$MonitoringValues$values<TRes> {
  factory CopyWith$Fragment$MonitoringValues$values(
    Fragment$MonitoringValues$values instance,
    TRes Function(Fragment$MonitoringValues$values) then,
  ) = _CopyWithImpl$Fragment$MonitoringValues$values;

  factory CopyWith$Fragment$MonitoringValues$values.stub(TRes res) =
      _CopyWithStubImpl$Fragment$MonitoringValues$values;

  TRes call({String? value, DateTime? timestamp, String? $__typename});
}

class _CopyWithImpl$Fragment$MonitoringValues$values<TRes>
    implements CopyWith$Fragment$MonitoringValues$values<TRes> {
  _CopyWithImpl$Fragment$MonitoringValues$values(this._instance, this._then);

  final Fragment$MonitoringValues$values _instance;

  final TRes Function(Fragment$MonitoringValues$values) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? value = _undefined,
    Object? timestamp = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$MonitoringValues$values(
      value:
          value == _undefined || value == null
              ? _instance.value
              : (value as String),
      timestamp:
          timestamp == _undefined || timestamp == null
              ? _instance.timestamp
              : (timestamp as DateTime),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$MonitoringValues$values<TRes>
    implements CopyWith$Fragment$MonitoringValues$values<TRes> {
  _CopyWithStubImpl$Fragment$MonitoringValues$values(this._res);

  TRes _res;

  call({String? value, DateTime? timestamp, String? $__typename}) => _res;
}

class Fragment$MonitoringQueryError {
  Fragment$MonitoringQueryError({
    required this.error,
    this.$__typename = 'MonitoringQueryError',
  });

  factory Fragment$MonitoringQueryError.fromJson(Map<String, dynamic> json) {
    final l$error = json['error'];
    final l$$__typename = json['__typename'];
    return Fragment$MonitoringQueryError(
      error: (l$error as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String error;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$error = error;
    _resultData['error'] = l$error;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$error = error;
    final l$$__typename = $__typename;
    return Object.hashAll([l$error, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$MonitoringQueryError ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$error = error;
    final lOther$error = other.error;
    if (l$error != lOther$error) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$MonitoringQueryError
    on Fragment$MonitoringQueryError {
  CopyWith$Fragment$MonitoringQueryError<Fragment$MonitoringQueryError>
  get copyWith => CopyWith$Fragment$MonitoringQueryError(this, (i) => i);
}

abstract class CopyWith$Fragment$MonitoringQueryError<TRes> {
  factory CopyWith$Fragment$MonitoringQueryError(
    Fragment$MonitoringQueryError instance,
    TRes Function(Fragment$MonitoringQueryError) then,
  ) = _CopyWithImpl$Fragment$MonitoringQueryError;

  factory CopyWith$Fragment$MonitoringQueryError.stub(TRes res) =
      _CopyWithStubImpl$Fragment$MonitoringQueryError;

  TRes call({String? error, String? $__typename});
}

class _CopyWithImpl$Fragment$MonitoringQueryError<TRes>
    implements CopyWith$Fragment$MonitoringQueryError<TRes> {
  _CopyWithImpl$Fragment$MonitoringQueryError(this._instance, this._then);

  final Fragment$MonitoringQueryError _instance;

  final TRes Function(Fragment$MonitoringQueryError) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? error = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Fragment$MonitoringQueryError(
          error:
              error == _undefined || error == null
                  ? _instance.error
                  : (error as String),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );
}

class _CopyWithStubImpl$Fragment$MonitoringQueryError<TRes>
    implements CopyWith$Fragment$MonitoringQueryError<TRes> {
  _CopyWithStubImpl$Fragment$MonitoringQueryError(this._res);

  TRes _res;

  call({String? error, String? $__typename}) => _res;
}

const fragmentDefinitionMonitoringQueryError = FragmentDefinitionNode(
  name: NameNode(value: 'MonitoringQueryError'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(
      name: NameNode(value: 'MonitoringQueryError'),
      isNonNull: false,
    ),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'error'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentMonitoringQueryError = DocumentNode(
  definitions: [fragmentDefinitionMonitoringQueryError],
);

extension ClientExtension$Fragment$MonitoringQueryError
    on graphql.GraphQLClient {
  void writeFragment$MonitoringQueryError({
    required Fragment$MonitoringQueryError data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'MonitoringQueryError',
        document: documentNodeFragmentMonitoringQueryError,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Fragment$MonitoringQueryError? readFragment$MonitoringQueryError({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'MonitoringQueryError',
          document: documentNodeFragmentMonitoringQueryError,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null
        ? null
        : Fragment$MonitoringQueryError.fromJson(result);
  }
}

class Variables$Query$GetOverallCpuAndNetworkMetrics {
  factory Variables$Query$GetOverallCpuAndNetworkMetrics({
    DateTime? start,
    DateTime? end,
    required int step,
  }) => Variables$Query$GetOverallCpuAndNetworkMetrics._({
    if (start != null) r'start': start,
    if (end != null) r'end': end,
    r'step': step,
  });

  Variables$Query$GetOverallCpuAndNetworkMetrics._(this._$data);

  factory Variables$Query$GetOverallCpuAndNetworkMetrics.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('start')) {
      final l$start = data['start'];
      result$data['start'] = l$start == null ? null : dateTimeFromJson(l$start);
    }
    if (data.containsKey('end')) {
      final l$end = data['end'];
      result$data['end'] = l$end == null ? null : dateTimeFromJson(l$end);
    }
    final l$step = data['step'];
    result$data['step'] = (l$step as int);
    return Variables$Query$GetOverallCpuAndNetworkMetrics._(result$data);
  }

  Map<String, dynamic> _$data;

  DateTime? get start => (_$data['start'] as DateTime?);

  DateTime? get end => (_$data['end'] as DateTime?);

  int get step => (_$data['step'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('start')) {
      final l$start = start;
      result$data['start'] = l$start == null ? null : dateTimeToJson(l$start);
    }
    if (_$data.containsKey('end')) {
      final l$end = end;
      result$data['end'] = l$end == null ? null : dateTimeToJson(l$end);
    }
    final l$step = step;
    result$data['step'] = l$step;
    return result$data;
  }

  CopyWith$Variables$Query$GetOverallCpuAndNetworkMetrics<
    Variables$Query$GetOverallCpuAndNetworkMetrics
  >
  get copyWith =>
      CopyWith$Variables$Query$GetOverallCpuAndNetworkMetrics(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$GetOverallCpuAndNetworkMetrics ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$start = start;
    final lOther$start = other.start;
    if (_$data.containsKey('start') != other._$data.containsKey('start')) {
      return false;
    }
    if (l$start != lOther$start) {
      return false;
    }
    final l$end = end;
    final lOther$end = other.end;
    if (_$data.containsKey('end') != other._$data.containsKey('end')) {
      return false;
    }
    if (l$end != lOther$end) {
      return false;
    }
    final l$step = step;
    final lOther$step = other.step;
    if (l$step != lOther$step) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$start = start;
    final l$end = end;
    final l$step = step;
    return Object.hashAll([
      _$data.containsKey('start') ? l$start : const {},
      _$data.containsKey('end') ? l$end : const {},
      l$step,
    ]);
  }
}

abstract class CopyWith$Variables$Query$GetOverallCpuAndNetworkMetrics<TRes> {
  factory CopyWith$Variables$Query$GetOverallCpuAndNetworkMetrics(
    Variables$Query$GetOverallCpuAndNetworkMetrics instance,
    TRes Function(Variables$Query$GetOverallCpuAndNetworkMetrics) then,
  ) = _CopyWithImpl$Variables$Query$GetOverallCpuAndNetworkMetrics;

  factory CopyWith$Variables$Query$GetOverallCpuAndNetworkMetrics.stub(
    TRes res,
  ) = _CopyWithStubImpl$Variables$Query$GetOverallCpuAndNetworkMetrics;

  TRes call({DateTime? start, DateTime? end, int? step});
}

class _CopyWithImpl$Variables$Query$GetOverallCpuAndNetworkMetrics<TRes>
    implements CopyWith$Variables$Query$GetOverallCpuAndNetworkMetrics<TRes> {
  _CopyWithImpl$Variables$Query$GetOverallCpuAndNetworkMetrics(
    this._instance,
    this._then,
  );

  final Variables$Query$GetOverallCpuAndNetworkMetrics _instance;

  final TRes Function(Variables$Query$GetOverallCpuAndNetworkMetrics) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? start = _undefined,
    Object? end = _undefined,
    Object? step = _undefined,
  }) => _then(
    Variables$Query$GetOverallCpuAndNetworkMetrics._({
      ..._instance._$data,
      if (start != _undefined) 'start': (start as DateTime?),
      if (end != _undefined) 'end': (end as DateTime?),
      if (step != _undefined && step != null) 'step': (step as int),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$GetOverallCpuAndNetworkMetrics<TRes>
    implements CopyWith$Variables$Query$GetOverallCpuAndNetworkMetrics<TRes> {
  _CopyWithStubImpl$Variables$Query$GetOverallCpuAndNetworkMetrics(this._res);

  TRes _res;

  call({DateTime? start, DateTime? end, int? step}) => _res;
}

class Query$GetOverallCpuAndNetworkMetrics {
  Query$GetOverallCpuAndNetworkMetrics({
    required this.monitoring,
    this.$__typename = 'Query',
  });

  factory Query$GetOverallCpuAndNetworkMetrics.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$monitoring = json['monitoring'];
    final l$$__typename = json['__typename'];
    return Query$GetOverallCpuAndNetworkMetrics(
      monitoring: Query$GetOverallCpuAndNetworkMetrics$monitoring.fromJson(
        (l$monitoring as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetOverallCpuAndNetworkMetrics$monitoring monitoring;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$monitoring = monitoring;
    _resultData['monitoring'] = l$monitoring.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$monitoring = monitoring;
    final l$$__typename = $__typename;
    return Object.hashAll([l$monitoring, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetOverallCpuAndNetworkMetrics ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$monitoring = monitoring;
    final lOther$monitoring = other.monitoring;
    if (l$monitoring != lOther$monitoring) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOverallCpuAndNetworkMetrics
    on Query$GetOverallCpuAndNetworkMetrics {
  CopyWith$Query$GetOverallCpuAndNetworkMetrics<
    Query$GetOverallCpuAndNetworkMetrics
  >
  get copyWith => CopyWith$Query$GetOverallCpuAndNetworkMetrics(this, (i) => i);
}

abstract class CopyWith$Query$GetOverallCpuAndNetworkMetrics<TRes> {
  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics(
    Query$GetOverallCpuAndNetworkMetrics instance,
    TRes Function(Query$GetOverallCpuAndNetworkMetrics) then,
  ) = _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics;

  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics.stub(TRes res) =
      _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics;

  TRes call({
    Query$GetOverallCpuAndNetworkMetrics$monitoring? monitoring,
    String? $__typename,
  });
  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring<TRes> get monitoring;
}

class _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics<TRes>
    implements CopyWith$Query$GetOverallCpuAndNetworkMetrics<TRes> {
  _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics(
    this._instance,
    this._then,
  );

  final Query$GetOverallCpuAndNetworkMetrics _instance;

  final TRes Function(Query$GetOverallCpuAndNetworkMetrics) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? monitoring = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetOverallCpuAndNetworkMetrics(
      monitoring:
          monitoring == _undefined || monitoring == null
              ? _instance.monitoring
              : (monitoring as Query$GetOverallCpuAndNetworkMetrics$monitoring),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring<TRes>
  get monitoring {
    final local$monitoring = _instance.monitoring;
    return CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring(
      local$monitoring,
      (e) => call(monitoring: e),
    );
  }
}

class _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics<TRes>
    implements CopyWith$Query$GetOverallCpuAndNetworkMetrics<TRes> {
  _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics(this._res);

  TRes _res;

  call({
    Query$GetOverallCpuAndNetworkMetrics$monitoring? monitoring,
    String? $__typename,
  }) => _res;

  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring<TRes>
  get monitoring =>
      CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring.stub(_res);
}

const documentNodeQueryGetOverallCpuAndNetworkMetrics = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetOverallCpuAndNetworkMetrics'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'start')),
          type: NamedTypeNode(
            name: NameNode(value: 'DateTime'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'end')),
          type: NamedTypeNode(
            name: NameNode(value: 'DateTime'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'step')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'monitoring'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'cpuUsage'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'start'),
                      value: VariableNode(name: NameNode(value: 'start')),
                    ),
                    ArgumentNode(
                      name: NameNode(value: 'end'),
                      value: VariableNode(name: NameNode(value: 'end')),
                    ),
                    ArgumentNode(
                      name: NameNode(value: 'step'),
                      value: VariableNode(name: NameNode(value: 'step')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'overallUsage'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FragmentSpreadNode(
                              name: NameNode(value: 'MonitoringQueryError'),
                              directives: [],
                            ),
                            FragmentSpreadNode(
                              name: NameNode(value: 'MonitoringValues'),
                              directives: [],
                            ),
                            FieldNode(
                              name: NameNode(value: '__typename'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: 'networkUsage'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'start'),
                      value: VariableNode(name: NameNode(value: 'start')),
                    ),
                    ArgumentNode(
                      name: NameNode(value: 'end'),
                      value: VariableNode(name: NameNode(value: 'end')),
                    ),
                    ArgumentNode(
                      name: NameNode(value: 'step'),
                      value: VariableNode(name: NameNode(value: 'step')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'overallUsage'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FragmentSpreadNode(
                              name: NameNode(value: 'MonitoringQueryError'),
                              directives: [],
                            ),
                            FragmentSpreadNode(
                              name: NameNode(value: 'MonitoringMetrics'),
                              directives: [],
                            ),
                            FieldNode(
                              name: NameNode(value: '__typename'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionMonitoringQueryError,
    fragmentDefinitionMonitoringValues,
    fragmentDefinitionMonitoringMetrics,
  ],
);
Query$GetOverallCpuAndNetworkMetrics
_parserFn$Query$GetOverallCpuAndNetworkMetrics(Map<String, dynamic> data) =>
    Query$GetOverallCpuAndNetworkMetrics.fromJson(data);
typedef OnQueryComplete$Query$GetOverallCpuAndNetworkMetrics =
    FutureOr<void> Function(
      Map<String, dynamic>?,
      Query$GetOverallCpuAndNetworkMetrics?,
    );

class Options$Query$GetOverallCpuAndNetworkMetrics
    extends graphql.QueryOptions<Query$GetOverallCpuAndNetworkMetrics> {
  Options$Query$GetOverallCpuAndNetworkMetrics({
    String? operationName,
    required Variables$Query$GetOverallCpuAndNetworkMetrics variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetOverallCpuAndNetworkMetrics? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetOverallCpuAndNetworkMetrics? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete:
             onComplete == null
                 ? null
                 : (data) => onComplete(
                   data,
                   data == null
                       ? null
                       : _parserFn$Query$GetOverallCpuAndNetworkMetrics(data),
                 ),
         onError: onError,
         document: documentNodeQueryGetOverallCpuAndNetworkMetrics,
         parserFn: _parserFn$Query$GetOverallCpuAndNetworkMetrics,
       );

  final OnQueryComplete$Query$GetOverallCpuAndNetworkMetrics?
  onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$GetOverallCpuAndNetworkMetrics
    extends graphql.WatchQueryOptions<Query$GetOverallCpuAndNetworkMetrics> {
  WatchOptions$Query$GetOverallCpuAndNetworkMetrics({
    String? operationName,
    required Variables$Query$GetOverallCpuAndNetworkMetrics variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetOverallCpuAndNetworkMetrics? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryGetOverallCpuAndNetworkMetrics,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$GetOverallCpuAndNetworkMetrics,
       );
}

class FetchMoreOptions$Query$GetOverallCpuAndNetworkMetrics
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetOverallCpuAndNetworkMetrics({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetOverallCpuAndNetworkMetrics variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryGetOverallCpuAndNetworkMetrics,
       );
}

extension ClientExtension$Query$GetOverallCpuAndNetworkMetrics
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetOverallCpuAndNetworkMetrics>>
  query$GetOverallCpuAndNetworkMetrics(
    Options$Query$GetOverallCpuAndNetworkMetrics options,
  ) async => await this.query(options);
  graphql.ObservableQuery<Query$GetOverallCpuAndNetworkMetrics>
  watchQuery$GetOverallCpuAndNetworkMetrics(
    WatchOptions$Query$GetOverallCpuAndNetworkMetrics options,
  ) => this.watchQuery(options);
  void writeQuery$GetOverallCpuAndNetworkMetrics({
    required Query$GetOverallCpuAndNetworkMetrics data,
    required Variables$Query$GetOverallCpuAndNetworkMetrics variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(
        document: documentNodeQueryGetOverallCpuAndNetworkMetrics,
      ),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Query$GetOverallCpuAndNetworkMetrics?
  readQuery$GetOverallCpuAndNetworkMetrics({
    required Variables$Query$GetOverallCpuAndNetworkMetrics variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(
          document: documentNodeQueryGetOverallCpuAndNetworkMetrics,
        ),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null
        ? null
        : Query$GetOverallCpuAndNetworkMetrics.fromJson(result);
  }
}

class Query$GetOverallCpuAndNetworkMetrics$monitoring {
  Query$GetOverallCpuAndNetworkMetrics$monitoring({
    required this.cpuUsage,
    required this.networkUsage,
    this.$__typename = 'Monitoring',
  });

  factory Query$GetOverallCpuAndNetworkMetrics$monitoring.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$cpuUsage = json['cpuUsage'];
    final l$networkUsage = json['networkUsage'];
    final l$$__typename = json['__typename'];
    return Query$GetOverallCpuAndNetworkMetrics$monitoring(
      cpuUsage:
          Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage.fromJson(
            (l$cpuUsage as Map<String, dynamic>),
          ),
      networkUsage:
          Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage.fromJson(
            (l$networkUsage as Map<String, dynamic>),
          ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage cpuUsage;

  final Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage
  networkUsage;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$cpuUsage = cpuUsage;
    _resultData['cpuUsage'] = l$cpuUsage.toJson();
    final l$networkUsage = networkUsage;
    _resultData['networkUsage'] = l$networkUsage.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$cpuUsage = cpuUsage;
    final l$networkUsage = networkUsage;
    final l$$__typename = $__typename;
    return Object.hashAll([l$cpuUsage, l$networkUsage, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetOverallCpuAndNetworkMetrics$monitoring ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$cpuUsage = cpuUsage;
    final lOther$cpuUsage = other.cpuUsage;
    if (l$cpuUsage != lOther$cpuUsage) {
      return false;
    }
    final l$networkUsage = networkUsage;
    final lOther$networkUsage = other.networkUsage;
    if (l$networkUsage != lOther$networkUsage) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOverallCpuAndNetworkMetrics$monitoring
    on Query$GetOverallCpuAndNetworkMetrics$monitoring {
  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring<
    Query$GetOverallCpuAndNetworkMetrics$monitoring
  >
  get copyWith =>
      CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring(this, (i) => i);
}

abstract class CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring<TRes> {
  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring(
    Query$GetOverallCpuAndNetworkMetrics$monitoring instance,
    TRes Function(Query$GetOverallCpuAndNetworkMetrics$monitoring) then,
  ) = _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring;

  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring.stub(
    TRes res,
  ) = _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring;

  TRes call({
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage? cpuUsage,
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage? networkUsage,
    String? $__typename,
  });
  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage<TRes>
  get cpuUsage;
  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage<TRes>
  get networkUsage;
}

class _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring<TRes>
    implements CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring<TRes> {
  _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring(
    this._instance,
    this._then,
  );

  final Query$GetOverallCpuAndNetworkMetrics$monitoring _instance;

  final TRes Function(Query$GetOverallCpuAndNetworkMetrics$monitoring) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? cpuUsage = _undefined,
    Object? networkUsage = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetOverallCpuAndNetworkMetrics$monitoring(
      cpuUsage:
          cpuUsage == _undefined || cpuUsage == null
              ? _instance.cpuUsage
              : (cpuUsage
                  as Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage),
      networkUsage:
          networkUsage == _undefined || networkUsage == null
              ? _instance.networkUsage
              : (networkUsage
                  as Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage<TRes>
  get cpuUsage {
    final local$cpuUsage = _instance.cpuUsage;
    return CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage(
      local$cpuUsage,
      (e) => call(cpuUsage: e),
    );
  }

  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage<TRes>
  get networkUsage {
    final local$networkUsage = _instance.networkUsage;
    return CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage(
      local$networkUsage,
      (e) => call(networkUsage: e),
    );
  }
}

class _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring<TRes>
    implements CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring<TRes> {
  _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring(this._res);

  TRes _res;

  call({
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage? cpuUsage,
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage? networkUsage,
    String? $__typename,
  }) => _res;

  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage<TRes>
  get cpuUsage =>
      CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage.stub(
        _res,
      );

  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage<TRes>
  get networkUsage =>
      CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage.stub(
        _res,
      );
}

class Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage {
  Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage({
    required this.overallUsage,
    this.$__typename = 'CpuMonitoring',
  });

  factory Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$overallUsage = json['overallUsage'];
    final l$$__typename = json['__typename'];
    return Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage(
      overallUsage:
          Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage.fromJson(
            (l$overallUsage as Map<String, dynamic>),
          ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage
  overallUsage;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$overallUsage = overallUsage;
    _resultData['overallUsage'] = l$overallUsage.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$overallUsage = overallUsage;
    final l$$__typename = $__typename;
    return Object.hashAll([l$overallUsage, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$overallUsage = overallUsage;
    final lOther$overallUsage = other.overallUsage;
    if (l$overallUsage != lOther$overallUsage) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage
    on Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage {
  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage<
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage
  >
  get copyWith =>
      CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage<
  TRes
> {
  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage instance,
    TRes Function(Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage)
    then,
  ) = _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage;

  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage.stub(
    TRes res,
  ) = _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage;

  TRes call({
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage?
    overallUsage,
    String? $__typename,
  });
  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage<
    TRes
  >
  get overallUsage;
}

class _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage<
          TRes
        > {
  _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage(
    this._instance,
    this._then,
  );

  final Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage _instance;

  final TRes Function(Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage)
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? overallUsage = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage(
      overallUsage:
          overallUsage == _undefined || overallUsage == null
              ? _instance.overallUsage
              : (overallUsage
                  as Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage<
    TRes
  >
  get overallUsage {
    final local$overallUsage = _instance.overallUsage;
    return CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage(
      local$overallUsage,
      (e) => call(overallUsage: e),
    );
  }
}

class _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage<
          TRes
        > {
  _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage(
    this._res,
  );

  TRes _res;

  call({
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage?
    overallUsage,
    String? $__typename,
  }) => _res;

  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage<
    TRes
  >
  get overallUsage =>
      CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage.stub(
        _res,
      );
}

class Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage {
  Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage({
    required this.$__typename,
  });

  factory Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage.fromJson(
    Map<String, dynamic> json,
  ) {
    switch (json["__typename"] as String) {
      case "MonitoringValues":
        return Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues.fromJson(
          json,
        );

      case "MonitoringQueryError":
        return Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError.fromJson(
          json,
        );

      default:
        final l$$__typename = json['__typename'];
        return Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage(
          $__typename: (l$$__typename as String),
        );
    }
  }

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$$__typename = $__typename;
    return Object.hashAll([l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage
    on Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage {
  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage<
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage
  >
  get copyWith =>
      CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage(
        this,
        (i) => i,
      );
  _T when<_T>({
    required _T Function(
      Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues,
    )
    monitoringValues,
    required _T Function(
      Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError,
    )
    monitoringQueryError,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "MonitoringValues":
        return monitoringValues(
          this
              as Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues,
        );

      case "MonitoringQueryError":
        return monitoringQueryError(
          this
              as Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError,
        );

      default:
        return orElse();
    }
  }

  _T maybeWhen<_T>({
    _T Function(
      Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues,
    )?
    monitoringValues,
    _T Function(
      Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError,
    )?
    monitoringQueryError,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "MonitoringValues":
        if (monitoringValues != null) {
          return monitoringValues(
            this
                as Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues,
          );
        } else {
          return orElse();
        }

      case "MonitoringQueryError":
        if (monitoringQueryError != null) {
          return monitoringQueryError(
            this
                as Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError,
          );
        } else {
          return orElse();
        }

      default:
        return orElse();
    }
  }
}

abstract class CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage<
  TRes
> {
  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage
    instance,
    TRes Function(
      Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage;

  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage;

  TRes call({String? $__typename});
}

class _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage<
          TRes
        > {
  _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage(
    this._instance,
    this._then,
  );

  final Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage
  _instance;

  final TRes Function(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? $__typename = _undefined}) => _then(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage(
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage<
          TRes
        > {
  _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage(
    this._res,
  );

  TRes _res;

  call({String? $__typename}) => _res;
}

class Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues
    implements
        Fragment$MonitoringValues,
        Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage {
  Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues({
    required this.values,
    this.$__typename = 'MonitoringValues',
  });

  factory Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$values = json['values'];
    final l$$__typename = json['__typename'];
    return Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues(
      values:
          (l$values as List<dynamic>)
              .map(
                (e) =>
                    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values.fromJson(
                      (e as Map<String, dynamic>),
                    ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values
  >
  values;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$values = values;
    _resultData['values'] = l$values.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$values = values;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$values.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$values = values;
    final lOther$values = other.values;
    if (l$values.length != lOther$values.length) {
      return false;
    }
    for (int i = 0; i < l$values.length; i++) {
      final l$values$entry = l$values[i];
      final lOther$values$entry = lOther$values[i];
      if (l$values$entry != lOther$values$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues
    on
        Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues {
  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues<
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues
  >
  get copyWith =>
      CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues<
  TRes
> {
  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues
    instance,
    TRes Function(
      Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues;

  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues;

  TRes call({
    List<
      Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values
    >?
    values,
    String? $__typename,
  });
  TRes values(
    Iterable<
      Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values
    >
    Function(
      Iterable<
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values<
          Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues<
          TRes
        > {
  _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues(
    this._instance,
    this._then,
  );

  final Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues
  _instance;

  final TRes Function(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? values = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues(
      values:
          values == _undefined || values == null
              ? _instance.values
              : (values
                  as List<
                    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values
                  >),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes values(
    Iterable<
      Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values
    >
    Function(
      Iterable<
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values<
          Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values
        >
      >,
    )
    _fn,
  ) => call(
    values:
        _fn(
          _instance.values.map(
            (e) =>
                CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values(
                  e,
                  (i) => i,
                ),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues<
          TRes
        > {
  _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues(
    this._res,
  );

  TRes _res;

  call({
    List<
      Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values
    >?
    values,
    String? $__typename,
  }) => _res;

  values(_fn) => _res;
}

class Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values
    implements Fragment$MonitoringValues$values {
  Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values({
    required this.value,
    required this.timestamp,
    this.$__typename = 'MonitoringValue',
  });

  factory Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$value = json['value'];
    final l$timestamp = json['timestamp'];
    final l$$__typename = json['__typename'];
    return Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values(
      value: (l$value as String),
      timestamp: dateTimeFromJson(l$timestamp),
      $__typename: (l$$__typename as String),
    );
  }

  final String value;

  final DateTime timestamp;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$value = value;
    _resultData['value'] = l$value;
    final l$timestamp = timestamp;
    _resultData['timestamp'] = dateTimeToJson(l$timestamp);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$value = value;
    final l$timestamp = timestamp;
    final l$$__typename = $__typename;
    return Object.hashAll([l$value, l$timestamp, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
      return false;
    }
    final l$timestamp = timestamp;
    final lOther$timestamp = other.timestamp;
    if (l$timestamp != lOther$timestamp) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values
    on
        Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values {
  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values<
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values
  >
  get copyWith =>
      CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values<
  TRes
> {
  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values
    instance,
    TRes Function(
      Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values;

  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values;

  TRes call({String? value, DateTime? timestamp, String? $__typename});
}

class _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values<
          TRes
        > {
  _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values(
    this._instance,
    this._then,
  );

  final Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values
  _instance;

  final TRes Function(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? value = _undefined,
    Object? timestamp = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values(
      value:
          value == _undefined || value == null
              ? _instance.value
              : (value as String),
      timestamp:
          timestamp == _undefined || timestamp == null
              ? _instance.timestamp
              : (timestamp as DateTime),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values<
          TRes
        > {
  _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringValues$values(
    this._res,
  );

  TRes _res;

  call({String? value, DateTime? timestamp, String? $__typename}) => _res;
}

class Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError
    implements
        Fragment$MonitoringQueryError,
        Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage {
  Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError({
    required this.error,
    this.$__typename = 'MonitoringQueryError',
  });

  factory Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$error = json['error'];
    final l$$__typename = json['__typename'];
    return Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError(
      error: (l$error as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String error;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$error = error;
    _resultData['error'] = l$error;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$error = error;
    final l$$__typename = $__typename;
    return Object.hashAll([l$error, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$error = error;
    final lOther$error = other.error;
    if (l$error != lOther$error) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError
    on
        Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError {
  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError<
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError
  >
  get copyWith =>
      CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError<
  TRes
> {
  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError
    instance,
    TRes Function(
      Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError;

  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError;

  TRes call({String? error, String? $__typename});
}

class _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError<
          TRes
        > {
  _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError(
    this._instance,
    this._then,
  );

  final Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError
  _instance;

  final TRes Function(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? error = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError(
      error:
          error == _undefined || error == null
              ? _instance.error
              : (error as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError<
          TRes
        > {
  _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$cpuUsage$overallUsage$$MonitoringQueryError(
    this._res,
  );

  TRes _res;

  call({String? error, String? $__typename}) => _res;
}

class Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage {
  Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage({
    required this.overallUsage,
    this.$__typename = 'NetworkMonitoring',
  });

  factory Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$overallUsage = json['overallUsage'];
    final l$$__typename = json['__typename'];
    return Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage(
      overallUsage:
          Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage.fromJson(
            (l$overallUsage as Map<String, dynamic>),
          ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage
  overallUsage;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$overallUsage = overallUsage;
    _resultData['overallUsage'] = l$overallUsage.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$overallUsage = overallUsage;
    final l$$__typename = $__typename;
    return Object.hashAll([l$overallUsage, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$overallUsage = overallUsage;
    final lOther$overallUsage = other.overallUsage;
    if (l$overallUsage != lOther$overallUsage) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage
    on Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage {
  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage<
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage
  >
  get copyWith =>
      CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage<
  TRes
> {
  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage instance,
    TRes Function(Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage)
    then,
  ) = _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage;

  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage;

  TRes call({
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage?
    overallUsage,
    String? $__typename,
  });
  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage<
    TRes
  >
  get overallUsage;
}

class _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage<
          TRes
        > {
  _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage(
    this._instance,
    this._then,
  );

  final Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage _instance;

  final TRes Function(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? overallUsage = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage(
      overallUsage:
          overallUsage == _undefined || overallUsage == null
              ? _instance.overallUsage
              : (overallUsage
                  as Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage<
    TRes
  >
  get overallUsage {
    final local$overallUsage = _instance.overallUsage;
    return CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage(
      local$overallUsage,
      (e) => call(overallUsage: e),
    );
  }
}

class _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage<
          TRes
        > {
  _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage(
    this._res,
  );

  TRes _res;

  call({
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage?
    overallUsage,
    String? $__typename,
  }) => _res;

  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage<
    TRes
  >
  get overallUsage =>
      CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage.stub(
        _res,
      );
}

class Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage {
  Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage({
    required this.$__typename,
  });

  factory Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage.fromJson(
    Map<String, dynamic> json,
  ) {
    switch (json["__typename"] as String) {
      case "MonitoringMetrics":
        return Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics.fromJson(
          json,
        );

      case "MonitoringQueryError":
        return Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError.fromJson(
          json,
        );

      default:
        final l$$__typename = json['__typename'];
        return Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage(
          $__typename: (l$$__typename as String),
        );
    }
  }

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$$__typename = $__typename;
    return Object.hashAll([l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage
    on Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage {
  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage<
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage
  >
  get copyWith =>
      CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage(
        this,
        (i) => i,
      );
  _T when<_T>({
    required _T Function(
      Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics,
    )
    monitoringMetrics,
    required _T Function(
      Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError,
    )
    monitoringQueryError,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "MonitoringMetrics":
        return monitoringMetrics(
          this
              as Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics,
        );

      case "MonitoringQueryError":
        return monitoringQueryError(
          this
              as Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError,
        );

      default:
        return orElse();
    }
  }

  _T maybeWhen<_T>({
    _T Function(
      Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics,
    )?
    monitoringMetrics,
    _T Function(
      Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError,
    )?
    monitoringQueryError,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "MonitoringMetrics":
        if (monitoringMetrics != null) {
          return monitoringMetrics(
            this
                as Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics,
          );
        } else {
          return orElse();
        }

      case "MonitoringQueryError":
        if (monitoringQueryError != null) {
          return monitoringQueryError(
            this
                as Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError,
          );
        } else {
          return orElse();
        }

      default:
        return orElse();
    }
  }
}

abstract class CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage<
  TRes
> {
  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage
    instance,
    TRes Function(
      Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage;

  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage;

  TRes call({String? $__typename});
}

class _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage<
          TRes
        > {
  _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage(
    this._instance,
    this._then,
  );

  final Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage
  _instance;

  final TRes Function(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? $__typename = _undefined}) => _then(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage(
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage<
          TRes
        > {
  _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage(
    this._res,
  );

  TRes _res;

  call({String? $__typename}) => _res;
}

class Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics
    implements
        Fragment$MonitoringMetrics,
        Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage {
  Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics({
    required this.metrics,
    this.$__typename = 'MonitoringMetrics',
  });

  factory Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$metrics = json['metrics'];
    final l$$__typename = json['__typename'];
    return Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics(
      metrics:
          (l$metrics as List<dynamic>)
              .map(
                (e) =>
                    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics.fromJson(
                      (e as Map<String, dynamic>),
                    ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics
  >
  metrics;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$metrics = metrics;
    _resultData['metrics'] = l$metrics.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$metrics = metrics;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$metrics.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$metrics = metrics;
    final lOther$metrics = other.metrics;
    if (l$metrics.length != lOther$metrics.length) {
      return false;
    }
    for (int i = 0; i < l$metrics.length; i++) {
      final l$metrics$entry = l$metrics[i];
      final lOther$metrics$entry = lOther$metrics[i];
      if (l$metrics$entry != lOther$metrics$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics
    on
        Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics {
  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics<
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics
  >
  get copyWith =>
      CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics<
  TRes
> {
  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics
    instance,
    TRes Function(
      Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics;

  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics;

  TRes call({
    List<
      Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics
    >?
    metrics,
    String? $__typename,
  });
  TRes metrics(
    Iterable<
      Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics
    >
    Function(
      Iterable<
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics<
          Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics<
          TRes
        > {
  _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics(
    this._instance,
    this._then,
  );

  final Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics
  _instance;

  final TRes Function(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? metrics = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics(
      metrics:
          metrics == _undefined || metrics == null
              ? _instance.metrics
              : (metrics
                  as List<
                    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics
                  >),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes metrics(
    Iterable<
      Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics
    >
    Function(
      Iterable<
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics<
          Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics
        >
      >,
    )
    _fn,
  ) => call(
    metrics:
        _fn(
          _instance.metrics.map(
            (e) =>
                CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics(
                  e,
                  (i) => i,
                ),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics<
          TRes
        > {
  _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics(
    this._res,
  );

  TRes _res;

  call({
    List<
      Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics
    >?
    metrics,
    String? $__typename,
  }) => _res;

  metrics(_fn) => _res;
}

class Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics
    implements Fragment$MonitoringMetrics$metrics {
  Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics({
    required this.metricId,
    required this.values,
    this.$__typename = 'MonitoringMetric',
  });

  factory Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$metricId = json['metricId'];
    final l$values = json['values'];
    final l$$__typename = json['__typename'];
    return Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics(
      metricId: (l$metricId as String),
      values:
          (l$values as List<dynamic>)
              .map(
                (e) =>
                    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values.fromJson(
                      (e as Map<String, dynamic>),
                    ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String metricId;

  final List<
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values
  >
  values;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$metricId = metricId;
    _resultData['metricId'] = l$metricId;
    final l$values = values;
    _resultData['values'] = l$values.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$metricId = metricId;
    final l$values = values;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$metricId,
      Object.hashAll(l$values.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$metricId = metricId;
    final lOther$metricId = other.metricId;
    if (l$metricId != lOther$metricId) {
      return false;
    }
    final l$values = values;
    final lOther$values = other.values;
    if (l$values.length != lOther$values.length) {
      return false;
    }
    for (int i = 0; i < l$values.length; i++) {
      final l$values$entry = l$values[i];
      final lOther$values$entry = lOther$values[i];
      if (l$values$entry != lOther$values$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics
    on
        Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics {
  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics<
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics
  >
  get copyWith =>
      CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics<
  TRes
> {
  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics
    instance,
    TRes Function(
      Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics;

  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics;

  TRes call({
    String? metricId,
    List<
      Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values
    >?
    values,
    String? $__typename,
  });
  TRes values(
    Iterable<
      Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values
    >
    Function(
      Iterable<
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values<
          Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics<
          TRes
        > {
  _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics(
    this._instance,
    this._then,
  );

  final Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics
  _instance;

  final TRes Function(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? metricId = _undefined,
    Object? values = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics(
      metricId:
          metricId == _undefined || metricId == null
              ? _instance.metricId
              : (metricId as String),
      values:
          values == _undefined || values == null
              ? _instance.values
              : (values
                  as List<
                    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values
                  >),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes values(
    Iterable<
      Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values
    >
    Function(
      Iterable<
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values<
          Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values
        >
      >,
    )
    _fn,
  ) => call(
    values:
        _fn(
          _instance.values.map(
            (e) =>
                CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values(
                  e,
                  (i) => i,
                ),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics<
          TRes
        > {
  _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics(
    this._res,
  );

  TRes _res;

  call({
    String? metricId,
    List<
      Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values
    >?
    values,
    String? $__typename,
  }) => _res;

  values(_fn) => _res;
}

class Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values
    implements Fragment$MonitoringMetrics$metrics$values {
  Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values({
    required this.timestamp,
    required this.value,
    this.$__typename = 'MonitoringValue',
  });

  factory Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$timestamp = json['timestamp'];
    final l$value = json['value'];
    final l$$__typename = json['__typename'];
    return Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values(
      timestamp: dateTimeFromJson(l$timestamp),
      value: (l$value as String),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime timestamp;

  final String value;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$timestamp = timestamp;
    _resultData['timestamp'] = dateTimeToJson(l$timestamp);
    final l$value = value;
    _resultData['value'] = l$value;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$timestamp = timestamp;
    final l$value = value;
    final l$$__typename = $__typename;
    return Object.hashAll([l$timestamp, l$value, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$timestamp = timestamp;
    final lOther$timestamp = other.timestamp;
    if (l$timestamp != lOther$timestamp) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values
    on
        Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values {
  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values<
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values
  >
  get copyWith =>
      CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values<
  TRes
> {
  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values
    instance,
    TRes Function(
      Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values;

  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values;

  TRes call({DateTime? timestamp, String? value, String? $__typename});
}

class _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values<
          TRes
        > {
  _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values(
    this._instance,
    this._then,
  );

  final Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values
  _instance;

  final TRes Function(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? timestamp = _undefined,
    Object? value = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values(
      timestamp:
          timestamp == _undefined || timestamp == null
              ? _instance.timestamp
              : (timestamp as DateTime),
      value:
          value == _undefined || value == null
              ? _instance.value
              : (value as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values<
          TRes
        > {
  _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringMetrics$metrics$values(
    this._res,
  );

  TRes _res;

  call({DateTime? timestamp, String? value, String? $__typename}) => _res;
}

class Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError
    implements
        Fragment$MonitoringQueryError,
        Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage {
  Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError({
    required this.error,
    this.$__typename = 'MonitoringQueryError',
  });

  factory Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$error = json['error'];
    final l$$__typename = json['__typename'];
    return Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError(
      error: (l$error as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String error;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$error = error;
    _resultData['error'] = l$error;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$error = error;
    final l$$__typename = $__typename;
    return Object.hashAll([l$error, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$error = error;
    final lOther$error = other.error;
    if (l$error != lOther$error) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError
    on
        Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError {
  CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError<
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError
  >
  get copyWith =>
      CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError<
  TRes
> {
  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError
    instance,
    TRes Function(
      Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError;

  factory CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError;

  TRes call({String? error, String? $__typename});
}

class _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError<
          TRes
        > {
  _CopyWithImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError(
    this._instance,
    this._then,
  );

  final Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError
  _instance;

  final TRes Function(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? error = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError(
      error:
          error == _undefined || error == null
              ? _instance.error
              : (error as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError<
  TRes
>
    implements
        CopyWith$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError<
          TRes
        > {
  _CopyWithStubImpl$Query$GetOverallCpuAndNetworkMetrics$monitoring$networkUsage$overallUsage$$MonitoringQueryError(
    this._res,
  );

  TRes _res;

  call({String? error, String? $__typename}) => _res;
}

class Variables$Query$GetMemoryMetrics {
  factory Variables$Query$GetMemoryMetrics({
    DateTime? start,
    DateTime? end,
    required int step,
  }) => Variables$Query$GetMemoryMetrics._({
    if (start != null) r'start': start,
    if (end != null) r'end': end,
    r'step': step,
  });

  Variables$Query$GetMemoryMetrics._(this._$data);

  factory Variables$Query$GetMemoryMetrics.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('start')) {
      final l$start = data['start'];
      result$data['start'] = l$start == null ? null : dateTimeFromJson(l$start);
    }
    if (data.containsKey('end')) {
      final l$end = data['end'];
      result$data['end'] = l$end == null ? null : dateTimeFromJson(l$end);
    }
    final l$step = data['step'];
    result$data['step'] = (l$step as int);
    return Variables$Query$GetMemoryMetrics._(result$data);
  }

  Map<String, dynamic> _$data;

  DateTime? get start => (_$data['start'] as DateTime?);

  DateTime? get end => (_$data['end'] as DateTime?);

  int get step => (_$data['step'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('start')) {
      final l$start = start;
      result$data['start'] = l$start == null ? null : dateTimeToJson(l$start);
    }
    if (_$data.containsKey('end')) {
      final l$end = end;
      result$data['end'] = l$end == null ? null : dateTimeToJson(l$end);
    }
    final l$step = step;
    result$data['step'] = l$step;
    return result$data;
  }

  CopyWith$Variables$Query$GetMemoryMetrics<Variables$Query$GetMemoryMetrics>
  get copyWith => CopyWith$Variables$Query$GetMemoryMetrics(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$GetMemoryMetrics ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$start = start;
    final lOther$start = other.start;
    if (_$data.containsKey('start') != other._$data.containsKey('start')) {
      return false;
    }
    if (l$start != lOther$start) {
      return false;
    }
    final l$end = end;
    final lOther$end = other.end;
    if (_$data.containsKey('end') != other._$data.containsKey('end')) {
      return false;
    }
    if (l$end != lOther$end) {
      return false;
    }
    final l$step = step;
    final lOther$step = other.step;
    if (l$step != lOther$step) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$start = start;
    final l$end = end;
    final l$step = step;
    return Object.hashAll([
      _$data.containsKey('start') ? l$start : const {},
      _$data.containsKey('end') ? l$end : const {},
      l$step,
    ]);
  }
}

abstract class CopyWith$Variables$Query$GetMemoryMetrics<TRes> {
  factory CopyWith$Variables$Query$GetMemoryMetrics(
    Variables$Query$GetMemoryMetrics instance,
    TRes Function(Variables$Query$GetMemoryMetrics) then,
  ) = _CopyWithImpl$Variables$Query$GetMemoryMetrics;

  factory CopyWith$Variables$Query$GetMemoryMetrics.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetMemoryMetrics;

  TRes call({DateTime? start, DateTime? end, int? step});
}

class _CopyWithImpl$Variables$Query$GetMemoryMetrics<TRes>
    implements CopyWith$Variables$Query$GetMemoryMetrics<TRes> {
  _CopyWithImpl$Variables$Query$GetMemoryMetrics(this._instance, this._then);

  final Variables$Query$GetMemoryMetrics _instance;

  final TRes Function(Variables$Query$GetMemoryMetrics) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? start = _undefined,
    Object? end = _undefined,
    Object? step = _undefined,
  }) => _then(
    Variables$Query$GetMemoryMetrics._({
      ..._instance._$data,
      if (start != _undefined) 'start': (start as DateTime?),
      if (end != _undefined) 'end': (end as DateTime?),
      if (step != _undefined && step != null) 'step': (step as int),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$GetMemoryMetrics<TRes>
    implements CopyWith$Variables$Query$GetMemoryMetrics<TRes> {
  _CopyWithStubImpl$Variables$Query$GetMemoryMetrics(this._res);

  TRes _res;

  call({DateTime? start, DateTime? end, int? step}) => _res;
}

class Query$GetMemoryMetrics {
  Query$GetMemoryMetrics({
    required this.monitoring,
    this.$__typename = 'Query',
  });

  factory Query$GetMemoryMetrics.fromJson(Map<String, dynamic> json) {
    final l$monitoring = json['monitoring'];
    final l$$__typename = json['__typename'];
    return Query$GetMemoryMetrics(
      monitoring: Query$GetMemoryMetrics$monitoring.fromJson(
        (l$monitoring as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetMemoryMetrics$monitoring monitoring;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$monitoring = monitoring;
    _resultData['monitoring'] = l$monitoring.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$monitoring = monitoring;
    final l$$__typename = $__typename;
    return Object.hashAll([l$monitoring, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetMemoryMetrics || runtimeType != other.runtimeType) {
      return false;
    }
    final l$monitoring = monitoring;
    final lOther$monitoring = other.monitoring;
    if (l$monitoring != lOther$monitoring) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics on Query$GetMemoryMetrics {
  CopyWith$Query$GetMemoryMetrics<Query$GetMemoryMetrics> get copyWith =>
      CopyWith$Query$GetMemoryMetrics(this, (i) => i);
}

abstract class CopyWith$Query$GetMemoryMetrics<TRes> {
  factory CopyWith$Query$GetMemoryMetrics(
    Query$GetMemoryMetrics instance,
    TRes Function(Query$GetMemoryMetrics) then,
  ) = _CopyWithImpl$Query$GetMemoryMetrics;

  factory CopyWith$Query$GetMemoryMetrics.stub(TRes res) =
      _CopyWithStubImpl$Query$GetMemoryMetrics;

  TRes call({
    Query$GetMemoryMetrics$monitoring? monitoring,
    String? $__typename,
  });
  CopyWith$Query$GetMemoryMetrics$monitoring<TRes> get monitoring;
}

class _CopyWithImpl$Query$GetMemoryMetrics<TRes>
    implements CopyWith$Query$GetMemoryMetrics<TRes> {
  _CopyWithImpl$Query$GetMemoryMetrics(this._instance, this._then);

  final Query$GetMemoryMetrics _instance;

  final TRes Function(Query$GetMemoryMetrics) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? monitoring = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetMemoryMetrics(
      monitoring:
          monitoring == _undefined || monitoring == null
              ? _instance.monitoring
              : (monitoring as Query$GetMemoryMetrics$monitoring),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$GetMemoryMetrics$monitoring<TRes> get monitoring {
    final local$monitoring = _instance.monitoring;
    return CopyWith$Query$GetMemoryMetrics$monitoring(
      local$monitoring,
      (e) => call(monitoring: e),
    );
  }
}

class _CopyWithStubImpl$Query$GetMemoryMetrics<TRes>
    implements CopyWith$Query$GetMemoryMetrics<TRes> {
  _CopyWithStubImpl$Query$GetMemoryMetrics(this._res);

  TRes _res;

  call({Query$GetMemoryMetrics$monitoring? monitoring, String? $__typename}) =>
      _res;

  CopyWith$Query$GetMemoryMetrics$monitoring<TRes> get monitoring =>
      CopyWith$Query$GetMemoryMetrics$monitoring.stub(_res);
}

const documentNodeQueryGetMemoryMetrics = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetMemoryMetrics'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'start')),
          type: NamedTypeNode(
            name: NameNode(value: 'DateTime'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'end')),
          type: NamedTypeNode(
            name: NameNode(value: 'DateTime'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'step')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'monitoring'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'memoryUsage'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'start'),
                      value: VariableNode(name: NameNode(value: 'start')),
                    ),
                    ArgumentNode(
                      name: NameNode(value: 'end'),
                      value: VariableNode(name: NameNode(value: 'end')),
                    ),
                    ArgumentNode(
                      name: NameNode(value: 'step'),
                      value: VariableNode(name: NameNode(value: 'step')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'overallUsage'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FragmentSpreadNode(
                              name: NameNode(value: 'MonitoringQueryError'),
                              directives: [],
                            ),
                            FragmentSpreadNode(
                              name: NameNode(value: 'MonitoringValues'),
                              directives: [],
                            ),
                            FieldNode(
                              name: NameNode(value: '__typename'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: 'swapUsageOverall'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FragmentSpreadNode(
                              name: NameNode(value: 'MonitoringQueryError'),
                              directives: [],
                            ),
                            FragmentSpreadNode(
                              name: NameNode(value: 'MonitoringValues'),
                              directives: [],
                            ),
                            FieldNode(
                              name: NameNode(value: '__typename'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: 'averageUsageByService'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FragmentSpreadNode(
                              name: NameNode(value: 'MonitoringQueryError'),
                              directives: [],
                            ),
                            FragmentSpreadNode(
                              name: NameNode(value: 'MonitoringMetrics'),
                              directives: [],
                            ),
                            FieldNode(
                              name: NameNode(value: '__typename'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: 'maxUsageByService'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FragmentSpreadNode(
                              name: NameNode(value: 'MonitoringQueryError'),
                              directives: [],
                            ),
                            FragmentSpreadNode(
                              name: NameNode(value: 'MonitoringMetrics'),
                              directives: [],
                            ),
                            FieldNode(
                              name: NameNode(value: '__typename'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionMonitoringQueryError,
    fragmentDefinitionMonitoringValues,
    fragmentDefinitionMonitoringMetrics,
  ],
);
Query$GetMemoryMetrics _parserFn$Query$GetMemoryMetrics(
  Map<String, dynamic> data,
) => Query$GetMemoryMetrics.fromJson(data);
typedef OnQueryComplete$Query$GetMemoryMetrics =
    FutureOr<void> Function(Map<String, dynamic>?, Query$GetMemoryMetrics?);

class Options$Query$GetMemoryMetrics
    extends graphql.QueryOptions<Query$GetMemoryMetrics> {
  Options$Query$GetMemoryMetrics({
    String? operationName,
    required Variables$Query$GetMemoryMetrics variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetMemoryMetrics? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetMemoryMetrics? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete:
             onComplete == null
                 ? null
                 : (data) => onComplete(
                   data,
                   data == null ? null : _parserFn$Query$GetMemoryMetrics(data),
                 ),
         onError: onError,
         document: documentNodeQueryGetMemoryMetrics,
         parserFn: _parserFn$Query$GetMemoryMetrics,
       );

  final OnQueryComplete$Query$GetMemoryMetrics? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$GetMemoryMetrics
    extends graphql.WatchQueryOptions<Query$GetMemoryMetrics> {
  WatchOptions$Query$GetMemoryMetrics({
    String? operationName,
    required Variables$Query$GetMemoryMetrics variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetMemoryMetrics? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryGetMemoryMetrics,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$GetMemoryMetrics,
       );
}

class FetchMoreOptions$Query$GetMemoryMetrics extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetMemoryMetrics({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetMemoryMetrics variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryGetMemoryMetrics,
       );
}

extension ClientExtension$Query$GetMemoryMetrics on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetMemoryMetrics>> query$GetMemoryMetrics(
    Options$Query$GetMemoryMetrics options,
  ) async => await this.query(options);
  graphql.ObservableQuery<Query$GetMemoryMetrics> watchQuery$GetMemoryMetrics(
    WatchOptions$Query$GetMemoryMetrics options,
  ) => this.watchQuery(options);
  void writeQuery$GetMemoryMetrics({
    required Query$GetMemoryMetrics data,
    required Variables$Query$GetMemoryMetrics variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryGetMemoryMetrics),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Query$GetMemoryMetrics? readQuery$GetMemoryMetrics({
    required Variables$Query$GetMemoryMetrics variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(
          document: documentNodeQueryGetMemoryMetrics,
        ),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetMemoryMetrics.fromJson(result);
  }
}

class Query$GetMemoryMetrics$monitoring {
  Query$GetMemoryMetrics$monitoring({
    required this.memoryUsage,
    this.$__typename = 'Monitoring',
  });

  factory Query$GetMemoryMetrics$monitoring.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$memoryUsage = json['memoryUsage'];
    final l$$__typename = json['__typename'];
    return Query$GetMemoryMetrics$monitoring(
      memoryUsage: Query$GetMemoryMetrics$monitoring$memoryUsage.fromJson(
        (l$memoryUsage as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetMemoryMetrics$monitoring$memoryUsage memoryUsage;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$memoryUsage = memoryUsage;
    _resultData['memoryUsage'] = l$memoryUsage.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$memoryUsage = memoryUsage;
    final l$$__typename = $__typename;
    return Object.hashAll([l$memoryUsage, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetMemoryMetrics$monitoring ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$memoryUsage = memoryUsage;
    final lOther$memoryUsage = other.memoryUsage;
    if (l$memoryUsage != lOther$memoryUsage) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring
    on Query$GetMemoryMetrics$monitoring {
  CopyWith$Query$GetMemoryMetrics$monitoring<Query$GetMemoryMetrics$monitoring>
  get copyWith => CopyWith$Query$GetMemoryMetrics$monitoring(this, (i) => i);
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring<TRes> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring(
    Query$GetMemoryMetrics$monitoring instance,
    TRes Function(Query$GetMemoryMetrics$monitoring) then,
  ) = _CopyWithImpl$Query$GetMemoryMetrics$monitoring;

  factory CopyWith$Query$GetMemoryMetrics$monitoring.stub(TRes res) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring;

  TRes call({
    Query$GetMemoryMetrics$monitoring$memoryUsage? memoryUsage,
    String? $__typename,
  });
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage<TRes> get memoryUsage;
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring<TRes>
    implements CopyWith$Query$GetMemoryMetrics$monitoring<TRes> {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring(this._instance, this._then);

  final Query$GetMemoryMetrics$monitoring _instance;

  final TRes Function(Query$GetMemoryMetrics$monitoring) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? memoryUsage = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetMemoryMetrics$monitoring(
      memoryUsage:
          memoryUsage == _undefined || memoryUsage == null
              ? _instance.memoryUsage
              : (memoryUsage as Query$GetMemoryMetrics$monitoring$memoryUsage),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage<TRes> get memoryUsage {
    final local$memoryUsage = _instance.memoryUsage;
    return CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage(
      local$memoryUsage,
      (e) => call(memoryUsage: e),
    );
  }
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring<TRes>
    implements CopyWith$Query$GetMemoryMetrics$monitoring<TRes> {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring(this._res);

  TRes _res;

  call({
    Query$GetMemoryMetrics$monitoring$memoryUsage? memoryUsage,
    String? $__typename,
  }) => _res;

  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage<TRes>
  get memoryUsage =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage.stub(_res);
}

class Query$GetMemoryMetrics$monitoring$memoryUsage {
  Query$GetMemoryMetrics$monitoring$memoryUsage({
    required this.overallUsage,
    required this.swapUsageOverall,
    required this.averageUsageByService,
    required this.maxUsageByService,
    this.$__typename = 'MemoryMonitoring',
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$overallUsage = json['overallUsage'];
    final l$swapUsageOverall = json['swapUsageOverall'];
    final l$averageUsageByService = json['averageUsageByService'];
    final l$maxUsageByService = json['maxUsageByService'];
    final l$$__typename = json['__typename'];
    return Query$GetMemoryMetrics$monitoring$memoryUsage(
      overallUsage:
          Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage.fromJson(
            (l$overallUsage as Map<String, dynamic>),
          ),
      swapUsageOverall:
          Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall.fromJson(
            (l$swapUsageOverall as Map<String, dynamic>),
          ),
      averageUsageByService:
          Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService.fromJson(
            (l$averageUsageByService as Map<String, dynamic>),
          ),
      maxUsageByService:
          Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService.fromJson(
            (l$maxUsageByService as Map<String, dynamic>),
          ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage overallUsage;

  final Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall
  swapUsageOverall;

  final Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService
  averageUsageByService;

  final Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService
  maxUsageByService;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$overallUsage = overallUsage;
    _resultData['overallUsage'] = l$overallUsage.toJson();
    final l$swapUsageOverall = swapUsageOverall;
    _resultData['swapUsageOverall'] = l$swapUsageOverall.toJson();
    final l$averageUsageByService = averageUsageByService;
    _resultData['averageUsageByService'] = l$averageUsageByService.toJson();
    final l$maxUsageByService = maxUsageByService;
    _resultData['maxUsageByService'] = l$maxUsageByService.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$overallUsage = overallUsage;
    final l$swapUsageOverall = swapUsageOverall;
    final l$averageUsageByService = averageUsageByService;
    final l$maxUsageByService = maxUsageByService;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$overallUsage,
      l$swapUsageOverall,
      l$averageUsageByService,
      l$maxUsageByService,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetMemoryMetrics$monitoring$memoryUsage ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$overallUsage = overallUsage;
    final lOther$overallUsage = other.overallUsage;
    if (l$overallUsage != lOther$overallUsage) {
      return false;
    }
    final l$swapUsageOverall = swapUsageOverall;
    final lOther$swapUsageOverall = other.swapUsageOverall;
    if (l$swapUsageOverall != lOther$swapUsageOverall) {
      return false;
    }
    final l$averageUsageByService = averageUsageByService;
    final lOther$averageUsageByService = other.averageUsageByService;
    if (l$averageUsageByService != lOther$averageUsageByService) {
      return false;
    }
    final l$maxUsageByService = maxUsageByService;
    final lOther$maxUsageByService = other.maxUsageByService;
    if (l$maxUsageByService != lOther$maxUsageByService) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage
    on Query$GetMemoryMetrics$monitoring$memoryUsage {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage<
    Query$GetMemoryMetrics$monitoring$memoryUsage
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage(this, (i) => i);
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage<TRes> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage(
    Query$GetMemoryMetrics$monitoring$memoryUsage instance,
    TRes Function(Query$GetMemoryMetrics$monitoring$memoryUsage) then,
  ) = _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage.stub(
    TRes res,
  ) = _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage;

  TRes call({
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage? overallUsage,
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall?
    swapUsageOverall,
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService?
    averageUsageByService,
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService?
    maxUsageByService,
    String? $__typename,
  });
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage<TRes>
  get overallUsage;
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall<TRes>
  get swapUsageOverall;
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService<
    TRes
  >
  get averageUsageByService;
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService<TRes>
  get maxUsageByService;
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage<TRes>
    implements CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage<TRes> {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage _instance;

  final TRes Function(Query$GetMemoryMetrics$monitoring$memoryUsage) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? overallUsage = _undefined,
    Object? swapUsageOverall = _undefined,
    Object? averageUsageByService = _undefined,
    Object? maxUsageByService = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage(
      overallUsage:
          overallUsage == _undefined || overallUsage == null
              ? _instance.overallUsage
              : (overallUsage
                  as Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage),
      swapUsageOverall:
          swapUsageOverall == _undefined || swapUsageOverall == null
              ? _instance.swapUsageOverall
              : (swapUsageOverall
                  as Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall),
      averageUsageByService:
          averageUsageByService == _undefined || averageUsageByService == null
              ? _instance.averageUsageByService
              : (averageUsageByService
                  as Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService),
      maxUsageByService:
          maxUsageByService == _undefined || maxUsageByService == null
              ? _instance.maxUsageByService
              : (maxUsageByService
                  as Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage<TRes>
  get overallUsage {
    final local$overallUsage = _instance.overallUsage;
    return CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage(
      local$overallUsage,
      (e) => call(overallUsage: e),
    );
  }

  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall<TRes>
  get swapUsageOverall {
    final local$swapUsageOverall = _instance.swapUsageOverall;
    return CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall(
      local$swapUsageOverall,
      (e) => call(swapUsageOverall: e),
    );
  }

  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService<
    TRes
  >
  get averageUsageByService {
    final local$averageUsageByService = _instance.averageUsageByService;
    return CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService(
      local$averageUsageByService,
      (e) => call(averageUsageByService: e),
    );
  }

  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService<TRes>
  get maxUsageByService {
    final local$maxUsageByService = _instance.maxUsageByService;
    return CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService(
      local$maxUsageByService,
      (e) => call(maxUsageByService: e),
    );
  }
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage<TRes>
    implements CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage<TRes> {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage(this._res);

  TRes _res;

  call({
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage? overallUsage,
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall?
    swapUsageOverall,
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService?
    averageUsageByService,
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService?
    maxUsageByService,
    String? $__typename,
  }) => _res;

  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage<TRes>
  get overallUsage =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage.stub(
        _res,
      );

  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall<TRes>
  get swapUsageOverall =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall.stub(
        _res,
      );

  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService<
    TRes
  >
  get averageUsageByService =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService.stub(
        _res,
      );

  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService<TRes>
  get maxUsageByService =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService.stub(
        _res,
      );
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage {
  Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage({
    required this.$__typename,
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage.fromJson(
    Map<String, dynamic> json,
  ) {
    switch (json["__typename"] as String) {
      case "MonitoringValues":
        return Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues.fromJson(
          json,
        );

      case "MonitoringQueryError":
        return Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError.fromJson(
          json,
        );

      default:
        final l$$__typename = json['__typename'];
        return Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage(
          $__typename: (l$$__typename as String),
        );
    }
  }

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$$__typename = $__typename;
    return Object.hashAll([l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage
    on Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage<
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage(
        this,
        (i) => i,
      );
  _T when<_T>({
    required _T Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues,
    )
    monitoringValues,
    required _T Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError,
    )
    monitoringQueryError,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "MonitoringValues":
        return monitoringValues(
          this
              as Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues,
        );

      case "MonitoringQueryError":
        return monitoringQueryError(
          this
              as Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError,
        );

      default:
        return orElse();
    }
  }

  _T maybeWhen<_T>({
    _T Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues,
    )?
    monitoringValues,
    _T Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError,
    )?
    monitoringQueryError,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "MonitoringValues":
        if (monitoringValues != null) {
          return monitoringValues(
            this
                as Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues,
          );
        } else {
          return orElse();
        }

      case "MonitoringQueryError":
        if (monitoringQueryError != null) {
          return monitoringQueryError(
            this
                as Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError,
          );
        } else {
          return orElse();
        }

      default:
        return orElse();
    }
  }
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage(
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage instance,
    TRes Function(Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage)
    then,
  ) = _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage.stub(
    TRes res,
  ) = _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage;

  TRes call({String? $__typename});
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? $__typename = _undefined}) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage(
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage(
    this._res,
  );

  TRes _res;

  call({String? $__typename}) => _res;
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues
    implements
        Fragment$MonitoringValues,
        Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage {
  Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues({
    required this.values,
    this.$__typename = 'MonitoringValues',
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$values = json['values'];
    final l$$__typename = json['__typename'];
    return Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues(
      values:
          (l$values as List<dynamic>)
              .map(
                (e) =>
                    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values.fromJson(
                      (e as Map<String, dynamic>),
                    ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values
  >
  values;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$values = values;
    _resultData['values'] = l$values.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$values = values;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$values.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$values = values;
    final lOther$values = other.values;
    if (l$values.length != lOther$values.length) {
      return false;
    }
    for (int i = 0; i < l$values.length; i++) {
      final l$values$entry = l$values[i];
      final lOther$values$entry = lOther$values[i];
      if (l$values$entry != lOther$values$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues
    on Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues<
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues(
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues
    instance,
    TRes Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues;

  TRes call({
    List<
      Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values
    >?
    values,
    String? $__typename,
  });
  TRes values(
    Iterable<
      Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values
    >
    Function(
      Iterable<
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values<
          Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues
  _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? values = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues(
      values:
          values == _undefined || values == null
              ? _instance.values
              : (values
                  as List<
                    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values
                  >),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes values(
    Iterable<
      Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values
    >
    Function(
      Iterable<
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values<
          Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values
        >
      >,
    )
    _fn,
  ) => call(
    values:
        _fn(
          _instance.values.map(
            (e) =>
                CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values(
                  e,
                  (i) => i,
                ),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues(
    this._res,
  );

  TRes _res;

  call({
    List<
      Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values
    >?
    values,
    String? $__typename,
  }) => _res;

  values(_fn) => _res;
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values
    implements Fragment$MonitoringValues$values {
  Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values({
    required this.value,
    required this.timestamp,
    this.$__typename = 'MonitoringValue',
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$value = json['value'];
    final l$timestamp = json['timestamp'];
    final l$$__typename = json['__typename'];
    return Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values(
      value: (l$value as String),
      timestamp: dateTimeFromJson(l$timestamp),
      $__typename: (l$$__typename as String),
    );
  }

  final String value;

  final DateTime timestamp;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$value = value;
    _resultData['value'] = l$value;
    final l$timestamp = timestamp;
    _resultData['timestamp'] = dateTimeToJson(l$timestamp);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$value = value;
    final l$timestamp = timestamp;
    final l$$__typename = $__typename;
    return Object.hashAll([l$value, l$timestamp, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
      return false;
    }
    final l$timestamp = timestamp;
    final lOther$timestamp = other.timestamp;
    if (l$timestamp != lOther$timestamp) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values
    on
        Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values<
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values(
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values
    instance,
    TRes Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values;

  TRes call({String? value, DateTime? timestamp, String? $__typename});
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values
  _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? value = _undefined,
    Object? timestamp = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values(
      value:
          value == _undefined || value == null
              ? _instance.value
              : (value as String),
      timestamp:
          timestamp == _undefined || timestamp == null
              ? _instance.timestamp
              : (timestamp as DateTime),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringValues$values(
    this._res,
  );

  TRes _res;

  call({String? value, DateTime? timestamp, String? $__typename}) => _res;
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError
    implements
        Fragment$MonitoringQueryError,
        Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage {
  Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError({
    required this.error,
    this.$__typename = 'MonitoringQueryError',
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$error = json['error'];
    final l$$__typename = json['__typename'];
    return Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError(
      error: (l$error as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String error;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$error = error;
    _resultData['error'] = l$error;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$error = error;
    final l$$__typename = $__typename;
    return Object.hashAll([l$error, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$error = error;
    final lOther$error = other.error;
    if (l$error != lOther$error) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError
    on
        Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError<
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError(
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError
    instance,
    TRes Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError;

  TRes call({String? error, String? $__typename});
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError
  _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? error = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError(
      error:
          error == _undefined || error == null
              ? _instance.error
              : (error as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$overallUsage$$MonitoringQueryError(
    this._res,
  );

  TRes _res;

  call({String? error, String? $__typename}) => _res;
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall {
  Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall({
    required this.$__typename,
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall.fromJson(
    Map<String, dynamic> json,
  ) {
    switch (json["__typename"] as String) {
      case "MonitoringValues":
        return Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues.fromJson(
          json,
        );

      case "MonitoringQueryError":
        return Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError.fromJson(
          json,
        );

      default:
        final l$$__typename = json['__typename'];
        return Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall(
          $__typename: (l$$__typename as String),
        );
    }
  }

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$$__typename = $__typename;
    return Object.hashAll([l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall
    on Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall<
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall(
        this,
        (i) => i,
      );
  _T when<_T>({
    required _T Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues,
    )
    monitoringValues,
    required _T Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError,
    )
    monitoringQueryError,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "MonitoringValues":
        return monitoringValues(
          this
              as Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues,
        );

      case "MonitoringQueryError":
        return monitoringQueryError(
          this
              as Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError,
        );

      default:
        return orElse();
    }
  }

  _T maybeWhen<_T>({
    _T Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues,
    )?
    monitoringValues,
    _T Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError,
    )?
    monitoringQueryError,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "MonitoringValues":
        if (monitoringValues != null) {
          return monitoringValues(
            this
                as Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues,
          );
        } else {
          return orElse();
        }

      case "MonitoringQueryError":
        if (monitoringQueryError != null) {
          return monitoringQueryError(
            this
                as Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError,
          );
        } else {
          return orElse();
        }

      default:
        return orElse();
    }
  }
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall(
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall instance,
    TRes Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall,
    )
    then,
  ) = _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall;

  TRes call({String? $__typename});
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall
  _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? $__typename = _undefined}) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall(
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall(
    this._res,
  );

  TRes _res;

  call({String? $__typename}) => _res;
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues
    implements
        Fragment$MonitoringValues,
        Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall {
  Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues({
    required this.values,
    this.$__typename = 'MonitoringValues',
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$values = json['values'];
    final l$$__typename = json['__typename'];
    return Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues(
      values:
          (l$values as List<dynamic>)
              .map(
                (e) =>
                    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values.fromJson(
                      (e as Map<String, dynamic>),
                    ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values
  >
  values;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$values = values;
    _resultData['values'] = l$values.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$values = values;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$values.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$values = values;
    final lOther$values = other.values;
    if (l$values.length != lOther$values.length) {
      return false;
    }
    for (int i = 0; i < l$values.length; i++) {
      final l$values$entry = l$values[i];
      final lOther$values$entry = lOther$values[i];
      if (l$values$entry != lOther$values$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues
    on
        Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues<
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues(
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues
    instance,
    TRes Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues;

  TRes call({
    List<
      Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values
    >?
    values,
    String? $__typename,
  });
  TRes values(
    Iterable<
      Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values
    >
    Function(
      Iterable<
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values<
          Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues
  _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? values = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues(
      values:
          values == _undefined || values == null
              ? _instance.values
              : (values
                  as List<
                    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values
                  >),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes values(
    Iterable<
      Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values
    >
    Function(
      Iterable<
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values<
          Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values
        >
      >,
    )
    _fn,
  ) => call(
    values:
        _fn(
          _instance.values.map(
            (e) =>
                CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values(
                  e,
                  (i) => i,
                ),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues(
    this._res,
  );

  TRes _res;

  call({
    List<
      Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values
    >?
    values,
    String? $__typename,
  }) => _res;

  values(_fn) => _res;
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values
    implements Fragment$MonitoringValues$values {
  Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values({
    required this.value,
    required this.timestamp,
    this.$__typename = 'MonitoringValue',
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$value = json['value'];
    final l$timestamp = json['timestamp'];
    final l$$__typename = json['__typename'];
    return Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values(
      value: (l$value as String),
      timestamp: dateTimeFromJson(l$timestamp),
      $__typename: (l$$__typename as String),
    );
  }

  final String value;

  final DateTime timestamp;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$value = value;
    _resultData['value'] = l$value;
    final l$timestamp = timestamp;
    _resultData['timestamp'] = dateTimeToJson(l$timestamp);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$value = value;
    final l$timestamp = timestamp;
    final l$$__typename = $__typename;
    return Object.hashAll([l$value, l$timestamp, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
      return false;
    }
    final l$timestamp = timestamp;
    final lOther$timestamp = other.timestamp;
    if (l$timestamp != lOther$timestamp) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values
    on
        Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values<
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values(
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values
    instance,
    TRes Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values;

  TRes call({String? value, DateTime? timestamp, String? $__typename});
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values
  _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? value = _undefined,
    Object? timestamp = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values(
      value:
          value == _undefined || value == null
              ? _instance.value
              : (value as String),
      timestamp:
          timestamp == _undefined || timestamp == null
              ? _instance.timestamp
              : (timestamp as DateTime),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringValues$values(
    this._res,
  );

  TRes _res;

  call({String? value, DateTime? timestamp, String? $__typename}) => _res;
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError
    implements
        Fragment$MonitoringQueryError,
        Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall {
  Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError({
    required this.error,
    this.$__typename = 'MonitoringQueryError',
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$error = json['error'];
    final l$$__typename = json['__typename'];
    return Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError(
      error: (l$error as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String error;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$error = error;
    _resultData['error'] = l$error;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$error = error;
    final l$$__typename = $__typename;
    return Object.hashAll([l$error, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$error = error;
    final lOther$error = other.error;
    if (l$error != lOther$error) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError
    on
        Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError<
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError(
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError
    instance,
    TRes Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError;

  TRes call({String? error, String? $__typename});
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError
  _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? error = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError(
      error:
          error == _undefined || error == null
              ? _instance.error
              : (error as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$swapUsageOverall$$MonitoringQueryError(
    this._res,
  );

  TRes _res;

  call({String? error, String? $__typename}) => _res;
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService {
  Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService({
    required this.$__typename,
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService.fromJson(
    Map<String, dynamic> json,
  ) {
    switch (json["__typename"] as String) {
      case "MonitoringMetrics":
        return Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics.fromJson(
          json,
        );

      case "MonitoringQueryError":
        return Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError.fromJson(
          json,
        );

      default:
        final l$$__typename = json['__typename'];
        return Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService(
          $__typename: (l$$__typename as String),
        );
    }
  }

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$$__typename = $__typename;
    return Object.hashAll([l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService
    on Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService<
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService(
        this,
        (i) => i,
      );
  _T when<_T>({
    required _T Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics,
    )
    monitoringMetrics,
    required _T Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError,
    )
    monitoringQueryError,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "MonitoringMetrics":
        return monitoringMetrics(
          this
              as Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics,
        );

      case "MonitoringQueryError":
        return monitoringQueryError(
          this
              as Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError,
        );

      default:
        return orElse();
    }
  }

  _T maybeWhen<_T>({
    _T Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics,
    )?
    monitoringMetrics,
    _T Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError,
    )?
    monitoringQueryError,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "MonitoringMetrics":
        if (monitoringMetrics != null) {
          return monitoringMetrics(
            this
                as Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics,
          );
        } else {
          return orElse();
        }

      case "MonitoringQueryError":
        if (monitoringQueryError != null) {
          return monitoringQueryError(
            this
                as Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError,
          );
        } else {
          return orElse();
        }

      default:
        return orElse();
    }
  }
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService(
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService
    instance,
    TRes Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService;

  TRes call({String? $__typename});
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService
  _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? $__typename = _undefined}) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService(
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService(
    this._res,
  );

  TRes _res;

  call({String? $__typename}) => _res;
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics
    implements
        Fragment$MonitoringMetrics,
        Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService {
  Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics({
    required this.metrics,
    this.$__typename = 'MonitoringMetrics',
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$metrics = json['metrics'];
    final l$$__typename = json['__typename'];
    return Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics(
      metrics:
          (l$metrics as List<dynamic>)
              .map(
                (e) =>
                    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics.fromJson(
                      (e as Map<String, dynamic>),
                    ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics
  >
  metrics;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$metrics = metrics;
    _resultData['metrics'] = l$metrics.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$metrics = metrics;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$metrics.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$metrics = metrics;
    final lOther$metrics = other.metrics;
    if (l$metrics.length != lOther$metrics.length) {
      return false;
    }
    for (int i = 0; i < l$metrics.length; i++) {
      final l$metrics$entry = l$metrics[i];
      final lOther$metrics$entry = lOther$metrics[i];
      if (l$metrics$entry != lOther$metrics$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics
    on
        Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics<
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics(
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics
    instance,
    TRes Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics;

  TRes call({
    List<
      Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics
    >?
    metrics,
    String? $__typename,
  });
  TRes metrics(
    Iterable<
      Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics
    >
    Function(
      Iterable<
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics<
          Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics
  _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? metrics = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics(
      metrics:
          metrics == _undefined || metrics == null
              ? _instance.metrics
              : (metrics
                  as List<
                    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics
                  >),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes metrics(
    Iterable<
      Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics
    >
    Function(
      Iterable<
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics<
          Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics
        >
      >,
    )
    _fn,
  ) => call(
    metrics:
        _fn(
          _instance.metrics.map(
            (e) =>
                CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics(
                  e,
                  (i) => i,
                ),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics(
    this._res,
  );

  TRes _res;

  call({
    List<
      Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics
    >?
    metrics,
    String? $__typename,
  }) => _res;

  metrics(_fn) => _res;
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics
    implements Fragment$MonitoringMetrics$metrics {
  Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics({
    required this.metricId,
    required this.values,
    this.$__typename = 'MonitoringMetric',
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$metricId = json['metricId'];
    final l$values = json['values'];
    final l$$__typename = json['__typename'];
    return Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics(
      metricId: (l$metricId as String),
      values:
          (l$values as List<dynamic>)
              .map(
                (e) =>
                    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values.fromJson(
                      (e as Map<String, dynamic>),
                    ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String metricId;

  final List<
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values
  >
  values;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$metricId = metricId;
    _resultData['metricId'] = l$metricId;
    final l$values = values;
    _resultData['values'] = l$values.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$metricId = metricId;
    final l$values = values;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$metricId,
      Object.hashAll(l$values.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$metricId = metricId;
    final lOther$metricId = other.metricId;
    if (l$metricId != lOther$metricId) {
      return false;
    }
    final l$values = values;
    final lOther$values = other.values;
    if (l$values.length != lOther$values.length) {
      return false;
    }
    for (int i = 0; i < l$values.length; i++) {
      final l$values$entry = l$values[i];
      final lOther$values$entry = lOther$values[i];
      if (l$values$entry != lOther$values$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics
    on
        Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics<
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics(
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics
    instance,
    TRes Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics;

  TRes call({
    String? metricId,
    List<
      Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values
    >?
    values,
    String? $__typename,
  });
  TRes values(
    Iterable<
      Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values
    >
    Function(
      Iterable<
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values<
          Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics
  _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? metricId = _undefined,
    Object? values = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics(
      metricId:
          metricId == _undefined || metricId == null
              ? _instance.metricId
              : (metricId as String),
      values:
          values == _undefined || values == null
              ? _instance.values
              : (values
                  as List<
                    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values
                  >),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes values(
    Iterable<
      Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values
    >
    Function(
      Iterable<
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values<
          Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values
        >
      >,
    )
    _fn,
  ) => call(
    values:
        _fn(
          _instance.values.map(
            (e) =>
                CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values(
                  e,
                  (i) => i,
                ),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics(
    this._res,
  );

  TRes _res;

  call({
    String? metricId,
    List<
      Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values
    >?
    values,
    String? $__typename,
  }) => _res;

  values(_fn) => _res;
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values
    implements Fragment$MonitoringMetrics$metrics$values {
  Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values({
    required this.timestamp,
    required this.value,
    this.$__typename = 'MonitoringValue',
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$timestamp = json['timestamp'];
    final l$value = json['value'];
    final l$$__typename = json['__typename'];
    return Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values(
      timestamp: dateTimeFromJson(l$timestamp),
      value: (l$value as String),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime timestamp;

  final String value;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$timestamp = timestamp;
    _resultData['timestamp'] = dateTimeToJson(l$timestamp);
    final l$value = value;
    _resultData['value'] = l$value;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$timestamp = timestamp;
    final l$value = value;
    final l$$__typename = $__typename;
    return Object.hashAll([l$timestamp, l$value, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$timestamp = timestamp;
    final lOther$timestamp = other.timestamp;
    if (l$timestamp != lOther$timestamp) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values
    on
        Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values<
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values(
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values
    instance,
    TRes Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values;

  TRes call({DateTime? timestamp, String? value, String? $__typename});
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values
  _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? timestamp = _undefined,
    Object? value = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values(
      timestamp:
          timestamp == _undefined || timestamp == null
              ? _instance.timestamp
              : (timestamp as DateTime),
      value:
          value == _undefined || value == null
              ? _instance.value
              : (value as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringMetrics$metrics$values(
    this._res,
  );

  TRes _res;

  call({DateTime? timestamp, String? value, String? $__typename}) => _res;
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError
    implements
        Fragment$MonitoringQueryError,
        Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService {
  Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError({
    required this.error,
    this.$__typename = 'MonitoringQueryError',
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$error = json['error'];
    final l$$__typename = json['__typename'];
    return Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError(
      error: (l$error as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String error;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$error = error;
    _resultData['error'] = l$error;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$error = error;
    final l$$__typename = $__typename;
    return Object.hashAll([l$error, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$error = error;
    final lOther$error = other.error;
    if (l$error != lOther$error) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError
    on
        Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError<
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError(
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError
    instance,
    TRes Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError;

  TRes call({String? error, String? $__typename});
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError
  _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? error = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError(
      error:
          error == _undefined || error == null
              ? _instance.error
              : (error as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$averageUsageByService$$MonitoringQueryError(
    this._res,
  );

  TRes _res;

  call({String? error, String? $__typename}) => _res;
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService {
  Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService({
    required this.$__typename,
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService.fromJson(
    Map<String, dynamic> json,
  ) {
    switch (json["__typename"] as String) {
      case "MonitoringMetrics":
        return Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics.fromJson(
          json,
        );

      case "MonitoringQueryError":
        return Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError.fromJson(
          json,
        );

      default:
        final l$$__typename = json['__typename'];
        return Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService(
          $__typename: (l$$__typename as String),
        );
    }
  }

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$$__typename = $__typename;
    return Object.hashAll([l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService
    on Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService<
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService(
        this,
        (i) => i,
      );
  _T when<_T>({
    required _T Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics,
    )
    monitoringMetrics,
    required _T Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError,
    )
    monitoringQueryError,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "MonitoringMetrics":
        return monitoringMetrics(
          this
              as Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics,
        );

      case "MonitoringQueryError":
        return monitoringQueryError(
          this
              as Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError,
        );

      default:
        return orElse();
    }
  }

  _T maybeWhen<_T>({
    _T Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics,
    )?
    monitoringMetrics,
    _T Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError,
    )?
    monitoringQueryError,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "MonitoringMetrics":
        if (monitoringMetrics != null) {
          return monitoringMetrics(
            this
                as Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics,
          );
        } else {
          return orElse();
        }

      case "MonitoringQueryError":
        if (monitoringQueryError != null) {
          return monitoringQueryError(
            this
                as Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError,
          );
        } else {
          return orElse();
        }

      default:
        return orElse();
    }
  }
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService(
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService instance,
    TRes Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService;

  TRes call({String? $__typename});
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService
  _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? $__typename = _undefined}) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService(
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService(
    this._res,
  );

  TRes _res;

  call({String? $__typename}) => _res;
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics
    implements
        Fragment$MonitoringMetrics,
        Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService {
  Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics({
    required this.metrics,
    this.$__typename = 'MonitoringMetrics',
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$metrics = json['metrics'];
    final l$$__typename = json['__typename'];
    return Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics(
      metrics:
          (l$metrics as List<dynamic>)
              .map(
                (e) =>
                    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics.fromJson(
                      (e as Map<String, dynamic>),
                    ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics
  >
  metrics;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$metrics = metrics;
    _resultData['metrics'] = l$metrics.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$metrics = metrics;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$metrics.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$metrics = metrics;
    final lOther$metrics = other.metrics;
    if (l$metrics.length != lOther$metrics.length) {
      return false;
    }
    for (int i = 0; i < l$metrics.length; i++) {
      final l$metrics$entry = l$metrics[i];
      final lOther$metrics$entry = lOther$metrics[i];
      if (l$metrics$entry != lOther$metrics$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics
    on
        Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics<
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics(
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics
    instance,
    TRes Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics;

  TRes call({
    List<
      Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics
    >?
    metrics,
    String? $__typename,
  });
  TRes metrics(
    Iterable<
      Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics
    >
    Function(
      Iterable<
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics<
          Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics
  _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? metrics = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics(
      metrics:
          metrics == _undefined || metrics == null
              ? _instance.metrics
              : (metrics
                  as List<
                    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics
                  >),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes metrics(
    Iterable<
      Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics
    >
    Function(
      Iterable<
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics<
          Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics
        >
      >,
    )
    _fn,
  ) => call(
    metrics:
        _fn(
          _instance.metrics.map(
            (e) =>
                CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics(
                  e,
                  (i) => i,
                ),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics(
    this._res,
  );

  TRes _res;

  call({
    List<
      Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics
    >?
    metrics,
    String? $__typename,
  }) => _res;

  metrics(_fn) => _res;
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics
    implements Fragment$MonitoringMetrics$metrics {
  Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics({
    required this.metricId,
    required this.values,
    this.$__typename = 'MonitoringMetric',
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$metricId = json['metricId'];
    final l$values = json['values'];
    final l$$__typename = json['__typename'];
    return Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics(
      metricId: (l$metricId as String),
      values:
          (l$values as List<dynamic>)
              .map(
                (e) =>
                    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values.fromJson(
                      (e as Map<String, dynamic>),
                    ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String metricId;

  final List<
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values
  >
  values;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$metricId = metricId;
    _resultData['metricId'] = l$metricId;
    final l$values = values;
    _resultData['values'] = l$values.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$metricId = metricId;
    final l$values = values;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$metricId,
      Object.hashAll(l$values.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$metricId = metricId;
    final lOther$metricId = other.metricId;
    if (l$metricId != lOther$metricId) {
      return false;
    }
    final l$values = values;
    final lOther$values = other.values;
    if (l$values.length != lOther$values.length) {
      return false;
    }
    for (int i = 0; i < l$values.length; i++) {
      final l$values$entry = l$values[i];
      final lOther$values$entry = lOther$values[i];
      if (l$values$entry != lOther$values$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics
    on
        Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics<
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics(
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics
    instance,
    TRes Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics;

  TRes call({
    String? metricId,
    List<
      Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values
    >?
    values,
    String? $__typename,
  });
  TRes values(
    Iterable<
      Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values
    >
    Function(
      Iterable<
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values<
          Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics
  _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? metricId = _undefined,
    Object? values = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics(
      metricId:
          metricId == _undefined || metricId == null
              ? _instance.metricId
              : (metricId as String),
      values:
          values == _undefined || values == null
              ? _instance.values
              : (values
                  as List<
                    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values
                  >),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes values(
    Iterable<
      Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values
    >
    Function(
      Iterable<
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values<
          Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values
        >
      >,
    )
    _fn,
  ) => call(
    values:
        _fn(
          _instance.values.map(
            (e) =>
                CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values(
                  e,
                  (i) => i,
                ),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics(
    this._res,
  );

  TRes _res;

  call({
    String? metricId,
    List<
      Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values
    >?
    values,
    String? $__typename,
  }) => _res;

  values(_fn) => _res;
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values
    implements Fragment$MonitoringMetrics$metrics$values {
  Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values({
    required this.timestamp,
    required this.value,
    this.$__typename = 'MonitoringValue',
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$timestamp = json['timestamp'];
    final l$value = json['value'];
    final l$$__typename = json['__typename'];
    return Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values(
      timestamp: dateTimeFromJson(l$timestamp),
      value: (l$value as String),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime timestamp;

  final String value;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$timestamp = timestamp;
    _resultData['timestamp'] = dateTimeToJson(l$timestamp);
    final l$value = value;
    _resultData['value'] = l$value;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$timestamp = timestamp;
    final l$value = value;
    final l$$__typename = $__typename;
    return Object.hashAll([l$timestamp, l$value, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$timestamp = timestamp;
    final lOther$timestamp = other.timestamp;
    if (l$timestamp != lOther$timestamp) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values
    on
        Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values<
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values(
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values
    instance,
    TRes Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values;

  TRes call({DateTime? timestamp, String? value, String? $__typename});
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values
  _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? timestamp = _undefined,
    Object? value = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values(
      timestamp:
          timestamp == _undefined || timestamp == null
              ? _instance.timestamp
              : (timestamp as DateTime),
      value:
          value == _undefined || value == null
              ? _instance.value
              : (value as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringMetrics$metrics$values(
    this._res,
  );

  TRes _res;

  call({DateTime? timestamp, String? value, String? $__typename}) => _res;
}

class Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError
    implements
        Fragment$MonitoringQueryError,
        Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService {
  Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError({
    required this.error,
    this.$__typename = 'MonitoringQueryError',
  });

  factory Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$error = json['error'];
    final l$$__typename = json['__typename'];
    return Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError(
      error: (l$error as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String error;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$error = error;
    _resultData['error'] = l$error;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$error = error;
    final l$$__typename = $__typename;
    return Object.hashAll([l$error, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$error = error;
    final lOther$error = other.error;
    if (l$error != lOther$error) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError
    on
        Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError {
  CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError<
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError
  >
  get copyWith =>
      CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError<
  TRes
> {
  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError(
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError
    instance,
    TRes Function(
      Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError;

  factory CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError;

  TRes call({String? error, String? $__typename});
}

class _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError<
          TRes
        > {
  _CopyWithImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError(
    this._instance,
    this._then,
  );

  final Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError
  _instance;

  final TRes Function(
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? error = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError(
      error:
          error == _undefined || error == null
              ? _instance.error
              : (error as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError<
  TRes
>
    implements
        CopyWith$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError<
          TRes
        > {
  _CopyWithStubImpl$Query$GetMemoryMetrics$monitoring$memoryUsage$maxUsageByService$$MonitoringQueryError(
    this._res,
  );

  TRes _res;

  call({String? error, String? $__typename}) => _res;
}

class Variables$Query$GetDiskMetrics {
  factory Variables$Query$GetDiskMetrics({
    DateTime? start,
    DateTime? end,
    required int step,
  }) => Variables$Query$GetDiskMetrics._({
    if (start != null) r'start': start,
    if (end != null) r'end': end,
    r'step': step,
  });

  Variables$Query$GetDiskMetrics._(this._$data);

  factory Variables$Query$GetDiskMetrics.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('start')) {
      final l$start = data['start'];
      result$data['start'] = l$start == null ? null : dateTimeFromJson(l$start);
    }
    if (data.containsKey('end')) {
      final l$end = data['end'];
      result$data['end'] = l$end == null ? null : dateTimeFromJson(l$end);
    }
    final l$step = data['step'];
    result$data['step'] = (l$step as int);
    return Variables$Query$GetDiskMetrics._(result$data);
  }

  Map<String, dynamic> _$data;

  DateTime? get start => (_$data['start'] as DateTime?);

  DateTime? get end => (_$data['end'] as DateTime?);

  int get step => (_$data['step'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('start')) {
      final l$start = start;
      result$data['start'] = l$start == null ? null : dateTimeToJson(l$start);
    }
    if (_$data.containsKey('end')) {
      final l$end = end;
      result$data['end'] = l$end == null ? null : dateTimeToJson(l$end);
    }
    final l$step = step;
    result$data['step'] = l$step;
    return result$data;
  }

  CopyWith$Variables$Query$GetDiskMetrics<Variables$Query$GetDiskMetrics>
  get copyWith => CopyWith$Variables$Query$GetDiskMetrics(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$GetDiskMetrics ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$start = start;
    final lOther$start = other.start;
    if (_$data.containsKey('start') != other._$data.containsKey('start')) {
      return false;
    }
    if (l$start != lOther$start) {
      return false;
    }
    final l$end = end;
    final lOther$end = other.end;
    if (_$data.containsKey('end') != other._$data.containsKey('end')) {
      return false;
    }
    if (l$end != lOther$end) {
      return false;
    }
    final l$step = step;
    final lOther$step = other.step;
    if (l$step != lOther$step) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$start = start;
    final l$end = end;
    final l$step = step;
    return Object.hashAll([
      _$data.containsKey('start') ? l$start : const {},
      _$data.containsKey('end') ? l$end : const {},
      l$step,
    ]);
  }
}

abstract class CopyWith$Variables$Query$GetDiskMetrics<TRes> {
  factory CopyWith$Variables$Query$GetDiskMetrics(
    Variables$Query$GetDiskMetrics instance,
    TRes Function(Variables$Query$GetDiskMetrics) then,
  ) = _CopyWithImpl$Variables$Query$GetDiskMetrics;

  factory CopyWith$Variables$Query$GetDiskMetrics.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetDiskMetrics;

  TRes call({DateTime? start, DateTime? end, int? step});
}

class _CopyWithImpl$Variables$Query$GetDiskMetrics<TRes>
    implements CopyWith$Variables$Query$GetDiskMetrics<TRes> {
  _CopyWithImpl$Variables$Query$GetDiskMetrics(this._instance, this._then);

  final Variables$Query$GetDiskMetrics _instance;

  final TRes Function(Variables$Query$GetDiskMetrics) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? start = _undefined,
    Object? end = _undefined,
    Object? step = _undefined,
  }) => _then(
    Variables$Query$GetDiskMetrics._({
      ..._instance._$data,
      if (start != _undefined) 'start': (start as DateTime?),
      if (end != _undefined) 'end': (end as DateTime?),
      if (step != _undefined && step != null) 'step': (step as int),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$GetDiskMetrics<TRes>
    implements CopyWith$Variables$Query$GetDiskMetrics<TRes> {
  _CopyWithStubImpl$Variables$Query$GetDiskMetrics(this._res);

  TRes _res;

  call({DateTime? start, DateTime? end, int? step}) => _res;
}

class Query$GetDiskMetrics {
  Query$GetDiskMetrics({required this.monitoring, this.$__typename = 'Query'});

  factory Query$GetDiskMetrics.fromJson(Map<String, dynamic> json) {
    final l$monitoring = json['monitoring'];
    final l$$__typename = json['__typename'];
    return Query$GetDiskMetrics(
      monitoring: Query$GetDiskMetrics$monitoring.fromJson(
        (l$monitoring as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetDiskMetrics$monitoring monitoring;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$monitoring = monitoring;
    _resultData['monitoring'] = l$monitoring.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$monitoring = monitoring;
    final l$$__typename = $__typename;
    return Object.hashAll([l$monitoring, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetDiskMetrics || runtimeType != other.runtimeType) {
      return false;
    }
    final l$monitoring = monitoring;
    final lOther$monitoring = other.monitoring;
    if (l$monitoring != lOther$monitoring) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetDiskMetrics on Query$GetDiskMetrics {
  CopyWith$Query$GetDiskMetrics<Query$GetDiskMetrics> get copyWith =>
      CopyWith$Query$GetDiskMetrics(this, (i) => i);
}

abstract class CopyWith$Query$GetDiskMetrics<TRes> {
  factory CopyWith$Query$GetDiskMetrics(
    Query$GetDiskMetrics instance,
    TRes Function(Query$GetDiskMetrics) then,
  ) = _CopyWithImpl$Query$GetDiskMetrics;

  factory CopyWith$Query$GetDiskMetrics.stub(TRes res) =
      _CopyWithStubImpl$Query$GetDiskMetrics;

  TRes call({Query$GetDiskMetrics$monitoring? monitoring, String? $__typename});
  CopyWith$Query$GetDiskMetrics$monitoring<TRes> get monitoring;
}

class _CopyWithImpl$Query$GetDiskMetrics<TRes>
    implements CopyWith$Query$GetDiskMetrics<TRes> {
  _CopyWithImpl$Query$GetDiskMetrics(this._instance, this._then);

  final Query$GetDiskMetrics _instance;

  final TRes Function(Query$GetDiskMetrics) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? monitoring = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetDiskMetrics(
      monitoring:
          monitoring == _undefined || monitoring == null
              ? _instance.monitoring
              : (monitoring as Query$GetDiskMetrics$monitoring),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$GetDiskMetrics$monitoring<TRes> get monitoring {
    final local$monitoring = _instance.monitoring;
    return CopyWith$Query$GetDiskMetrics$monitoring(
      local$monitoring,
      (e) => call(monitoring: e),
    );
  }
}

class _CopyWithStubImpl$Query$GetDiskMetrics<TRes>
    implements CopyWith$Query$GetDiskMetrics<TRes> {
  _CopyWithStubImpl$Query$GetDiskMetrics(this._res);

  TRes _res;

  call({Query$GetDiskMetrics$monitoring? monitoring, String? $__typename}) =>
      _res;

  CopyWith$Query$GetDiskMetrics$monitoring<TRes> get monitoring =>
      CopyWith$Query$GetDiskMetrics$monitoring.stub(_res);
}

const documentNodeQueryGetDiskMetrics = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetDiskMetrics'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'start')),
          type: NamedTypeNode(
            name: NameNode(value: 'DateTime'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'end')),
          type: NamedTypeNode(
            name: NameNode(value: 'DateTime'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'step')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'monitoring'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'diskUsage'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'start'),
                      value: VariableNode(name: NameNode(value: 'start')),
                    ),
                    ArgumentNode(
                      name: NameNode(value: 'end'),
                      value: VariableNode(name: NameNode(value: 'end')),
                    ),
                    ArgumentNode(
                      name: NameNode(value: 'step'),
                      value: VariableNode(name: NameNode(value: 'step')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'overallUsage'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FragmentSpreadNode(
                              name: NameNode(value: 'MonitoringQueryError'),
                              directives: [],
                            ),
                            FragmentSpreadNode(
                              name: NameNode(value: 'MonitoringMetrics'),
                              directives: [],
                            ),
                            FieldNode(
                              name: NameNode(value: '__typename'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionMonitoringQueryError,
    fragmentDefinitionMonitoringMetrics,
  ],
);
Query$GetDiskMetrics _parserFn$Query$GetDiskMetrics(
  Map<String, dynamic> data,
) => Query$GetDiskMetrics.fromJson(data);
typedef OnQueryComplete$Query$GetDiskMetrics =
    FutureOr<void> Function(Map<String, dynamic>?, Query$GetDiskMetrics?);

class Options$Query$GetDiskMetrics
    extends graphql.QueryOptions<Query$GetDiskMetrics> {
  Options$Query$GetDiskMetrics({
    String? operationName,
    required Variables$Query$GetDiskMetrics variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetDiskMetrics? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetDiskMetrics? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete:
             onComplete == null
                 ? null
                 : (data) => onComplete(
                   data,
                   data == null ? null : _parserFn$Query$GetDiskMetrics(data),
                 ),
         onError: onError,
         document: documentNodeQueryGetDiskMetrics,
         parserFn: _parserFn$Query$GetDiskMetrics,
       );

  final OnQueryComplete$Query$GetDiskMetrics? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$GetDiskMetrics
    extends graphql.WatchQueryOptions<Query$GetDiskMetrics> {
  WatchOptions$Query$GetDiskMetrics({
    String? operationName,
    required Variables$Query$GetDiskMetrics variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetDiskMetrics? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryGetDiskMetrics,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$GetDiskMetrics,
       );
}

class FetchMoreOptions$Query$GetDiskMetrics extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetDiskMetrics({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetDiskMetrics variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryGetDiskMetrics,
       );
}

extension ClientExtension$Query$GetDiskMetrics on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetDiskMetrics>> query$GetDiskMetrics(
    Options$Query$GetDiskMetrics options,
  ) async => await this.query(options);
  graphql.ObservableQuery<Query$GetDiskMetrics> watchQuery$GetDiskMetrics(
    WatchOptions$Query$GetDiskMetrics options,
  ) => this.watchQuery(options);
  void writeQuery$GetDiskMetrics({
    required Query$GetDiskMetrics data,
    required Variables$Query$GetDiskMetrics variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryGetDiskMetrics),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Query$GetDiskMetrics? readQuery$GetDiskMetrics({
    required Variables$Query$GetDiskMetrics variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryGetDiskMetrics),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetDiskMetrics.fromJson(result);
  }
}

class Query$GetDiskMetrics$monitoring {
  Query$GetDiskMetrics$monitoring({
    required this.diskUsage,
    this.$__typename = 'Monitoring',
  });

  factory Query$GetDiskMetrics$monitoring.fromJson(Map<String, dynamic> json) {
    final l$diskUsage = json['diskUsage'];
    final l$$__typename = json['__typename'];
    return Query$GetDiskMetrics$monitoring(
      diskUsage: Query$GetDiskMetrics$monitoring$diskUsage.fromJson(
        (l$diskUsage as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetDiskMetrics$monitoring$diskUsage diskUsage;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$diskUsage = diskUsage;
    _resultData['diskUsage'] = l$diskUsage.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$diskUsage = diskUsage;
    final l$$__typename = $__typename;
    return Object.hashAll([l$diskUsage, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetDiskMetrics$monitoring ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$diskUsage = diskUsage;
    final lOther$diskUsage = other.diskUsage;
    if (l$diskUsage != lOther$diskUsage) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetDiskMetrics$monitoring
    on Query$GetDiskMetrics$monitoring {
  CopyWith$Query$GetDiskMetrics$monitoring<Query$GetDiskMetrics$monitoring>
  get copyWith => CopyWith$Query$GetDiskMetrics$monitoring(this, (i) => i);
}

abstract class CopyWith$Query$GetDiskMetrics$monitoring<TRes> {
  factory CopyWith$Query$GetDiskMetrics$monitoring(
    Query$GetDiskMetrics$monitoring instance,
    TRes Function(Query$GetDiskMetrics$monitoring) then,
  ) = _CopyWithImpl$Query$GetDiskMetrics$monitoring;

  factory CopyWith$Query$GetDiskMetrics$monitoring.stub(TRes res) =
      _CopyWithStubImpl$Query$GetDiskMetrics$monitoring;

  TRes call({
    Query$GetDiskMetrics$monitoring$diskUsage? diskUsage,
    String? $__typename,
  });
  CopyWith$Query$GetDiskMetrics$monitoring$diskUsage<TRes> get diskUsage;
}

class _CopyWithImpl$Query$GetDiskMetrics$monitoring<TRes>
    implements CopyWith$Query$GetDiskMetrics$monitoring<TRes> {
  _CopyWithImpl$Query$GetDiskMetrics$monitoring(this._instance, this._then);

  final Query$GetDiskMetrics$monitoring _instance;

  final TRes Function(Query$GetDiskMetrics$monitoring) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? diskUsage = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetDiskMetrics$monitoring(
      diskUsage:
          diskUsage == _undefined || diskUsage == null
              ? _instance.diskUsage
              : (diskUsage as Query$GetDiskMetrics$monitoring$diskUsage),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$GetDiskMetrics$monitoring$diskUsage<TRes> get diskUsage {
    final local$diskUsage = _instance.diskUsage;
    return CopyWith$Query$GetDiskMetrics$monitoring$diskUsage(
      local$diskUsage,
      (e) => call(diskUsage: e),
    );
  }
}

class _CopyWithStubImpl$Query$GetDiskMetrics$monitoring<TRes>
    implements CopyWith$Query$GetDiskMetrics$monitoring<TRes> {
  _CopyWithStubImpl$Query$GetDiskMetrics$monitoring(this._res);

  TRes _res;

  call({
    Query$GetDiskMetrics$monitoring$diskUsage? diskUsage,
    String? $__typename,
  }) => _res;

  CopyWith$Query$GetDiskMetrics$monitoring$diskUsage<TRes> get diskUsage =>
      CopyWith$Query$GetDiskMetrics$monitoring$diskUsage.stub(_res);
}

class Query$GetDiskMetrics$monitoring$diskUsage {
  Query$GetDiskMetrics$monitoring$diskUsage({
    required this.overallUsage,
    this.$__typename = 'DiskMonitoring',
  });

  factory Query$GetDiskMetrics$monitoring$diskUsage.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$overallUsage = json['overallUsage'];
    final l$$__typename = json['__typename'];
    return Query$GetDiskMetrics$monitoring$diskUsage(
      overallUsage:
          Query$GetDiskMetrics$monitoring$diskUsage$overallUsage.fromJson(
            (l$overallUsage as Map<String, dynamic>),
          ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetDiskMetrics$monitoring$diskUsage$overallUsage overallUsage;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$overallUsage = overallUsage;
    _resultData['overallUsage'] = l$overallUsage.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$overallUsage = overallUsage;
    final l$$__typename = $__typename;
    return Object.hashAll([l$overallUsage, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetDiskMetrics$monitoring$diskUsage ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$overallUsage = overallUsage;
    final lOther$overallUsage = other.overallUsage;
    if (l$overallUsage != lOther$overallUsage) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetDiskMetrics$monitoring$diskUsage
    on Query$GetDiskMetrics$monitoring$diskUsage {
  CopyWith$Query$GetDiskMetrics$monitoring$diskUsage<
    Query$GetDiskMetrics$monitoring$diskUsage
  >
  get copyWith =>
      CopyWith$Query$GetDiskMetrics$monitoring$diskUsage(this, (i) => i);
}

abstract class CopyWith$Query$GetDiskMetrics$monitoring$diskUsage<TRes> {
  factory CopyWith$Query$GetDiskMetrics$monitoring$diskUsage(
    Query$GetDiskMetrics$monitoring$diskUsage instance,
    TRes Function(Query$GetDiskMetrics$monitoring$diskUsage) then,
  ) = _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage;

  factory CopyWith$Query$GetDiskMetrics$monitoring$diskUsage.stub(TRes res) =
      _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage;

  TRes call({
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage? overallUsage,
    String? $__typename,
  });
  CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage<TRes>
  get overallUsage;
}

class _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage<TRes>
    implements CopyWith$Query$GetDiskMetrics$monitoring$diskUsage<TRes> {
  _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage(
    this._instance,
    this._then,
  );

  final Query$GetDiskMetrics$monitoring$diskUsage _instance;

  final TRes Function(Query$GetDiskMetrics$monitoring$diskUsage) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? overallUsage = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetDiskMetrics$monitoring$diskUsage(
      overallUsage:
          overallUsage == _undefined || overallUsage == null
              ? _instance.overallUsage
              : (overallUsage
                  as Query$GetDiskMetrics$monitoring$diskUsage$overallUsage),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage<TRes>
  get overallUsage {
    final local$overallUsage = _instance.overallUsage;
    return CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage(
      local$overallUsage,
      (e) => call(overallUsage: e),
    );
  }
}

class _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage<TRes>
    implements CopyWith$Query$GetDiskMetrics$monitoring$diskUsage<TRes> {
  _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage(this._res);

  TRes _res;

  call({
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage? overallUsage,
    String? $__typename,
  }) => _res;

  CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage<TRes>
  get overallUsage =>
      CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage.stub(
        _res,
      );
}

class Query$GetDiskMetrics$monitoring$diskUsage$overallUsage {
  Query$GetDiskMetrics$monitoring$diskUsage$overallUsage({
    required this.$__typename,
  });

  factory Query$GetDiskMetrics$monitoring$diskUsage$overallUsage.fromJson(
    Map<String, dynamic> json,
  ) {
    switch (json["__typename"] as String) {
      case "MonitoringMetrics":
        return Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics.fromJson(
          json,
        );

      case "MonitoringQueryError":
        return Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError.fromJson(
          json,
        );

      default:
        final l$$__typename = json['__typename'];
        return Query$GetDiskMetrics$monitoring$diskUsage$overallUsage(
          $__typename: (l$$__typename as String),
        );
    }
  }

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$$__typename = $__typename;
    return Object.hashAll([l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetDiskMetrics$monitoring$diskUsage$overallUsage ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage
    on Query$GetDiskMetrics$monitoring$diskUsage$overallUsage {
  CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage<
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage
  >
  get copyWith =>
      CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage(
        this,
        (i) => i,
      );
  _T when<_T>({
    required _T Function(
      Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics,
    )
    monitoringMetrics,
    required _T Function(
      Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError,
    )
    monitoringQueryError,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "MonitoringMetrics":
        return monitoringMetrics(
          this
              as Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics,
        );

      case "MonitoringQueryError":
        return monitoringQueryError(
          this
              as Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError,
        );

      default:
        return orElse();
    }
  }

  _T maybeWhen<_T>({
    _T Function(
      Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics,
    )?
    monitoringMetrics,
    _T Function(
      Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError,
    )?
    monitoringQueryError,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "MonitoringMetrics":
        if (monitoringMetrics != null) {
          return monitoringMetrics(
            this
                as Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics,
          );
        } else {
          return orElse();
        }

      case "MonitoringQueryError":
        if (monitoringQueryError != null) {
          return monitoringQueryError(
            this
                as Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError,
          );
        } else {
          return orElse();
        }

      default:
        return orElse();
    }
  }
}

abstract class CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage<
  TRes
> {
  factory CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage(
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage instance,
    TRes Function(Query$GetDiskMetrics$monitoring$diskUsage$overallUsage) then,
  ) = _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage;

  factory CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage.stub(
    TRes res,
  ) = _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage;

  TRes call({String? $__typename});
}

class _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage<TRes>
    implements
        CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage<TRes> {
  _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage(
    this._instance,
    this._then,
  );

  final Query$GetDiskMetrics$monitoring$diskUsage$overallUsage _instance;

  final TRes Function(Query$GetDiskMetrics$monitoring$diskUsage$overallUsage)
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? $__typename = _undefined}) => _then(
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage(
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage<
  TRes
>
    implements
        CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage<TRes> {
  _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage(
    this._res,
  );

  TRes _res;

  call({String? $__typename}) => _res;
}

class Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics
    implements
        Fragment$MonitoringMetrics,
        Query$GetDiskMetrics$monitoring$diskUsage$overallUsage {
  Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics({
    required this.metrics,
    this.$__typename = 'MonitoringMetrics',
  });

  factory Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$metrics = json['metrics'];
    final l$$__typename = json['__typename'];
    return Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics(
      metrics:
          (l$metrics as List<dynamic>)
              .map(
                (e) =>
                    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics.fromJson(
                      (e as Map<String, dynamic>),
                    ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics
  >
  metrics;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$metrics = metrics;
    _resultData['metrics'] = l$metrics.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$metrics = metrics;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$metrics.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$metrics = metrics;
    final lOther$metrics = other.metrics;
    if (l$metrics.length != lOther$metrics.length) {
      return false;
    }
    for (int i = 0; i < l$metrics.length; i++) {
      final l$metrics$entry = l$metrics[i];
      final lOther$metrics$entry = lOther$metrics[i];
      if (l$metrics$entry != lOther$metrics$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics
    on Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics {
  CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics<
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics
  >
  get copyWith =>
      CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics<
  TRes
> {
  factory CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics(
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics
    instance,
    TRes Function(
      Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics;

  factory CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics;

  TRes call({
    List<
      Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics
    >?
    metrics,
    String? $__typename,
  });
  TRes metrics(
    Iterable<
      Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics
    >
    Function(
      Iterable<
        CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics<
          Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics<
  TRes
>
    implements
        CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics<
          TRes
        > {
  _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics(
    this._instance,
    this._then,
  );

  final Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics
  _instance;

  final TRes Function(
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? metrics = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics(
      metrics:
          metrics == _undefined || metrics == null
              ? _instance.metrics
              : (metrics
                  as List<
                    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics
                  >),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes metrics(
    Iterable<
      Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics
    >
    Function(
      Iterable<
        CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics<
          Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics
        >
      >,
    )
    _fn,
  ) => call(
    metrics:
        _fn(
          _instance.metrics.map(
            (e) =>
                CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics(
                  e,
                  (i) => i,
                ),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics<
  TRes
>
    implements
        CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics<
          TRes
        > {
  _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics(
    this._res,
  );

  TRes _res;

  call({
    List<
      Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics
    >?
    metrics,
    String? $__typename,
  }) => _res;

  metrics(_fn) => _res;
}

class Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics
    implements Fragment$MonitoringMetrics$metrics {
  Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics({
    required this.metricId,
    required this.values,
    this.$__typename = 'MonitoringMetric',
  });

  factory Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$metricId = json['metricId'];
    final l$values = json['values'];
    final l$$__typename = json['__typename'];
    return Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics(
      metricId: (l$metricId as String),
      values:
          (l$values as List<dynamic>)
              .map(
                (e) =>
                    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values.fromJson(
                      (e as Map<String, dynamic>),
                    ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String metricId;

  final List<
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values
  >
  values;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$metricId = metricId;
    _resultData['metricId'] = l$metricId;
    final l$values = values;
    _resultData['values'] = l$values.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$metricId = metricId;
    final l$values = values;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$metricId,
      Object.hashAll(l$values.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$metricId = metricId;
    final lOther$metricId = other.metricId;
    if (l$metricId != lOther$metricId) {
      return false;
    }
    final l$values = values;
    final lOther$values = other.values;
    if (l$values.length != lOther$values.length) {
      return false;
    }
    for (int i = 0; i < l$values.length; i++) {
      final l$values$entry = l$values[i];
      final lOther$values$entry = lOther$values[i];
      if (l$values$entry != lOther$values$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics
    on
        Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics {
  CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics<
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics
  >
  get copyWith =>
      CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics<
  TRes
> {
  factory CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics(
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics
    instance,
    TRes Function(
      Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics;

  factory CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics;

  TRes call({
    String? metricId,
    List<
      Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values
    >?
    values,
    String? $__typename,
  });
  TRes values(
    Iterable<
      Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values
    >
    Function(
      Iterable<
        CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values<
          Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics<
  TRes
>
    implements
        CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics<
          TRes
        > {
  _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics(
    this._instance,
    this._then,
  );

  final Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics
  _instance;

  final TRes Function(
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? metricId = _undefined,
    Object? values = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics(
      metricId:
          metricId == _undefined || metricId == null
              ? _instance.metricId
              : (metricId as String),
      values:
          values == _undefined || values == null
              ? _instance.values
              : (values
                  as List<
                    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values
                  >),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes values(
    Iterable<
      Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values
    >
    Function(
      Iterable<
        CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values<
          Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values
        >
      >,
    )
    _fn,
  ) => call(
    values:
        _fn(
          _instance.values.map(
            (e) =>
                CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values(
                  e,
                  (i) => i,
                ),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics<
  TRes
>
    implements
        CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics<
          TRes
        > {
  _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics(
    this._res,
  );

  TRes _res;

  call({
    String? metricId,
    List<
      Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values
    >?
    values,
    String? $__typename,
  }) => _res;

  values(_fn) => _res;
}

class Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values
    implements Fragment$MonitoringMetrics$metrics$values {
  Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values({
    required this.timestamp,
    required this.value,
    this.$__typename = 'MonitoringValue',
  });

  factory Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$timestamp = json['timestamp'];
    final l$value = json['value'];
    final l$$__typename = json['__typename'];
    return Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values(
      timestamp: dateTimeFromJson(l$timestamp),
      value: (l$value as String),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime timestamp;

  final String value;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$timestamp = timestamp;
    _resultData['timestamp'] = dateTimeToJson(l$timestamp);
    final l$value = value;
    _resultData['value'] = l$value;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$timestamp = timestamp;
    final l$value = value;
    final l$$__typename = $__typename;
    return Object.hashAll([l$timestamp, l$value, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$timestamp = timestamp;
    final lOther$timestamp = other.timestamp;
    if (l$timestamp != lOther$timestamp) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values
    on
        Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values {
  CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values<
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values
  >
  get copyWith =>
      CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values<
  TRes
> {
  factory CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values(
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values
    instance,
    TRes Function(
      Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values;

  factory CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values;

  TRes call({DateTime? timestamp, String? value, String? $__typename});
}

class _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values<
  TRes
>
    implements
        CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values<
          TRes
        > {
  _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values(
    this._instance,
    this._then,
  );

  final Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values
  _instance;

  final TRes Function(
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? timestamp = _undefined,
    Object? value = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values(
      timestamp:
          timestamp == _undefined || timestamp == null
              ? _instance.timestamp
              : (timestamp as DateTime),
      value:
          value == _undefined || value == null
              ? _instance.value
              : (value as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values<
  TRes
>
    implements
        CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values<
          TRes
        > {
  _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringMetrics$metrics$values(
    this._res,
  );

  TRes _res;

  call({DateTime? timestamp, String? value, String? $__typename}) => _res;
}

class Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError
    implements
        Fragment$MonitoringQueryError,
        Query$GetDiskMetrics$monitoring$diskUsage$overallUsage {
  Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError({
    required this.error,
    this.$__typename = 'MonitoringQueryError',
  });

  factory Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$error = json['error'];
    final l$$__typename = json['__typename'];
    return Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError(
      error: (l$error as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String error;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$error = error;
    _resultData['error'] = l$error;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$error = error;
    final l$$__typename = $__typename;
    return Object.hashAll([l$error, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$error = error;
    final lOther$error = other.error;
    if (l$error != lOther$error) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError
    on Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError {
  CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError<
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError
  >
  get copyWith =>
      CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError<
  TRes
> {
  factory CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError(
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError
    instance,
    TRes Function(
      Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError,
    )
    then,
  ) =
      _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError;

  factory CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError;

  TRes call({String? error, String? $__typename});
}

class _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError<
  TRes
>
    implements
        CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError<
          TRes
        > {
  _CopyWithImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError(
    this._instance,
    this._then,
  );

  final Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError
  _instance;

  final TRes Function(
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? error = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError(
      error:
          error == _undefined || error == null
              ? _instance.error
              : (error as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError<
  TRes
>
    implements
        CopyWith$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError<
          TRes
        > {
  _CopyWithStubImpl$Query$GetDiskMetrics$monitoring$diskUsage$overallUsage$$MonitoringQueryError(
    this._res,
  );

  TRes _res;

  call({String? error, String? $__typename}) => _res;
}
