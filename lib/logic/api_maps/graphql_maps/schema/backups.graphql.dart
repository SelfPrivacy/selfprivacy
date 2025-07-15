import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:selfprivacy/utils/scalars.dart';
import 'schema.graphql.dart';
import 'server_api.graphql.dart';

class Fragment$genericBackupConfigReturn {
  Fragment$genericBackupConfigReturn({
    required this.code,
    required this.message,
    required this.success,
    this.configuration,
    this.$__typename = 'GenericBackupConfigReturn',
  });

  factory Fragment$genericBackupConfigReturn.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$configuration = json['configuration'];
    final l$$__typename = json['__typename'];
    return Fragment$genericBackupConfigReturn(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      configuration:
          l$configuration == null
              ? null
              : Fragment$genericBackupConfigReturn$configuration.fromJson(
                (l$configuration as Map<String, dynamic>),
              ),
      $__typename: (l$$__typename as String),
    );
  }

  final int code;

  final String message;

  final bool success;

  final Fragment$genericBackupConfigReturn$configuration? configuration;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$configuration = configuration;
    _resultData['configuration'] = l$configuration?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$configuration = configuration;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$configuration,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$genericBackupConfigReturn ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) {
      return false;
    }
    final l$configuration = configuration;
    final lOther$configuration = other.configuration;
    if (l$configuration != lOther$configuration) {
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

extension UtilityExtension$Fragment$genericBackupConfigReturn
    on Fragment$genericBackupConfigReturn {
  CopyWith$Fragment$genericBackupConfigReturn<
    Fragment$genericBackupConfigReturn
  >
  get copyWith => CopyWith$Fragment$genericBackupConfigReturn(this, (i) => i);
}

abstract class CopyWith$Fragment$genericBackupConfigReturn<TRes> {
  factory CopyWith$Fragment$genericBackupConfigReturn(
    Fragment$genericBackupConfigReturn instance,
    TRes Function(Fragment$genericBackupConfigReturn) then,
  ) = _CopyWithImpl$Fragment$genericBackupConfigReturn;

  factory CopyWith$Fragment$genericBackupConfigReturn.stub(TRes res) =
      _CopyWithStubImpl$Fragment$genericBackupConfigReturn;

  TRes call({
    int? code,
    String? message,
    bool? success,
    Fragment$genericBackupConfigReturn$configuration? configuration,
    String? $__typename,
  });
  CopyWith$Fragment$genericBackupConfigReturn$configuration<TRes>
  get configuration;
}

class _CopyWithImpl$Fragment$genericBackupConfigReturn<TRes>
    implements CopyWith$Fragment$genericBackupConfigReturn<TRes> {
  _CopyWithImpl$Fragment$genericBackupConfigReturn(this._instance, this._then);

  final Fragment$genericBackupConfigReturn _instance;

  final TRes Function(Fragment$genericBackupConfigReturn) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? configuration = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$genericBackupConfigReturn(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      configuration:
          configuration == _undefined
              ? _instance.configuration
              : (configuration
                  as Fragment$genericBackupConfigReturn$configuration?),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Fragment$genericBackupConfigReturn$configuration<TRes>
  get configuration {
    final local$configuration = _instance.configuration;
    return local$configuration == null
        ? CopyWith$Fragment$genericBackupConfigReturn$configuration.stub(
          _then(_instance),
        )
        : CopyWith$Fragment$genericBackupConfigReturn$configuration(
          local$configuration,
          (e) => call(configuration: e),
        );
  }
}

class _CopyWithStubImpl$Fragment$genericBackupConfigReturn<TRes>
    implements CopyWith$Fragment$genericBackupConfigReturn<TRes> {
  _CopyWithStubImpl$Fragment$genericBackupConfigReturn(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    Fragment$genericBackupConfigReturn$configuration? configuration,
    String? $__typename,
  }) => _res;

  CopyWith$Fragment$genericBackupConfigReturn$configuration<TRes>
  get configuration =>
      CopyWith$Fragment$genericBackupConfigReturn$configuration.stub(_res);
}

const fragmentDefinitiongenericBackupConfigReturn = FragmentDefinitionNode(
  name: NameNode(value: 'genericBackupConfigReturn'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(
      name: NameNode(value: 'GenericBackupConfigReturn'),
      isNonNull: false,
    ),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'code'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'message'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'success'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'configuration'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FieldNode(
              name: NameNode(value: 'provider'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'encryptionKey'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'isInitialized'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'autobackupPeriod'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'locationName'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'locationId'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'autobackupQuotas'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(
                selections: [
                  FieldNode(
                    name: NameNode(value: 'last'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'daily'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'weekly'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'monthly'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'yearly'),
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
const documentNodeFragmentgenericBackupConfigReturn = DocumentNode(
  definitions: [fragmentDefinitiongenericBackupConfigReturn],
);

extension ClientExtension$Fragment$genericBackupConfigReturn
    on graphql.GraphQLClient {
  void writeFragment$genericBackupConfigReturn({
    required Fragment$genericBackupConfigReturn data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'genericBackupConfigReturn',
        document: documentNodeFragmentgenericBackupConfigReturn,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Fragment$genericBackupConfigReturn? readFragment$genericBackupConfigReturn({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'genericBackupConfigReturn',
          document: documentNodeFragmentgenericBackupConfigReturn,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null
        ? null
        : Fragment$genericBackupConfigReturn.fromJson(result);
  }
}

class Fragment$genericBackupConfigReturn$configuration {
  Fragment$genericBackupConfigReturn$configuration({
    required this.provider,
    required this.encryptionKey,
    required this.isInitialized,
    this.autobackupPeriod,
    this.locationName,
    this.locationId,
    required this.autobackupQuotas,
    this.$__typename = 'BackupConfiguration',
  });

  factory Fragment$genericBackupConfigReturn$configuration.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$provider = json['provider'];
    final l$encryptionKey = json['encryptionKey'];
    final l$isInitialized = json['isInitialized'];
    final l$autobackupPeriod = json['autobackupPeriod'];
    final l$locationName = json['locationName'];
    final l$locationId = json['locationId'];
    final l$autobackupQuotas = json['autobackupQuotas'];
    final l$$__typename = json['__typename'];
    return Fragment$genericBackupConfigReturn$configuration(
      provider: fromJson$Enum$BackupProvider((l$provider as String)),
      encryptionKey: (l$encryptionKey as String),
      isInitialized: (l$isInitialized as bool),
      autobackupPeriod: (l$autobackupPeriod as int?),
      locationName: (l$locationName as String?),
      locationId: (l$locationId as String?),
      autobackupQuotas:
          Fragment$genericBackupConfigReturn$configuration$autobackupQuotas.fromJson(
            (l$autobackupQuotas as Map<String, dynamic>),
          ),
      $__typename: (l$$__typename as String),
    );
  }

  final Enum$BackupProvider provider;

  final String encryptionKey;

  final bool isInitialized;

  final int? autobackupPeriod;

  final String? locationName;

  final String? locationId;

  final Fragment$genericBackupConfigReturn$configuration$autobackupQuotas
  autobackupQuotas;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$provider = provider;
    _resultData['provider'] = toJson$Enum$BackupProvider(l$provider);
    final l$encryptionKey = encryptionKey;
    _resultData['encryptionKey'] = l$encryptionKey;
    final l$isInitialized = isInitialized;
    _resultData['isInitialized'] = l$isInitialized;
    final l$autobackupPeriod = autobackupPeriod;
    _resultData['autobackupPeriod'] = l$autobackupPeriod;
    final l$locationName = locationName;
    _resultData['locationName'] = l$locationName;
    final l$locationId = locationId;
    _resultData['locationId'] = l$locationId;
    final l$autobackupQuotas = autobackupQuotas;
    _resultData['autobackupQuotas'] = l$autobackupQuotas.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$provider = provider;
    final l$encryptionKey = encryptionKey;
    final l$isInitialized = isInitialized;
    final l$autobackupPeriod = autobackupPeriod;
    final l$locationName = locationName;
    final l$locationId = locationId;
    final l$autobackupQuotas = autobackupQuotas;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$provider,
      l$encryptionKey,
      l$isInitialized,
      l$autobackupPeriod,
      l$locationName,
      l$locationId,
      l$autobackupQuotas,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$genericBackupConfigReturn$configuration ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$provider = provider;
    final lOther$provider = other.provider;
    if (l$provider != lOther$provider) {
      return false;
    }
    final l$encryptionKey = encryptionKey;
    final lOther$encryptionKey = other.encryptionKey;
    if (l$encryptionKey != lOther$encryptionKey) {
      return false;
    }
    final l$isInitialized = isInitialized;
    final lOther$isInitialized = other.isInitialized;
    if (l$isInitialized != lOther$isInitialized) {
      return false;
    }
    final l$autobackupPeriod = autobackupPeriod;
    final lOther$autobackupPeriod = other.autobackupPeriod;
    if (l$autobackupPeriod != lOther$autobackupPeriod) {
      return false;
    }
    final l$locationName = locationName;
    final lOther$locationName = other.locationName;
    if (l$locationName != lOther$locationName) {
      return false;
    }
    final l$locationId = locationId;
    final lOther$locationId = other.locationId;
    if (l$locationId != lOther$locationId) {
      return false;
    }
    final l$autobackupQuotas = autobackupQuotas;
    final lOther$autobackupQuotas = other.autobackupQuotas;
    if (l$autobackupQuotas != lOther$autobackupQuotas) {
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

extension UtilityExtension$Fragment$genericBackupConfigReturn$configuration
    on Fragment$genericBackupConfigReturn$configuration {
  CopyWith$Fragment$genericBackupConfigReturn$configuration<
    Fragment$genericBackupConfigReturn$configuration
  >
  get copyWith =>
      CopyWith$Fragment$genericBackupConfigReturn$configuration(this, (i) => i);
}

abstract class CopyWith$Fragment$genericBackupConfigReturn$configuration<TRes> {
  factory CopyWith$Fragment$genericBackupConfigReturn$configuration(
    Fragment$genericBackupConfigReturn$configuration instance,
    TRes Function(Fragment$genericBackupConfigReturn$configuration) then,
  ) = _CopyWithImpl$Fragment$genericBackupConfigReturn$configuration;

  factory CopyWith$Fragment$genericBackupConfigReturn$configuration.stub(
    TRes res,
  ) = _CopyWithStubImpl$Fragment$genericBackupConfigReturn$configuration;

  TRes call({
    Enum$BackupProvider? provider,
    String? encryptionKey,
    bool? isInitialized,
    int? autobackupPeriod,
    String? locationName,
    String? locationId,
    Fragment$genericBackupConfigReturn$configuration$autobackupQuotas?
    autobackupQuotas,
    String? $__typename,
  });
  CopyWith$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas<
    TRes
  >
  get autobackupQuotas;
}

class _CopyWithImpl$Fragment$genericBackupConfigReturn$configuration<TRes>
    implements CopyWith$Fragment$genericBackupConfigReturn$configuration<TRes> {
  _CopyWithImpl$Fragment$genericBackupConfigReturn$configuration(
    this._instance,
    this._then,
  );

  final Fragment$genericBackupConfigReturn$configuration _instance;

  final TRes Function(Fragment$genericBackupConfigReturn$configuration) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? provider = _undefined,
    Object? encryptionKey = _undefined,
    Object? isInitialized = _undefined,
    Object? autobackupPeriod = _undefined,
    Object? locationName = _undefined,
    Object? locationId = _undefined,
    Object? autobackupQuotas = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$genericBackupConfigReturn$configuration(
      provider:
          provider == _undefined || provider == null
              ? _instance.provider
              : (provider as Enum$BackupProvider),
      encryptionKey:
          encryptionKey == _undefined || encryptionKey == null
              ? _instance.encryptionKey
              : (encryptionKey as String),
      isInitialized:
          isInitialized == _undefined || isInitialized == null
              ? _instance.isInitialized
              : (isInitialized as bool),
      autobackupPeriod:
          autobackupPeriod == _undefined
              ? _instance.autobackupPeriod
              : (autobackupPeriod as int?),
      locationName:
          locationName == _undefined
              ? _instance.locationName
              : (locationName as String?),
      locationId:
          locationId == _undefined
              ? _instance.locationId
              : (locationId as String?),
      autobackupQuotas:
          autobackupQuotas == _undefined || autobackupQuotas == null
              ? _instance.autobackupQuotas
              : (autobackupQuotas
                  as Fragment$genericBackupConfigReturn$configuration$autobackupQuotas),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas<
    TRes
  >
  get autobackupQuotas {
    final local$autobackupQuotas = _instance.autobackupQuotas;
    return CopyWith$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas(
      local$autobackupQuotas,
      (e) => call(autobackupQuotas: e),
    );
  }
}

class _CopyWithStubImpl$Fragment$genericBackupConfigReturn$configuration<TRes>
    implements CopyWith$Fragment$genericBackupConfigReturn$configuration<TRes> {
  _CopyWithStubImpl$Fragment$genericBackupConfigReturn$configuration(this._res);

  TRes _res;

  call({
    Enum$BackupProvider? provider,
    String? encryptionKey,
    bool? isInitialized,
    int? autobackupPeriod,
    String? locationName,
    String? locationId,
    Fragment$genericBackupConfigReturn$configuration$autobackupQuotas?
    autobackupQuotas,
    String? $__typename,
  }) => _res;

  CopyWith$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas<
    TRes
  >
  get autobackupQuotas =>
      CopyWith$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas.stub(
        _res,
      );
}

class Fragment$genericBackupConfigReturn$configuration$autobackupQuotas {
  Fragment$genericBackupConfigReturn$configuration$autobackupQuotas({
    required this.last,
    required this.daily,
    required this.weekly,
    required this.monthly,
    required this.yearly,
    this.$__typename = 'AutobackupQuotas',
  });

  factory Fragment$genericBackupConfigReturn$configuration$autobackupQuotas.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$last = json['last'];
    final l$daily = json['daily'];
    final l$weekly = json['weekly'];
    final l$monthly = json['monthly'];
    final l$yearly = json['yearly'];
    final l$$__typename = json['__typename'];
    return Fragment$genericBackupConfigReturn$configuration$autobackupQuotas(
      last: (l$last as int),
      daily: (l$daily as int),
      weekly: (l$weekly as int),
      monthly: (l$monthly as int),
      yearly: (l$yearly as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int last;

  final int daily;

  final int weekly;

  final int monthly;

  final int yearly;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$last = last;
    _resultData['last'] = l$last;
    final l$daily = daily;
    _resultData['daily'] = l$daily;
    final l$weekly = weekly;
    _resultData['weekly'] = l$weekly;
    final l$monthly = monthly;
    _resultData['monthly'] = l$monthly;
    final l$yearly = yearly;
    _resultData['yearly'] = l$yearly;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$last = last;
    final l$daily = daily;
    final l$weekly = weekly;
    final l$monthly = monthly;
    final l$yearly = yearly;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$last,
      l$daily,
      l$weekly,
      l$monthly,
      l$yearly,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Fragment$genericBackupConfigReturn$configuration$autobackupQuotas ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$last = last;
    final lOther$last = other.last;
    if (l$last != lOther$last) {
      return false;
    }
    final l$daily = daily;
    final lOther$daily = other.daily;
    if (l$daily != lOther$daily) {
      return false;
    }
    final l$weekly = weekly;
    final lOther$weekly = other.weekly;
    if (l$weekly != lOther$weekly) {
      return false;
    }
    final l$monthly = monthly;
    final lOther$monthly = other.monthly;
    if (l$monthly != lOther$monthly) {
      return false;
    }
    final l$yearly = yearly;
    final lOther$yearly = other.yearly;
    if (l$yearly != lOther$yearly) {
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

extension UtilityExtension$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas
    on Fragment$genericBackupConfigReturn$configuration$autobackupQuotas {
  CopyWith$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas<
    Fragment$genericBackupConfigReturn$configuration$autobackupQuotas
  >
  get copyWith =>
      CopyWith$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas<
  TRes
> {
  factory CopyWith$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas(
    Fragment$genericBackupConfigReturn$configuration$autobackupQuotas instance,
    TRes Function(
      Fragment$genericBackupConfigReturn$configuration$autobackupQuotas,
    )
    then,
  ) =
      _CopyWithImpl$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas;

  factory CopyWith$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas;

  TRes call({
    int? last,
    int? daily,
    int? weekly,
    int? monthly,
    int? yearly,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas<
  TRes
>
    implements
        CopyWith$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas<
          TRes
        > {
  _CopyWithImpl$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas(
    this._instance,
    this._then,
  );

  final Fragment$genericBackupConfigReturn$configuration$autobackupQuotas
  _instance;

  final TRes Function(
    Fragment$genericBackupConfigReturn$configuration$autobackupQuotas,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? last = _undefined,
    Object? daily = _undefined,
    Object? weekly = _undefined,
    Object? monthly = _undefined,
    Object? yearly = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$genericBackupConfigReturn$configuration$autobackupQuotas(
      last: last == _undefined || last == null ? _instance.last : (last as int),
      daily:
          daily == _undefined || daily == null
              ? _instance.daily
              : (daily as int),
      weekly:
          weekly == _undefined || weekly == null
              ? _instance.weekly
              : (weekly as int),
      monthly:
          monthly == _undefined || monthly == null
              ? _instance.monthly
              : (monthly as int),
      yearly:
          yearly == _undefined || yearly == null
              ? _instance.yearly
              : (yearly as int),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas<
  TRes
>
    implements
        CopyWith$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas<
          TRes
        > {
  _CopyWithStubImpl$Fragment$genericBackupConfigReturn$configuration$autobackupQuotas(
    this._res,
  );

  TRes _res;

  call({
    int? last,
    int? daily,
    int? weekly,
    int? monthly,
    int? yearly,
    String? $__typename,
  }) => _res;
}

class Query$BackupConfiguration {
  Query$BackupConfiguration({required this.backup, this.$__typename = 'Query'});

  factory Query$BackupConfiguration.fromJson(Map<String, dynamic> json) {
    final l$backup = json['backup'];
    final l$$__typename = json['__typename'];
    return Query$BackupConfiguration(
      backup: Query$BackupConfiguration$backup.fromJson(
        (l$backup as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$BackupConfiguration$backup backup;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$backup = backup;
    _resultData['backup'] = l$backup.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$backup = backup;
    final l$$__typename = $__typename;
    return Object.hashAll([l$backup, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$BackupConfiguration ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$backup = backup;
    final lOther$backup = other.backup;
    if (l$backup != lOther$backup) {
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

extension UtilityExtension$Query$BackupConfiguration
    on Query$BackupConfiguration {
  CopyWith$Query$BackupConfiguration<Query$BackupConfiguration> get copyWith =>
      CopyWith$Query$BackupConfiguration(this, (i) => i);
}

abstract class CopyWith$Query$BackupConfiguration<TRes> {
  factory CopyWith$Query$BackupConfiguration(
    Query$BackupConfiguration instance,
    TRes Function(Query$BackupConfiguration) then,
  ) = _CopyWithImpl$Query$BackupConfiguration;

  factory CopyWith$Query$BackupConfiguration.stub(TRes res) =
      _CopyWithStubImpl$Query$BackupConfiguration;

  TRes call({Query$BackupConfiguration$backup? backup, String? $__typename});
  CopyWith$Query$BackupConfiguration$backup<TRes> get backup;
}

class _CopyWithImpl$Query$BackupConfiguration<TRes>
    implements CopyWith$Query$BackupConfiguration<TRes> {
  _CopyWithImpl$Query$BackupConfiguration(this._instance, this._then);

  final Query$BackupConfiguration _instance;

  final TRes Function(Query$BackupConfiguration) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? backup = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$BackupConfiguration(
          backup:
              backup == _undefined || backup == null
                  ? _instance.backup
                  : (backup as Query$BackupConfiguration$backup),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Query$BackupConfiguration$backup<TRes> get backup {
    final local$backup = _instance.backup;
    return CopyWith$Query$BackupConfiguration$backup(
      local$backup,
      (e) => call(backup: e),
    );
  }
}

class _CopyWithStubImpl$Query$BackupConfiguration<TRes>
    implements CopyWith$Query$BackupConfiguration<TRes> {
  _CopyWithStubImpl$Query$BackupConfiguration(this._res);

  TRes _res;

  call({Query$BackupConfiguration$backup? backup, String? $__typename}) => _res;

  CopyWith$Query$BackupConfiguration$backup<TRes> get backup =>
      CopyWith$Query$BackupConfiguration$backup.stub(_res);
}

const documentNodeQueryBackupConfiguration = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'BackupConfiguration'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'backup'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'configuration'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'autobackupPeriod'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'encryptionKey'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'isInitialized'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'locationId'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'locationName'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'provider'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'autobackupQuotas'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FieldNode(
                              name: NameNode(value: 'last'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'daily'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'weekly'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'monthly'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'yearly'),
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
  ],
);
Query$BackupConfiguration _parserFn$Query$BackupConfiguration(
  Map<String, dynamic> data,
) => Query$BackupConfiguration.fromJson(data);
typedef OnQueryComplete$Query$BackupConfiguration =
    FutureOr<void> Function(Map<String, dynamic>?, Query$BackupConfiguration?);

class Options$Query$BackupConfiguration
    extends graphql.QueryOptions<Query$BackupConfiguration> {
  Options$Query$BackupConfiguration({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$BackupConfiguration? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$BackupConfiguration? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
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
                       : _parserFn$Query$BackupConfiguration(data),
                 ),
         onError: onError,
         document: documentNodeQueryBackupConfiguration,
         parserFn: _parserFn$Query$BackupConfiguration,
       );

  final OnQueryComplete$Query$BackupConfiguration? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$BackupConfiguration
    extends graphql.WatchQueryOptions<Query$BackupConfiguration> {
  WatchOptions$Query$BackupConfiguration({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$BackupConfiguration? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryBackupConfiguration,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$BackupConfiguration,
       );
}

class FetchMoreOptions$Query$BackupConfiguration
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$BackupConfiguration({
    required graphql.UpdateQuery updateQuery,
  }) : super(
         updateQuery: updateQuery,
         document: documentNodeQueryBackupConfiguration,
       );
}

extension ClientExtension$Query$BackupConfiguration on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$BackupConfiguration>>
  query$BackupConfiguration([
    Options$Query$BackupConfiguration? options,
  ]) async => await this.query(options ?? Options$Query$BackupConfiguration());
  graphql.ObservableQuery<Query$BackupConfiguration>
  watchQuery$BackupConfiguration([
    WatchOptions$Query$BackupConfiguration? options,
  ]) => this.watchQuery(options ?? WatchOptions$Query$BackupConfiguration());
  void writeQuery$BackupConfiguration({
    required Query$BackupConfiguration data,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(
        document: documentNodeQueryBackupConfiguration,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Query$BackupConfiguration? readQuery$BackupConfiguration({
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(
          document: documentNodeQueryBackupConfiguration,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$BackupConfiguration.fromJson(result);
  }
}

class Query$BackupConfiguration$backup {
  Query$BackupConfiguration$backup({
    required this.configuration,
    this.$__typename = 'Backup',
  });

  factory Query$BackupConfiguration$backup.fromJson(Map<String, dynamic> json) {
    final l$configuration = json['configuration'];
    final l$$__typename = json['__typename'];
    return Query$BackupConfiguration$backup(
      configuration: Query$BackupConfiguration$backup$configuration.fromJson(
        (l$configuration as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$BackupConfiguration$backup$configuration configuration;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$configuration = configuration;
    _resultData['configuration'] = l$configuration.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$configuration = configuration;
    final l$$__typename = $__typename;
    return Object.hashAll([l$configuration, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$BackupConfiguration$backup ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$configuration = configuration;
    final lOther$configuration = other.configuration;
    if (l$configuration != lOther$configuration) {
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

extension UtilityExtension$Query$BackupConfiguration$backup
    on Query$BackupConfiguration$backup {
  CopyWith$Query$BackupConfiguration$backup<Query$BackupConfiguration$backup>
  get copyWith => CopyWith$Query$BackupConfiguration$backup(this, (i) => i);
}

abstract class CopyWith$Query$BackupConfiguration$backup<TRes> {
  factory CopyWith$Query$BackupConfiguration$backup(
    Query$BackupConfiguration$backup instance,
    TRes Function(Query$BackupConfiguration$backup) then,
  ) = _CopyWithImpl$Query$BackupConfiguration$backup;

  factory CopyWith$Query$BackupConfiguration$backup.stub(TRes res) =
      _CopyWithStubImpl$Query$BackupConfiguration$backup;

  TRes call({
    Query$BackupConfiguration$backup$configuration? configuration,
    String? $__typename,
  });
  CopyWith$Query$BackupConfiguration$backup$configuration<TRes>
  get configuration;
}

class _CopyWithImpl$Query$BackupConfiguration$backup<TRes>
    implements CopyWith$Query$BackupConfiguration$backup<TRes> {
  _CopyWithImpl$Query$BackupConfiguration$backup(this._instance, this._then);

  final Query$BackupConfiguration$backup _instance;

  final TRes Function(Query$BackupConfiguration$backup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? configuration = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$BackupConfiguration$backup(
      configuration:
          configuration == _undefined || configuration == null
              ? _instance.configuration
              : (configuration
                  as Query$BackupConfiguration$backup$configuration),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$BackupConfiguration$backup$configuration<TRes>
  get configuration {
    final local$configuration = _instance.configuration;
    return CopyWith$Query$BackupConfiguration$backup$configuration(
      local$configuration,
      (e) => call(configuration: e),
    );
  }
}

class _CopyWithStubImpl$Query$BackupConfiguration$backup<TRes>
    implements CopyWith$Query$BackupConfiguration$backup<TRes> {
  _CopyWithStubImpl$Query$BackupConfiguration$backup(this._res);

  TRes _res;

  call({
    Query$BackupConfiguration$backup$configuration? configuration,
    String? $__typename,
  }) => _res;

  CopyWith$Query$BackupConfiguration$backup$configuration<TRes>
  get configuration =>
      CopyWith$Query$BackupConfiguration$backup$configuration.stub(_res);
}

class Query$BackupConfiguration$backup$configuration {
  Query$BackupConfiguration$backup$configuration({
    this.autobackupPeriod,
    required this.encryptionKey,
    required this.isInitialized,
    this.locationId,
    this.locationName,
    required this.provider,
    required this.autobackupQuotas,
    this.$__typename = 'BackupConfiguration',
  });

  factory Query$BackupConfiguration$backup$configuration.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$autobackupPeriod = json['autobackupPeriod'];
    final l$encryptionKey = json['encryptionKey'];
    final l$isInitialized = json['isInitialized'];
    final l$locationId = json['locationId'];
    final l$locationName = json['locationName'];
    final l$provider = json['provider'];
    final l$autobackupQuotas = json['autobackupQuotas'];
    final l$$__typename = json['__typename'];
    return Query$BackupConfiguration$backup$configuration(
      autobackupPeriod: (l$autobackupPeriod as int?),
      encryptionKey: (l$encryptionKey as String),
      isInitialized: (l$isInitialized as bool),
      locationId: (l$locationId as String?),
      locationName: (l$locationName as String?),
      provider: fromJson$Enum$BackupProvider((l$provider as String)),
      autobackupQuotas:
          Query$BackupConfiguration$backup$configuration$autobackupQuotas.fromJson(
            (l$autobackupQuotas as Map<String, dynamic>),
          ),
      $__typename: (l$$__typename as String),
    );
  }

  final int? autobackupPeriod;

  final String encryptionKey;

  final bool isInitialized;

  final String? locationId;

  final String? locationName;

  final Enum$BackupProvider provider;

  final Query$BackupConfiguration$backup$configuration$autobackupQuotas
  autobackupQuotas;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$autobackupPeriod = autobackupPeriod;
    _resultData['autobackupPeriod'] = l$autobackupPeriod;
    final l$encryptionKey = encryptionKey;
    _resultData['encryptionKey'] = l$encryptionKey;
    final l$isInitialized = isInitialized;
    _resultData['isInitialized'] = l$isInitialized;
    final l$locationId = locationId;
    _resultData['locationId'] = l$locationId;
    final l$locationName = locationName;
    _resultData['locationName'] = l$locationName;
    final l$provider = provider;
    _resultData['provider'] = toJson$Enum$BackupProvider(l$provider);
    final l$autobackupQuotas = autobackupQuotas;
    _resultData['autobackupQuotas'] = l$autobackupQuotas.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$autobackupPeriod = autobackupPeriod;
    final l$encryptionKey = encryptionKey;
    final l$isInitialized = isInitialized;
    final l$locationId = locationId;
    final l$locationName = locationName;
    final l$provider = provider;
    final l$autobackupQuotas = autobackupQuotas;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$autobackupPeriod,
      l$encryptionKey,
      l$isInitialized,
      l$locationId,
      l$locationName,
      l$provider,
      l$autobackupQuotas,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$BackupConfiguration$backup$configuration ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$autobackupPeriod = autobackupPeriod;
    final lOther$autobackupPeriod = other.autobackupPeriod;
    if (l$autobackupPeriod != lOther$autobackupPeriod) {
      return false;
    }
    final l$encryptionKey = encryptionKey;
    final lOther$encryptionKey = other.encryptionKey;
    if (l$encryptionKey != lOther$encryptionKey) {
      return false;
    }
    final l$isInitialized = isInitialized;
    final lOther$isInitialized = other.isInitialized;
    if (l$isInitialized != lOther$isInitialized) {
      return false;
    }
    final l$locationId = locationId;
    final lOther$locationId = other.locationId;
    if (l$locationId != lOther$locationId) {
      return false;
    }
    final l$locationName = locationName;
    final lOther$locationName = other.locationName;
    if (l$locationName != lOther$locationName) {
      return false;
    }
    final l$provider = provider;
    final lOther$provider = other.provider;
    if (l$provider != lOther$provider) {
      return false;
    }
    final l$autobackupQuotas = autobackupQuotas;
    final lOther$autobackupQuotas = other.autobackupQuotas;
    if (l$autobackupQuotas != lOther$autobackupQuotas) {
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

extension UtilityExtension$Query$BackupConfiguration$backup$configuration
    on Query$BackupConfiguration$backup$configuration {
  CopyWith$Query$BackupConfiguration$backup$configuration<
    Query$BackupConfiguration$backup$configuration
  >
  get copyWith =>
      CopyWith$Query$BackupConfiguration$backup$configuration(this, (i) => i);
}

abstract class CopyWith$Query$BackupConfiguration$backup$configuration<TRes> {
  factory CopyWith$Query$BackupConfiguration$backup$configuration(
    Query$BackupConfiguration$backup$configuration instance,
    TRes Function(Query$BackupConfiguration$backup$configuration) then,
  ) = _CopyWithImpl$Query$BackupConfiguration$backup$configuration;

  factory CopyWith$Query$BackupConfiguration$backup$configuration.stub(
    TRes res,
  ) = _CopyWithStubImpl$Query$BackupConfiguration$backup$configuration;

  TRes call({
    int? autobackupPeriod,
    String? encryptionKey,
    bool? isInitialized,
    String? locationId,
    String? locationName,
    Enum$BackupProvider? provider,
    Query$BackupConfiguration$backup$configuration$autobackupQuotas?
    autobackupQuotas,
    String? $__typename,
  });
  CopyWith$Query$BackupConfiguration$backup$configuration$autobackupQuotas<TRes>
  get autobackupQuotas;
}

class _CopyWithImpl$Query$BackupConfiguration$backup$configuration<TRes>
    implements CopyWith$Query$BackupConfiguration$backup$configuration<TRes> {
  _CopyWithImpl$Query$BackupConfiguration$backup$configuration(
    this._instance,
    this._then,
  );

  final Query$BackupConfiguration$backup$configuration _instance;

  final TRes Function(Query$BackupConfiguration$backup$configuration) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? autobackupPeriod = _undefined,
    Object? encryptionKey = _undefined,
    Object? isInitialized = _undefined,
    Object? locationId = _undefined,
    Object? locationName = _undefined,
    Object? provider = _undefined,
    Object? autobackupQuotas = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$BackupConfiguration$backup$configuration(
      autobackupPeriod:
          autobackupPeriod == _undefined
              ? _instance.autobackupPeriod
              : (autobackupPeriod as int?),
      encryptionKey:
          encryptionKey == _undefined || encryptionKey == null
              ? _instance.encryptionKey
              : (encryptionKey as String),
      isInitialized:
          isInitialized == _undefined || isInitialized == null
              ? _instance.isInitialized
              : (isInitialized as bool),
      locationId:
          locationId == _undefined
              ? _instance.locationId
              : (locationId as String?),
      locationName:
          locationName == _undefined
              ? _instance.locationName
              : (locationName as String?),
      provider:
          provider == _undefined || provider == null
              ? _instance.provider
              : (provider as Enum$BackupProvider),
      autobackupQuotas:
          autobackupQuotas == _undefined || autobackupQuotas == null
              ? _instance.autobackupQuotas
              : (autobackupQuotas
                  as Query$BackupConfiguration$backup$configuration$autobackupQuotas),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$BackupConfiguration$backup$configuration$autobackupQuotas<TRes>
  get autobackupQuotas {
    final local$autobackupQuotas = _instance.autobackupQuotas;
    return CopyWith$Query$BackupConfiguration$backup$configuration$autobackupQuotas(
      local$autobackupQuotas,
      (e) => call(autobackupQuotas: e),
    );
  }
}

class _CopyWithStubImpl$Query$BackupConfiguration$backup$configuration<TRes>
    implements CopyWith$Query$BackupConfiguration$backup$configuration<TRes> {
  _CopyWithStubImpl$Query$BackupConfiguration$backup$configuration(this._res);

  TRes _res;

  call({
    int? autobackupPeriod,
    String? encryptionKey,
    bool? isInitialized,
    String? locationId,
    String? locationName,
    Enum$BackupProvider? provider,
    Query$BackupConfiguration$backup$configuration$autobackupQuotas?
    autobackupQuotas,
    String? $__typename,
  }) => _res;

  CopyWith$Query$BackupConfiguration$backup$configuration$autobackupQuotas<TRes>
  get autobackupQuotas =>
      CopyWith$Query$BackupConfiguration$backup$configuration$autobackupQuotas.stub(
        _res,
      );
}

class Query$BackupConfiguration$backup$configuration$autobackupQuotas {
  Query$BackupConfiguration$backup$configuration$autobackupQuotas({
    required this.last,
    required this.daily,
    required this.weekly,
    required this.monthly,
    required this.yearly,
    this.$__typename = 'AutobackupQuotas',
  });

  factory Query$BackupConfiguration$backup$configuration$autobackupQuotas.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$last = json['last'];
    final l$daily = json['daily'];
    final l$weekly = json['weekly'];
    final l$monthly = json['monthly'];
    final l$yearly = json['yearly'];
    final l$$__typename = json['__typename'];
    return Query$BackupConfiguration$backup$configuration$autobackupQuotas(
      last: (l$last as int),
      daily: (l$daily as int),
      weekly: (l$weekly as int),
      monthly: (l$monthly as int),
      yearly: (l$yearly as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int last;

  final int daily;

  final int weekly;

  final int monthly;

  final int yearly;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$last = last;
    _resultData['last'] = l$last;
    final l$daily = daily;
    _resultData['daily'] = l$daily;
    final l$weekly = weekly;
    _resultData['weekly'] = l$weekly;
    final l$monthly = monthly;
    _resultData['monthly'] = l$monthly;
    final l$yearly = yearly;
    _resultData['yearly'] = l$yearly;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$last = last;
    final l$daily = daily;
    final l$weekly = weekly;
    final l$monthly = monthly;
    final l$yearly = yearly;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$last,
      l$daily,
      l$weekly,
      l$monthly,
      l$yearly,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$BackupConfiguration$backup$configuration$autobackupQuotas ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$last = last;
    final lOther$last = other.last;
    if (l$last != lOther$last) {
      return false;
    }
    final l$daily = daily;
    final lOther$daily = other.daily;
    if (l$daily != lOther$daily) {
      return false;
    }
    final l$weekly = weekly;
    final lOther$weekly = other.weekly;
    if (l$weekly != lOther$weekly) {
      return false;
    }
    final l$monthly = monthly;
    final lOther$monthly = other.monthly;
    if (l$monthly != lOther$monthly) {
      return false;
    }
    final l$yearly = yearly;
    final lOther$yearly = other.yearly;
    if (l$yearly != lOther$yearly) {
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

extension UtilityExtension$Query$BackupConfiguration$backup$configuration$autobackupQuotas
    on Query$BackupConfiguration$backup$configuration$autobackupQuotas {
  CopyWith$Query$BackupConfiguration$backup$configuration$autobackupQuotas<
    Query$BackupConfiguration$backup$configuration$autobackupQuotas
  >
  get copyWith =>
      CopyWith$Query$BackupConfiguration$backup$configuration$autobackupQuotas(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$BackupConfiguration$backup$configuration$autobackupQuotas<
  TRes
> {
  factory CopyWith$Query$BackupConfiguration$backup$configuration$autobackupQuotas(
    Query$BackupConfiguration$backup$configuration$autobackupQuotas instance,
    TRes Function(
      Query$BackupConfiguration$backup$configuration$autobackupQuotas,
    )
    then,
  ) =
      _CopyWithImpl$Query$BackupConfiguration$backup$configuration$autobackupQuotas;

  factory CopyWith$Query$BackupConfiguration$backup$configuration$autobackupQuotas.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$BackupConfiguration$backup$configuration$autobackupQuotas;

  TRes call({
    int? last,
    int? daily,
    int? weekly,
    int? monthly,
    int? yearly,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$BackupConfiguration$backup$configuration$autobackupQuotas<
  TRes
>
    implements
        CopyWith$Query$BackupConfiguration$backup$configuration$autobackupQuotas<
          TRes
        > {
  _CopyWithImpl$Query$BackupConfiguration$backup$configuration$autobackupQuotas(
    this._instance,
    this._then,
  );

  final Query$BackupConfiguration$backup$configuration$autobackupQuotas
  _instance;

  final TRes Function(
    Query$BackupConfiguration$backup$configuration$autobackupQuotas,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? last = _undefined,
    Object? daily = _undefined,
    Object? weekly = _undefined,
    Object? monthly = _undefined,
    Object? yearly = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$BackupConfiguration$backup$configuration$autobackupQuotas(
      last: last == _undefined || last == null ? _instance.last : (last as int),
      daily:
          daily == _undefined || daily == null
              ? _instance.daily
              : (daily as int),
      weekly:
          weekly == _undefined || weekly == null
              ? _instance.weekly
              : (weekly as int),
      monthly:
          monthly == _undefined || monthly == null
              ? _instance.monthly
              : (monthly as int),
      yearly:
          yearly == _undefined || yearly == null
              ? _instance.yearly
              : (yearly as int),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$BackupConfiguration$backup$configuration$autobackupQuotas<
  TRes
>
    implements
        CopyWith$Query$BackupConfiguration$backup$configuration$autobackupQuotas<
          TRes
        > {
  _CopyWithStubImpl$Query$BackupConfiguration$backup$configuration$autobackupQuotas(
    this._res,
  );

  TRes _res;

  call({
    int? last,
    int? daily,
    int? weekly,
    int? monthly,
    int? yearly,
    String? $__typename,
  }) => _res;
}

class Query$AllBackupSnapshots {
  Query$AllBackupSnapshots({required this.backup, this.$__typename = 'Query'});

  factory Query$AllBackupSnapshots.fromJson(Map<String, dynamic> json) {
    final l$backup = json['backup'];
    final l$$__typename = json['__typename'];
    return Query$AllBackupSnapshots(
      backup: Query$AllBackupSnapshots$backup.fromJson(
        (l$backup as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$AllBackupSnapshots$backup backup;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$backup = backup;
    _resultData['backup'] = l$backup.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$backup = backup;
    final l$$__typename = $__typename;
    return Object.hashAll([l$backup, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$AllBackupSnapshots ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$backup = backup;
    final lOther$backup = other.backup;
    if (l$backup != lOther$backup) {
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

extension UtilityExtension$Query$AllBackupSnapshots
    on Query$AllBackupSnapshots {
  CopyWith$Query$AllBackupSnapshots<Query$AllBackupSnapshots> get copyWith =>
      CopyWith$Query$AllBackupSnapshots(this, (i) => i);
}

abstract class CopyWith$Query$AllBackupSnapshots<TRes> {
  factory CopyWith$Query$AllBackupSnapshots(
    Query$AllBackupSnapshots instance,
    TRes Function(Query$AllBackupSnapshots) then,
  ) = _CopyWithImpl$Query$AllBackupSnapshots;

  factory CopyWith$Query$AllBackupSnapshots.stub(TRes res) =
      _CopyWithStubImpl$Query$AllBackupSnapshots;

  TRes call({Query$AllBackupSnapshots$backup? backup, String? $__typename});
  CopyWith$Query$AllBackupSnapshots$backup<TRes> get backup;
}

class _CopyWithImpl$Query$AllBackupSnapshots<TRes>
    implements CopyWith$Query$AllBackupSnapshots<TRes> {
  _CopyWithImpl$Query$AllBackupSnapshots(this._instance, this._then);

  final Query$AllBackupSnapshots _instance;

  final TRes Function(Query$AllBackupSnapshots) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? backup = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$AllBackupSnapshots(
          backup:
              backup == _undefined || backup == null
                  ? _instance.backup
                  : (backup as Query$AllBackupSnapshots$backup),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Query$AllBackupSnapshots$backup<TRes> get backup {
    final local$backup = _instance.backup;
    return CopyWith$Query$AllBackupSnapshots$backup(
      local$backup,
      (e) => call(backup: e),
    );
  }
}

class _CopyWithStubImpl$Query$AllBackupSnapshots<TRes>
    implements CopyWith$Query$AllBackupSnapshots<TRes> {
  _CopyWithStubImpl$Query$AllBackupSnapshots(this._res);

  TRes _res;

  call({Query$AllBackupSnapshots$backup? backup, String? $__typename}) => _res;

  CopyWith$Query$AllBackupSnapshots$backup<TRes> get backup =>
      CopyWith$Query$AllBackupSnapshots$backup.stub(_res);
}

const documentNodeQueryAllBackupSnapshots = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'AllBackupSnapshots'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'backup'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'allSnapshots'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'createdAt'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'service'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FieldNode(
                              name: NameNode(value: 'displayName'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'id'),
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
                        name: NameNode(value: 'reason'),
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
    ),
  ],
);
Query$AllBackupSnapshots _parserFn$Query$AllBackupSnapshots(
  Map<String, dynamic> data,
) => Query$AllBackupSnapshots.fromJson(data);
typedef OnQueryComplete$Query$AllBackupSnapshots =
    FutureOr<void> Function(Map<String, dynamic>?, Query$AllBackupSnapshots?);

class Options$Query$AllBackupSnapshots
    extends graphql.QueryOptions<Query$AllBackupSnapshots> {
  Options$Query$AllBackupSnapshots({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$AllBackupSnapshots? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$AllBackupSnapshots? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
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
                       : _parserFn$Query$AllBackupSnapshots(data),
                 ),
         onError: onError,
         document: documentNodeQueryAllBackupSnapshots,
         parserFn: _parserFn$Query$AllBackupSnapshots,
       );

  final OnQueryComplete$Query$AllBackupSnapshots? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$AllBackupSnapshots
    extends graphql.WatchQueryOptions<Query$AllBackupSnapshots> {
  WatchOptions$Query$AllBackupSnapshots({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$AllBackupSnapshots? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryAllBackupSnapshots,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$AllBackupSnapshots,
       );
}

class FetchMoreOptions$Query$AllBackupSnapshots
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$AllBackupSnapshots({
    required graphql.UpdateQuery updateQuery,
  }) : super(
         updateQuery: updateQuery,
         document: documentNodeQueryAllBackupSnapshots,
       );
}

extension ClientExtension$Query$AllBackupSnapshots on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$AllBackupSnapshots>>
  query$AllBackupSnapshots([Options$Query$AllBackupSnapshots? options]) async =>
      await this.query(options ?? Options$Query$AllBackupSnapshots());
  graphql.ObservableQuery<Query$AllBackupSnapshots>
  watchQuery$AllBackupSnapshots([
    WatchOptions$Query$AllBackupSnapshots? options,
  ]) => this.watchQuery(options ?? WatchOptions$Query$AllBackupSnapshots());
  void writeQuery$AllBackupSnapshots({
    required Query$AllBackupSnapshots data,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(
        document: documentNodeQueryAllBackupSnapshots,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Query$AllBackupSnapshots? readQuery$AllBackupSnapshots({
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(
          document: documentNodeQueryAllBackupSnapshots,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$AllBackupSnapshots.fromJson(result);
  }
}

class Query$AllBackupSnapshots$backup {
  Query$AllBackupSnapshots$backup({
    required this.allSnapshots,
    this.$__typename = 'Backup',
  });

  factory Query$AllBackupSnapshots$backup.fromJson(Map<String, dynamic> json) {
    final l$allSnapshots = json['allSnapshots'];
    final l$$__typename = json['__typename'];
    return Query$AllBackupSnapshots$backup(
      allSnapshots:
          (l$allSnapshots as List<dynamic>)
              .map(
                (e) => Query$AllBackupSnapshots$backup$allSnapshots.fromJson(
                  (e as Map<String, dynamic>),
                ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$AllBackupSnapshots$backup$allSnapshots> allSnapshots;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$allSnapshots = allSnapshots;
    _resultData['allSnapshots'] =
        l$allSnapshots.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$allSnapshots = allSnapshots;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$allSnapshots.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$AllBackupSnapshots$backup ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$allSnapshots = allSnapshots;
    final lOther$allSnapshots = other.allSnapshots;
    if (l$allSnapshots.length != lOther$allSnapshots.length) {
      return false;
    }
    for (int i = 0; i < l$allSnapshots.length; i++) {
      final l$allSnapshots$entry = l$allSnapshots[i];
      final lOther$allSnapshots$entry = lOther$allSnapshots[i];
      if (l$allSnapshots$entry != lOther$allSnapshots$entry) {
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

extension UtilityExtension$Query$AllBackupSnapshots$backup
    on Query$AllBackupSnapshots$backup {
  CopyWith$Query$AllBackupSnapshots$backup<Query$AllBackupSnapshots$backup>
  get copyWith => CopyWith$Query$AllBackupSnapshots$backup(this, (i) => i);
}

abstract class CopyWith$Query$AllBackupSnapshots$backup<TRes> {
  factory CopyWith$Query$AllBackupSnapshots$backup(
    Query$AllBackupSnapshots$backup instance,
    TRes Function(Query$AllBackupSnapshots$backup) then,
  ) = _CopyWithImpl$Query$AllBackupSnapshots$backup;

  factory CopyWith$Query$AllBackupSnapshots$backup.stub(TRes res) =
      _CopyWithStubImpl$Query$AllBackupSnapshots$backup;

  TRes call({
    List<Query$AllBackupSnapshots$backup$allSnapshots>? allSnapshots,
    String? $__typename,
  });
  TRes allSnapshots(
    Iterable<Query$AllBackupSnapshots$backup$allSnapshots> Function(
      Iterable<
        CopyWith$Query$AllBackupSnapshots$backup$allSnapshots<
          Query$AllBackupSnapshots$backup$allSnapshots
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$AllBackupSnapshots$backup<TRes>
    implements CopyWith$Query$AllBackupSnapshots$backup<TRes> {
  _CopyWithImpl$Query$AllBackupSnapshots$backup(this._instance, this._then);

  final Query$AllBackupSnapshots$backup _instance;

  final TRes Function(Query$AllBackupSnapshots$backup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? allSnapshots = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$AllBackupSnapshots$backup(
      allSnapshots:
          allSnapshots == _undefined || allSnapshots == null
              ? _instance.allSnapshots
              : (allSnapshots
                  as List<Query$AllBackupSnapshots$backup$allSnapshots>),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes allSnapshots(
    Iterable<Query$AllBackupSnapshots$backup$allSnapshots> Function(
      Iterable<
        CopyWith$Query$AllBackupSnapshots$backup$allSnapshots<
          Query$AllBackupSnapshots$backup$allSnapshots
        >
      >,
    )
    _fn,
  ) => call(
    allSnapshots:
        _fn(
          _instance.allSnapshots.map(
            (e) => CopyWith$Query$AllBackupSnapshots$backup$allSnapshots(
              e,
              (i) => i,
            ),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$AllBackupSnapshots$backup<TRes>
    implements CopyWith$Query$AllBackupSnapshots$backup<TRes> {
  _CopyWithStubImpl$Query$AllBackupSnapshots$backup(this._res);

  TRes _res;

  call({
    List<Query$AllBackupSnapshots$backup$allSnapshots>? allSnapshots,
    String? $__typename,
  }) => _res;

  allSnapshots(_fn) => _res;
}

class Query$AllBackupSnapshots$backup$allSnapshots {
  Query$AllBackupSnapshots$backup$allSnapshots({
    required this.id,
    required this.createdAt,
    required this.service,
    required this.reason,
    this.$__typename = 'SnapshotInfo',
  });

  factory Query$AllBackupSnapshots$backup$allSnapshots.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    final l$createdAt = json['createdAt'];
    final l$service = json['service'];
    final l$reason = json['reason'];
    final l$$__typename = json['__typename'];
    return Query$AllBackupSnapshots$backup$allSnapshots(
      id: (l$id as String),
      createdAt: dateTimeFromJson(l$createdAt),
      service: Query$AllBackupSnapshots$backup$allSnapshots$service.fromJson(
        (l$service as Map<String, dynamic>),
      ),
      reason: fromJson$Enum$BackupReason((l$reason as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final DateTime createdAt;

  final Query$AllBackupSnapshots$backup$allSnapshots$service service;

  final Enum$BackupReason reason;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = dateTimeToJson(l$createdAt);
    final l$service = service;
    _resultData['service'] = l$service.toJson();
    final l$reason = reason;
    _resultData['reason'] = toJson$Enum$BackupReason(l$reason);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$createdAt = createdAt;
    final l$service = service;
    final l$reason = reason;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$createdAt,
      l$service,
      l$reason,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$AllBackupSnapshots$backup$allSnapshots ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$service = service;
    final lOther$service = other.service;
    if (l$service != lOther$service) {
      return false;
    }
    final l$reason = reason;
    final lOther$reason = other.reason;
    if (l$reason != lOther$reason) {
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

extension UtilityExtension$Query$AllBackupSnapshots$backup$allSnapshots
    on Query$AllBackupSnapshots$backup$allSnapshots {
  CopyWith$Query$AllBackupSnapshots$backup$allSnapshots<
    Query$AllBackupSnapshots$backup$allSnapshots
  >
  get copyWith =>
      CopyWith$Query$AllBackupSnapshots$backup$allSnapshots(this, (i) => i);
}

abstract class CopyWith$Query$AllBackupSnapshots$backup$allSnapshots<TRes> {
  factory CopyWith$Query$AllBackupSnapshots$backup$allSnapshots(
    Query$AllBackupSnapshots$backup$allSnapshots instance,
    TRes Function(Query$AllBackupSnapshots$backup$allSnapshots) then,
  ) = _CopyWithImpl$Query$AllBackupSnapshots$backup$allSnapshots;

  factory CopyWith$Query$AllBackupSnapshots$backup$allSnapshots.stub(TRes res) =
      _CopyWithStubImpl$Query$AllBackupSnapshots$backup$allSnapshots;

  TRes call({
    String? id,
    DateTime? createdAt,
    Query$AllBackupSnapshots$backup$allSnapshots$service? service,
    Enum$BackupReason? reason,
    String? $__typename,
  });
  CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service<TRes>
  get service;
}

class _CopyWithImpl$Query$AllBackupSnapshots$backup$allSnapshots<TRes>
    implements CopyWith$Query$AllBackupSnapshots$backup$allSnapshots<TRes> {
  _CopyWithImpl$Query$AllBackupSnapshots$backup$allSnapshots(
    this._instance,
    this._then,
  );

  final Query$AllBackupSnapshots$backup$allSnapshots _instance;

  final TRes Function(Query$AllBackupSnapshots$backup$allSnapshots) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? createdAt = _undefined,
    Object? service = _undefined,
    Object? reason = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$AllBackupSnapshots$backup$allSnapshots(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      createdAt:
          createdAt == _undefined || createdAt == null
              ? _instance.createdAt
              : (createdAt as DateTime),
      service:
          service == _undefined || service == null
              ? _instance.service
              : (service
                  as Query$AllBackupSnapshots$backup$allSnapshots$service),
      reason:
          reason == _undefined || reason == null
              ? _instance.reason
              : (reason as Enum$BackupReason),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service<TRes>
  get service {
    final local$service = _instance.service;
    return CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service(
      local$service,
      (e) => call(service: e),
    );
  }
}

class _CopyWithStubImpl$Query$AllBackupSnapshots$backup$allSnapshots<TRes>
    implements CopyWith$Query$AllBackupSnapshots$backup$allSnapshots<TRes> {
  _CopyWithStubImpl$Query$AllBackupSnapshots$backup$allSnapshots(this._res);

  TRes _res;

  call({
    String? id,
    DateTime? createdAt,
    Query$AllBackupSnapshots$backup$allSnapshots$service? service,
    Enum$BackupReason? reason,
    String? $__typename,
  }) => _res;

  CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service<TRes>
  get service =>
      CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service.stub(_res);
}

class Query$AllBackupSnapshots$backup$allSnapshots$service {
  Query$AllBackupSnapshots$backup$allSnapshots$service({
    required this.displayName,
    required this.id,
    this.$__typename = 'Service',
  });

  factory Query$AllBackupSnapshots$backup$allSnapshots$service.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$displayName = json['displayName'];
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return Query$AllBackupSnapshots$backup$allSnapshots$service(
      displayName: (l$displayName as String),
      id: (l$id as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String displayName;

  final String id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$displayName = displayName;
    _resultData['displayName'] = l$displayName;
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$displayName = displayName;
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([l$displayName, l$id, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$AllBackupSnapshots$backup$allSnapshots$service ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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

extension UtilityExtension$Query$AllBackupSnapshots$backup$allSnapshots$service
    on Query$AllBackupSnapshots$backup$allSnapshots$service {
  CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service<
    Query$AllBackupSnapshots$backup$allSnapshots$service
  >
  get copyWith => CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service(
    this,
    (i) => i,
  );
}

abstract class CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service<
  TRes
> {
  factory CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service(
    Query$AllBackupSnapshots$backup$allSnapshots$service instance,
    TRes Function(Query$AllBackupSnapshots$backup$allSnapshots$service) then,
  ) = _CopyWithImpl$Query$AllBackupSnapshots$backup$allSnapshots$service;

  factory CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service.stub(
    TRes res,
  ) = _CopyWithStubImpl$Query$AllBackupSnapshots$backup$allSnapshots$service;

  TRes call({String? displayName, String? id, String? $__typename});
}

class _CopyWithImpl$Query$AllBackupSnapshots$backup$allSnapshots$service<TRes>
    implements
        CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service<TRes> {
  _CopyWithImpl$Query$AllBackupSnapshots$backup$allSnapshots$service(
    this._instance,
    this._then,
  );

  final Query$AllBackupSnapshots$backup$allSnapshots$service _instance;

  final TRes Function(Query$AllBackupSnapshots$backup$allSnapshots$service)
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? displayName = _undefined,
    Object? id = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$AllBackupSnapshots$backup$allSnapshots$service(
      displayName:
          displayName == _undefined || displayName == null
              ? _instance.displayName
              : (displayName as String),
      id: id == _undefined || id == null ? _instance.id : (id as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$AllBackupSnapshots$backup$allSnapshots$service<
  TRes
>
    implements
        CopyWith$Query$AllBackupSnapshots$backup$allSnapshots$service<TRes> {
  _CopyWithStubImpl$Query$AllBackupSnapshots$backup$allSnapshots$service(
    this._res,
  );

  TRes _res;

  call({String? displayName, String? id, String? $__typename}) => _res;
}

class Mutation$ForceSnapshotsReload {
  Mutation$ForceSnapshotsReload({
    required this.backup,
    this.$__typename = 'Mutation',
  });

  factory Mutation$ForceSnapshotsReload.fromJson(Map<String, dynamic> json) {
    final l$backup = json['backup'];
    final l$$__typename = json['__typename'];
    return Mutation$ForceSnapshotsReload(
      backup: Mutation$ForceSnapshotsReload$backup.fromJson(
        (l$backup as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$ForceSnapshotsReload$backup backup;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$backup = backup;
    _resultData['backup'] = l$backup.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$backup = backup;
    final l$$__typename = $__typename;
    return Object.hashAll([l$backup, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ForceSnapshotsReload ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$backup = backup;
    final lOther$backup = other.backup;
    if (l$backup != lOther$backup) {
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

extension UtilityExtension$Mutation$ForceSnapshotsReload
    on Mutation$ForceSnapshotsReload {
  CopyWith$Mutation$ForceSnapshotsReload<Mutation$ForceSnapshotsReload>
  get copyWith => CopyWith$Mutation$ForceSnapshotsReload(this, (i) => i);
}

abstract class CopyWith$Mutation$ForceSnapshotsReload<TRes> {
  factory CopyWith$Mutation$ForceSnapshotsReload(
    Mutation$ForceSnapshotsReload instance,
    TRes Function(Mutation$ForceSnapshotsReload) then,
  ) = _CopyWithImpl$Mutation$ForceSnapshotsReload;

  factory CopyWith$Mutation$ForceSnapshotsReload.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ForceSnapshotsReload;

  TRes call({
    Mutation$ForceSnapshotsReload$backup? backup,
    String? $__typename,
  });
  CopyWith$Mutation$ForceSnapshotsReload$backup<TRes> get backup;
}

class _CopyWithImpl$Mutation$ForceSnapshotsReload<TRes>
    implements CopyWith$Mutation$ForceSnapshotsReload<TRes> {
  _CopyWithImpl$Mutation$ForceSnapshotsReload(this._instance, this._then);

  final Mutation$ForceSnapshotsReload _instance;

  final TRes Function(Mutation$ForceSnapshotsReload) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? backup = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$ForceSnapshotsReload(
          backup:
              backup == _undefined || backup == null
                  ? _instance.backup
                  : (backup as Mutation$ForceSnapshotsReload$backup),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$ForceSnapshotsReload$backup<TRes> get backup {
    final local$backup = _instance.backup;
    return CopyWith$Mutation$ForceSnapshotsReload$backup(
      local$backup,
      (e) => call(backup: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$ForceSnapshotsReload<TRes>
    implements CopyWith$Mutation$ForceSnapshotsReload<TRes> {
  _CopyWithStubImpl$Mutation$ForceSnapshotsReload(this._res);

  TRes _res;

  call({Mutation$ForceSnapshotsReload$backup? backup, String? $__typename}) =>
      _res;

  CopyWith$Mutation$ForceSnapshotsReload$backup<TRes> get backup =>
      CopyWith$Mutation$ForceSnapshotsReload$backup.stub(_res);
}

const documentNodeMutationForceSnapshotsReload = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ForceSnapshotsReload'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'backup'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'forceSnapshotsReload'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'basicMutationReturnFields'),
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
    fragmentDefinitionbasicMutationReturnFields,
  ],
);
Mutation$ForceSnapshotsReload _parserFn$Mutation$ForceSnapshotsReload(
  Map<String, dynamic> data,
) => Mutation$ForceSnapshotsReload.fromJson(data);
typedef OnMutationCompleted$Mutation$ForceSnapshotsReload =
    FutureOr<void> Function(
      Map<String, dynamic>?,
      Mutation$ForceSnapshotsReload?,
    );

class Options$Mutation$ForceSnapshotsReload
    extends graphql.MutationOptions<Mutation$ForceSnapshotsReload> {
  Options$Mutation$ForceSnapshotsReload({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ForceSnapshotsReload? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$ForceSnapshotsReload? onCompleted,
    graphql.OnMutationUpdate<Mutation$ForceSnapshotsReload>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
                 ? null
                 : (data) => onCompleted(
                   data,
                   data == null
                       ? null
                       : _parserFn$Mutation$ForceSnapshotsReload(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationForceSnapshotsReload,
         parserFn: _parserFn$Mutation$ForceSnapshotsReload,
       );

  final OnMutationCompleted$Mutation$ForceSnapshotsReload?
  onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$ForceSnapshotsReload
    extends graphql.WatchQueryOptions<Mutation$ForceSnapshotsReload> {
  WatchOptions$Mutation$ForceSnapshotsReload({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ForceSnapshotsReload? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationForceSnapshotsReload,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$ForceSnapshotsReload,
       );
}

extension ClientExtension$Mutation$ForceSnapshotsReload
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$ForceSnapshotsReload>>
  mutate$ForceSnapshotsReload([
    Options$Mutation$ForceSnapshotsReload? options,
  ]) async =>
      await this.mutate(options ?? Options$Mutation$ForceSnapshotsReload());
  graphql.ObservableQuery<Mutation$ForceSnapshotsReload>
  watchMutation$ForceSnapshotsReload([
    WatchOptions$Mutation$ForceSnapshotsReload? options,
  ]) => this.watchMutation(
    options ?? WatchOptions$Mutation$ForceSnapshotsReload(),
  );
}

class Mutation$ForceSnapshotsReload$backup {
  Mutation$ForceSnapshotsReload$backup({
    required this.forceSnapshotsReload,
    this.$__typename = 'BackupMutations',
  });

  factory Mutation$ForceSnapshotsReload$backup.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$forceSnapshotsReload = json['forceSnapshotsReload'];
    final l$$__typename = json['__typename'];
    return Mutation$ForceSnapshotsReload$backup(
      forceSnapshotsReload:
          Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload.fromJson(
            (l$forceSnapshotsReload as Map<String, dynamic>),
          ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload
  forceSnapshotsReload;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$forceSnapshotsReload = forceSnapshotsReload;
    _resultData['forceSnapshotsReload'] = l$forceSnapshotsReload.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$forceSnapshotsReload = forceSnapshotsReload;
    final l$$__typename = $__typename;
    return Object.hashAll([l$forceSnapshotsReload, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ForceSnapshotsReload$backup ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$forceSnapshotsReload = forceSnapshotsReload;
    final lOther$forceSnapshotsReload = other.forceSnapshotsReload;
    if (l$forceSnapshotsReload != lOther$forceSnapshotsReload) {
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

extension UtilityExtension$Mutation$ForceSnapshotsReload$backup
    on Mutation$ForceSnapshotsReload$backup {
  CopyWith$Mutation$ForceSnapshotsReload$backup<
    Mutation$ForceSnapshotsReload$backup
  >
  get copyWith => CopyWith$Mutation$ForceSnapshotsReload$backup(this, (i) => i);
}

abstract class CopyWith$Mutation$ForceSnapshotsReload$backup<TRes> {
  factory CopyWith$Mutation$ForceSnapshotsReload$backup(
    Mutation$ForceSnapshotsReload$backup instance,
    TRes Function(Mutation$ForceSnapshotsReload$backup) then,
  ) = _CopyWithImpl$Mutation$ForceSnapshotsReload$backup;

  factory CopyWith$Mutation$ForceSnapshotsReload$backup.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ForceSnapshotsReload$backup;

  TRes call({
    Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload?
    forceSnapshotsReload,
    String? $__typename,
  });
  CopyWith$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload<TRes>
  get forceSnapshotsReload;
}

class _CopyWithImpl$Mutation$ForceSnapshotsReload$backup<TRes>
    implements CopyWith$Mutation$ForceSnapshotsReload$backup<TRes> {
  _CopyWithImpl$Mutation$ForceSnapshotsReload$backup(
    this._instance,
    this._then,
  );

  final Mutation$ForceSnapshotsReload$backup _instance;

  final TRes Function(Mutation$ForceSnapshotsReload$backup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? forceSnapshotsReload = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$ForceSnapshotsReload$backup(
      forceSnapshotsReload:
          forceSnapshotsReload == _undefined || forceSnapshotsReload == null
              ? _instance.forceSnapshotsReload
              : (forceSnapshotsReload
                  as Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload<TRes>
  get forceSnapshotsReload {
    final local$forceSnapshotsReload = _instance.forceSnapshotsReload;
    return CopyWith$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload(
      local$forceSnapshotsReload,
      (e) => call(forceSnapshotsReload: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$ForceSnapshotsReload$backup<TRes>
    implements CopyWith$Mutation$ForceSnapshotsReload$backup<TRes> {
  _CopyWithStubImpl$Mutation$ForceSnapshotsReload$backup(this._res);

  TRes _res;

  call({
    Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload?
    forceSnapshotsReload,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload<TRes>
  get forceSnapshotsReload =>
      CopyWith$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload.stub(
        _res,
      );
}

class Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload
    implements Fragment$basicMutationReturnFields$$GenericMutationReturn {
  Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    return Object.hashAll([l$code, l$message, l$success, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) {
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

extension UtilityExtension$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload
    on Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload {
  CopyWith$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload<
    Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload
  >
  get copyWith =>
      CopyWith$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload<
  TRes
> {
  factory CopyWith$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload(
    Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload instance,
    TRes Function(Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload)
    then,
  ) = _CopyWithImpl$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload;

  factory CopyWith$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload.stub(
    TRes res,
  ) = _CopyWithStubImpl$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload<
  TRes
>
    implements
        CopyWith$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload<
          TRes
        > {
  _CopyWithImpl$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload(
    this._instance,
    this._then,
  );

  final Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload _instance;

  final TRes Function(Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload)
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload<
  TRes
>
    implements
        CopyWith$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload<
          TRes
        > {
  _CopyWithStubImpl$Mutation$ForceSnapshotsReload$backup$forceSnapshotsReload(
    this._res,
  );

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

class Variables$Mutation$StartBackup {
  factory Variables$Mutation$StartBackup({required String serviceId}) =>
      Variables$Mutation$StartBackup._({r'serviceId': serviceId});

  Variables$Mutation$StartBackup._(this._$data);

  factory Variables$Mutation$StartBackup.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$serviceId = data['serviceId'];
    result$data['serviceId'] = (l$serviceId as String);
    return Variables$Mutation$StartBackup._(result$data);
  }

  Map<String, dynamic> _$data;

  String get serviceId => (_$data['serviceId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$serviceId = serviceId;
    result$data['serviceId'] = l$serviceId;
    return result$data;
  }

  CopyWith$Variables$Mutation$StartBackup<Variables$Mutation$StartBackup>
  get copyWith => CopyWith$Variables$Mutation$StartBackup(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$StartBackup ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$serviceId = serviceId;
    final lOther$serviceId = other.serviceId;
    if (l$serviceId != lOther$serviceId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$serviceId = serviceId;
    return Object.hashAll([l$serviceId]);
  }
}

abstract class CopyWith$Variables$Mutation$StartBackup<TRes> {
  factory CopyWith$Variables$Mutation$StartBackup(
    Variables$Mutation$StartBackup instance,
    TRes Function(Variables$Mutation$StartBackup) then,
  ) = _CopyWithImpl$Variables$Mutation$StartBackup;

  factory CopyWith$Variables$Mutation$StartBackup.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$StartBackup;

  TRes call({String? serviceId});
}

class _CopyWithImpl$Variables$Mutation$StartBackup<TRes>
    implements CopyWith$Variables$Mutation$StartBackup<TRes> {
  _CopyWithImpl$Variables$Mutation$StartBackup(this._instance, this._then);

  final Variables$Mutation$StartBackup _instance;

  final TRes Function(Variables$Mutation$StartBackup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? serviceId = _undefined}) => _then(
    Variables$Mutation$StartBackup._({
      ..._instance._$data,
      if (serviceId != _undefined && serviceId != null)
        'serviceId': (serviceId as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$StartBackup<TRes>
    implements CopyWith$Variables$Mutation$StartBackup<TRes> {
  _CopyWithStubImpl$Variables$Mutation$StartBackup(this._res);

  TRes _res;

  call({String? serviceId}) => _res;
}

class Mutation$StartBackup {
  Mutation$StartBackup({required this.backup, this.$__typename = 'Mutation'});

  factory Mutation$StartBackup.fromJson(Map<String, dynamic> json) {
    final l$backup = json['backup'];
    final l$$__typename = json['__typename'];
    return Mutation$StartBackup(
      backup: Mutation$StartBackup$backup.fromJson(
        (l$backup as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$StartBackup$backup backup;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$backup = backup;
    _resultData['backup'] = l$backup.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$backup = backup;
    final l$$__typename = $__typename;
    return Object.hashAll([l$backup, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$StartBackup || runtimeType != other.runtimeType) {
      return false;
    }
    final l$backup = backup;
    final lOther$backup = other.backup;
    if (l$backup != lOther$backup) {
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

extension UtilityExtension$Mutation$StartBackup on Mutation$StartBackup {
  CopyWith$Mutation$StartBackup<Mutation$StartBackup> get copyWith =>
      CopyWith$Mutation$StartBackup(this, (i) => i);
}

abstract class CopyWith$Mutation$StartBackup<TRes> {
  factory CopyWith$Mutation$StartBackup(
    Mutation$StartBackup instance,
    TRes Function(Mutation$StartBackup) then,
  ) = _CopyWithImpl$Mutation$StartBackup;

  factory CopyWith$Mutation$StartBackup.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StartBackup;

  TRes call({Mutation$StartBackup$backup? backup, String? $__typename});
  CopyWith$Mutation$StartBackup$backup<TRes> get backup;
}

class _CopyWithImpl$Mutation$StartBackup<TRes>
    implements CopyWith$Mutation$StartBackup<TRes> {
  _CopyWithImpl$Mutation$StartBackup(this._instance, this._then);

  final Mutation$StartBackup _instance;

  final TRes Function(Mutation$StartBackup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? backup = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$StartBackup(
          backup:
              backup == _undefined || backup == null
                  ? _instance.backup
                  : (backup as Mutation$StartBackup$backup),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$StartBackup$backup<TRes> get backup {
    final local$backup = _instance.backup;
    return CopyWith$Mutation$StartBackup$backup(
      local$backup,
      (e) => call(backup: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$StartBackup<TRes>
    implements CopyWith$Mutation$StartBackup<TRes> {
  _CopyWithStubImpl$Mutation$StartBackup(this._res);

  TRes _res;

  call({Mutation$StartBackup$backup? backup, String? $__typename}) => _res;

  CopyWith$Mutation$StartBackup$backup<TRes> get backup =>
      CopyWith$Mutation$StartBackup$backup.stub(_res);
}

const documentNodeMutationStartBackup = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'StartBackup'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'serviceId')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'backup'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'startBackup'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'serviceId'),
                      value: VariableNode(name: NameNode(value: 'serviceId')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'basicMutationReturnFields'),
                        directives: [],
                      ),
                      FieldNode(
                        name: NameNode(value: 'job'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FragmentSpreadNode(
                              name: NameNode(value: 'basicApiJobsFields'),
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
    fragmentDefinitionbasicMutationReturnFields,
    fragmentDefinitionbasicApiJobsFields,
  ],
);
Mutation$StartBackup _parserFn$Mutation$StartBackup(
  Map<String, dynamic> data,
) => Mutation$StartBackup.fromJson(data);
typedef OnMutationCompleted$Mutation$StartBackup =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$StartBackup?);

class Options$Mutation$StartBackup
    extends graphql.MutationOptions<Mutation$StartBackup> {
  Options$Mutation$StartBackup({
    String? operationName,
    required Variables$Mutation$StartBackup variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$StartBackup? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$StartBackup? onCompleted,
    graphql.OnMutationUpdate<Mutation$StartBackup>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
                 ? null
                 : (data) => onCompleted(
                   data,
                   data == null ? null : _parserFn$Mutation$StartBackup(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationStartBackup,
         parserFn: _parserFn$Mutation$StartBackup,
       );

  final OnMutationCompleted$Mutation$StartBackup? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$StartBackup
    extends graphql.WatchQueryOptions<Mutation$StartBackup> {
  WatchOptions$Mutation$StartBackup({
    String? operationName,
    required Variables$Mutation$StartBackup variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$StartBackup? typedOptimisticResult,
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
         document: documentNodeMutationStartBackup,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$StartBackup,
       );
}

extension ClientExtension$Mutation$StartBackup on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$StartBackup>> mutate$StartBackup(
    Options$Mutation$StartBackup options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$StartBackup> watchMutation$StartBackup(
    WatchOptions$Mutation$StartBackup options,
  ) => this.watchMutation(options);
}

class Mutation$StartBackup$backup {
  Mutation$StartBackup$backup({
    required this.startBackup,
    this.$__typename = 'BackupMutations',
  });

  factory Mutation$StartBackup$backup.fromJson(Map<String, dynamic> json) {
    final l$startBackup = json['startBackup'];
    final l$$__typename = json['__typename'];
    return Mutation$StartBackup$backup(
      startBackup: Mutation$StartBackup$backup$startBackup.fromJson(
        (l$startBackup as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$StartBackup$backup$startBackup startBackup;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$startBackup = startBackup;
    _resultData['startBackup'] = l$startBackup.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$startBackup = startBackup;
    final l$$__typename = $__typename;
    return Object.hashAll([l$startBackup, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$StartBackup$backup ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$startBackup = startBackup;
    final lOther$startBackup = other.startBackup;
    if (l$startBackup != lOther$startBackup) {
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

extension UtilityExtension$Mutation$StartBackup$backup
    on Mutation$StartBackup$backup {
  CopyWith$Mutation$StartBackup$backup<Mutation$StartBackup$backup>
  get copyWith => CopyWith$Mutation$StartBackup$backup(this, (i) => i);
}

abstract class CopyWith$Mutation$StartBackup$backup<TRes> {
  factory CopyWith$Mutation$StartBackup$backup(
    Mutation$StartBackup$backup instance,
    TRes Function(Mutation$StartBackup$backup) then,
  ) = _CopyWithImpl$Mutation$StartBackup$backup;

  factory CopyWith$Mutation$StartBackup$backup.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StartBackup$backup;

  TRes call({
    Mutation$StartBackup$backup$startBackup? startBackup,
    String? $__typename,
  });
  CopyWith$Mutation$StartBackup$backup$startBackup<TRes> get startBackup;
}

class _CopyWithImpl$Mutation$StartBackup$backup<TRes>
    implements CopyWith$Mutation$StartBackup$backup<TRes> {
  _CopyWithImpl$Mutation$StartBackup$backup(this._instance, this._then);

  final Mutation$StartBackup$backup _instance;

  final TRes Function(Mutation$StartBackup$backup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? startBackup = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$StartBackup$backup(
      startBackup:
          startBackup == _undefined || startBackup == null
              ? _instance.startBackup
              : (startBackup as Mutation$StartBackup$backup$startBackup),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$StartBackup$backup$startBackup<TRes> get startBackup {
    final local$startBackup = _instance.startBackup;
    return CopyWith$Mutation$StartBackup$backup$startBackup(
      local$startBackup,
      (e) => call(startBackup: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$StartBackup$backup<TRes>
    implements CopyWith$Mutation$StartBackup$backup<TRes> {
  _CopyWithStubImpl$Mutation$StartBackup$backup(this._res);

  TRes _res;

  call({
    Mutation$StartBackup$backup$startBackup? startBackup,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$StartBackup$backup$startBackup<TRes> get startBackup =>
      CopyWith$Mutation$StartBackup$backup$startBackup.stub(_res);
}

class Mutation$StartBackup$backup$startBackup
    implements Fragment$basicMutationReturnFields$$GenericJobMutationReturn {
  Mutation$StartBackup$backup$startBackup({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericJobMutationReturn',
    this.job,
  });

  factory Mutation$StartBackup$backup$startBackup.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$job = json['job'];
    return Mutation$StartBackup$backup$startBackup(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      job:
          l$job == null
              ? null
              : Fragment$basicApiJobsFields.fromJson(
                (l$job as Map<String, dynamic>),
              ),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final Fragment$basicApiJobsFields? job;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    final l$job = job;
    _resultData['job'] = l$job?.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$job = job;
    return Object.hashAll([l$code, l$message, l$success, l$$__typename, l$job]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$StartBackup$backup$startBackup ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    final l$job = job;
    final lOther$job = other.job;
    if (l$job != lOther$job) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$StartBackup$backup$startBackup
    on Mutation$StartBackup$backup$startBackup {
  CopyWith$Mutation$StartBackup$backup$startBackup<
    Mutation$StartBackup$backup$startBackup
  >
  get copyWith =>
      CopyWith$Mutation$StartBackup$backup$startBackup(this, (i) => i);
}

abstract class CopyWith$Mutation$StartBackup$backup$startBackup<TRes> {
  factory CopyWith$Mutation$StartBackup$backup$startBackup(
    Mutation$StartBackup$backup$startBackup instance,
    TRes Function(Mutation$StartBackup$backup$startBackup) then,
  ) = _CopyWithImpl$Mutation$StartBackup$backup$startBackup;

  factory CopyWith$Mutation$StartBackup$backup$startBackup.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StartBackup$backup$startBackup;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$basicApiJobsFields? job,
  });
  CopyWith$Fragment$basicApiJobsFields<TRes> get job;
}

class _CopyWithImpl$Mutation$StartBackup$backup$startBackup<TRes>
    implements CopyWith$Mutation$StartBackup$backup$startBackup<TRes> {
  _CopyWithImpl$Mutation$StartBackup$backup$startBackup(
    this._instance,
    this._then,
  );

  final Mutation$StartBackup$backup$startBackup _instance;

  final TRes Function(Mutation$StartBackup$backup$startBackup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? job = _undefined,
  }) => _then(
    Mutation$StartBackup$backup$startBackup(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
      job:
          job == _undefined
              ? _instance.job
              : (job as Fragment$basicApiJobsFields?),
    ),
  );

  CopyWith$Fragment$basicApiJobsFields<TRes> get job {
    final local$job = _instance.job;
    return local$job == null
        ? CopyWith$Fragment$basicApiJobsFields.stub(_then(_instance))
        : CopyWith$Fragment$basicApiJobsFields(local$job, (e) => call(job: e));
  }
}

class _CopyWithStubImpl$Mutation$StartBackup$backup$startBackup<TRes>
    implements CopyWith$Mutation$StartBackup$backup$startBackup<TRes> {
  _CopyWithStubImpl$Mutation$StartBackup$backup$startBackup(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$basicApiJobsFields? job,
  }) => _res;

  CopyWith$Fragment$basicApiJobsFields<TRes> get job =>
      CopyWith$Fragment$basicApiJobsFields.stub(_res);
}

class Variables$Mutation$SetAutobackupPeriod {
  factory Variables$Mutation$SetAutobackupPeriod({int? period}) =>
      Variables$Mutation$SetAutobackupPeriod._({
        if (period != null) r'period': period,
      });

  Variables$Mutation$SetAutobackupPeriod._(this._$data);

  factory Variables$Mutation$SetAutobackupPeriod.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('period')) {
      final l$period = data['period'];
      result$data['period'] = (l$period as int?);
    }
    return Variables$Mutation$SetAutobackupPeriod._(result$data);
  }

  Map<String, dynamic> _$data;

  int? get period => (_$data['period'] as int?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('period')) {
      final l$period = period;
      result$data['period'] = l$period;
    }
    return result$data;
  }

  CopyWith$Variables$Mutation$SetAutobackupPeriod<
    Variables$Mutation$SetAutobackupPeriod
  >
  get copyWith =>
      CopyWith$Variables$Mutation$SetAutobackupPeriod(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$SetAutobackupPeriod ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$period = period;
    final lOther$period = other.period;
    if (_$data.containsKey('period') != other._$data.containsKey('period')) {
      return false;
    }
    if (l$period != lOther$period) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$period = period;
    return Object.hashAll([_$data.containsKey('period') ? l$period : const {}]);
  }
}

abstract class CopyWith$Variables$Mutation$SetAutobackupPeriod<TRes> {
  factory CopyWith$Variables$Mutation$SetAutobackupPeriod(
    Variables$Mutation$SetAutobackupPeriod instance,
    TRes Function(Variables$Mutation$SetAutobackupPeriod) then,
  ) = _CopyWithImpl$Variables$Mutation$SetAutobackupPeriod;

  factory CopyWith$Variables$Mutation$SetAutobackupPeriod.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$SetAutobackupPeriod;

  TRes call({int? period});
}

class _CopyWithImpl$Variables$Mutation$SetAutobackupPeriod<TRes>
    implements CopyWith$Variables$Mutation$SetAutobackupPeriod<TRes> {
  _CopyWithImpl$Variables$Mutation$SetAutobackupPeriod(
    this._instance,
    this._then,
  );

  final Variables$Mutation$SetAutobackupPeriod _instance;

  final TRes Function(Variables$Mutation$SetAutobackupPeriod) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? period = _undefined}) => _then(
    Variables$Mutation$SetAutobackupPeriod._({
      ..._instance._$data,
      if (period != _undefined) 'period': (period as int?),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$SetAutobackupPeriod<TRes>
    implements CopyWith$Variables$Mutation$SetAutobackupPeriod<TRes> {
  _CopyWithStubImpl$Variables$Mutation$SetAutobackupPeriod(this._res);

  TRes _res;

  call({int? period}) => _res;
}

class Mutation$SetAutobackupPeriod {
  Mutation$SetAutobackupPeriod({
    required this.backup,
    this.$__typename = 'Mutation',
  });

  factory Mutation$SetAutobackupPeriod.fromJson(Map<String, dynamic> json) {
    final l$backup = json['backup'];
    final l$$__typename = json['__typename'];
    return Mutation$SetAutobackupPeriod(
      backup: Mutation$SetAutobackupPeriod$backup.fromJson(
        (l$backup as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$SetAutobackupPeriod$backup backup;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$backup = backup;
    _resultData['backup'] = l$backup.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$backup = backup;
    final l$$__typename = $__typename;
    return Object.hashAll([l$backup, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$SetAutobackupPeriod ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$backup = backup;
    final lOther$backup = other.backup;
    if (l$backup != lOther$backup) {
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

extension UtilityExtension$Mutation$SetAutobackupPeriod
    on Mutation$SetAutobackupPeriod {
  CopyWith$Mutation$SetAutobackupPeriod<Mutation$SetAutobackupPeriod>
  get copyWith => CopyWith$Mutation$SetAutobackupPeriod(this, (i) => i);
}

abstract class CopyWith$Mutation$SetAutobackupPeriod<TRes> {
  factory CopyWith$Mutation$SetAutobackupPeriod(
    Mutation$SetAutobackupPeriod instance,
    TRes Function(Mutation$SetAutobackupPeriod) then,
  ) = _CopyWithImpl$Mutation$SetAutobackupPeriod;

  factory CopyWith$Mutation$SetAutobackupPeriod.stub(TRes res) =
      _CopyWithStubImpl$Mutation$SetAutobackupPeriod;

  TRes call({Mutation$SetAutobackupPeriod$backup? backup, String? $__typename});
  CopyWith$Mutation$SetAutobackupPeriod$backup<TRes> get backup;
}

class _CopyWithImpl$Mutation$SetAutobackupPeriod<TRes>
    implements CopyWith$Mutation$SetAutobackupPeriod<TRes> {
  _CopyWithImpl$Mutation$SetAutobackupPeriod(this._instance, this._then);

  final Mutation$SetAutobackupPeriod _instance;

  final TRes Function(Mutation$SetAutobackupPeriod) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? backup = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$SetAutobackupPeriod(
          backup:
              backup == _undefined || backup == null
                  ? _instance.backup
                  : (backup as Mutation$SetAutobackupPeriod$backup),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$SetAutobackupPeriod$backup<TRes> get backup {
    final local$backup = _instance.backup;
    return CopyWith$Mutation$SetAutobackupPeriod$backup(
      local$backup,
      (e) => call(backup: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$SetAutobackupPeriod<TRes>
    implements CopyWith$Mutation$SetAutobackupPeriod<TRes> {
  _CopyWithStubImpl$Mutation$SetAutobackupPeriod(this._res);

  TRes _res;

  call({Mutation$SetAutobackupPeriod$backup? backup, String? $__typename}) =>
      _res;

  CopyWith$Mutation$SetAutobackupPeriod$backup<TRes> get backup =>
      CopyWith$Mutation$SetAutobackupPeriod$backup.stub(_res);
}

const documentNodeMutationSetAutobackupPeriod = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SetAutobackupPeriod'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'period')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: false),
          defaultValue: DefaultValueNode(value: NullValueNode()),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'backup'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'setAutobackupPeriod'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'period'),
                      value: VariableNode(name: NameNode(value: 'period')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'genericBackupConfigReturn'),
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
    fragmentDefinitiongenericBackupConfigReturn,
  ],
);
Mutation$SetAutobackupPeriod _parserFn$Mutation$SetAutobackupPeriod(
  Map<String, dynamic> data,
) => Mutation$SetAutobackupPeriod.fromJson(data);
typedef OnMutationCompleted$Mutation$SetAutobackupPeriod =
    FutureOr<void> Function(
      Map<String, dynamic>?,
      Mutation$SetAutobackupPeriod?,
    );

class Options$Mutation$SetAutobackupPeriod
    extends graphql.MutationOptions<Mutation$SetAutobackupPeriod> {
  Options$Mutation$SetAutobackupPeriod({
    String? operationName,
    Variables$Mutation$SetAutobackupPeriod? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$SetAutobackupPeriod? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$SetAutobackupPeriod? onCompleted,
    graphql.OnMutationUpdate<Mutation$SetAutobackupPeriod>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables?.toJson() ?? {},
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
                 ? null
                 : (data) => onCompleted(
                   data,
                   data == null
                       ? null
                       : _parserFn$Mutation$SetAutobackupPeriod(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationSetAutobackupPeriod,
         parserFn: _parserFn$Mutation$SetAutobackupPeriod,
       );

  final OnMutationCompleted$Mutation$SetAutobackupPeriod? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$SetAutobackupPeriod
    extends graphql.WatchQueryOptions<Mutation$SetAutobackupPeriod> {
  WatchOptions$Mutation$SetAutobackupPeriod({
    String? operationName,
    Variables$Mutation$SetAutobackupPeriod? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$SetAutobackupPeriod? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables?.toJson() ?? {},
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSetAutobackupPeriod,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$SetAutobackupPeriod,
       );
}

extension ClientExtension$Mutation$SetAutobackupPeriod
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$SetAutobackupPeriod>>
  mutate$SetAutobackupPeriod([
    Options$Mutation$SetAutobackupPeriod? options,
  ]) async =>
      await this.mutate(options ?? Options$Mutation$SetAutobackupPeriod());
  graphql.ObservableQuery<Mutation$SetAutobackupPeriod>
  watchMutation$SetAutobackupPeriod([
    WatchOptions$Mutation$SetAutobackupPeriod? options,
  ]) => this.watchMutation(
    options ?? WatchOptions$Mutation$SetAutobackupPeriod(),
  );
}

class Mutation$SetAutobackupPeriod$backup {
  Mutation$SetAutobackupPeriod$backup({
    required this.setAutobackupPeriod,
    this.$__typename = 'BackupMutations',
  });

  factory Mutation$SetAutobackupPeriod$backup.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$setAutobackupPeriod = json['setAutobackupPeriod'];
    final l$$__typename = json['__typename'];
    return Mutation$SetAutobackupPeriod$backup(
      setAutobackupPeriod: Fragment$genericBackupConfigReturn.fromJson(
        (l$setAutobackupPeriod as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$genericBackupConfigReturn setAutobackupPeriod;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$setAutobackupPeriod = setAutobackupPeriod;
    _resultData['setAutobackupPeriod'] = l$setAutobackupPeriod.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$setAutobackupPeriod = setAutobackupPeriod;
    final l$$__typename = $__typename;
    return Object.hashAll([l$setAutobackupPeriod, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$SetAutobackupPeriod$backup ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$setAutobackupPeriod = setAutobackupPeriod;
    final lOther$setAutobackupPeriod = other.setAutobackupPeriod;
    if (l$setAutobackupPeriod != lOther$setAutobackupPeriod) {
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

extension UtilityExtension$Mutation$SetAutobackupPeriod$backup
    on Mutation$SetAutobackupPeriod$backup {
  CopyWith$Mutation$SetAutobackupPeriod$backup<
    Mutation$SetAutobackupPeriod$backup
  >
  get copyWith => CopyWith$Mutation$SetAutobackupPeriod$backup(this, (i) => i);
}

abstract class CopyWith$Mutation$SetAutobackupPeriod$backup<TRes> {
  factory CopyWith$Mutation$SetAutobackupPeriod$backup(
    Mutation$SetAutobackupPeriod$backup instance,
    TRes Function(Mutation$SetAutobackupPeriod$backup) then,
  ) = _CopyWithImpl$Mutation$SetAutobackupPeriod$backup;

  factory CopyWith$Mutation$SetAutobackupPeriod$backup.stub(TRes res) =
      _CopyWithStubImpl$Mutation$SetAutobackupPeriod$backup;

  TRes call({
    Fragment$genericBackupConfigReturn? setAutobackupPeriod,
    String? $__typename,
  });
  CopyWith$Fragment$genericBackupConfigReturn<TRes> get setAutobackupPeriod;
}

class _CopyWithImpl$Mutation$SetAutobackupPeriod$backup<TRes>
    implements CopyWith$Mutation$SetAutobackupPeriod$backup<TRes> {
  _CopyWithImpl$Mutation$SetAutobackupPeriod$backup(this._instance, this._then);

  final Mutation$SetAutobackupPeriod$backup _instance;

  final TRes Function(Mutation$SetAutobackupPeriod$backup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? setAutobackupPeriod = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$SetAutobackupPeriod$backup(
      setAutobackupPeriod:
          setAutobackupPeriod == _undefined || setAutobackupPeriod == null
              ? _instance.setAutobackupPeriod
              : (setAutobackupPeriod as Fragment$genericBackupConfigReturn),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Fragment$genericBackupConfigReturn<TRes> get setAutobackupPeriod {
    final local$setAutobackupPeriod = _instance.setAutobackupPeriod;
    return CopyWith$Fragment$genericBackupConfigReturn(
      local$setAutobackupPeriod,
      (e) => call(setAutobackupPeriod: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$SetAutobackupPeriod$backup<TRes>
    implements CopyWith$Mutation$SetAutobackupPeriod$backup<TRes> {
  _CopyWithStubImpl$Mutation$SetAutobackupPeriod$backup(this._res);

  TRes _res;

  call({
    Fragment$genericBackupConfigReturn? setAutobackupPeriod,
    String? $__typename,
  }) => _res;

  CopyWith$Fragment$genericBackupConfigReturn<TRes> get setAutobackupPeriod =>
      CopyWith$Fragment$genericBackupConfigReturn.stub(_res);
}

class Variables$Mutation$setAutobackupQuotas {
  factory Variables$Mutation$setAutobackupQuotas({
    required Input$AutobackupQuotasInput quotas,
  }) => Variables$Mutation$setAutobackupQuotas._({r'quotas': quotas});

  Variables$Mutation$setAutobackupQuotas._(this._$data);

  factory Variables$Mutation$setAutobackupQuotas.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$quotas = data['quotas'];
    result$data['quotas'] = Input$AutobackupQuotasInput.fromJson(
      (l$quotas as Map<String, dynamic>),
    );
    return Variables$Mutation$setAutobackupQuotas._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$AutobackupQuotasInput get quotas =>
      (_$data['quotas'] as Input$AutobackupQuotasInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$quotas = quotas;
    result$data['quotas'] = l$quotas.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$setAutobackupQuotas<
    Variables$Mutation$setAutobackupQuotas
  >
  get copyWith =>
      CopyWith$Variables$Mutation$setAutobackupQuotas(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$setAutobackupQuotas ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$quotas = quotas;
    final lOther$quotas = other.quotas;
    if (l$quotas != lOther$quotas) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$quotas = quotas;
    return Object.hashAll([l$quotas]);
  }
}

abstract class CopyWith$Variables$Mutation$setAutobackupQuotas<TRes> {
  factory CopyWith$Variables$Mutation$setAutobackupQuotas(
    Variables$Mutation$setAutobackupQuotas instance,
    TRes Function(Variables$Mutation$setAutobackupQuotas) then,
  ) = _CopyWithImpl$Variables$Mutation$setAutobackupQuotas;

  factory CopyWith$Variables$Mutation$setAutobackupQuotas.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$setAutobackupQuotas;

  TRes call({Input$AutobackupQuotasInput? quotas});
}

class _CopyWithImpl$Variables$Mutation$setAutobackupQuotas<TRes>
    implements CopyWith$Variables$Mutation$setAutobackupQuotas<TRes> {
  _CopyWithImpl$Variables$Mutation$setAutobackupQuotas(
    this._instance,
    this._then,
  );

  final Variables$Mutation$setAutobackupQuotas _instance;

  final TRes Function(Variables$Mutation$setAutobackupQuotas) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? quotas = _undefined}) => _then(
    Variables$Mutation$setAutobackupQuotas._({
      ..._instance._$data,
      if (quotas != _undefined && quotas != null)
        'quotas': (quotas as Input$AutobackupQuotasInput),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$setAutobackupQuotas<TRes>
    implements CopyWith$Variables$Mutation$setAutobackupQuotas<TRes> {
  _CopyWithStubImpl$Variables$Mutation$setAutobackupQuotas(this._res);

  TRes _res;

  call({Input$AutobackupQuotasInput? quotas}) => _res;
}

class Mutation$setAutobackupQuotas {
  Mutation$setAutobackupQuotas({
    required this.backup,
    this.$__typename = 'Mutation',
  });

  factory Mutation$setAutobackupQuotas.fromJson(Map<String, dynamic> json) {
    final l$backup = json['backup'];
    final l$$__typename = json['__typename'];
    return Mutation$setAutobackupQuotas(
      backup: Mutation$setAutobackupQuotas$backup.fromJson(
        (l$backup as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$setAutobackupQuotas$backup backup;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$backup = backup;
    _resultData['backup'] = l$backup.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$backup = backup;
    final l$$__typename = $__typename;
    return Object.hashAll([l$backup, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$setAutobackupQuotas ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$backup = backup;
    final lOther$backup = other.backup;
    if (l$backup != lOther$backup) {
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

extension UtilityExtension$Mutation$setAutobackupQuotas
    on Mutation$setAutobackupQuotas {
  CopyWith$Mutation$setAutobackupQuotas<Mutation$setAutobackupQuotas>
  get copyWith => CopyWith$Mutation$setAutobackupQuotas(this, (i) => i);
}

abstract class CopyWith$Mutation$setAutobackupQuotas<TRes> {
  factory CopyWith$Mutation$setAutobackupQuotas(
    Mutation$setAutobackupQuotas instance,
    TRes Function(Mutation$setAutobackupQuotas) then,
  ) = _CopyWithImpl$Mutation$setAutobackupQuotas;

  factory CopyWith$Mutation$setAutobackupQuotas.stub(TRes res) =
      _CopyWithStubImpl$Mutation$setAutobackupQuotas;

  TRes call({Mutation$setAutobackupQuotas$backup? backup, String? $__typename});
  CopyWith$Mutation$setAutobackupQuotas$backup<TRes> get backup;
}

class _CopyWithImpl$Mutation$setAutobackupQuotas<TRes>
    implements CopyWith$Mutation$setAutobackupQuotas<TRes> {
  _CopyWithImpl$Mutation$setAutobackupQuotas(this._instance, this._then);

  final Mutation$setAutobackupQuotas _instance;

  final TRes Function(Mutation$setAutobackupQuotas) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? backup = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$setAutobackupQuotas(
          backup:
              backup == _undefined || backup == null
                  ? _instance.backup
                  : (backup as Mutation$setAutobackupQuotas$backup),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$setAutobackupQuotas$backup<TRes> get backup {
    final local$backup = _instance.backup;
    return CopyWith$Mutation$setAutobackupQuotas$backup(
      local$backup,
      (e) => call(backup: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$setAutobackupQuotas<TRes>
    implements CopyWith$Mutation$setAutobackupQuotas<TRes> {
  _CopyWithStubImpl$Mutation$setAutobackupQuotas(this._res);

  TRes _res;

  call({Mutation$setAutobackupQuotas$backup? backup, String? $__typename}) =>
      _res;

  CopyWith$Mutation$setAutobackupQuotas$backup<TRes> get backup =>
      CopyWith$Mutation$setAutobackupQuotas$backup.stub(_res);
}

const documentNodeMutationsetAutobackupQuotas = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'setAutobackupQuotas'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'quotas')),
          type: NamedTypeNode(
            name: NameNode(value: 'AutobackupQuotasInput'),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'backup'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'setAutobackupQuotas'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'quotas'),
                      value: VariableNode(name: NameNode(value: 'quotas')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'genericBackupConfigReturn'),
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
    fragmentDefinitiongenericBackupConfigReturn,
  ],
);
Mutation$setAutobackupQuotas _parserFn$Mutation$setAutobackupQuotas(
  Map<String, dynamic> data,
) => Mutation$setAutobackupQuotas.fromJson(data);
typedef OnMutationCompleted$Mutation$setAutobackupQuotas =
    FutureOr<void> Function(
      Map<String, dynamic>?,
      Mutation$setAutobackupQuotas?,
    );

class Options$Mutation$setAutobackupQuotas
    extends graphql.MutationOptions<Mutation$setAutobackupQuotas> {
  Options$Mutation$setAutobackupQuotas({
    String? operationName,
    required Variables$Mutation$setAutobackupQuotas variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$setAutobackupQuotas? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$setAutobackupQuotas? onCompleted,
    graphql.OnMutationUpdate<Mutation$setAutobackupQuotas>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
                 ? null
                 : (data) => onCompleted(
                   data,
                   data == null
                       ? null
                       : _parserFn$Mutation$setAutobackupQuotas(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationsetAutobackupQuotas,
         parserFn: _parserFn$Mutation$setAutobackupQuotas,
       );

  final OnMutationCompleted$Mutation$setAutobackupQuotas? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$setAutobackupQuotas
    extends graphql.WatchQueryOptions<Mutation$setAutobackupQuotas> {
  WatchOptions$Mutation$setAutobackupQuotas({
    String? operationName,
    required Variables$Mutation$setAutobackupQuotas variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$setAutobackupQuotas? typedOptimisticResult,
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
         document: documentNodeMutationsetAutobackupQuotas,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$setAutobackupQuotas,
       );
}

extension ClientExtension$Mutation$setAutobackupQuotas
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$setAutobackupQuotas>>
  mutate$setAutobackupQuotas(
    Options$Mutation$setAutobackupQuotas options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$setAutobackupQuotas>
  watchMutation$setAutobackupQuotas(
    WatchOptions$Mutation$setAutobackupQuotas options,
  ) => this.watchMutation(options);
}

class Mutation$setAutobackupQuotas$backup {
  Mutation$setAutobackupQuotas$backup({
    required this.setAutobackupQuotas,
    this.$__typename = 'BackupMutations',
  });

  factory Mutation$setAutobackupQuotas$backup.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$setAutobackupQuotas = json['setAutobackupQuotas'];
    final l$$__typename = json['__typename'];
    return Mutation$setAutobackupQuotas$backup(
      setAutobackupQuotas: Fragment$genericBackupConfigReturn.fromJson(
        (l$setAutobackupQuotas as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$genericBackupConfigReturn setAutobackupQuotas;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$setAutobackupQuotas = setAutobackupQuotas;
    _resultData['setAutobackupQuotas'] = l$setAutobackupQuotas.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$setAutobackupQuotas = setAutobackupQuotas;
    final l$$__typename = $__typename;
    return Object.hashAll([l$setAutobackupQuotas, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$setAutobackupQuotas$backup ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$setAutobackupQuotas = setAutobackupQuotas;
    final lOther$setAutobackupQuotas = other.setAutobackupQuotas;
    if (l$setAutobackupQuotas != lOther$setAutobackupQuotas) {
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

extension UtilityExtension$Mutation$setAutobackupQuotas$backup
    on Mutation$setAutobackupQuotas$backup {
  CopyWith$Mutation$setAutobackupQuotas$backup<
    Mutation$setAutobackupQuotas$backup
  >
  get copyWith => CopyWith$Mutation$setAutobackupQuotas$backup(this, (i) => i);
}

abstract class CopyWith$Mutation$setAutobackupQuotas$backup<TRes> {
  factory CopyWith$Mutation$setAutobackupQuotas$backup(
    Mutation$setAutobackupQuotas$backup instance,
    TRes Function(Mutation$setAutobackupQuotas$backup) then,
  ) = _CopyWithImpl$Mutation$setAutobackupQuotas$backup;

  factory CopyWith$Mutation$setAutobackupQuotas$backup.stub(TRes res) =
      _CopyWithStubImpl$Mutation$setAutobackupQuotas$backup;

  TRes call({
    Fragment$genericBackupConfigReturn? setAutobackupQuotas,
    String? $__typename,
  });
  CopyWith$Fragment$genericBackupConfigReturn<TRes> get setAutobackupQuotas;
}

class _CopyWithImpl$Mutation$setAutobackupQuotas$backup<TRes>
    implements CopyWith$Mutation$setAutobackupQuotas$backup<TRes> {
  _CopyWithImpl$Mutation$setAutobackupQuotas$backup(this._instance, this._then);

  final Mutation$setAutobackupQuotas$backup _instance;

  final TRes Function(Mutation$setAutobackupQuotas$backup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? setAutobackupQuotas = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$setAutobackupQuotas$backup(
      setAutobackupQuotas:
          setAutobackupQuotas == _undefined || setAutobackupQuotas == null
              ? _instance.setAutobackupQuotas
              : (setAutobackupQuotas as Fragment$genericBackupConfigReturn),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Fragment$genericBackupConfigReturn<TRes> get setAutobackupQuotas {
    final local$setAutobackupQuotas = _instance.setAutobackupQuotas;
    return CopyWith$Fragment$genericBackupConfigReturn(
      local$setAutobackupQuotas,
      (e) => call(setAutobackupQuotas: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$setAutobackupQuotas$backup<TRes>
    implements CopyWith$Mutation$setAutobackupQuotas$backup<TRes> {
  _CopyWithStubImpl$Mutation$setAutobackupQuotas$backup(this._res);

  TRes _res;

  call({
    Fragment$genericBackupConfigReturn? setAutobackupQuotas,
    String? $__typename,
  }) => _res;

  CopyWith$Fragment$genericBackupConfigReturn<TRes> get setAutobackupQuotas =>
      CopyWith$Fragment$genericBackupConfigReturn.stub(_res);
}

class Mutation$RemoveRepository {
  Mutation$RemoveRepository({
    required this.backup,
    this.$__typename = 'Mutation',
  });

  factory Mutation$RemoveRepository.fromJson(Map<String, dynamic> json) {
    final l$backup = json['backup'];
    final l$$__typename = json['__typename'];
    return Mutation$RemoveRepository(
      backup: Mutation$RemoveRepository$backup.fromJson(
        (l$backup as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$RemoveRepository$backup backup;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$backup = backup;
    _resultData['backup'] = l$backup.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$backup = backup;
    final l$$__typename = $__typename;
    return Object.hashAll([l$backup, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$RemoveRepository ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$backup = backup;
    final lOther$backup = other.backup;
    if (l$backup != lOther$backup) {
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

extension UtilityExtension$Mutation$RemoveRepository
    on Mutation$RemoveRepository {
  CopyWith$Mutation$RemoveRepository<Mutation$RemoveRepository> get copyWith =>
      CopyWith$Mutation$RemoveRepository(this, (i) => i);
}

abstract class CopyWith$Mutation$RemoveRepository<TRes> {
  factory CopyWith$Mutation$RemoveRepository(
    Mutation$RemoveRepository instance,
    TRes Function(Mutation$RemoveRepository) then,
  ) = _CopyWithImpl$Mutation$RemoveRepository;

  factory CopyWith$Mutation$RemoveRepository.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RemoveRepository;

  TRes call({Mutation$RemoveRepository$backup? backup, String? $__typename});
  CopyWith$Mutation$RemoveRepository$backup<TRes> get backup;
}

class _CopyWithImpl$Mutation$RemoveRepository<TRes>
    implements CopyWith$Mutation$RemoveRepository<TRes> {
  _CopyWithImpl$Mutation$RemoveRepository(this._instance, this._then);

  final Mutation$RemoveRepository _instance;

  final TRes Function(Mutation$RemoveRepository) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? backup = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$RemoveRepository(
          backup:
              backup == _undefined || backup == null
                  ? _instance.backup
                  : (backup as Mutation$RemoveRepository$backup),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$RemoveRepository$backup<TRes> get backup {
    final local$backup = _instance.backup;
    return CopyWith$Mutation$RemoveRepository$backup(
      local$backup,
      (e) => call(backup: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$RemoveRepository<TRes>
    implements CopyWith$Mutation$RemoveRepository<TRes> {
  _CopyWithStubImpl$Mutation$RemoveRepository(this._res);

  TRes _res;

  call({Mutation$RemoveRepository$backup? backup, String? $__typename}) => _res;

  CopyWith$Mutation$RemoveRepository$backup<TRes> get backup =>
      CopyWith$Mutation$RemoveRepository$backup.stub(_res);
}

const documentNodeMutationRemoveRepository = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RemoveRepository'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'backup'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'removeRepository'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'genericBackupConfigReturn'),
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
    fragmentDefinitiongenericBackupConfigReturn,
  ],
);
Mutation$RemoveRepository _parserFn$Mutation$RemoveRepository(
  Map<String, dynamic> data,
) => Mutation$RemoveRepository.fromJson(data);
typedef OnMutationCompleted$Mutation$RemoveRepository =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$RemoveRepository?);

class Options$Mutation$RemoveRepository
    extends graphql.MutationOptions<Mutation$RemoveRepository> {
  Options$Mutation$RemoveRepository({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RemoveRepository? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$RemoveRepository? onCompleted,
    graphql.OnMutationUpdate<Mutation$RemoveRepository>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
                 ? null
                 : (data) => onCompleted(
                   data,
                   data == null
                       ? null
                       : _parserFn$Mutation$RemoveRepository(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationRemoveRepository,
         parserFn: _parserFn$Mutation$RemoveRepository,
       );

  final OnMutationCompleted$Mutation$RemoveRepository? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$RemoveRepository
    extends graphql.WatchQueryOptions<Mutation$RemoveRepository> {
  WatchOptions$Mutation$RemoveRepository({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RemoveRepository? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationRemoveRepository,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$RemoveRepository,
       );
}

extension ClientExtension$Mutation$RemoveRepository on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RemoveRepository>>
  mutate$RemoveRepository([Options$Mutation$RemoveRepository? options]) async =>
      await this.mutate(options ?? Options$Mutation$RemoveRepository());
  graphql.ObservableQuery<Mutation$RemoveRepository>
  watchMutation$RemoveRepository([
    WatchOptions$Mutation$RemoveRepository? options,
  ]) => this.watchMutation(options ?? WatchOptions$Mutation$RemoveRepository());
}

class Mutation$RemoveRepository$backup {
  Mutation$RemoveRepository$backup({
    required this.removeRepository,
    this.$__typename = 'BackupMutations',
  });

  factory Mutation$RemoveRepository$backup.fromJson(Map<String, dynamic> json) {
    final l$removeRepository = json['removeRepository'];
    final l$$__typename = json['__typename'];
    return Mutation$RemoveRepository$backup(
      removeRepository: Fragment$genericBackupConfigReturn.fromJson(
        (l$removeRepository as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$genericBackupConfigReturn removeRepository;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$removeRepository = removeRepository;
    _resultData['removeRepository'] = l$removeRepository.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$removeRepository = removeRepository;
    final l$$__typename = $__typename;
    return Object.hashAll([l$removeRepository, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$RemoveRepository$backup ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$removeRepository = removeRepository;
    final lOther$removeRepository = other.removeRepository;
    if (l$removeRepository != lOther$removeRepository) {
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

extension UtilityExtension$Mutation$RemoveRepository$backup
    on Mutation$RemoveRepository$backup {
  CopyWith$Mutation$RemoveRepository$backup<Mutation$RemoveRepository$backup>
  get copyWith => CopyWith$Mutation$RemoveRepository$backup(this, (i) => i);
}

abstract class CopyWith$Mutation$RemoveRepository$backup<TRes> {
  factory CopyWith$Mutation$RemoveRepository$backup(
    Mutation$RemoveRepository$backup instance,
    TRes Function(Mutation$RemoveRepository$backup) then,
  ) = _CopyWithImpl$Mutation$RemoveRepository$backup;

  factory CopyWith$Mutation$RemoveRepository$backup.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RemoveRepository$backup;

  TRes call({
    Fragment$genericBackupConfigReturn? removeRepository,
    String? $__typename,
  });
  CopyWith$Fragment$genericBackupConfigReturn<TRes> get removeRepository;
}

class _CopyWithImpl$Mutation$RemoveRepository$backup<TRes>
    implements CopyWith$Mutation$RemoveRepository$backup<TRes> {
  _CopyWithImpl$Mutation$RemoveRepository$backup(this._instance, this._then);

  final Mutation$RemoveRepository$backup _instance;

  final TRes Function(Mutation$RemoveRepository$backup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? removeRepository = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$RemoveRepository$backup(
      removeRepository:
          removeRepository == _undefined || removeRepository == null
              ? _instance.removeRepository
              : (removeRepository as Fragment$genericBackupConfigReturn),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Fragment$genericBackupConfigReturn<TRes> get removeRepository {
    final local$removeRepository = _instance.removeRepository;
    return CopyWith$Fragment$genericBackupConfigReturn(
      local$removeRepository,
      (e) => call(removeRepository: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$RemoveRepository$backup<TRes>
    implements CopyWith$Mutation$RemoveRepository$backup<TRes> {
  _CopyWithStubImpl$Mutation$RemoveRepository$backup(this._res);

  TRes _res;

  call({
    Fragment$genericBackupConfigReturn? removeRepository,
    String? $__typename,
  }) => _res;

  CopyWith$Fragment$genericBackupConfigReturn<TRes> get removeRepository =>
      CopyWith$Fragment$genericBackupConfigReturn.stub(_res);
}

class Variables$Mutation$InitializeRepository {
  factory Variables$Mutation$InitializeRepository({
    required Input$InitializeRepositoryInput repository,
  }) => Variables$Mutation$InitializeRepository._({r'repository': repository});

  Variables$Mutation$InitializeRepository._(this._$data);

  factory Variables$Mutation$InitializeRepository.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$repository = data['repository'];
    result$data['repository'] = Input$InitializeRepositoryInput.fromJson(
      (l$repository as Map<String, dynamic>),
    );
    return Variables$Mutation$InitializeRepository._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$InitializeRepositoryInput get repository =>
      (_$data['repository'] as Input$InitializeRepositoryInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$repository = repository;
    result$data['repository'] = l$repository.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$InitializeRepository<
    Variables$Mutation$InitializeRepository
  >
  get copyWith =>
      CopyWith$Variables$Mutation$InitializeRepository(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$InitializeRepository ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$repository = repository;
    final lOther$repository = other.repository;
    if (l$repository != lOther$repository) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$repository = repository;
    return Object.hashAll([l$repository]);
  }
}

abstract class CopyWith$Variables$Mutation$InitializeRepository<TRes> {
  factory CopyWith$Variables$Mutation$InitializeRepository(
    Variables$Mutation$InitializeRepository instance,
    TRes Function(Variables$Mutation$InitializeRepository) then,
  ) = _CopyWithImpl$Variables$Mutation$InitializeRepository;

  factory CopyWith$Variables$Mutation$InitializeRepository.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$InitializeRepository;

  TRes call({Input$InitializeRepositoryInput? repository});
}

class _CopyWithImpl$Variables$Mutation$InitializeRepository<TRes>
    implements CopyWith$Variables$Mutation$InitializeRepository<TRes> {
  _CopyWithImpl$Variables$Mutation$InitializeRepository(
    this._instance,
    this._then,
  );

  final Variables$Mutation$InitializeRepository _instance;

  final TRes Function(Variables$Mutation$InitializeRepository) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? repository = _undefined}) => _then(
    Variables$Mutation$InitializeRepository._({
      ..._instance._$data,
      if (repository != _undefined && repository != null)
        'repository': (repository as Input$InitializeRepositoryInput),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$InitializeRepository<TRes>
    implements CopyWith$Variables$Mutation$InitializeRepository<TRes> {
  _CopyWithStubImpl$Variables$Mutation$InitializeRepository(this._res);

  TRes _res;

  call({Input$InitializeRepositoryInput? repository}) => _res;
}

class Mutation$InitializeRepository {
  Mutation$InitializeRepository({
    required this.backup,
    this.$__typename = 'Mutation',
  });

  factory Mutation$InitializeRepository.fromJson(Map<String, dynamic> json) {
    final l$backup = json['backup'];
    final l$$__typename = json['__typename'];
    return Mutation$InitializeRepository(
      backup: Mutation$InitializeRepository$backup.fromJson(
        (l$backup as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$InitializeRepository$backup backup;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$backup = backup;
    _resultData['backup'] = l$backup.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$backup = backup;
    final l$$__typename = $__typename;
    return Object.hashAll([l$backup, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$InitializeRepository ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$backup = backup;
    final lOther$backup = other.backup;
    if (l$backup != lOther$backup) {
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

extension UtilityExtension$Mutation$InitializeRepository
    on Mutation$InitializeRepository {
  CopyWith$Mutation$InitializeRepository<Mutation$InitializeRepository>
  get copyWith => CopyWith$Mutation$InitializeRepository(this, (i) => i);
}

abstract class CopyWith$Mutation$InitializeRepository<TRes> {
  factory CopyWith$Mutation$InitializeRepository(
    Mutation$InitializeRepository instance,
    TRes Function(Mutation$InitializeRepository) then,
  ) = _CopyWithImpl$Mutation$InitializeRepository;

  factory CopyWith$Mutation$InitializeRepository.stub(TRes res) =
      _CopyWithStubImpl$Mutation$InitializeRepository;

  TRes call({
    Mutation$InitializeRepository$backup? backup,
    String? $__typename,
  });
  CopyWith$Mutation$InitializeRepository$backup<TRes> get backup;
}

class _CopyWithImpl$Mutation$InitializeRepository<TRes>
    implements CopyWith$Mutation$InitializeRepository<TRes> {
  _CopyWithImpl$Mutation$InitializeRepository(this._instance, this._then);

  final Mutation$InitializeRepository _instance;

  final TRes Function(Mutation$InitializeRepository) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? backup = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$InitializeRepository(
          backup:
              backup == _undefined || backup == null
                  ? _instance.backup
                  : (backup as Mutation$InitializeRepository$backup),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$InitializeRepository$backup<TRes> get backup {
    final local$backup = _instance.backup;
    return CopyWith$Mutation$InitializeRepository$backup(
      local$backup,
      (e) => call(backup: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$InitializeRepository<TRes>
    implements CopyWith$Mutation$InitializeRepository<TRes> {
  _CopyWithStubImpl$Mutation$InitializeRepository(this._res);

  TRes _res;

  call({Mutation$InitializeRepository$backup? backup, String? $__typename}) =>
      _res;

  CopyWith$Mutation$InitializeRepository$backup<TRes> get backup =>
      CopyWith$Mutation$InitializeRepository$backup.stub(_res);
}

const documentNodeMutationInitializeRepository = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'InitializeRepository'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'repository')),
          type: NamedTypeNode(
            name: NameNode(value: 'InitializeRepositoryInput'),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'backup'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'initializeRepository'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'repository'),
                      value: VariableNode(name: NameNode(value: 'repository')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'genericBackupConfigReturn'),
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
    fragmentDefinitiongenericBackupConfigReturn,
  ],
);
Mutation$InitializeRepository _parserFn$Mutation$InitializeRepository(
  Map<String, dynamic> data,
) => Mutation$InitializeRepository.fromJson(data);
typedef OnMutationCompleted$Mutation$InitializeRepository =
    FutureOr<void> Function(
      Map<String, dynamic>?,
      Mutation$InitializeRepository?,
    );

class Options$Mutation$InitializeRepository
    extends graphql.MutationOptions<Mutation$InitializeRepository> {
  Options$Mutation$InitializeRepository({
    String? operationName,
    required Variables$Mutation$InitializeRepository variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$InitializeRepository? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$InitializeRepository? onCompleted,
    graphql.OnMutationUpdate<Mutation$InitializeRepository>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
                 ? null
                 : (data) => onCompleted(
                   data,
                   data == null
                       ? null
                       : _parserFn$Mutation$InitializeRepository(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationInitializeRepository,
         parserFn: _parserFn$Mutation$InitializeRepository,
       );

  final OnMutationCompleted$Mutation$InitializeRepository?
  onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$InitializeRepository
    extends graphql.WatchQueryOptions<Mutation$InitializeRepository> {
  WatchOptions$Mutation$InitializeRepository({
    String? operationName,
    required Variables$Mutation$InitializeRepository variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$InitializeRepository? typedOptimisticResult,
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
         document: documentNodeMutationInitializeRepository,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$InitializeRepository,
       );
}

extension ClientExtension$Mutation$InitializeRepository
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$InitializeRepository>>
  mutate$InitializeRepository(
    Options$Mutation$InitializeRepository options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$InitializeRepository>
  watchMutation$InitializeRepository(
    WatchOptions$Mutation$InitializeRepository options,
  ) => this.watchMutation(options);
}

class Mutation$InitializeRepository$backup {
  Mutation$InitializeRepository$backup({
    required this.initializeRepository,
    this.$__typename = 'BackupMutations',
  });

  factory Mutation$InitializeRepository$backup.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$initializeRepository = json['initializeRepository'];
    final l$$__typename = json['__typename'];
    return Mutation$InitializeRepository$backup(
      initializeRepository: Fragment$genericBackupConfigReturn.fromJson(
        (l$initializeRepository as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$genericBackupConfigReturn initializeRepository;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$initializeRepository = initializeRepository;
    _resultData['initializeRepository'] = l$initializeRepository.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$initializeRepository = initializeRepository;
    final l$$__typename = $__typename;
    return Object.hashAll([l$initializeRepository, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$InitializeRepository$backup ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$initializeRepository = initializeRepository;
    final lOther$initializeRepository = other.initializeRepository;
    if (l$initializeRepository != lOther$initializeRepository) {
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

extension UtilityExtension$Mutation$InitializeRepository$backup
    on Mutation$InitializeRepository$backup {
  CopyWith$Mutation$InitializeRepository$backup<
    Mutation$InitializeRepository$backup
  >
  get copyWith => CopyWith$Mutation$InitializeRepository$backup(this, (i) => i);
}

abstract class CopyWith$Mutation$InitializeRepository$backup<TRes> {
  factory CopyWith$Mutation$InitializeRepository$backup(
    Mutation$InitializeRepository$backup instance,
    TRes Function(Mutation$InitializeRepository$backup) then,
  ) = _CopyWithImpl$Mutation$InitializeRepository$backup;

  factory CopyWith$Mutation$InitializeRepository$backup.stub(TRes res) =
      _CopyWithStubImpl$Mutation$InitializeRepository$backup;

  TRes call({
    Fragment$genericBackupConfigReturn? initializeRepository,
    String? $__typename,
  });
  CopyWith$Fragment$genericBackupConfigReturn<TRes> get initializeRepository;
}

class _CopyWithImpl$Mutation$InitializeRepository$backup<TRes>
    implements CopyWith$Mutation$InitializeRepository$backup<TRes> {
  _CopyWithImpl$Mutation$InitializeRepository$backup(
    this._instance,
    this._then,
  );

  final Mutation$InitializeRepository$backup _instance;

  final TRes Function(Mutation$InitializeRepository$backup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? initializeRepository = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$InitializeRepository$backup(
      initializeRepository:
          initializeRepository == _undefined || initializeRepository == null
              ? _instance.initializeRepository
              : (initializeRepository as Fragment$genericBackupConfigReturn),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Fragment$genericBackupConfigReturn<TRes> get initializeRepository {
    final local$initializeRepository = _instance.initializeRepository;
    return CopyWith$Fragment$genericBackupConfigReturn(
      local$initializeRepository,
      (e) => call(initializeRepository: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$InitializeRepository$backup<TRes>
    implements CopyWith$Mutation$InitializeRepository$backup<TRes> {
  _CopyWithStubImpl$Mutation$InitializeRepository$backup(this._res);

  TRes _res;

  call({
    Fragment$genericBackupConfigReturn? initializeRepository,
    String? $__typename,
  }) => _res;

  CopyWith$Fragment$genericBackupConfigReturn<TRes> get initializeRepository =>
      CopyWith$Fragment$genericBackupConfigReturn.stub(_res);
}

class Variables$Mutation$RestoreBackup {
  factory Variables$Mutation$RestoreBackup({
    required String snapshotId,
    Enum$RestoreStrategy? strategy,
  }) => Variables$Mutation$RestoreBackup._({
    r'snapshotId': snapshotId,
    if (strategy != null) r'strategy': strategy,
  });

  Variables$Mutation$RestoreBackup._(this._$data);

  factory Variables$Mutation$RestoreBackup.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$snapshotId = data['snapshotId'];
    result$data['snapshotId'] = (l$snapshotId as String);
    if (data.containsKey('strategy')) {
      final l$strategy = data['strategy'];
      result$data['strategy'] = fromJson$Enum$RestoreStrategy(
        (l$strategy as String),
      );
    }
    return Variables$Mutation$RestoreBackup._(result$data);
  }

  Map<String, dynamic> _$data;

  String get snapshotId => (_$data['snapshotId'] as String);

  Enum$RestoreStrategy? get strategy =>
      (_$data['strategy'] as Enum$RestoreStrategy?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$snapshotId = snapshotId;
    result$data['snapshotId'] = l$snapshotId;
    if (_$data.containsKey('strategy')) {
      final l$strategy = strategy;
      result$data['strategy'] = toJson$Enum$RestoreStrategy(
        (l$strategy as Enum$RestoreStrategy),
      );
    }
    return result$data;
  }

  CopyWith$Variables$Mutation$RestoreBackup<Variables$Mutation$RestoreBackup>
  get copyWith => CopyWith$Variables$Mutation$RestoreBackup(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$RestoreBackup ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$snapshotId = snapshotId;
    final lOther$snapshotId = other.snapshotId;
    if (l$snapshotId != lOther$snapshotId) {
      return false;
    }
    final l$strategy = strategy;
    final lOther$strategy = other.strategy;
    if (_$data.containsKey('strategy') !=
        other._$data.containsKey('strategy')) {
      return false;
    }
    if (l$strategy != lOther$strategy) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$snapshotId = snapshotId;
    final l$strategy = strategy;
    return Object.hashAll([
      l$snapshotId,
      _$data.containsKey('strategy') ? l$strategy : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$RestoreBackup<TRes> {
  factory CopyWith$Variables$Mutation$RestoreBackup(
    Variables$Mutation$RestoreBackup instance,
    TRes Function(Variables$Mutation$RestoreBackup) then,
  ) = _CopyWithImpl$Variables$Mutation$RestoreBackup;

  factory CopyWith$Variables$Mutation$RestoreBackup.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$RestoreBackup;

  TRes call({String? snapshotId, Enum$RestoreStrategy? strategy});
}

class _CopyWithImpl$Variables$Mutation$RestoreBackup<TRes>
    implements CopyWith$Variables$Mutation$RestoreBackup<TRes> {
  _CopyWithImpl$Variables$Mutation$RestoreBackup(this._instance, this._then);

  final Variables$Mutation$RestoreBackup _instance;

  final TRes Function(Variables$Mutation$RestoreBackup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? snapshotId = _undefined, Object? strategy = _undefined}) =>
      _then(
        Variables$Mutation$RestoreBackup._({
          ..._instance._$data,
          if (snapshotId != _undefined && snapshotId != null)
            'snapshotId': (snapshotId as String),
          if (strategy != _undefined && strategy != null)
            'strategy': (strategy as Enum$RestoreStrategy),
        }),
      );
}

class _CopyWithStubImpl$Variables$Mutation$RestoreBackup<TRes>
    implements CopyWith$Variables$Mutation$RestoreBackup<TRes> {
  _CopyWithStubImpl$Variables$Mutation$RestoreBackup(this._res);

  TRes _res;

  call({String? snapshotId, Enum$RestoreStrategy? strategy}) => _res;
}

class Mutation$RestoreBackup {
  Mutation$RestoreBackup({required this.backup, this.$__typename = 'Mutation'});

  factory Mutation$RestoreBackup.fromJson(Map<String, dynamic> json) {
    final l$backup = json['backup'];
    final l$$__typename = json['__typename'];
    return Mutation$RestoreBackup(
      backup: Mutation$RestoreBackup$backup.fromJson(
        (l$backup as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$RestoreBackup$backup backup;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$backup = backup;
    _resultData['backup'] = l$backup.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$backup = backup;
    final l$$__typename = $__typename;
    return Object.hashAll([l$backup, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$RestoreBackup || runtimeType != other.runtimeType) {
      return false;
    }
    final l$backup = backup;
    final lOther$backup = other.backup;
    if (l$backup != lOther$backup) {
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

extension UtilityExtension$Mutation$RestoreBackup on Mutation$RestoreBackup {
  CopyWith$Mutation$RestoreBackup<Mutation$RestoreBackup> get copyWith =>
      CopyWith$Mutation$RestoreBackup(this, (i) => i);
}

abstract class CopyWith$Mutation$RestoreBackup<TRes> {
  factory CopyWith$Mutation$RestoreBackup(
    Mutation$RestoreBackup instance,
    TRes Function(Mutation$RestoreBackup) then,
  ) = _CopyWithImpl$Mutation$RestoreBackup;

  factory CopyWith$Mutation$RestoreBackup.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RestoreBackup;

  TRes call({Mutation$RestoreBackup$backup? backup, String? $__typename});
  CopyWith$Mutation$RestoreBackup$backup<TRes> get backup;
}

class _CopyWithImpl$Mutation$RestoreBackup<TRes>
    implements CopyWith$Mutation$RestoreBackup<TRes> {
  _CopyWithImpl$Mutation$RestoreBackup(this._instance, this._then);

  final Mutation$RestoreBackup _instance;

  final TRes Function(Mutation$RestoreBackup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? backup = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$RestoreBackup(
          backup:
              backup == _undefined || backup == null
                  ? _instance.backup
                  : (backup as Mutation$RestoreBackup$backup),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$RestoreBackup$backup<TRes> get backup {
    final local$backup = _instance.backup;
    return CopyWith$Mutation$RestoreBackup$backup(
      local$backup,
      (e) => call(backup: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$RestoreBackup<TRes>
    implements CopyWith$Mutation$RestoreBackup<TRes> {
  _CopyWithStubImpl$Mutation$RestoreBackup(this._res);

  TRes _res;

  call({Mutation$RestoreBackup$backup? backup, String? $__typename}) => _res;

  CopyWith$Mutation$RestoreBackup$backup<TRes> get backup =>
      CopyWith$Mutation$RestoreBackup$backup.stub(_res);
}

const documentNodeMutationRestoreBackup = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RestoreBackup'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'snapshotId')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'strategy')),
          type: NamedTypeNode(
            name: NameNode(value: 'RestoreStrategy'),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(
            value: EnumValueNode(
              name: NameNode(value: 'DOWNLOAD_VERIFY_OVERWRITE'),
            ),
          ),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'backup'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'restoreBackup'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'snapshotId'),
                      value: VariableNode(name: NameNode(value: 'snapshotId')),
                    ),
                    ArgumentNode(
                      name: NameNode(value: 'strategy'),
                      value: VariableNode(name: NameNode(value: 'strategy')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'basicMutationReturnFields'),
                        directives: [],
                      ),
                      FieldNode(
                        name: NameNode(value: 'job'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FragmentSpreadNode(
                              name: NameNode(value: 'basicApiJobsFields'),
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
    fragmentDefinitionbasicMutationReturnFields,
    fragmentDefinitionbasicApiJobsFields,
  ],
);
Mutation$RestoreBackup _parserFn$Mutation$RestoreBackup(
  Map<String, dynamic> data,
) => Mutation$RestoreBackup.fromJson(data);
typedef OnMutationCompleted$Mutation$RestoreBackup =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$RestoreBackup?);

class Options$Mutation$RestoreBackup
    extends graphql.MutationOptions<Mutation$RestoreBackup> {
  Options$Mutation$RestoreBackup({
    String? operationName,
    required Variables$Mutation$RestoreBackup variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RestoreBackup? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$RestoreBackup? onCompleted,
    graphql.OnMutationUpdate<Mutation$RestoreBackup>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
                 ? null
                 : (data) => onCompleted(
                   data,
                   data == null ? null : _parserFn$Mutation$RestoreBackup(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationRestoreBackup,
         parserFn: _parserFn$Mutation$RestoreBackup,
       );

  final OnMutationCompleted$Mutation$RestoreBackup? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$RestoreBackup
    extends graphql.WatchQueryOptions<Mutation$RestoreBackup> {
  WatchOptions$Mutation$RestoreBackup({
    String? operationName,
    required Variables$Mutation$RestoreBackup variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RestoreBackup? typedOptimisticResult,
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
         document: documentNodeMutationRestoreBackup,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$RestoreBackup,
       );
}

extension ClientExtension$Mutation$RestoreBackup on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RestoreBackup>> mutate$RestoreBackup(
    Options$Mutation$RestoreBackup options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$RestoreBackup> watchMutation$RestoreBackup(
    WatchOptions$Mutation$RestoreBackup options,
  ) => this.watchMutation(options);
}

class Mutation$RestoreBackup$backup {
  Mutation$RestoreBackup$backup({
    required this.restoreBackup,
    this.$__typename = 'BackupMutations',
  });

  factory Mutation$RestoreBackup$backup.fromJson(Map<String, dynamic> json) {
    final l$restoreBackup = json['restoreBackup'];
    final l$$__typename = json['__typename'];
    return Mutation$RestoreBackup$backup(
      restoreBackup: Mutation$RestoreBackup$backup$restoreBackup.fromJson(
        (l$restoreBackup as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$RestoreBackup$backup$restoreBackup restoreBackup;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$restoreBackup = restoreBackup;
    _resultData['restoreBackup'] = l$restoreBackup.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$restoreBackup = restoreBackup;
    final l$$__typename = $__typename;
    return Object.hashAll([l$restoreBackup, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$RestoreBackup$backup ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$restoreBackup = restoreBackup;
    final lOther$restoreBackup = other.restoreBackup;
    if (l$restoreBackup != lOther$restoreBackup) {
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

extension UtilityExtension$Mutation$RestoreBackup$backup
    on Mutation$RestoreBackup$backup {
  CopyWith$Mutation$RestoreBackup$backup<Mutation$RestoreBackup$backup>
  get copyWith => CopyWith$Mutation$RestoreBackup$backup(this, (i) => i);
}

abstract class CopyWith$Mutation$RestoreBackup$backup<TRes> {
  factory CopyWith$Mutation$RestoreBackup$backup(
    Mutation$RestoreBackup$backup instance,
    TRes Function(Mutation$RestoreBackup$backup) then,
  ) = _CopyWithImpl$Mutation$RestoreBackup$backup;

  factory CopyWith$Mutation$RestoreBackup$backup.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RestoreBackup$backup;

  TRes call({
    Mutation$RestoreBackup$backup$restoreBackup? restoreBackup,
    String? $__typename,
  });
  CopyWith$Mutation$RestoreBackup$backup$restoreBackup<TRes> get restoreBackup;
}

class _CopyWithImpl$Mutation$RestoreBackup$backup<TRes>
    implements CopyWith$Mutation$RestoreBackup$backup<TRes> {
  _CopyWithImpl$Mutation$RestoreBackup$backup(this._instance, this._then);

  final Mutation$RestoreBackup$backup _instance;

  final TRes Function(Mutation$RestoreBackup$backup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? restoreBackup = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$RestoreBackup$backup(
      restoreBackup:
          restoreBackup == _undefined || restoreBackup == null
              ? _instance.restoreBackup
              : (restoreBackup as Mutation$RestoreBackup$backup$restoreBackup),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$RestoreBackup$backup$restoreBackup<TRes> get restoreBackup {
    final local$restoreBackup = _instance.restoreBackup;
    return CopyWith$Mutation$RestoreBackup$backup$restoreBackup(
      local$restoreBackup,
      (e) => call(restoreBackup: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$RestoreBackup$backup<TRes>
    implements CopyWith$Mutation$RestoreBackup$backup<TRes> {
  _CopyWithStubImpl$Mutation$RestoreBackup$backup(this._res);

  TRes _res;

  call({
    Mutation$RestoreBackup$backup$restoreBackup? restoreBackup,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$RestoreBackup$backup$restoreBackup<TRes>
  get restoreBackup =>
      CopyWith$Mutation$RestoreBackup$backup$restoreBackup.stub(_res);
}

class Mutation$RestoreBackup$backup$restoreBackup
    implements Fragment$basicMutationReturnFields$$GenericJobMutationReturn {
  Mutation$RestoreBackup$backup$restoreBackup({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericJobMutationReturn',
    this.job,
  });

  factory Mutation$RestoreBackup$backup$restoreBackup.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$job = json['job'];
    return Mutation$RestoreBackup$backup$restoreBackup(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      job:
          l$job == null
              ? null
              : Fragment$basicApiJobsFields.fromJson(
                (l$job as Map<String, dynamic>),
              ),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final Fragment$basicApiJobsFields? job;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    final l$job = job;
    _resultData['job'] = l$job?.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$job = job;
    return Object.hashAll([l$code, l$message, l$success, l$$__typename, l$job]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$RestoreBackup$backup$restoreBackup ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    final l$job = job;
    final lOther$job = other.job;
    if (l$job != lOther$job) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$RestoreBackup$backup$restoreBackup
    on Mutation$RestoreBackup$backup$restoreBackup {
  CopyWith$Mutation$RestoreBackup$backup$restoreBackup<
    Mutation$RestoreBackup$backup$restoreBackup
  >
  get copyWith =>
      CopyWith$Mutation$RestoreBackup$backup$restoreBackup(this, (i) => i);
}

abstract class CopyWith$Mutation$RestoreBackup$backup$restoreBackup<TRes> {
  factory CopyWith$Mutation$RestoreBackup$backup$restoreBackup(
    Mutation$RestoreBackup$backup$restoreBackup instance,
    TRes Function(Mutation$RestoreBackup$backup$restoreBackup) then,
  ) = _CopyWithImpl$Mutation$RestoreBackup$backup$restoreBackup;

  factory CopyWith$Mutation$RestoreBackup$backup$restoreBackup.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RestoreBackup$backup$restoreBackup;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$basicApiJobsFields? job,
  });
  CopyWith$Fragment$basicApiJobsFields<TRes> get job;
}

class _CopyWithImpl$Mutation$RestoreBackup$backup$restoreBackup<TRes>
    implements CopyWith$Mutation$RestoreBackup$backup$restoreBackup<TRes> {
  _CopyWithImpl$Mutation$RestoreBackup$backup$restoreBackup(
    this._instance,
    this._then,
  );

  final Mutation$RestoreBackup$backup$restoreBackup _instance;

  final TRes Function(Mutation$RestoreBackup$backup$restoreBackup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? job = _undefined,
  }) => _then(
    Mutation$RestoreBackup$backup$restoreBackup(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
      job:
          job == _undefined
              ? _instance.job
              : (job as Fragment$basicApiJobsFields?),
    ),
  );

  CopyWith$Fragment$basicApiJobsFields<TRes> get job {
    final local$job = _instance.job;
    return local$job == null
        ? CopyWith$Fragment$basicApiJobsFields.stub(_then(_instance))
        : CopyWith$Fragment$basicApiJobsFields(local$job, (e) => call(job: e));
  }
}

class _CopyWithStubImpl$Mutation$RestoreBackup$backup$restoreBackup<TRes>
    implements CopyWith$Mutation$RestoreBackup$backup$restoreBackup<TRes> {
  _CopyWithStubImpl$Mutation$RestoreBackup$backup$restoreBackup(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$basicApiJobsFields? job,
  }) => _res;

  CopyWith$Fragment$basicApiJobsFields<TRes> get job =>
      CopyWith$Fragment$basicApiJobsFields.stub(_res);
}

class Variables$Mutation$ForgetSnapshot {
  factory Variables$Mutation$ForgetSnapshot({required String snapshotId}) =>
      Variables$Mutation$ForgetSnapshot._({r'snapshotId': snapshotId});

  Variables$Mutation$ForgetSnapshot._(this._$data);

  factory Variables$Mutation$ForgetSnapshot.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$snapshotId = data['snapshotId'];
    result$data['snapshotId'] = (l$snapshotId as String);
    return Variables$Mutation$ForgetSnapshot._(result$data);
  }

  Map<String, dynamic> _$data;

  String get snapshotId => (_$data['snapshotId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$snapshotId = snapshotId;
    result$data['snapshotId'] = l$snapshotId;
    return result$data;
  }

  CopyWith$Variables$Mutation$ForgetSnapshot<Variables$Mutation$ForgetSnapshot>
  get copyWith => CopyWith$Variables$Mutation$ForgetSnapshot(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$ForgetSnapshot ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$snapshotId = snapshotId;
    final lOther$snapshotId = other.snapshotId;
    if (l$snapshotId != lOther$snapshotId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$snapshotId = snapshotId;
    return Object.hashAll([l$snapshotId]);
  }
}

abstract class CopyWith$Variables$Mutation$ForgetSnapshot<TRes> {
  factory CopyWith$Variables$Mutation$ForgetSnapshot(
    Variables$Mutation$ForgetSnapshot instance,
    TRes Function(Variables$Mutation$ForgetSnapshot) then,
  ) = _CopyWithImpl$Variables$Mutation$ForgetSnapshot;

  factory CopyWith$Variables$Mutation$ForgetSnapshot.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ForgetSnapshot;

  TRes call({String? snapshotId});
}

class _CopyWithImpl$Variables$Mutation$ForgetSnapshot<TRes>
    implements CopyWith$Variables$Mutation$ForgetSnapshot<TRes> {
  _CopyWithImpl$Variables$Mutation$ForgetSnapshot(this._instance, this._then);

  final Variables$Mutation$ForgetSnapshot _instance;

  final TRes Function(Variables$Mutation$ForgetSnapshot) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? snapshotId = _undefined}) => _then(
    Variables$Mutation$ForgetSnapshot._({
      ..._instance._$data,
      if (snapshotId != _undefined && snapshotId != null)
        'snapshotId': (snapshotId as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$ForgetSnapshot<TRes>
    implements CopyWith$Variables$Mutation$ForgetSnapshot<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ForgetSnapshot(this._res);

  TRes _res;

  call({String? snapshotId}) => _res;
}

class Mutation$ForgetSnapshot {
  Mutation$ForgetSnapshot({
    required this.backup,
    this.$__typename = 'Mutation',
  });

  factory Mutation$ForgetSnapshot.fromJson(Map<String, dynamic> json) {
    final l$backup = json['backup'];
    final l$$__typename = json['__typename'];
    return Mutation$ForgetSnapshot(
      backup: Mutation$ForgetSnapshot$backup.fromJson(
        (l$backup as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$ForgetSnapshot$backup backup;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$backup = backup;
    _resultData['backup'] = l$backup.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$backup = backup;
    final l$$__typename = $__typename;
    return Object.hashAll([l$backup, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ForgetSnapshot || runtimeType != other.runtimeType) {
      return false;
    }
    final l$backup = backup;
    final lOther$backup = other.backup;
    if (l$backup != lOther$backup) {
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

extension UtilityExtension$Mutation$ForgetSnapshot on Mutation$ForgetSnapshot {
  CopyWith$Mutation$ForgetSnapshot<Mutation$ForgetSnapshot> get copyWith =>
      CopyWith$Mutation$ForgetSnapshot(this, (i) => i);
}

abstract class CopyWith$Mutation$ForgetSnapshot<TRes> {
  factory CopyWith$Mutation$ForgetSnapshot(
    Mutation$ForgetSnapshot instance,
    TRes Function(Mutation$ForgetSnapshot) then,
  ) = _CopyWithImpl$Mutation$ForgetSnapshot;

  factory CopyWith$Mutation$ForgetSnapshot.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ForgetSnapshot;

  TRes call({Mutation$ForgetSnapshot$backup? backup, String? $__typename});
  CopyWith$Mutation$ForgetSnapshot$backup<TRes> get backup;
}

class _CopyWithImpl$Mutation$ForgetSnapshot<TRes>
    implements CopyWith$Mutation$ForgetSnapshot<TRes> {
  _CopyWithImpl$Mutation$ForgetSnapshot(this._instance, this._then);

  final Mutation$ForgetSnapshot _instance;

  final TRes Function(Mutation$ForgetSnapshot) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? backup = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Mutation$ForgetSnapshot(
          backup:
              backup == _undefined || backup == null
                  ? _instance.backup
                  : (backup as Mutation$ForgetSnapshot$backup),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );

  CopyWith$Mutation$ForgetSnapshot$backup<TRes> get backup {
    final local$backup = _instance.backup;
    return CopyWith$Mutation$ForgetSnapshot$backup(
      local$backup,
      (e) => call(backup: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$ForgetSnapshot<TRes>
    implements CopyWith$Mutation$ForgetSnapshot<TRes> {
  _CopyWithStubImpl$Mutation$ForgetSnapshot(this._res);

  TRes _res;

  call({Mutation$ForgetSnapshot$backup? backup, String? $__typename}) => _res;

  CopyWith$Mutation$ForgetSnapshot$backup<TRes> get backup =>
      CopyWith$Mutation$ForgetSnapshot$backup.stub(_res);
}

const documentNodeMutationForgetSnapshot = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ForgetSnapshot'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'snapshotId')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'backup'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'forgetSnapshot'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'snapshotId'),
                      value: VariableNode(name: NameNode(value: 'snapshotId')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'basicMutationReturnFields'),
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
    fragmentDefinitionbasicMutationReturnFields,
  ],
);
Mutation$ForgetSnapshot _parserFn$Mutation$ForgetSnapshot(
  Map<String, dynamic> data,
) => Mutation$ForgetSnapshot.fromJson(data);
typedef OnMutationCompleted$Mutation$ForgetSnapshot =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$ForgetSnapshot?);

class Options$Mutation$ForgetSnapshot
    extends graphql.MutationOptions<Mutation$ForgetSnapshot> {
  Options$Mutation$ForgetSnapshot({
    String? operationName,
    required Variables$Mutation$ForgetSnapshot variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ForgetSnapshot? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$ForgetSnapshot? onCompleted,
    graphql.OnMutationUpdate<Mutation$ForgetSnapshot>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
                 ? null
                 : (data) => onCompleted(
                   data,
                   data == null
                       ? null
                       : _parserFn$Mutation$ForgetSnapshot(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationForgetSnapshot,
         parserFn: _parserFn$Mutation$ForgetSnapshot,
       );

  final OnMutationCompleted$Mutation$ForgetSnapshot? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$ForgetSnapshot
    extends graphql.WatchQueryOptions<Mutation$ForgetSnapshot> {
  WatchOptions$Mutation$ForgetSnapshot({
    String? operationName,
    required Variables$Mutation$ForgetSnapshot variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ForgetSnapshot? typedOptimisticResult,
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
         document: documentNodeMutationForgetSnapshot,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$ForgetSnapshot,
       );
}

extension ClientExtension$Mutation$ForgetSnapshot on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$ForgetSnapshot>> mutate$ForgetSnapshot(
    Options$Mutation$ForgetSnapshot options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$ForgetSnapshot> watchMutation$ForgetSnapshot(
    WatchOptions$Mutation$ForgetSnapshot options,
  ) => this.watchMutation(options);
}

class Mutation$ForgetSnapshot$backup {
  Mutation$ForgetSnapshot$backup({
    required this.forgetSnapshot,
    this.$__typename = 'BackupMutations',
  });

  factory Mutation$ForgetSnapshot$backup.fromJson(Map<String, dynamic> json) {
    final l$forgetSnapshot = json['forgetSnapshot'];
    final l$$__typename = json['__typename'];
    return Mutation$ForgetSnapshot$backup(
      forgetSnapshot: Mutation$ForgetSnapshot$backup$forgetSnapshot.fromJson(
        (l$forgetSnapshot as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$ForgetSnapshot$backup$forgetSnapshot forgetSnapshot;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$forgetSnapshot = forgetSnapshot;
    _resultData['forgetSnapshot'] = l$forgetSnapshot.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$forgetSnapshot = forgetSnapshot;
    final l$$__typename = $__typename;
    return Object.hashAll([l$forgetSnapshot, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ForgetSnapshot$backup ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$forgetSnapshot = forgetSnapshot;
    final lOther$forgetSnapshot = other.forgetSnapshot;
    if (l$forgetSnapshot != lOther$forgetSnapshot) {
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

extension UtilityExtension$Mutation$ForgetSnapshot$backup
    on Mutation$ForgetSnapshot$backup {
  CopyWith$Mutation$ForgetSnapshot$backup<Mutation$ForgetSnapshot$backup>
  get copyWith => CopyWith$Mutation$ForgetSnapshot$backup(this, (i) => i);
}

abstract class CopyWith$Mutation$ForgetSnapshot$backup<TRes> {
  factory CopyWith$Mutation$ForgetSnapshot$backup(
    Mutation$ForgetSnapshot$backup instance,
    TRes Function(Mutation$ForgetSnapshot$backup) then,
  ) = _CopyWithImpl$Mutation$ForgetSnapshot$backup;

  factory CopyWith$Mutation$ForgetSnapshot$backup.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ForgetSnapshot$backup;

  TRes call({
    Mutation$ForgetSnapshot$backup$forgetSnapshot? forgetSnapshot,
    String? $__typename,
  });
  CopyWith$Mutation$ForgetSnapshot$backup$forgetSnapshot<TRes>
  get forgetSnapshot;
}

class _CopyWithImpl$Mutation$ForgetSnapshot$backup<TRes>
    implements CopyWith$Mutation$ForgetSnapshot$backup<TRes> {
  _CopyWithImpl$Mutation$ForgetSnapshot$backup(this._instance, this._then);

  final Mutation$ForgetSnapshot$backup _instance;

  final TRes Function(Mutation$ForgetSnapshot$backup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? forgetSnapshot = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$ForgetSnapshot$backup(
      forgetSnapshot:
          forgetSnapshot == _undefined || forgetSnapshot == null
              ? _instance.forgetSnapshot
              : (forgetSnapshot
                  as Mutation$ForgetSnapshot$backup$forgetSnapshot),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$ForgetSnapshot$backup$forgetSnapshot<TRes>
  get forgetSnapshot {
    final local$forgetSnapshot = _instance.forgetSnapshot;
    return CopyWith$Mutation$ForgetSnapshot$backup$forgetSnapshot(
      local$forgetSnapshot,
      (e) => call(forgetSnapshot: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$ForgetSnapshot$backup<TRes>
    implements CopyWith$Mutation$ForgetSnapshot$backup<TRes> {
  _CopyWithStubImpl$Mutation$ForgetSnapshot$backup(this._res);

  TRes _res;

  call({
    Mutation$ForgetSnapshot$backup$forgetSnapshot? forgetSnapshot,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$ForgetSnapshot$backup$forgetSnapshot<TRes>
  get forgetSnapshot =>
      CopyWith$Mutation$ForgetSnapshot$backup$forgetSnapshot.stub(_res);
}

class Mutation$ForgetSnapshot$backup$forgetSnapshot
    implements Fragment$basicMutationReturnFields$$GenericMutationReturn {
  Mutation$ForgetSnapshot$backup$forgetSnapshot({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Mutation$ForgetSnapshot$backup$forgetSnapshot.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$ForgetSnapshot$backup$forgetSnapshot(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    return Object.hashAll([l$code, l$message, l$success, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ForgetSnapshot$backup$forgetSnapshot ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) {
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

extension UtilityExtension$Mutation$ForgetSnapshot$backup$forgetSnapshot
    on Mutation$ForgetSnapshot$backup$forgetSnapshot {
  CopyWith$Mutation$ForgetSnapshot$backup$forgetSnapshot<
    Mutation$ForgetSnapshot$backup$forgetSnapshot
  >
  get copyWith =>
      CopyWith$Mutation$ForgetSnapshot$backup$forgetSnapshot(this, (i) => i);
}

abstract class CopyWith$Mutation$ForgetSnapshot$backup$forgetSnapshot<TRes> {
  factory CopyWith$Mutation$ForgetSnapshot$backup$forgetSnapshot(
    Mutation$ForgetSnapshot$backup$forgetSnapshot instance,
    TRes Function(Mutation$ForgetSnapshot$backup$forgetSnapshot) then,
  ) = _CopyWithImpl$Mutation$ForgetSnapshot$backup$forgetSnapshot;

  factory CopyWith$Mutation$ForgetSnapshot$backup$forgetSnapshot.stub(
    TRes res,
  ) = _CopyWithStubImpl$Mutation$ForgetSnapshot$backup$forgetSnapshot;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$ForgetSnapshot$backup$forgetSnapshot<TRes>
    implements CopyWith$Mutation$ForgetSnapshot$backup$forgetSnapshot<TRes> {
  _CopyWithImpl$Mutation$ForgetSnapshot$backup$forgetSnapshot(
    this._instance,
    this._then,
  );

  final Mutation$ForgetSnapshot$backup$forgetSnapshot _instance;

  final TRes Function(Mutation$ForgetSnapshot$backup$forgetSnapshot) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$ForgetSnapshot$backup$forgetSnapshot(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Mutation$ForgetSnapshot$backup$forgetSnapshot<TRes>
    implements CopyWith$Mutation$ForgetSnapshot$backup$forgetSnapshot<TRes> {
  _CopyWithStubImpl$Mutation$ForgetSnapshot$backup$forgetSnapshot(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}
