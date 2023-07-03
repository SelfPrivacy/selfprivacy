import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:selfprivacy/utils/scalars.dart';
import 'schema.graphql.dart';

class Fragment$basicMutationReturnFields {
  Fragment$basicMutationReturnFields({
    required this.code,
    required this.message,
    required this.success,
    required this.$__typename,
  });

  factory Fragment$basicMutationReturnFields.fromJson(
      Map<String, dynamic> json) {
    switch (json["__typename"] as String) {
      case "ApiKeyMutationReturn":
        return Fragment$basicMutationReturnFields$$ApiKeyMutationReturn
            .fromJson(json);

      case "AutoUpgradeSettingsMutationReturn":
        return Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn
            .fromJson(json);

      case "DeviceApiTokenMutationReturn":
        return Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn
            .fromJson(json);

      case "GenericBackupConfigReturn":
        return Fragment$basicMutationReturnFields$$GenericBackupConfigReturn
            .fromJson(json);

      case "GenericJobMutationReturn":
        return Fragment$basicMutationReturnFields$$GenericJobMutationReturn
            .fromJson(json);

      case "GenericMutationReturn":
        return Fragment$basicMutationReturnFields$$GenericMutationReturn
            .fromJson(json);

      case "ServiceJobMutationReturn":
        return Fragment$basicMutationReturnFields$$ServiceJobMutationReturn
            .fromJson(json);

      case "ServiceMutationReturn":
        return Fragment$basicMutationReturnFields$$ServiceMutationReturn
            .fromJson(json);

      case "TimezoneMutationReturn":
        return Fragment$basicMutationReturnFields$$TimezoneMutationReturn
            .fromJson(json);

      case "UserMutationReturn":
        return Fragment$basicMutationReturnFields$$UserMutationReturn.fromJson(
            json);

      default:
        final l$code = json['code'];
        final l$message = json['message'];
        final l$success = json['success'];
        final l$$__typename = json['__typename'];
        return Fragment$basicMutationReturnFields(
          code: (l$code as int),
          message: (l$message as String),
          success: (l$success as bool),
          $__typename: (l$$__typename as String),
        );
    }
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$basicMutationReturnFields) ||
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

extension UtilityExtension$Fragment$basicMutationReturnFields
    on Fragment$basicMutationReturnFields {
  CopyWith$Fragment$basicMutationReturnFields<
          Fragment$basicMutationReturnFields>
      get copyWith => CopyWith$Fragment$basicMutationReturnFields(
            this,
            (i) => i,
          );
  _T when<_T>({
    required _T Function(
            Fragment$basicMutationReturnFields$$ApiKeyMutationReturn)
        apiKeyMutationReturn,
    required _T Function(
            Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn)
        autoUpgradeSettingsMutationReturn,
    required _T Function(
            Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn)
        deviceApiTokenMutationReturn,
    required _T Function(
            Fragment$basicMutationReturnFields$$GenericBackupConfigReturn)
        genericBackupConfigReturn,
    required _T Function(
            Fragment$basicMutationReturnFields$$GenericJobMutationReturn)
        genericJobMutationReturn,
    required _T Function(
            Fragment$basicMutationReturnFields$$GenericMutationReturn)
        genericMutationReturn,
    required _T Function(
            Fragment$basicMutationReturnFields$$ServiceJobMutationReturn)
        serviceJobMutationReturn,
    required _T Function(
            Fragment$basicMutationReturnFields$$ServiceMutationReturn)
        serviceMutationReturn,
    required _T Function(
            Fragment$basicMutationReturnFields$$TimezoneMutationReturn)
        timezoneMutationReturn,
    required _T Function(Fragment$basicMutationReturnFields$$UserMutationReturn)
        userMutationReturn,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "ApiKeyMutationReturn":
        return apiKeyMutationReturn(
            this as Fragment$basicMutationReturnFields$$ApiKeyMutationReturn);

      case "AutoUpgradeSettingsMutationReturn":
        return autoUpgradeSettingsMutationReturn(this
            as Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn);

      case "DeviceApiTokenMutationReturn":
        return deviceApiTokenMutationReturn(this
            as Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn);

      case "GenericBackupConfigReturn":
        return genericBackupConfigReturn(this
            as Fragment$basicMutationReturnFields$$GenericBackupConfigReturn);

      case "GenericJobMutationReturn":
        return genericJobMutationReturn(this
            as Fragment$basicMutationReturnFields$$GenericJobMutationReturn);

      case "GenericMutationReturn":
        return genericMutationReturn(
            this as Fragment$basicMutationReturnFields$$GenericMutationReturn);

      case "ServiceJobMutationReturn":
        return serviceJobMutationReturn(this
            as Fragment$basicMutationReturnFields$$ServiceJobMutationReturn);

      case "ServiceMutationReturn":
        return serviceMutationReturn(
            this as Fragment$basicMutationReturnFields$$ServiceMutationReturn);

      case "TimezoneMutationReturn":
        return timezoneMutationReturn(
            this as Fragment$basicMutationReturnFields$$TimezoneMutationReturn);

      case "UserMutationReturn":
        return userMutationReturn(
            this as Fragment$basicMutationReturnFields$$UserMutationReturn);

      default:
        return orElse();
    }
  }

  _T maybeWhen<_T>({
    _T Function(Fragment$basicMutationReturnFields$$ApiKeyMutationReturn)?
        apiKeyMutationReturn,
    _T Function(
            Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn)?
        autoUpgradeSettingsMutationReturn,
    _T Function(
            Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn)?
        deviceApiTokenMutationReturn,
    _T Function(Fragment$basicMutationReturnFields$$GenericBackupConfigReturn)?
        genericBackupConfigReturn,
    _T Function(Fragment$basicMutationReturnFields$$GenericJobMutationReturn)?
        genericJobMutationReturn,
    _T Function(Fragment$basicMutationReturnFields$$GenericMutationReturn)?
        genericMutationReturn,
    _T Function(Fragment$basicMutationReturnFields$$ServiceJobMutationReturn)?
        serviceJobMutationReturn,
    _T Function(Fragment$basicMutationReturnFields$$ServiceMutationReturn)?
        serviceMutationReturn,
    _T Function(Fragment$basicMutationReturnFields$$TimezoneMutationReturn)?
        timezoneMutationReturn,
    _T Function(Fragment$basicMutationReturnFields$$UserMutationReturn)?
        userMutationReturn,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "ApiKeyMutationReturn":
        if (apiKeyMutationReturn != null) {
          return apiKeyMutationReturn(
              this as Fragment$basicMutationReturnFields$$ApiKeyMutationReturn);
        } else {
          return orElse();
        }

      case "AutoUpgradeSettingsMutationReturn":
        if (autoUpgradeSettingsMutationReturn != null) {
          return autoUpgradeSettingsMutationReturn(this
              as Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn);
        } else {
          return orElse();
        }

      case "DeviceApiTokenMutationReturn":
        if (deviceApiTokenMutationReturn != null) {
          return deviceApiTokenMutationReturn(this
              as Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn);
        } else {
          return orElse();
        }

      case "GenericBackupConfigReturn":
        if (genericBackupConfigReturn != null) {
          return genericBackupConfigReturn(this
              as Fragment$basicMutationReturnFields$$GenericBackupConfigReturn);
        } else {
          return orElse();
        }

      case "GenericJobMutationReturn":
        if (genericJobMutationReturn != null) {
          return genericJobMutationReturn(this
              as Fragment$basicMutationReturnFields$$GenericJobMutationReturn);
        } else {
          return orElse();
        }

      case "GenericMutationReturn":
        if (genericMutationReturn != null) {
          return genericMutationReturn(this
              as Fragment$basicMutationReturnFields$$GenericMutationReturn);
        } else {
          return orElse();
        }

      case "ServiceJobMutationReturn":
        if (serviceJobMutationReturn != null) {
          return serviceJobMutationReturn(this
              as Fragment$basicMutationReturnFields$$ServiceJobMutationReturn);
        } else {
          return orElse();
        }

      case "ServiceMutationReturn":
        if (serviceMutationReturn != null) {
          return serviceMutationReturn(this
              as Fragment$basicMutationReturnFields$$ServiceMutationReturn);
        } else {
          return orElse();
        }

      case "TimezoneMutationReturn":
        if (timezoneMutationReturn != null) {
          return timezoneMutationReturn(this
              as Fragment$basicMutationReturnFields$$TimezoneMutationReturn);
        } else {
          return orElse();
        }

      case "UserMutationReturn":
        if (userMutationReturn != null) {
          return userMutationReturn(
              this as Fragment$basicMutationReturnFields$$UserMutationReturn);
        } else {
          return orElse();
        }

      default:
        return orElse();
    }
  }
}

abstract class CopyWith$Fragment$basicMutationReturnFields<TRes> {
  factory CopyWith$Fragment$basicMutationReturnFields(
    Fragment$basicMutationReturnFields instance,
    TRes Function(Fragment$basicMutationReturnFields) then,
  ) = _CopyWithImpl$Fragment$basicMutationReturnFields;

  factory CopyWith$Fragment$basicMutationReturnFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$basicMutationReturnFields;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$basicMutationReturnFields<TRes>
    implements CopyWith$Fragment$basicMutationReturnFields<TRes> {
  _CopyWithImpl$Fragment$basicMutationReturnFields(
    this._instance,
    this._then,
  );

  final Fragment$basicMutationReturnFields _instance;

  final TRes Function(Fragment$basicMutationReturnFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$basicMutationReturnFields(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$basicMutationReturnFields<TRes>
    implements CopyWith$Fragment$basicMutationReturnFields<TRes> {
  _CopyWithStubImpl$Fragment$basicMutationReturnFields(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

const fragmentDefinitionbasicMutationReturnFields = FragmentDefinitionNode(
  name: NameNode(value: 'basicMutationReturnFields'),
  typeCondition: TypeConditionNode(
      on: NamedTypeNode(
    name: NameNode(value: 'MutationReturnInterface'),
    isNonNull: false,
  )),
  directives: [],
  selectionSet: SelectionSetNode(selections: [
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
      name: NameNode(value: '__typename'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
  ]),
);
const documentNodeFragmentbasicMutationReturnFields =
    DocumentNode(definitions: [
  fragmentDefinitionbasicMutationReturnFields,
]);

extension ClientExtension$Fragment$basicMutationReturnFields
    on graphql.GraphQLClient {
  void writeFragment$basicMutationReturnFields({
    required Fragment$basicMutationReturnFields data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) =>
      this.writeFragment(
        graphql.FragmentRequest(
          idFields: idFields,
          fragment: const graphql.Fragment(
            fragmentName: 'basicMutationReturnFields',
            document: documentNodeFragmentbasicMutationReturnFields,
          ),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Fragment$basicMutationReturnFields? readFragment$basicMutationReturnFields({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'basicMutationReturnFields',
          document: documentNodeFragmentbasicMutationReturnFields,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null
        ? null
        : Fragment$basicMutationReturnFields.fromJson(result);
  }
}

class Fragment$basicMutationReturnFields$$ApiKeyMutationReturn
    implements Fragment$basicMutationReturnFields {
  Fragment$basicMutationReturnFields$$ApiKeyMutationReturn({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ApiKeyMutationReturn',
  });

  factory Fragment$basicMutationReturnFields$$ApiKeyMutationReturn.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Fragment$basicMutationReturnFields$$ApiKeyMutationReturn(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$basicMutationReturnFields$$ApiKeyMutationReturn) ||
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

extension UtilityExtension$Fragment$basicMutationReturnFields$$ApiKeyMutationReturn
    on Fragment$basicMutationReturnFields$$ApiKeyMutationReturn {
  CopyWith$Fragment$basicMutationReturnFields$$ApiKeyMutationReturn<
          Fragment$basicMutationReturnFields$$ApiKeyMutationReturn>
      get copyWith =>
          CopyWith$Fragment$basicMutationReturnFields$$ApiKeyMutationReturn(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Fragment$basicMutationReturnFields$$ApiKeyMutationReturn<
    TRes> {
  factory CopyWith$Fragment$basicMutationReturnFields$$ApiKeyMutationReturn(
    Fragment$basicMutationReturnFields$$ApiKeyMutationReturn instance,
    TRes Function(Fragment$basicMutationReturnFields$$ApiKeyMutationReturn)
        then,
  ) = _CopyWithImpl$Fragment$basicMutationReturnFields$$ApiKeyMutationReturn;

  factory CopyWith$Fragment$basicMutationReturnFields$$ApiKeyMutationReturn.stub(
          TRes res) =
      _CopyWithStubImpl$Fragment$basicMutationReturnFields$$ApiKeyMutationReturn;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$basicMutationReturnFields$$ApiKeyMutationReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$ApiKeyMutationReturn<
            TRes> {
  _CopyWithImpl$Fragment$basicMutationReturnFields$$ApiKeyMutationReturn(
    this._instance,
    this._then,
  );

  final Fragment$basicMutationReturnFields$$ApiKeyMutationReturn _instance;

  final TRes Function(Fragment$basicMutationReturnFields$$ApiKeyMutationReturn)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$basicMutationReturnFields$$ApiKeyMutationReturn(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$basicMutationReturnFields$$ApiKeyMutationReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$ApiKeyMutationReturn<
            TRes> {
  _CopyWithStubImpl$Fragment$basicMutationReturnFields$$ApiKeyMutationReturn(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn
    implements Fragment$basicMutationReturnFields {
  Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'AutoUpgradeSettingsMutationReturn',
  });

  factory Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn) ||
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

extension UtilityExtension$Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn
    on Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn {
  CopyWith$Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn<
          Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn>
      get copyWith =>
          CopyWith$Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn<
    TRes> {
  factory CopyWith$Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn(
    Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn
        instance,
    TRes Function(
            Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn)
        then,
  ) = _CopyWithImpl$Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn;

  factory CopyWith$Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn.stub(
          TRes res) =
      _CopyWithStubImpl$Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn<
            TRes> {
  _CopyWithImpl$Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn(
    this._instance,
    this._then,
  );

  final Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn
      _instance;

  final TRes Function(
          Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(
          Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn<
            TRes> {
  _CopyWithStubImpl$Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn
    implements Fragment$basicMutationReturnFields {
  Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'DeviceApiTokenMutationReturn',
  });

  factory Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn) ||
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

extension UtilityExtension$Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn
    on Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn {
  CopyWith$Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn<
          Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn>
      get copyWith =>
          CopyWith$Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn<
    TRes> {
  factory CopyWith$Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn(
    Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn instance,
    TRes Function(
            Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn)
        then,
  ) = _CopyWithImpl$Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn;

  factory CopyWith$Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn.stub(
          TRes res) =
      _CopyWithStubImpl$Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn<
            TRes> {
  _CopyWithImpl$Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn(
    this._instance,
    this._then,
  );

  final Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn
      _instance;

  final TRes Function(
      Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn<
            TRes> {
  _CopyWithStubImpl$Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Fragment$basicMutationReturnFields$$GenericBackupConfigReturn
    implements Fragment$basicMutationReturnFields {
  Fragment$basicMutationReturnFields$$GenericBackupConfigReturn({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericBackupConfigReturn',
  });

  factory Fragment$basicMutationReturnFields$$GenericBackupConfigReturn.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Fragment$basicMutationReturnFields$$GenericBackupConfigReturn(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Fragment$basicMutationReturnFields$$GenericBackupConfigReturn) ||
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

extension UtilityExtension$Fragment$basicMutationReturnFields$$GenericBackupConfigReturn
    on Fragment$basicMutationReturnFields$$GenericBackupConfigReturn {
  CopyWith$Fragment$basicMutationReturnFields$$GenericBackupConfigReturn<
          Fragment$basicMutationReturnFields$$GenericBackupConfigReturn>
      get copyWith =>
          CopyWith$Fragment$basicMutationReturnFields$$GenericBackupConfigReturn(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Fragment$basicMutationReturnFields$$GenericBackupConfigReturn<
    TRes> {
  factory CopyWith$Fragment$basicMutationReturnFields$$GenericBackupConfigReturn(
    Fragment$basicMutationReturnFields$$GenericBackupConfigReturn instance,
    TRes Function(Fragment$basicMutationReturnFields$$GenericBackupConfigReturn)
        then,
  ) = _CopyWithImpl$Fragment$basicMutationReturnFields$$GenericBackupConfigReturn;

  factory CopyWith$Fragment$basicMutationReturnFields$$GenericBackupConfigReturn.stub(
          TRes res) =
      _CopyWithStubImpl$Fragment$basicMutationReturnFields$$GenericBackupConfigReturn;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$basicMutationReturnFields$$GenericBackupConfigReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$GenericBackupConfigReturn<
            TRes> {
  _CopyWithImpl$Fragment$basicMutationReturnFields$$GenericBackupConfigReturn(
    this._instance,
    this._then,
  );

  final Fragment$basicMutationReturnFields$$GenericBackupConfigReturn _instance;

  final TRes Function(
      Fragment$basicMutationReturnFields$$GenericBackupConfigReturn) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$basicMutationReturnFields$$GenericBackupConfigReturn(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$basicMutationReturnFields$$GenericBackupConfigReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$GenericBackupConfigReturn<
            TRes> {
  _CopyWithStubImpl$Fragment$basicMutationReturnFields$$GenericBackupConfigReturn(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Fragment$basicMutationReturnFields$$GenericJobMutationReturn
    implements Fragment$basicMutationReturnFields {
  Fragment$basicMutationReturnFields$$GenericJobMutationReturn({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericJobMutationReturn',
  });

  factory Fragment$basicMutationReturnFields$$GenericJobMutationReturn.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Fragment$basicMutationReturnFields$$GenericJobMutationReturn(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Fragment$basicMutationReturnFields$$GenericJobMutationReturn) ||
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

extension UtilityExtension$Fragment$basicMutationReturnFields$$GenericJobMutationReturn
    on Fragment$basicMutationReturnFields$$GenericJobMutationReturn {
  CopyWith$Fragment$basicMutationReturnFields$$GenericJobMutationReturn<
          Fragment$basicMutationReturnFields$$GenericJobMutationReturn>
      get copyWith =>
          CopyWith$Fragment$basicMutationReturnFields$$GenericJobMutationReturn(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Fragment$basicMutationReturnFields$$GenericJobMutationReturn<
    TRes> {
  factory CopyWith$Fragment$basicMutationReturnFields$$GenericJobMutationReturn(
    Fragment$basicMutationReturnFields$$GenericJobMutationReturn instance,
    TRes Function(Fragment$basicMutationReturnFields$$GenericJobMutationReturn)
        then,
  ) = _CopyWithImpl$Fragment$basicMutationReturnFields$$GenericJobMutationReturn;

  factory CopyWith$Fragment$basicMutationReturnFields$$GenericJobMutationReturn.stub(
          TRes res) =
      _CopyWithStubImpl$Fragment$basicMutationReturnFields$$GenericJobMutationReturn;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$basicMutationReturnFields$$GenericJobMutationReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$GenericJobMutationReturn<
            TRes> {
  _CopyWithImpl$Fragment$basicMutationReturnFields$$GenericJobMutationReturn(
    this._instance,
    this._then,
  );

  final Fragment$basicMutationReturnFields$$GenericJobMutationReturn _instance;

  final TRes Function(
      Fragment$basicMutationReturnFields$$GenericJobMutationReturn) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$basicMutationReturnFields$$GenericJobMutationReturn(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$basicMutationReturnFields$$GenericJobMutationReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$GenericJobMutationReturn<
            TRes> {
  _CopyWithStubImpl$Fragment$basicMutationReturnFields$$GenericJobMutationReturn(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Fragment$basicMutationReturnFields$$GenericMutationReturn
    implements Fragment$basicMutationReturnFields {
  Fragment$basicMutationReturnFields$$GenericMutationReturn({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Fragment$basicMutationReturnFields$$GenericMutationReturn.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Fragment$basicMutationReturnFields$$GenericMutationReturn(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$basicMutationReturnFields$$GenericMutationReturn) ||
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

extension UtilityExtension$Fragment$basicMutationReturnFields$$GenericMutationReturn
    on Fragment$basicMutationReturnFields$$GenericMutationReturn {
  CopyWith$Fragment$basicMutationReturnFields$$GenericMutationReturn<
          Fragment$basicMutationReturnFields$$GenericMutationReturn>
      get copyWith =>
          CopyWith$Fragment$basicMutationReturnFields$$GenericMutationReturn(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Fragment$basicMutationReturnFields$$GenericMutationReturn<
    TRes> {
  factory CopyWith$Fragment$basicMutationReturnFields$$GenericMutationReturn(
    Fragment$basicMutationReturnFields$$GenericMutationReturn instance,
    TRes Function(Fragment$basicMutationReturnFields$$GenericMutationReturn)
        then,
  ) = _CopyWithImpl$Fragment$basicMutationReturnFields$$GenericMutationReturn;

  factory CopyWith$Fragment$basicMutationReturnFields$$GenericMutationReturn.stub(
          TRes res) =
      _CopyWithStubImpl$Fragment$basicMutationReturnFields$$GenericMutationReturn;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$basicMutationReturnFields$$GenericMutationReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$GenericMutationReturn<
            TRes> {
  _CopyWithImpl$Fragment$basicMutationReturnFields$$GenericMutationReturn(
    this._instance,
    this._then,
  );

  final Fragment$basicMutationReturnFields$$GenericMutationReturn _instance;

  final TRes Function(Fragment$basicMutationReturnFields$$GenericMutationReturn)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$basicMutationReturnFields$$GenericMutationReturn(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$basicMutationReturnFields$$GenericMutationReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$GenericMutationReturn<
            TRes> {
  _CopyWithStubImpl$Fragment$basicMutationReturnFields$$GenericMutationReturn(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Fragment$basicMutationReturnFields$$ServiceJobMutationReturn
    implements Fragment$basicMutationReturnFields {
  Fragment$basicMutationReturnFields$$ServiceJobMutationReturn({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ServiceJobMutationReturn',
  });

  factory Fragment$basicMutationReturnFields$$ServiceJobMutationReturn.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Fragment$basicMutationReturnFields$$ServiceJobMutationReturn(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Fragment$basicMutationReturnFields$$ServiceJobMutationReturn) ||
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

extension UtilityExtension$Fragment$basicMutationReturnFields$$ServiceJobMutationReturn
    on Fragment$basicMutationReturnFields$$ServiceJobMutationReturn {
  CopyWith$Fragment$basicMutationReturnFields$$ServiceJobMutationReturn<
          Fragment$basicMutationReturnFields$$ServiceJobMutationReturn>
      get copyWith =>
          CopyWith$Fragment$basicMutationReturnFields$$ServiceJobMutationReturn(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Fragment$basicMutationReturnFields$$ServiceJobMutationReturn<
    TRes> {
  factory CopyWith$Fragment$basicMutationReturnFields$$ServiceJobMutationReturn(
    Fragment$basicMutationReturnFields$$ServiceJobMutationReturn instance,
    TRes Function(Fragment$basicMutationReturnFields$$ServiceJobMutationReturn)
        then,
  ) = _CopyWithImpl$Fragment$basicMutationReturnFields$$ServiceJobMutationReturn;

  factory CopyWith$Fragment$basicMutationReturnFields$$ServiceJobMutationReturn.stub(
          TRes res) =
      _CopyWithStubImpl$Fragment$basicMutationReturnFields$$ServiceJobMutationReturn;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$basicMutationReturnFields$$ServiceJobMutationReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$ServiceJobMutationReturn<
            TRes> {
  _CopyWithImpl$Fragment$basicMutationReturnFields$$ServiceJobMutationReturn(
    this._instance,
    this._then,
  );

  final Fragment$basicMutationReturnFields$$ServiceJobMutationReturn _instance;

  final TRes Function(
      Fragment$basicMutationReturnFields$$ServiceJobMutationReturn) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$basicMutationReturnFields$$ServiceJobMutationReturn(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$basicMutationReturnFields$$ServiceJobMutationReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$ServiceJobMutationReturn<
            TRes> {
  _CopyWithStubImpl$Fragment$basicMutationReturnFields$$ServiceJobMutationReturn(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Fragment$basicMutationReturnFields$$ServiceMutationReturn
    implements Fragment$basicMutationReturnFields {
  Fragment$basicMutationReturnFields$$ServiceMutationReturn({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ServiceMutationReturn',
  });

  factory Fragment$basicMutationReturnFields$$ServiceMutationReturn.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Fragment$basicMutationReturnFields$$ServiceMutationReturn(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$basicMutationReturnFields$$ServiceMutationReturn) ||
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

extension UtilityExtension$Fragment$basicMutationReturnFields$$ServiceMutationReturn
    on Fragment$basicMutationReturnFields$$ServiceMutationReturn {
  CopyWith$Fragment$basicMutationReturnFields$$ServiceMutationReturn<
          Fragment$basicMutationReturnFields$$ServiceMutationReturn>
      get copyWith =>
          CopyWith$Fragment$basicMutationReturnFields$$ServiceMutationReturn(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Fragment$basicMutationReturnFields$$ServiceMutationReturn<
    TRes> {
  factory CopyWith$Fragment$basicMutationReturnFields$$ServiceMutationReturn(
    Fragment$basicMutationReturnFields$$ServiceMutationReturn instance,
    TRes Function(Fragment$basicMutationReturnFields$$ServiceMutationReturn)
        then,
  ) = _CopyWithImpl$Fragment$basicMutationReturnFields$$ServiceMutationReturn;

  factory CopyWith$Fragment$basicMutationReturnFields$$ServiceMutationReturn.stub(
          TRes res) =
      _CopyWithStubImpl$Fragment$basicMutationReturnFields$$ServiceMutationReturn;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$basicMutationReturnFields$$ServiceMutationReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$ServiceMutationReturn<
            TRes> {
  _CopyWithImpl$Fragment$basicMutationReturnFields$$ServiceMutationReturn(
    this._instance,
    this._then,
  );

  final Fragment$basicMutationReturnFields$$ServiceMutationReturn _instance;

  final TRes Function(Fragment$basicMutationReturnFields$$ServiceMutationReturn)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$basicMutationReturnFields$$ServiceMutationReturn(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$basicMutationReturnFields$$ServiceMutationReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$ServiceMutationReturn<
            TRes> {
  _CopyWithStubImpl$Fragment$basicMutationReturnFields$$ServiceMutationReturn(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Fragment$basicMutationReturnFields$$TimezoneMutationReturn
    implements Fragment$basicMutationReturnFields {
  Fragment$basicMutationReturnFields$$TimezoneMutationReturn({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'TimezoneMutationReturn',
  });

  factory Fragment$basicMutationReturnFields$$TimezoneMutationReturn.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Fragment$basicMutationReturnFields$$TimezoneMutationReturn(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Fragment$basicMutationReturnFields$$TimezoneMutationReturn) ||
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

extension UtilityExtension$Fragment$basicMutationReturnFields$$TimezoneMutationReturn
    on Fragment$basicMutationReturnFields$$TimezoneMutationReturn {
  CopyWith$Fragment$basicMutationReturnFields$$TimezoneMutationReturn<
          Fragment$basicMutationReturnFields$$TimezoneMutationReturn>
      get copyWith =>
          CopyWith$Fragment$basicMutationReturnFields$$TimezoneMutationReturn(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Fragment$basicMutationReturnFields$$TimezoneMutationReturn<
    TRes> {
  factory CopyWith$Fragment$basicMutationReturnFields$$TimezoneMutationReturn(
    Fragment$basicMutationReturnFields$$TimezoneMutationReturn instance,
    TRes Function(Fragment$basicMutationReturnFields$$TimezoneMutationReturn)
        then,
  ) = _CopyWithImpl$Fragment$basicMutationReturnFields$$TimezoneMutationReturn;

  factory CopyWith$Fragment$basicMutationReturnFields$$TimezoneMutationReturn.stub(
          TRes res) =
      _CopyWithStubImpl$Fragment$basicMutationReturnFields$$TimezoneMutationReturn;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$basicMutationReturnFields$$TimezoneMutationReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$TimezoneMutationReturn<
            TRes> {
  _CopyWithImpl$Fragment$basicMutationReturnFields$$TimezoneMutationReturn(
    this._instance,
    this._then,
  );

  final Fragment$basicMutationReturnFields$$TimezoneMutationReturn _instance;

  final TRes Function(
      Fragment$basicMutationReturnFields$$TimezoneMutationReturn) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$basicMutationReturnFields$$TimezoneMutationReturn(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$basicMutationReturnFields$$TimezoneMutationReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$TimezoneMutationReturn<
            TRes> {
  _CopyWithStubImpl$Fragment$basicMutationReturnFields$$TimezoneMutationReturn(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Fragment$basicMutationReturnFields$$UserMutationReturn
    implements Fragment$basicMutationReturnFields {
  Fragment$basicMutationReturnFields$$UserMutationReturn({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'UserMutationReturn',
  });

  factory Fragment$basicMutationReturnFields$$UserMutationReturn.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Fragment$basicMutationReturnFields$$UserMutationReturn(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$basicMutationReturnFields$$UserMutationReturn) ||
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

extension UtilityExtension$Fragment$basicMutationReturnFields$$UserMutationReturn
    on Fragment$basicMutationReturnFields$$UserMutationReturn {
  CopyWith$Fragment$basicMutationReturnFields$$UserMutationReturn<
          Fragment$basicMutationReturnFields$$UserMutationReturn>
      get copyWith =>
          CopyWith$Fragment$basicMutationReturnFields$$UserMutationReturn(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Fragment$basicMutationReturnFields$$UserMutationReturn<
    TRes> {
  factory CopyWith$Fragment$basicMutationReturnFields$$UserMutationReturn(
    Fragment$basicMutationReturnFields$$UserMutationReturn instance,
    TRes Function(Fragment$basicMutationReturnFields$$UserMutationReturn) then,
  ) = _CopyWithImpl$Fragment$basicMutationReturnFields$$UserMutationReturn;

  factory CopyWith$Fragment$basicMutationReturnFields$$UserMutationReturn.stub(
          TRes res) =
      _CopyWithStubImpl$Fragment$basicMutationReturnFields$$UserMutationReturn;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$basicMutationReturnFields$$UserMutationReturn<TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$UserMutationReturn<TRes> {
  _CopyWithImpl$Fragment$basicMutationReturnFields$$UserMutationReturn(
    this._instance,
    this._then,
  );

  final Fragment$basicMutationReturnFields$$UserMutationReturn _instance;

  final TRes Function(Fragment$basicMutationReturnFields$$UserMutationReturn)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$basicMutationReturnFields$$UserMutationReturn(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$basicMutationReturnFields$$UserMutationReturn<
        TRes>
    implements
        CopyWith$Fragment$basicMutationReturnFields$$UserMutationReturn<TRes> {
  _CopyWithStubImpl$Fragment$basicMutationReturnFields$$UserMutationReturn(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Fragment$basicApiJobsFields {
  Fragment$basicApiJobsFields({
    required this.createdAt,
    required this.description,
    this.error,
    this.finishedAt,
    required this.name,
    this.progress,
    this.result,
    required this.status,
    this.statusText,
    required this.uid,
    required this.typeId,
    required this.updatedAt,
    this.$__typename = 'ApiJob',
  });

  factory Fragment$basicApiJobsFields.fromJson(Map<String, dynamic> json) {
    final l$createdAt = json['createdAt'];
    final l$description = json['description'];
    final l$error = json['error'];
    final l$finishedAt = json['finishedAt'];
    final l$name = json['name'];
    final l$progress = json['progress'];
    final l$result = json['result'];
    final l$status = json['status'];
    final l$statusText = json['statusText'];
    final l$uid = json['uid'];
    final l$typeId = json['typeId'];
    final l$updatedAt = json['updatedAt'];
    final l$$__typename = json['__typename'];
    return Fragment$basicApiJobsFields(
      createdAt: dateTimeFromJson(l$createdAt),
      description: (l$description as String),
      error: (l$error as String?),
      finishedAt: l$finishedAt == null ? null : dateTimeFromJson(l$finishedAt),
      name: (l$name as String),
      progress: (l$progress as int?),
      result: (l$result as String?),
      status: (l$status as String),
      statusText: (l$statusText as String?),
      uid: (l$uid as String),
      typeId: (l$typeId as String),
      updatedAt: dateTimeFromJson(l$updatedAt),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime createdAt;

  final String description;

  final String? error;

  final DateTime? finishedAt;

  final String name;

  final int? progress;

  final String? result;

  final String status;

  final String? statusText;

  final String uid;

  final String typeId;

  final DateTime updatedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createdAt = createdAt;
    _resultData['createdAt'] = dateTimeToJson(l$createdAt);
    final l$description = description;
    _resultData['description'] = l$description;
    final l$error = error;
    _resultData['error'] = l$error;
    final l$finishedAt = finishedAt;
    _resultData['finishedAt'] =
        l$finishedAt == null ? null : dateTimeToJson(l$finishedAt);
    final l$name = name;
    _resultData['name'] = l$name;
    final l$progress = progress;
    _resultData['progress'] = l$progress;
    final l$result = result;
    _resultData['result'] = l$result;
    final l$status = status;
    _resultData['status'] = l$status;
    final l$statusText = statusText;
    _resultData['statusText'] = l$statusText;
    final l$uid = uid;
    _resultData['uid'] = l$uid;
    final l$typeId = typeId;
    _resultData['typeId'] = l$typeId;
    final l$updatedAt = updatedAt;
    _resultData['updatedAt'] = dateTimeToJson(l$updatedAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createdAt = createdAt;
    final l$description = description;
    final l$error = error;
    final l$finishedAt = finishedAt;
    final l$name = name;
    final l$progress = progress;
    final l$result = result;
    final l$status = status;
    final l$statusText = statusText;
    final l$uid = uid;
    final l$typeId = typeId;
    final l$updatedAt = updatedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$createdAt,
      l$description,
      l$error,
      l$finishedAt,
      l$name,
      l$progress,
      l$result,
      l$status,
      l$statusText,
      l$uid,
      l$typeId,
      l$updatedAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$basicApiJobsFields) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$error = error;
    final lOther$error = other.error;
    if (l$error != lOther$error) {
      return false;
    }
    final l$finishedAt = finishedAt;
    final lOther$finishedAt = other.finishedAt;
    if (l$finishedAt != lOther$finishedAt) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$progress = progress;
    final lOther$progress = other.progress;
    if (l$progress != lOther$progress) {
      return false;
    }
    final l$result = result;
    final lOther$result = other.result;
    if (l$result != lOther$result) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$statusText = statusText;
    final lOther$statusText = other.statusText;
    if (l$statusText != lOther$statusText) {
      return false;
    }
    final l$uid = uid;
    final lOther$uid = other.uid;
    if (l$uid != lOther$uid) {
      return false;
    }
    final l$typeId = typeId;
    final lOther$typeId = other.typeId;
    if (l$typeId != lOther$typeId) {
      return false;
    }
    final l$updatedAt = updatedAt;
    final lOther$updatedAt = other.updatedAt;
    if (l$updatedAt != lOther$updatedAt) {
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

extension UtilityExtension$Fragment$basicApiJobsFields
    on Fragment$basicApiJobsFields {
  CopyWith$Fragment$basicApiJobsFields<Fragment$basicApiJobsFields>
      get copyWith => CopyWith$Fragment$basicApiJobsFields(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Fragment$basicApiJobsFields<TRes> {
  factory CopyWith$Fragment$basicApiJobsFields(
    Fragment$basicApiJobsFields instance,
    TRes Function(Fragment$basicApiJobsFields) then,
  ) = _CopyWithImpl$Fragment$basicApiJobsFields;

  factory CopyWith$Fragment$basicApiJobsFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$basicApiJobsFields;

  TRes call({
    DateTime? createdAt,
    String? description,
    String? error,
    DateTime? finishedAt,
    String? name,
    int? progress,
    String? result,
    String? status,
    String? statusText,
    String? uid,
    String? typeId,
    DateTime? updatedAt,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$basicApiJobsFields<TRes>
    implements CopyWith$Fragment$basicApiJobsFields<TRes> {
  _CopyWithImpl$Fragment$basicApiJobsFields(
    this._instance,
    this._then,
  );

  final Fragment$basicApiJobsFields _instance;

  final TRes Function(Fragment$basicApiJobsFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? createdAt = _undefined,
    Object? description = _undefined,
    Object? error = _undefined,
    Object? finishedAt = _undefined,
    Object? name = _undefined,
    Object? progress = _undefined,
    Object? result = _undefined,
    Object? status = _undefined,
    Object? statusText = _undefined,
    Object? uid = _undefined,
    Object? typeId = _undefined,
    Object? updatedAt = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$basicApiJobsFields(
        createdAt: createdAt == _undefined || createdAt == null
            ? _instance.createdAt
            : (createdAt as DateTime),
        description: description == _undefined || description == null
            ? _instance.description
            : (description as String),
        error: error == _undefined ? _instance.error : (error as String?),
        finishedAt: finishedAt == _undefined
            ? _instance.finishedAt
            : (finishedAt as DateTime?),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        progress:
            progress == _undefined ? _instance.progress : (progress as int?),
        result: result == _undefined ? _instance.result : (result as String?),
        status: status == _undefined || status == null
            ? _instance.status
            : (status as String),
        statusText: statusText == _undefined
            ? _instance.statusText
            : (statusText as String?),
        uid: uid == _undefined || uid == null ? _instance.uid : (uid as String),
        typeId: typeId == _undefined || typeId == null
            ? _instance.typeId
            : (typeId as String),
        updatedAt: updatedAt == _undefined || updatedAt == null
            ? _instance.updatedAt
            : (updatedAt as DateTime),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$basicApiJobsFields<TRes>
    implements CopyWith$Fragment$basicApiJobsFields<TRes> {
  _CopyWithStubImpl$Fragment$basicApiJobsFields(this._res);

  TRes _res;

  call({
    DateTime? createdAt,
    String? description,
    String? error,
    DateTime? finishedAt,
    String? name,
    int? progress,
    String? result,
    String? status,
    String? statusText,
    String? uid,
    String? typeId,
    DateTime? updatedAt,
    String? $__typename,
  }) =>
      _res;
}

const fragmentDefinitionbasicApiJobsFields = FragmentDefinitionNode(
  name: NameNode(value: 'basicApiJobsFields'),
  typeCondition: TypeConditionNode(
      on: NamedTypeNode(
    name: NameNode(value: 'ApiJob'),
    isNonNull: false,
  )),
  directives: [],
  selectionSet: SelectionSetNode(selections: [
    FieldNode(
      name: NameNode(value: 'createdAt'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'description'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'error'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'finishedAt'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'name'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'progress'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'result'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'status'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'statusText'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'uid'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'typeId'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'updatedAt'),
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
  ]),
);
const documentNodeFragmentbasicApiJobsFields = DocumentNode(definitions: [
  fragmentDefinitionbasicApiJobsFields,
]);

extension ClientExtension$Fragment$basicApiJobsFields on graphql.GraphQLClient {
  void writeFragment$basicApiJobsFields({
    required Fragment$basicApiJobsFields data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) =>
      this.writeFragment(
        graphql.FragmentRequest(
          idFields: idFields,
          fragment: const graphql.Fragment(
            fragmentName: 'basicApiJobsFields',
            document: documentNodeFragmentbasicApiJobsFields,
          ),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Fragment$basicApiJobsFields? readFragment$basicApiJobsFields({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'basicApiJobsFields',
          document: documentNodeFragmentbasicApiJobsFields,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$basicApiJobsFields.fromJson(result);
  }
}

class Query$GetApiVersion {
  Query$GetApiVersion({
    required this.api,
    this.$__typename = 'Query',
  });

  factory Query$GetApiVersion.fromJson(Map<String, dynamic> json) {
    final l$api = json['api'];
    final l$$__typename = json['__typename'];
    return Query$GetApiVersion(
      api: Query$GetApiVersion$api.fromJson((l$api as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetApiVersion$api api;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$api = api;
    _resultData['api'] = l$api.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$api = api;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$api,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetApiVersion) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$api = api;
    final lOther$api = other.api;
    if (l$api != lOther$api) {
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

extension UtilityExtension$Query$GetApiVersion on Query$GetApiVersion {
  CopyWith$Query$GetApiVersion<Query$GetApiVersion> get copyWith =>
      CopyWith$Query$GetApiVersion(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetApiVersion<TRes> {
  factory CopyWith$Query$GetApiVersion(
    Query$GetApiVersion instance,
    TRes Function(Query$GetApiVersion) then,
  ) = _CopyWithImpl$Query$GetApiVersion;

  factory CopyWith$Query$GetApiVersion.stub(TRes res) =
      _CopyWithStubImpl$Query$GetApiVersion;

  TRes call({
    Query$GetApiVersion$api? api,
    String? $__typename,
  });
  CopyWith$Query$GetApiVersion$api<TRes> get api;
}

class _CopyWithImpl$Query$GetApiVersion<TRes>
    implements CopyWith$Query$GetApiVersion<TRes> {
  _CopyWithImpl$Query$GetApiVersion(
    this._instance,
    this._then,
  );

  final Query$GetApiVersion _instance;

  final TRes Function(Query$GetApiVersion) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? api = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetApiVersion(
        api: api == _undefined || api == null
            ? _instance.api
            : (api as Query$GetApiVersion$api),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$GetApiVersion$api<TRes> get api {
    final local$api = _instance.api;
    return CopyWith$Query$GetApiVersion$api(local$api, (e) => call(api: e));
  }
}

class _CopyWithStubImpl$Query$GetApiVersion<TRes>
    implements CopyWith$Query$GetApiVersion<TRes> {
  _CopyWithStubImpl$Query$GetApiVersion(this._res);

  TRes _res;

  call({
    Query$GetApiVersion$api? api,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$GetApiVersion$api<TRes> get api =>
      CopyWith$Query$GetApiVersion$api.stub(_res);
}

const documentNodeQueryGetApiVersion = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetApiVersion'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'api'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'version'),
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
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetApiVersion _parserFn$Query$GetApiVersion(Map<String, dynamic> data) =>
    Query$GetApiVersion.fromJson(data);
typedef OnQueryComplete$Query$GetApiVersion = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetApiVersion?,
);

class Options$Query$GetApiVersion
    extends graphql.QueryOptions<Query$GetApiVersion> {
  Options$Query$GetApiVersion({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetApiVersion? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetApiVersion? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetApiVersion(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetApiVersion,
          parserFn: _parserFn$Query$GetApiVersion,
        );

  final OnQueryComplete$Query$GetApiVersion? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetApiVersion
    extends graphql.WatchQueryOptions<Query$GetApiVersion> {
  WatchOptions$Query$GetApiVersion({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetApiVersion? typedOptimisticResult,
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
          document: documentNodeQueryGetApiVersion,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetApiVersion,
        );
}

class FetchMoreOptions$Query$GetApiVersion extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetApiVersion(
      {required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryGetApiVersion,
        );
}

extension ClientExtension$Query$GetApiVersion on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetApiVersion>> query$GetApiVersion(
          [Options$Query$GetApiVersion? options]) async =>
      await this.query(options ?? Options$Query$GetApiVersion());
  graphql.ObservableQuery<Query$GetApiVersion> watchQuery$GetApiVersion(
          [WatchOptions$Query$GetApiVersion? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetApiVersion());
  void writeQuery$GetApiVersion({
    required Query$GetApiVersion data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryGetApiVersion)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetApiVersion? readQuery$GetApiVersion({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetApiVersion)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetApiVersion.fromJson(result);
  }
}

class Query$GetApiVersion$api {
  Query$GetApiVersion$api({
    required this.version,
    this.$__typename = 'Api',
  });

  factory Query$GetApiVersion$api.fromJson(Map<String, dynamic> json) {
    final l$version = json['version'];
    final l$$__typename = json['__typename'];
    return Query$GetApiVersion$api(
      version: (l$version as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String version;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$version = version;
    _resultData['version'] = l$version;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$version = version;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$version,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetApiVersion$api) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$version = version;
    final lOther$version = other.version;
    if (l$version != lOther$version) {
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

extension UtilityExtension$Query$GetApiVersion$api on Query$GetApiVersion$api {
  CopyWith$Query$GetApiVersion$api<Query$GetApiVersion$api> get copyWith =>
      CopyWith$Query$GetApiVersion$api(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetApiVersion$api<TRes> {
  factory CopyWith$Query$GetApiVersion$api(
    Query$GetApiVersion$api instance,
    TRes Function(Query$GetApiVersion$api) then,
  ) = _CopyWithImpl$Query$GetApiVersion$api;

  factory CopyWith$Query$GetApiVersion$api.stub(TRes res) =
      _CopyWithStubImpl$Query$GetApiVersion$api;

  TRes call({
    String? version,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetApiVersion$api<TRes>
    implements CopyWith$Query$GetApiVersion$api<TRes> {
  _CopyWithImpl$Query$GetApiVersion$api(
    this._instance,
    this._then,
  );

  final Query$GetApiVersion$api _instance;

  final TRes Function(Query$GetApiVersion$api) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? version = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetApiVersion$api(
        version: version == _undefined || version == null
            ? _instance.version
            : (version as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetApiVersion$api<TRes>
    implements CopyWith$Query$GetApiVersion$api<TRes> {
  _CopyWithStubImpl$Query$GetApiVersion$api(this._res);

  TRes _res;

  call({
    String? version,
    String? $__typename,
  }) =>
      _res;
}

class Query$GetApiJobs {
  Query$GetApiJobs({
    required this.jobs,
    this.$__typename = 'Query',
  });

  factory Query$GetApiJobs.fromJson(Map<String, dynamic> json) {
    final l$jobs = json['jobs'];
    final l$$__typename = json['__typename'];
    return Query$GetApiJobs(
      jobs: Query$GetApiJobs$jobs.fromJson((l$jobs as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetApiJobs$jobs jobs;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$jobs = jobs;
    _resultData['jobs'] = l$jobs.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$jobs = jobs;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$jobs,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetApiJobs) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$jobs = jobs;
    final lOther$jobs = other.jobs;
    if (l$jobs != lOther$jobs) {
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

extension UtilityExtension$Query$GetApiJobs on Query$GetApiJobs {
  CopyWith$Query$GetApiJobs<Query$GetApiJobs> get copyWith =>
      CopyWith$Query$GetApiJobs(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetApiJobs<TRes> {
  factory CopyWith$Query$GetApiJobs(
    Query$GetApiJobs instance,
    TRes Function(Query$GetApiJobs) then,
  ) = _CopyWithImpl$Query$GetApiJobs;

  factory CopyWith$Query$GetApiJobs.stub(TRes res) =
      _CopyWithStubImpl$Query$GetApiJobs;

  TRes call({
    Query$GetApiJobs$jobs? jobs,
    String? $__typename,
  });
  CopyWith$Query$GetApiJobs$jobs<TRes> get jobs;
}

class _CopyWithImpl$Query$GetApiJobs<TRes>
    implements CopyWith$Query$GetApiJobs<TRes> {
  _CopyWithImpl$Query$GetApiJobs(
    this._instance,
    this._then,
  );

  final Query$GetApiJobs _instance;

  final TRes Function(Query$GetApiJobs) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? jobs = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetApiJobs(
        jobs: jobs == _undefined || jobs == null
            ? _instance.jobs
            : (jobs as Query$GetApiJobs$jobs),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$GetApiJobs$jobs<TRes> get jobs {
    final local$jobs = _instance.jobs;
    return CopyWith$Query$GetApiJobs$jobs(local$jobs, (e) => call(jobs: e));
  }
}

class _CopyWithStubImpl$Query$GetApiJobs<TRes>
    implements CopyWith$Query$GetApiJobs<TRes> {
  _CopyWithStubImpl$Query$GetApiJobs(this._res);

  TRes _res;

  call({
    Query$GetApiJobs$jobs? jobs,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$GetApiJobs$jobs<TRes> get jobs =>
      CopyWith$Query$GetApiJobs$jobs.stub(_res);
}

const documentNodeQueryGetApiJobs = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetApiJobs'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'jobs'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'getJobs'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
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
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicApiJobsFields,
]);
Query$GetApiJobs _parserFn$Query$GetApiJobs(Map<String, dynamic> data) =>
    Query$GetApiJobs.fromJson(data);
typedef OnQueryComplete$Query$GetApiJobs = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetApiJobs?,
);

class Options$Query$GetApiJobs extends graphql.QueryOptions<Query$GetApiJobs> {
  Options$Query$GetApiJobs({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetApiJobs? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetApiJobs? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetApiJobs(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetApiJobs,
          parserFn: _parserFn$Query$GetApiJobs,
        );

  final OnQueryComplete$Query$GetApiJobs? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetApiJobs
    extends graphql.WatchQueryOptions<Query$GetApiJobs> {
  WatchOptions$Query$GetApiJobs({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetApiJobs? typedOptimisticResult,
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
          document: documentNodeQueryGetApiJobs,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetApiJobs,
        );
}

class FetchMoreOptions$Query$GetApiJobs extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetApiJobs({required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryGetApiJobs,
        );
}

extension ClientExtension$Query$GetApiJobs on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetApiJobs>> query$GetApiJobs(
          [Options$Query$GetApiJobs? options]) async =>
      await this.query(options ?? Options$Query$GetApiJobs());
  graphql.ObservableQuery<Query$GetApiJobs> watchQuery$GetApiJobs(
          [WatchOptions$Query$GetApiJobs? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetApiJobs());
  void writeQuery$GetApiJobs({
    required Query$GetApiJobs data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryGetApiJobs)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetApiJobs? readQuery$GetApiJobs({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryGetApiJobs)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetApiJobs.fromJson(result);
  }
}

class Query$GetApiJobs$jobs {
  Query$GetApiJobs$jobs({
    required this.getJobs,
    this.$__typename = 'Job',
  });

  factory Query$GetApiJobs$jobs.fromJson(Map<String, dynamic> json) {
    final l$getJobs = json['getJobs'];
    final l$$__typename = json['__typename'];
    return Query$GetApiJobs$jobs(
      getJobs: (l$getJobs as List<dynamic>)
          .map((e) =>
              Fragment$basicApiJobsFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$basicApiJobsFields> getJobs;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getJobs = getJobs;
    _resultData['getJobs'] = l$getJobs.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getJobs = getJobs;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$getJobs.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetApiJobs$jobs) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$getJobs = getJobs;
    final lOther$getJobs = other.getJobs;
    if (l$getJobs.length != lOther$getJobs.length) {
      return false;
    }
    for (int i = 0; i < l$getJobs.length; i++) {
      final l$getJobs$entry = l$getJobs[i];
      final lOther$getJobs$entry = lOther$getJobs[i];
      if (l$getJobs$entry != lOther$getJobs$entry) {
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

extension UtilityExtension$Query$GetApiJobs$jobs on Query$GetApiJobs$jobs {
  CopyWith$Query$GetApiJobs$jobs<Query$GetApiJobs$jobs> get copyWith =>
      CopyWith$Query$GetApiJobs$jobs(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetApiJobs$jobs<TRes> {
  factory CopyWith$Query$GetApiJobs$jobs(
    Query$GetApiJobs$jobs instance,
    TRes Function(Query$GetApiJobs$jobs) then,
  ) = _CopyWithImpl$Query$GetApiJobs$jobs;

  factory CopyWith$Query$GetApiJobs$jobs.stub(TRes res) =
      _CopyWithStubImpl$Query$GetApiJobs$jobs;

  TRes call({
    List<Fragment$basicApiJobsFields>? getJobs,
    String? $__typename,
  });
  TRes getJobs(
      Iterable<Fragment$basicApiJobsFields> Function(
              Iterable<
                  CopyWith$Fragment$basicApiJobsFields<
                      Fragment$basicApiJobsFields>>)
          _fn);
}

class _CopyWithImpl$Query$GetApiJobs$jobs<TRes>
    implements CopyWith$Query$GetApiJobs$jobs<TRes> {
  _CopyWithImpl$Query$GetApiJobs$jobs(
    this._instance,
    this._then,
  );

  final Query$GetApiJobs$jobs _instance;

  final TRes Function(Query$GetApiJobs$jobs) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getJobs = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetApiJobs$jobs(
        getJobs: getJobs == _undefined || getJobs == null
            ? _instance.getJobs
            : (getJobs as List<Fragment$basicApiJobsFields>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  TRes getJobs(
          Iterable<Fragment$basicApiJobsFields> Function(
                  Iterable<
                      CopyWith$Fragment$basicApiJobsFields<
                          Fragment$basicApiJobsFields>>)
              _fn) =>
      call(
          getJobs: _fn(
              _instance.getJobs.map((e) => CopyWith$Fragment$basicApiJobsFields(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$GetApiJobs$jobs<TRes>
    implements CopyWith$Query$GetApiJobs$jobs<TRes> {
  _CopyWithStubImpl$Query$GetApiJobs$jobs(this._res);

  TRes _res;

  call({
    List<Fragment$basicApiJobsFields>? getJobs,
    String? $__typename,
  }) =>
      _res;
  getJobs(_fn) => _res;
}

class Variables$Mutation$RemoveJob {
  factory Variables$Mutation$RemoveJob({required String jobId}) =>
      Variables$Mutation$RemoveJob._({
        r'jobId': jobId,
      });

  Variables$Mutation$RemoveJob._(this._$data);

  factory Variables$Mutation$RemoveJob.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$jobId = data['jobId'];
    result$data['jobId'] = (l$jobId as String);
    return Variables$Mutation$RemoveJob._(result$data);
  }

  Map<String, dynamic> _$data;

  String get jobId => (_$data['jobId'] as String);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$jobId = jobId;
    result$data['jobId'] = l$jobId;
    return result$data;
  }

  CopyWith$Variables$Mutation$RemoveJob<Variables$Mutation$RemoveJob>
      get copyWith => CopyWith$Variables$Mutation$RemoveJob(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$RemoveJob) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$jobId = jobId;
    final lOther$jobId = other.jobId;
    if (l$jobId != lOther$jobId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$jobId = jobId;
    return Object.hashAll([l$jobId]);
  }
}

abstract class CopyWith$Variables$Mutation$RemoveJob<TRes> {
  factory CopyWith$Variables$Mutation$RemoveJob(
    Variables$Mutation$RemoveJob instance,
    TRes Function(Variables$Mutation$RemoveJob) then,
  ) = _CopyWithImpl$Variables$Mutation$RemoveJob;

  factory CopyWith$Variables$Mutation$RemoveJob.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$RemoveJob;

  TRes call({String? jobId});
}

class _CopyWithImpl$Variables$Mutation$RemoveJob<TRes>
    implements CopyWith$Variables$Mutation$RemoveJob<TRes> {
  _CopyWithImpl$Variables$Mutation$RemoveJob(
    this._instance,
    this._then,
  );

  final Variables$Mutation$RemoveJob _instance;

  final TRes Function(Variables$Mutation$RemoveJob) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? jobId = _undefined}) =>
      _then(Variables$Mutation$RemoveJob._({
        ..._instance._$data,
        if (jobId != _undefined && jobId != null) 'jobId': (jobId as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$RemoveJob<TRes>
    implements CopyWith$Variables$Mutation$RemoveJob<TRes> {
  _CopyWithStubImpl$Variables$Mutation$RemoveJob(this._res);

  TRes _res;

  call({String? jobId}) => _res;
}

class Mutation$RemoveJob {
  Mutation$RemoveJob({
    required this.removeJob,
    this.$__typename = 'Mutation',
  });

  factory Mutation$RemoveJob.fromJson(Map<String, dynamic> json) {
    final l$removeJob = json['removeJob'];
    final l$$__typename = json['__typename'];
    return Mutation$RemoveJob(
      removeJob: Mutation$RemoveJob$removeJob.fromJson(
          (l$removeJob as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$RemoveJob$removeJob removeJob;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$removeJob = removeJob;
    _resultData['removeJob'] = l$removeJob.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$removeJob = removeJob;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$removeJob,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RemoveJob) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$removeJob = removeJob;
    final lOther$removeJob = other.removeJob;
    if (l$removeJob != lOther$removeJob) {
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

extension UtilityExtension$Mutation$RemoveJob on Mutation$RemoveJob {
  CopyWith$Mutation$RemoveJob<Mutation$RemoveJob> get copyWith =>
      CopyWith$Mutation$RemoveJob(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$RemoveJob<TRes> {
  factory CopyWith$Mutation$RemoveJob(
    Mutation$RemoveJob instance,
    TRes Function(Mutation$RemoveJob) then,
  ) = _CopyWithImpl$Mutation$RemoveJob;

  factory CopyWith$Mutation$RemoveJob.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RemoveJob;

  TRes call({
    Mutation$RemoveJob$removeJob? removeJob,
    String? $__typename,
  });
  CopyWith$Mutation$RemoveJob$removeJob<TRes> get removeJob;
}

class _CopyWithImpl$Mutation$RemoveJob<TRes>
    implements CopyWith$Mutation$RemoveJob<TRes> {
  _CopyWithImpl$Mutation$RemoveJob(
    this._instance,
    this._then,
  );

  final Mutation$RemoveJob _instance;

  final TRes Function(Mutation$RemoveJob) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? removeJob = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$RemoveJob(
        removeJob: removeJob == _undefined || removeJob == null
            ? _instance.removeJob
            : (removeJob as Mutation$RemoveJob$removeJob),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$RemoveJob$removeJob<TRes> get removeJob {
    final local$removeJob = _instance.removeJob;
    return CopyWith$Mutation$RemoveJob$removeJob(
        local$removeJob, (e) => call(removeJob: e));
  }
}

class _CopyWithStubImpl$Mutation$RemoveJob<TRes>
    implements CopyWith$Mutation$RemoveJob<TRes> {
  _CopyWithStubImpl$Mutation$RemoveJob(this._res);

  TRes _res;

  call({
    Mutation$RemoveJob$removeJob? removeJob,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$RemoveJob$removeJob<TRes> get removeJob =>
      CopyWith$Mutation$RemoveJob$removeJob.stub(_res);
}

const documentNodeMutationRemoveJob = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'RemoveJob'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'jobId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'removeJob'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'jobId'),
            value: VariableNode(name: NameNode(value: 'jobId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
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
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$RemoveJob _parserFn$Mutation$RemoveJob(Map<String, dynamic> data) =>
    Mutation$RemoveJob.fromJson(data);
typedef OnMutationCompleted$Mutation$RemoveJob = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$RemoveJob?,
);

class Options$Mutation$RemoveJob
    extends graphql.MutationOptions<Mutation$RemoveJob> {
  Options$Mutation$RemoveJob({
    String? operationName,
    required Variables$Mutation$RemoveJob variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RemoveJob? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$RemoveJob? onCompleted,
    graphql.OnMutationUpdate<Mutation$RemoveJob>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$RemoveJob(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationRemoveJob,
          parserFn: _parserFn$Mutation$RemoveJob,
        );

  final OnMutationCompleted$Mutation$RemoveJob? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$RemoveJob
    extends graphql.WatchQueryOptions<Mutation$RemoveJob> {
  WatchOptions$Mutation$RemoveJob({
    String? operationName,
    required Variables$Mutation$RemoveJob variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RemoveJob? typedOptimisticResult,
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
          document: documentNodeMutationRemoveJob,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$RemoveJob,
        );
}

extension ClientExtension$Mutation$RemoveJob on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RemoveJob>> mutate$RemoveJob(
          Options$Mutation$RemoveJob options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$RemoveJob> watchMutation$RemoveJob(
          WatchOptions$Mutation$RemoveJob options) =>
      this.watchMutation(options);
}

class Mutation$RemoveJob$removeJob
    implements Fragment$basicMutationReturnFields$$GenericMutationReturn {
  Mutation$RemoveJob$removeJob({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Mutation$RemoveJob$removeJob.fromJson(Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$RemoveJob$removeJob(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RemoveJob$removeJob) ||
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

extension UtilityExtension$Mutation$RemoveJob$removeJob
    on Mutation$RemoveJob$removeJob {
  CopyWith$Mutation$RemoveJob$removeJob<Mutation$RemoveJob$removeJob>
      get copyWith => CopyWith$Mutation$RemoveJob$removeJob(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$RemoveJob$removeJob<TRes> {
  factory CopyWith$Mutation$RemoveJob$removeJob(
    Mutation$RemoveJob$removeJob instance,
    TRes Function(Mutation$RemoveJob$removeJob) then,
  ) = _CopyWithImpl$Mutation$RemoveJob$removeJob;

  factory CopyWith$Mutation$RemoveJob$removeJob.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RemoveJob$removeJob;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$RemoveJob$removeJob<TRes>
    implements CopyWith$Mutation$RemoveJob$removeJob<TRes> {
  _CopyWithImpl$Mutation$RemoveJob$removeJob(
    this._instance,
    this._then,
  );

  final Mutation$RemoveJob$removeJob _instance;

  final TRes Function(Mutation$RemoveJob$removeJob) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$RemoveJob$removeJob(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$RemoveJob$removeJob<TRes>
    implements CopyWith$Mutation$RemoveJob$removeJob<TRes> {
  _CopyWithStubImpl$Mutation$RemoveJob$removeJob(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Mutation$RunSystemRebuild {
  Mutation$RunSystemRebuild({
    required this.runSystemRebuild,
    this.$__typename = 'Mutation',
  });

  factory Mutation$RunSystemRebuild.fromJson(Map<String, dynamic> json) {
    final l$runSystemRebuild = json['runSystemRebuild'];
    final l$$__typename = json['__typename'];
    return Mutation$RunSystemRebuild(
      runSystemRebuild: Mutation$RunSystemRebuild$runSystemRebuild.fromJson(
          (l$runSystemRebuild as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$RunSystemRebuild$runSystemRebuild runSystemRebuild;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$runSystemRebuild = runSystemRebuild;
    _resultData['runSystemRebuild'] = l$runSystemRebuild.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$runSystemRebuild = runSystemRebuild;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$runSystemRebuild,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RunSystemRebuild) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$runSystemRebuild = runSystemRebuild;
    final lOther$runSystemRebuild = other.runSystemRebuild;
    if (l$runSystemRebuild != lOther$runSystemRebuild) {
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

extension UtilityExtension$Mutation$RunSystemRebuild
    on Mutation$RunSystemRebuild {
  CopyWith$Mutation$RunSystemRebuild<Mutation$RunSystemRebuild> get copyWith =>
      CopyWith$Mutation$RunSystemRebuild(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$RunSystemRebuild<TRes> {
  factory CopyWith$Mutation$RunSystemRebuild(
    Mutation$RunSystemRebuild instance,
    TRes Function(Mutation$RunSystemRebuild) then,
  ) = _CopyWithImpl$Mutation$RunSystemRebuild;

  factory CopyWith$Mutation$RunSystemRebuild.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RunSystemRebuild;

  TRes call({
    Mutation$RunSystemRebuild$runSystemRebuild? runSystemRebuild,
    String? $__typename,
  });
  CopyWith$Mutation$RunSystemRebuild$runSystemRebuild<TRes>
      get runSystemRebuild;
}

class _CopyWithImpl$Mutation$RunSystemRebuild<TRes>
    implements CopyWith$Mutation$RunSystemRebuild<TRes> {
  _CopyWithImpl$Mutation$RunSystemRebuild(
    this._instance,
    this._then,
  );

  final Mutation$RunSystemRebuild _instance;

  final TRes Function(Mutation$RunSystemRebuild) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? runSystemRebuild = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$RunSystemRebuild(
        runSystemRebuild: runSystemRebuild == _undefined ||
                runSystemRebuild == null
            ? _instance.runSystemRebuild
            : (runSystemRebuild as Mutation$RunSystemRebuild$runSystemRebuild),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$RunSystemRebuild$runSystemRebuild<TRes>
      get runSystemRebuild {
    final local$runSystemRebuild = _instance.runSystemRebuild;
    return CopyWith$Mutation$RunSystemRebuild$runSystemRebuild(
        local$runSystemRebuild, (e) => call(runSystemRebuild: e));
  }
}

class _CopyWithStubImpl$Mutation$RunSystemRebuild<TRes>
    implements CopyWith$Mutation$RunSystemRebuild<TRes> {
  _CopyWithStubImpl$Mutation$RunSystemRebuild(this._res);

  TRes _res;

  call({
    Mutation$RunSystemRebuild$runSystemRebuild? runSystemRebuild,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$RunSystemRebuild$runSystemRebuild<TRes>
      get runSystemRebuild =>
          CopyWith$Mutation$RunSystemRebuild$runSystemRebuild.stub(_res);
}

const documentNodeMutationRunSystemRebuild = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'RunSystemRebuild'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'runSystemRebuild'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
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
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$RunSystemRebuild _parserFn$Mutation$RunSystemRebuild(
        Map<String, dynamic> data) =>
    Mutation$RunSystemRebuild.fromJson(data);
typedef OnMutationCompleted$Mutation$RunSystemRebuild = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$RunSystemRebuild?,
);

class Options$Mutation$RunSystemRebuild
    extends graphql.MutationOptions<Mutation$RunSystemRebuild> {
  Options$Mutation$RunSystemRebuild({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RunSystemRebuild? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$RunSystemRebuild? onCompleted,
    graphql.OnMutationUpdate<Mutation$RunSystemRebuild>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$RunSystemRebuild(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationRunSystemRebuild,
          parserFn: _parserFn$Mutation$RunSystemRebuild,
        );

  final OnMutationCompleted$Mutation$RunSystemRebuild? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$RunSystemRebuild
    extends graphql.WatchQueryOptions<Mutation$RunSystemRebuild> {
  WatchOptions$Mutation$RunSystemRebuild({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RunSystemRebuild? typedOptimisticResult,
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
          document: documentNodeMutationRunSystemRebuild,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$RunSystemRebuild,
        );
}

extension ClientExtension$Mutation$RunSystemRebuild on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RunSystemRebuild>>
      mutate$RunSystemRebuild(
              [Options$Mutation$RunSystemRebuild? options]) async =>
          await this.mutate(options ?? Options$Mutation$RunSystemRebuild());
  graphql.ObservableQuery<
      Mutation$RunSystemRebuild> watchMutation$RunSystemRebuild(
          [WatchOptions$Mutation$RunSystemRebuild? options]) =>
      this.watchMutation(options ?? WatchOptions$Mutation$RunSystemRebuild());
}

class Mutation$RunSystemRebuild$runSystemRebuild
    implements Fragment$basicMutationReturnFields$$GenericMutationReturn {
  Mutation$RunSystemRebuild$runSystemRebuild({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Mutation$RunSystemRebuild$runSystemRebuild.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$RunSystemRebuild$runSystemRebuild(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RunSystemRebuild$runSystemRebuild) ||
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

extension UtilityExtension$Mutation$RunSystemRebuild$runSystemRebuild
    on Mutation$RunSystemRebuild$runSystemRebuild {
  CopyWith$Mutation$RunSystemRebuild$runSystemRebuild<
          Mutation$RunSystemRebuild$runSystemRebuild>
      get copyWith => CopyWith$Mutation$RunSystemRebuild$runSystemRebuild(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$RunSystemRebuild$runSystemRebuild<TRes> {
  factory CopyWith$Mutation$RunSystemRebuild$runSystemRebuild(
    Mutation$RunSystemRebuild$runSystemRebuild instance,
    TRes Function(Mutation$RunSystemRebuild$runSystemRebuild) then,
  ) = _CopyWithImpl$Mutation$RunSystemRebuild$runSystemRebuild;

  factory CopyWith$Mutation$RunSystemRebuild$runSystemRebuild.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RunSystemRebuild$runSystemRebuild;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$RunSystemRebuild$runSystemRebuild<TRes>
    implements CopyWith$Mutation$RunSystemRebuild$runSystemRebuild<TRes> {
  _CopyWithImpl$Mutation$RunSystemRebuild$runSystemRebuild(
    this._instance,
    this._then,
  );

  final Mutation$RunSystemRebuild$runSystemRebuild _instance;

  final TRes Function(Mutation$RunSystemRebuild$runSystemRebuild) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$RunSystemRebuild$runSystemRebuild(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$RunSystemRebuild$runSystemRebuild<TRes>
    implements CopyWith$Mutation$RunSystemRebuild$runSystemRebuild<TRes> {
  _CopyWithStubImpl$Mutation$RunSystemRebuild$runSystemRebuild(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Mutation$RunSystemRollback {
  Mutation$RunSystemRollback({
    required this.runSystemRollback,
    this.$__typename = 'Mutation',
  });

  factory Mutation$RunSystemRollback.fromJson(Map<String, dynamic> json) {
    final l$runSystemRollback = json['runSystemRollback'];
    final l$$__typename = json['__typename'];
    return Mutation$RunSystemRollback(
      runSystemRollback: Mutation$RunSystemRollback$runSystemRollback.fromJson(
          (l$runSystemRollback as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$RunSystemRollback$runSystemRollback runSystemRollback;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$runSystemRollback = runSystemRollback;
    _resultData['runSystemRollback'] = l$runSystemRollback.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$runSystemRollback = runSystemRollback;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$runSystemRollback,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RunSystemRollback) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$runSystemRollback = runSystemRollback;
    final lOther$runSystemRollback = other.runSystemRollback;
    if (l$runSystemRollback != lOther$runSystemRollback) {
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

extension UtilityExtension$Mutation$RunSystemRollback
    on Mutation$RunSystemRollback {
  CopyWith$Mutation$RunSystemRollback<Mutation$RunSystemRollback>
      get copyWith => CopyWith$Mutation$RunSystemRollback(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$RunSystemRollback<TRes> {
  factory CopyWith$Mutation$RunSystemRollback(
    Mutation$RunSystemRollback instance,
    TRes Function(Mutation$RunSystemRollback) then,
  ) = _CopyWithImpl$Mutation$RunSystemRollback;

  factory CopyWith$Mutation$RunSystemRollback.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RunSystemRollback;

  TRes call({
    Mutation$RunSystemRollback$runSystemRollback? runSystemRollback,
    String? $__typename,
  });
  CopyWith$Mutation$RunSystemRollback$runSystemRollback<TRes>
      get runSystemRollback;
}

class _CopyWithImpl$Mutation$RunSystemRollback<TRes>
    implements CopyWith$Mutation$RunSystemRollback<TRes> {
  _CopyWithImpl$Mutation$RunSystemRollback(
    this._instance,
    this._then,
  );

  final Mutation$RunSystemRollback _instance;

  final TRes Function(Mutation$RunSystemRollback) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? runSystemRollback = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$RunSystemRollback(
        runSystemRollback:
            runSystemRollback == _undefined || runSystemRollback == null
                ? _instance.runSystemRollback
                : (runSystemRollback
                    as Mutation$RunSystemRollback$runSystemRollback),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$RunSystemRollback$runSystemRollback<TRes>
      get runSystemRollback {
    final local$runSystemRollback = _instance.runSystemRollback;
    return CopyWith$Mutation$RunSystemRollback$runSystemRollback(
        local$runSystemRollback, (e) => call(runSystemRollback: e));
  }
}

class _CopyWithStubImpl$Mutation$RunSystemRollback<TRes>
    implements CopyWith$Mutation$RunSystemRollback<TRes> {
  _CopyWithStubImpl$Mutation$RunSystemRollback(this._res);

  TRes _res;

  call({
    Mutation$RunSystemRollback$runSystemRollback? runSystemRollback,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$RunSystemRollback$runSystemRollback<TRes>
      get runSystemRollback =>
          CopyWith$Mutation$RunSystemRollback$runSystemRollback.stub(_res);
}

const documentNodeMutationRunSystemRollback = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'RunSystemRollback'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'runSystemRollback'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
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
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$RunSystemRollback _parserFn$Mutation$RunSystemRollback(
        Map<String, dynamic> data) =>
    Mutation$RunSystemRollback.fromJson(data);
typedef OnMutationCompleted$Mutation$RunSystemRollback = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$RunSystemRollback?,
);

class Options$Mutation$RunSystemRollback
    extends graphql.MutationOptions<Mutation$RunSystemRollback> {
  Options$Mutation$RunSystemRollback({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RunSystemRollback? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$RunSystemRollback? onCompleted,
    graphql.OnMutationUpdate<Mutation$RunSystemRollback>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$RunSystemRollback(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationRunSystemRollback,
          parserFn: _parserFn$Mutation$RunSystemRollback,
        );

  final OnMutationCompleted$Mutation$RunSystemRollback? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$RunSystemRollback
    extends graphql.WatchQueryOptions<Mutation$RunSystemRollback> {
  WatchOptions$Mutation$RunSystemRollback({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RunSystemRollback? typedOptimisticResult,
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
          document: documentNodeMutationRunSystemRollback,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$RunSystemRollback,
        );
}

extension ClientExtension$Mutation$RunSystemRollback on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RunSystemRollback>>
      mutate$RunSystemRollback(
              [Options$Mutation$RunSystemRollback? options]) async =>
          await this.mutate(options ?? Options$Mutation$RunSystemRollback());
  graphql.ObservableQuery<
      Mutation$RunSystemRollback> watchMutation$RunSystemRollback(
          [WatchOptions$Mutation$RunSystemRollback? options]) =>
      this.watchMutation(options ?? WatchOptions$Mutation$RunSystemRollback());
}

class Mutation$RunSystemRollback$runSystemRollback
    implements Fragment$basicMutationReturnFields$$GenericMutationReturn {
  Mutation$RunSystemRollback$runSystemRollback({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Mutation$RunSystemRollback$runSystemRollback.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$RunSystemRollback$runSystemRollback(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RunSystemRollback$runSystemRollback) ||
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

extension UtilityExtension$Mutation$RunSystemRollback$runSystemRollback
    on Mutation$RunSystemRollback$runSystemRollback {
  CopyWith$Mutation$RunSystemRollback$runSystemRollback<
          Mutation$RunSystemRollback$runSystemRollback>
      get copyWith => CopyWith$Mutation$RunSystemRollback$runSystemRollback(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$RunSystemRollback$runSystemRollback<TRes> {
  factory CopyWith$Mutation$RunSystemRollback$runSystemRollback(
    Mutation$RunSystemRollback$runSystemRollback instance,
    TRes Function(Mutation$RunSystemRollback$runSystemRollback) then,
  ) = _CopyWithImpl$Mutation$RunSystemRollback$runSystemRollback;

  factory CopyWith$Mutation$RunSystemRollback$runSystemRollback.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RunSystemRollback$runSystemRollback;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$RunSystemRollback$runSystemRollback<TRes>
    implements CopyWith$Mutation$RunSystemRollback$runSystemRollback<TRes> {
  _CopyWithImpl$Mutation$RunSystemRollback$runSystemRollback(
    this._instance,
    this._then,
  );

  final Mutation$RunSystemRollback$runSystemRollback _instance;

  final TRes Function(Mutation$RunSystemRollback$runSystemRollback) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$RunSystemRollback$runSystemRollback(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$RunSystemRollback$runSystemRollback<TRes>
    implements CopyWith$Mutation$RunSystemRollback$runSystemRollback<TRes> {
  _CopyWithStubImpl$Mutation$RunSystemRollback$runSystemRollback(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Mutation$RunSystemUpgrade {
  Mutation$RunSystemUpgrade({
    required this.runSystemUpgrade,
    this.$__typename = 'Mutation',
  });

  factory Mutation$RunSystemUpgrade.fromJson(Map<String, dynamic> json) {
    final l$runSystemUpgrade = json['runSystemUpgrade'];
    final l$$__typename = json['__typename'];
    return Mutation$RunSystemUpgrade(
      runSystemUpgrade: Mutation$RunSystemUpgrade$runSystemUpgrade.fromJson(
          (l$runSystemUpgrade as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$RunSystemUpgrade$runSystemUpgrade runSystemUpgrade;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$runSystemUpgrade = runSystemUpgrade;
    _resultData['runSystemUpgrade'] = l$runSystemUpgrade.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$runSystemUpgrade = runSystemUpgrade;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$runSystemUpgrade,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RunSystemUpgrade) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$runSystemUpgrade = runSystemUpgrade;
    final lOther$runSystemUpgrade = other.runSystemUpgrade;
    if (l$runSystemUpgrade != lOther$runSystemUpgrade) {
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

extension UtilityExtension$Mutation$RunSystemUpgrade
    on Mutation$RunSystemUpgrade {
  CopyWith$Mutation$RunSystemUpgrade<Mutation$RunSystemUpgrade> get copyWith =>
      CopyWith$Mutation$RunSystemUpgrade(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$RunSystemUpgrade<TRes> {
  factory CopyWith$Mutation$RunSystemUpgrade(
    Mutation$RunSystemUpgrade instance,
    TRes Function(Mutation$RunSystemUpgrade) then,
  ) = _CopyWithImpl$Mutation$RunSystemUpgrade;

  factory CopyWith$Mutation$RunSystemUpgrade.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RunSystemUpgrade;

  TRes call({
    Mutation$RunSystemUpgrade$runSystemUpgrade? runSystemUpgrade,
    String? $__typename,
  });
  CopyWith$Mutation$RunSystemUpgrade$runSystemUpgrade<TRes>
      get runSystemUpgrade;
}

class _CopyWithImpl$Mutation$RunSystemUpgrade<TRes>
    implements CopyWith$Mutation$RunSystemUpgrade<TRes> {
  _CopyWithImpl$Mutation$RunSystemUpgrade(
    this._instance,
    this._then,
  );

  final Mutation$RunSystemUpgrade _instance;

  final TRes Function(Mutation$RunSystemUpgrade) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? runSystemUpgrade = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$RunSystemUpgrade(
        runSystemUpgrade: runSystemUpgrade == _undefined ||
                runSystemUpgrade == null
            ? _instance.runSystemUpgrade
            : (runSystemUpgrade as Mutation$RunSystemUpgrade$runSystemUpgrade),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$RunSystemUpgrade$runSystemUpgrade<TRes>
      get runSystemUpgrade {
    final local$runSystemUpgrade = _instance.runSystemUpgrade;
    return CopyWith$Mutation$RunSystemUpgrade$runSystemUpgrade(
        local$runSystemUpgrade, (e) => call(runSystemUpgrade: e));
  }
}

class _CopyWithStubImpl$Mutation$RunSystemUpgrade<TRes>
    implements CopyWith$Mutation$RunSystemUpgrade<TRes> {
  _CopyWithStubImpl$Mutation$RunSystemUpgrade(this._res);

  TRes _res;

  call({
    Mutation$RunSystemUpgrade$runSystemUpgrade? runSystemUpgrade,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$RunSystemUpgrade$runSystemUpgrade<TRes>
      get runSystemUpgrade =>
          CopyWith$Mutation$RunSystemUpgrade$runSystemUpgrade.stub(_res);
}

const documentNodeMutationRunSystemUpgrade = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'RunSystemUpgrade'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'runSystemUpgrade'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
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
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$RunSystemUpgrade _parserFn$Mutation$RunSystemUpgrade(
        Map<String, dynamic> data) =>
    Mutation$RunSystemUpgrade.fromJson(data);
typedef OnMutationCompleted$Mutation$RunSystemUpgrade = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$RunSystemUpgrade?,
);

class Options$Mutation$RunSystemUpgrade
    extends graphql.MutationOptions<Mutation$RunSystemUpgrade> {
  Options$Mutation$RunSystemUpgrade({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RunSystemUpgrade? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$RunSystemUpgrade? onCompleted,
    graphql.OnMutationUpdate<Mutation$RunSystemUpgrade>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$RunSystemUpgrade(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationRunSystemUpgrade,
          parserFn: _parserFn$Mutation$RunSystemUpgrade,
        );

  final OnMutationCompleted$Mutation$RunSystemUpgrade? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$RunSystemUpgrade
    extends graphql.WatchQueryOptions<Mutation$RunSystemUpgrade> {
  WatchOptions$Mutation$RunSystemUpgrade({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RunSystemUpgrade? typedOptimisticResult,
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
          document: documentNodeMutationRunSystemUpgrade,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$RunSystemUpgrade,
        );
}

extension ClientExtension$Mutation$RunSystemUpgrade on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RunSystemUpgrade>>
      mutate$RunSystemUpgrade(
              [Options$Mutation$RunSystemUpgrade? options]) async =>
          await this.mutate(options ?? Options$Mutation$RunSystemUpgrade());
  graphql.ObservableQuery<
      Mutation$RunSystemUpgrade> watchMutation$RunSystemUpgrade(
          [WatchOptions$Mutation$RunSystemUpgrade? options]) =>
      this.watchMutation(options ?? WatchOptions$Mutation$RunSystemUpgrade());
}

class Mutation$RunSystemUpgrade$runSystemUpgrade
    implements Fragment$basicMutationReturnFields$$GenericMutationReturn {
  Mutation$RunSystemUpgrade$runSystemUpgrade({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Mutation$RunSystemUpgrade$runSystemUpgrade.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$RunSystemUpgrade$runSystemUpgrade(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RunSystemUpgrade$runSystemUpgrade) ||
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

extension UtilityExtension$Mutation$RunSystemUpgrade$runSystemUpgrade
    on Mutation$RunSystemUpgrade$runSystemUpgrade {
  CopyWith$Mutation$RunSystemUpgrade$runSystemUpgrade<
          Mutation$RunSystemUpgrade$runSystemUpgrade>
      get copyWith => CopyWith$Mutation$RunSystemUpgrade$runSystemUpgrade(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$RunSystemUpgrade$runSystemUpgrade<TRes> {
  factory CopyWith$Mutation$RunSystemUpgrade$runSystemUpgrade(
    Mutation$RunSystemUpgrade$runSystemUpgrade instance,
    TRes Function(Mutation$RunSystemUpgrade$runSystemUpgrade) then,
  ) = _CopyWithImpl$Mutation$RunSystemUpgrade$runSystemUpgrade;

  factory CopyWith$Mutation$RunSystemUpgrade$runSystemUpgrade.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RunSystemUpgrade$runSystemUpgrade;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$RunSystemUpgrade$runSystemUpgrade<TRes>
    implements CopyWith$Mutation$RunSystemUpgrade$runSystemUpgrade<TRes> {
  _CopyWithImpl$Mutation$RunSystemUpgrade$runSystemUpgrade(
    this._instance,
    this._then,
  );

  final Mutation$RunSystemUpgrade$runSystemUpgrade _instance;

  final TRes Function(Mutation$RunSystemUpgrade$runSystemUpgrade) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$RunSystemUpgrade$runSystemUpgrade(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$RunSystemUpgrade$runSystemUpgrade<TRes>
    implements CopyWith$Mutation$RunSystemUpgrade$runSystemUpgrade<TRes> {
  _CopyWithStubImpl$Mutation$RunSystemUpgrade$runSystemUpgrade(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Mutation$PullRepositoryChanges {
  Mutation$PullRepositoryChanges({
    required this.pullRepositoryChanges,
    this.$__typename = 'Mutation',
  });

  factory Mutation$PullRepositoryChanges.fromJson(Map<String, dynamic> json) {
    final l$pullRepositoryChanges = json['pullRepositoryChanges'];
    final l$$__typename = json['__typename'];
    return Mutation$PullRepositoryChanges(
      pullRepositoryChanges:
          Mutation$PullRepositoryChanges$pullRepositoryChanges.fromJson(
              (l$pullRepositoryChanges as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$PullRepositoryChanges$pullRepositoryChanges
      pullRepositoryChanges;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$pullRepositoryChanges = pullRepositoryChanges;
    _resultData['pullRepositoryChanges'] = l$pullRepositoryChanges.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$pullRepositoryChanges = pullRepositoryChanges;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$pullRepositoryChanges,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$PullRepositoryChanges) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$pullRepositoryChanges = pullRepositoryChanges;
    final lOther$pullRepositoryChanges = other.pullRepositoryChanges;
    if (l$pullRepositoryChanges != lOther$pullRepositoryChanges) {
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

extension UtilityExtension$Mutation$PullRepositoryChanges
    on Mutation$PullRepositoryChanges {
  CopyWith$Mutation$PullRepositoryChanges<Mutation$PullRepositoryChanges>
      get copyWith => CopyWith$Mutation$PullRepositoryChanges(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$PullRepositoryChanges<TRes> {
  factory CopyWith$Mutation$PullRepositoryChanges(
    Mutation$PullRepositoryChanges instance,
    TRes Function(Mutation$PullRepositoryChanges) then,
  ) = _CopyWithImpl$Mutation$PullRepositoryChanges;

  factory CopyWith$Mutation$PullRepositoryChanges.stub(TRes res) =
      _CopyWithStubImpl$Mutation$PullRepositoryChanges;

  TRes call({
    Mutation$PullRepositoryChanges$pullRepositoryChanges? pullRepositoryChanges,
    String? $__typename,
  });
  CopyWith$Mutation$PullRepositoryChanges$pullRepositoryChanges<TRes>
      get pullRepositoryChanges;
}

class _CopyWithImpl$Mutation$PullRepositoryChanges<TRes>
    implements CopyWith$Mutation$PullRepositoryChanges<TRes> {
  _CopyWithImpl$Mutation$PullRepositoryChanges(
    this._instance,
    this._then,
  );

  final Mutation$PullRepositoryChanges _instance;

  final TRes Function(Mutation$PullRepositoryChanges) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? pullRepositoryChanges = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$PullRepositoryChanges(
        pullRepositoryChanges:
            pullRepositoryChanges == _undefined || pullRepositoryChanges == null
                ? _instance.pullRepositoryChanges
                : (pullRepositoryChanges
                    as Mutation$PullRepositoryChanges$pullRepositoryChanges),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$PullRepositoryChanges$pullRepositoryChanges<TRes>
      get pullRepositoryChanges {
    final local$pullRepositoryChanges = _instance.pullRepositoryChanges;
    return CopyWith$Mutation$PullRepositoryChanges$pullRepositoryChanges(
        local$pullRepositoryChanges, (e) => call(pullRepositoryChanges: e));
  }
}

class _CopyWithStubImpl$Mutation$PullRepositoryChanges<TRes>
    implements CopyWith$Mutation$PullRepositoryChanges<TRes> {
  _CopyWithStubImpl$Mutation$PullRepositoryChanges(this._res);

  TRes _res;

  call({
    Mutation$PullRepositoryChanges$pullRepositoryChanges? pullRepositoryChanges,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$PullRepositoryChanges$pullRepositoryChanges<TRes>
      get pullRepositoryChanges =>
          CopyWith$Mutation$PullRepositoryChanges$pullRepositoryChanges.stub(
              _res);
}

const documentNodeMutationPullRepositoryChanges = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'PullRepositoryChanges'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'pullRepositoryChanges'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
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
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$PullRepositoryChanges _parserFn$Mutation$PullRepositoryChanges(
        Map<String, dynamic> data) =>
    Mutation$PullRepositoryChanges.fromJson(data);
typedef OnMutationCompleted$Mutation$PullRepositoryChanges = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$PullRepositoryChanges?,
);

class Options$Mutation$PullRepositoryChanges
    extends graphql.MutationOptions<Mutation$PullRepositoryChanges> {
  Options$Mutation$PullRepositoryChanges({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$PullRepositoryChanges? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$PullRepositoryChanges? onCompleted,
    graphql.OnMutationUpdate<Mutation$PullRepositoryChanges>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$PullRepositoryChanges(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationPullRepositoryChanges,
          parserFn: _parserFn$Mutation$PullRepositoryChanges,
        );

  final OnMutationCompleted$Mutation$PullRepositoryChanges?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$PullRepositoryChanges
    extends graphql.WatchQueryOptions<Mutation$PullRepositoryChanges> {
  WatchOptions$Mutation$PullRepositoryChanges({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$PullRepositoryChanges? typedOptimisticResult,
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
          document: documentNodeMutationPullRepositoryChanges,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$PullRepositoryChanges,
        );
}

extension ClientExtension$Mutation$PullRepositoryChanges
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$PullRepositoryChanges>>
      mutate$PullRepositoryChanges(
              [Options$Mutation$PullRepositoryChanges? options]) async =>
          await this
              .mutate(options ?? Options$Mutation$PullRepositoryChanges());
  graphql.ObservableQuery<Mutation$PullRepositoryChanges>
      watchMutation$PullRepositoryChanges(
              [WatchOptions$Mutation$PullRepositoryChanges? options]) =>
          this.watchMutation(
              options ?? WatchOptions$Mutation$PullRepositoryChanges());
}

class Mutation$PullRepositoryChanges$pullRepositoryChanges
    implements Fragment$basicMutationReturnFields$$GenericMutationReturn {
  Mutation$PullRepositoryChanges$pullRepositoryChanges({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Mutation$PullRepositoryChanges$pullRepositoryChanges.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$PullRepositoryChanges$pullRepositoryChanges(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$PullRepositoryChanges$pullRepositoryChanges) ||
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

extension UtilityExtension$Mutation$PullRepositoryChanges$pullRepositoryChanges
    on Mutation$PullRepositoryChanges$pullRepositoryChanges {
  CopyWith$Mutation$PullRepositoryChanges$pullRepositoryChanges<
          Mutation$PullRepositoryChanges$pullRepositoryChanges>
      get copyWith =>
          CopyWith$Mutation$PullRepositoryChanges$pullRepositoryChanges(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$PullRepositoryChanges$pullRepositoryChanges<
    TRes> {
  factory CopyWith$Mutation$PullRepositoryChanges$pullRepositoryChanges(
    Mutation$PullRepositoryChanges$pullRepositoryChanges instance,
    TRes Function(Mutation$PullRepositoryChanges$pullRepositoryChanges) then,
  ) = _CopyWithImpl$Mutation$PullRepositoryChanges$pullRepositoryChanges;

  factory CopyWith$Mutation$PullRepositoryChanges$pullRepositoryChanges.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$PullRepositoryChanges$pullRepositoryChanges;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$PullRepositoryChanges$pullRepositoryChanges<TRes>
    implements
        CopyWith$Mutation$PullRepositoryChanges$pullRepositoryChanges<TRes> {
  _CopyWithImpl$Mutation$PullRepositoryChanges$pullRepositoryChanges(
    this._instance,
    this._then,
  );

  final Mutation$PullRepositoryChanges$pullRepositoryChanges _instance;

  final TRes Function(Mutation$PullRepositoryChanges$pullRepositoryChanges)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$PullRepositoryChanges$pullRepositoryChanges(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$PullRepositoryChanges$pullRepositoryChanges<
        TRes>
    implements
        CopyWith$Mutation$PullRepositoryChanges$pullRepositoryChanges<TRes> {
  _CopyWithStubImpl$Mutation$PullRepositoryChanges$pullRepositoryChanges(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Mutation$RebootSystem {
  Mutation$RebootSystem({
    required this.rebootSystem,
    this.$__typename = 'Mutation',
  });

  factory Mutation$RebootSystem.fromJson(Map<String, dynamic> json) {
    final l$rebootSystem = json['rebootSystem'];
    final l$$__typename = json['__typename'];
    return Mutation$RebootSystem(
      rebootSystem: Mutation$RebootSystem$rebootSystem.fromJson(
          (l$rebootSystem as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$RebootSystem$rebootSystem rebootSystem;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$rebootSystem = rebootSystem;
    _resultData['rebootSystem'] = l$rebootSystem.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$rebootSystem = rebootSystem;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$rebootSystem,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RebootSystem) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$rebootSystem = rebootSystem;
    final lOther$rebootSystem = other.rebootSystem;
    if (l$rebootSystem != lOther$rebootSystem) {
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

extension UtilityExtension$Mutation$RebootSystem on Mutation$RebootSystem {
  CopyWith$Mutation$RebootSystem<Mutation$RebootSystem> get copyWith =>
      CopyWith$Mutation$RebootSystem(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$RebootSystem<TRes> {
  factory CopyWith$Mutation$RebootSystem(
    Mutation$RebootSystem instance,
    TRes Function(Mutation$RebootSystem) then,
  ) = _CopyWithImpl$Mutation$RebootSystem;

  factory CopyWith$Mutation$RebootSystem.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RebootSystem;

  TRes call({
    Mutation$RebootSystem$rebootSystem? rebootSystem,
    String? $__typename,
  });
  CopyWith$Mutation$RebootSystem$rebootSystem<TRes> get rebootSystem;
}

class _CopyWithImpl$Mutation$RebootSystem<TRes>
    implements CopyWith$Mutation$RebootSystem<TRes> {
  _CopyWithImpl$Mutation$RebootSystem(
    this._instance,
    this._then,
  );

  final Mutation$RebootSystem _instance;

  final TRes Function(Mutation$RebootSystem) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? rebootSystem = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$RebootSystem(
        rebootSystem: rebootSystem == _undefined || rebootSystem == null
            ? _instance.rebootSystem
            : (rebootSystem as Mutation$RebootSystem$rebootSystem),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$RebootSystem$rebootSystem<TRes> get rebootSystem {
    final local$rebootSystem = _instance.rebootSystem;
    return CopyWith$Mutation$RebootSystem$rebootSystem(
        local$rebootSystem, (e) => call(rebootSystem: e));
  }
}

class _CopyWithStubImpl$Mutation$RebootSystem<TRes>
    implements CopyWith$Mutation$RebootSystem<TRes> {
  _CopyWithStubImpl$Mutation$RebootSystem(this._res);

  TRes _res;

  call({
    Mutation$RebootSystem$rebootSystem? rebootSystem,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$RebootSystem$rebootSystem<TRes> get rebootSystem =>
      CopyWith$Mutation$RebootSystem$rebootSystem.stub(_res);
}

const documentNodeMutationRebootSystem = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'RebootSystem'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'rebootSystem'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
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
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$RebootSystem _parserFn$Mutation$RebootSystem(
        Map<String, dynamic> data) =>
    Mutation$RebootSystem.fromJson(data);
typedef OnMutationCompleted$Mutation$RebootSystem = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$RebootSystem?,
);

class Options$Mutation$RebootSystem
    extends graphql.MutationOptions<Mutation$RebootSystem> {
  Options$Mutation$RebootSystem({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RebootSystem? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$RebootSystem? onCompleted,
    graphql.OnMutationUpdate<Mutation$RebootSystem>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$RebootSystem(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationRebootSystem,
          parserFn: _parserFn$Mutation$RebootSystem,
        );

  final OnMutationCompleted$Mutation$RebootSystem? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$RebootSystem
    extends graphql.WatchQueryOptions<Mutation$RebootSystem> {
  WatchOptions$Mutation$RebootSystem({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RebootSystem? typedOptimisticResult,
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
          document: documentNodeMutationRebootSystem,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$RebootSystem,
        );
}

extension ClientExtension$Mutation$RebootSystem on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RebootSystem>> mutate$RebootSystem(
          [Options$Mutation$RebootSystem? options]) async =>
      await this.mutate(options ?? Options$Mutation$RebootSystem());
  graphql.ObservableQuery<Mutation$RebootSystem> watchMutation$RebootSystem(
          [WatchOptions$Mutation$RebootSystem? options]) =>
      this.watchMutation(options ?? WatchOptions$Mutation$RebootSystem());
}

class Mutation$RebootSystem$rebootSystem
    implements Fragment$basicMutationReturnFields$$GenericMutationReturn {
  Mutation$RebootSystem$rebootSystem({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Mutation$RebootSystem$rebootSystem.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$RebootSystem$rebootSystem(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RebootSystem$rebootSystem) ||
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

extension UtilityExtension$Mutation$RebootSystem$rebootSystem
    on Mutation$RebootSystem$rebootSystem {
  CopyWith$Mutation$RebootSystem$rebootSystem<
          Mutation$RebootSystem$rebootSystem>
      get copyWith => CopyWith$Mutation$RebootSystem$rebootSystem(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$RebootSystem$rebootSystem<TRes> {
  factory CopyWith$Mutation$RebootSystem$rebootSystem(
    Mutation$RebootSystem$rebootSystem instance,
    TRes Function(Mutation$RebootSystem$rebootSystem) then,
  ) = _CopyWithImpl$Mutation$RebootSystem$rebootSystem;

  factory CopyWith$Mutation$RebootSystem$rebootSystem.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RebootSystem$rebootSystem;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$RebootSystem$rebootSystem<TRes>
    implements CopyWith$Mutation$RebootSystem$rebootSystem<TRes> {
  _CopyWithImpl$Mutation$RebootSystem$rebootSystem(
    this._instance,
    this._then,
  );

  final Mutation$RebootSystem$rebootSystem _instance;

  final TRes Function(Mutation$RebootSystem$rebootSystem) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$RebootSystem$rebootSystem(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$RebootSystem$rebootSystem<TRes>
    implements CopyWith$Mutation$RebootSystem$rebootSystem<TRes> {
  _CopyWithStubImpl$Mutation$RebootSystem$rebootSystem(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Query$SystemServerProvider {
  Query$SystemServerProvider({
    required this.system,
    this.$__typename = 'Query',
  });

  factory Query$SystemServerProvider.fromJson(Map<String, dynamic> json) {
    final l$system = json['system'];
    final l$$__typename = json['__typename'];
    return Query$SystemServerProvider(
      system: Query$SystemServerProvider$system.fromJson(
          (l$system as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$SystemServerProvider$system system;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$system = system;
    _resultData['system'] = l$system.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$system = system;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$system,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$SystemServerProvider) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$system = system;
    final lOther$system = other.system;
    if (l$system != lOther$system) {
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

extension UtilityExtension$Query$SystemServerProvider
    on Query$SystemServerProvider {
  CopyWith$Query$SystemServerProvider<Query$SystemServerProvider>
      get copyWith => CopyWith$Query$SystemServerProvider(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$SystemServerProvider<TRes> {
  factory CopyWith$Query$SystemServerProvider(
    Query$SystemServerProvider instance,
    TRes Function(Query$SystemServerProvider) then,
  ) = _CopyWithImpl$Query$SystemServerProvider;

  factory CopyWith$Query$SystemServerProvider.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemServerProvider;

  TRes call({
    Query$SystemServerProvider$system? system,
    String? $__typename,
  });
  CopyWith$Query$SystemServerProvider$system<TRes> get system;
}

class _CopyWithImpl$Query$SystemServerProvider<TRes>
    implements CopyWith$Query$SystemServerProvider<TRes> {
  _CopyWithImpl$Query$SystemServerProvider(
    this._instance,
    this._then,
  );

  final Query$SystemServerProvider _instance;

  final TRes Function(Query$SystemServerProvider) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? system = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$SystemServerProvider(
        system: system == _undefined || system == null
            ? _instance.system
            : (system as Query$SystemServerProvider$system),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$SystemServerProvider$system<TRes> get system {
    final local$system = _instance.system;
    return CopyWith$Query$SystemServerProvider$system(
        local$system, (e) => call(system: e));
  }
}

class _CopyWithStubImpl$Query$SystemServerProvider<TRes>
    implements CopyWith$Query$SystemServerProvider<TRes> {
  _CopyWithStubImpl$Query$SystemServerProvider(this._res);

  TRes _res;

  call({
    Query$SystemServerProvider$system? system,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$SystemServerProvider$system<TRes> get system =>
      CopyWith$Query$SystemServerProvider$system.stub(_res);
}

const documentNodeQuerySystemServerProvider = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'SystemServerProvider'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'system'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'provider'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'provider'),
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
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$SystemServerProvider _parserFn$Query$SystemServerProvider(
        Map<String, dynamic> data) =>
    Query$SystemServerProvider.fromJson(data);
typedef OnQueryComplete$Query$SystemServerProvider = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$SystemServerProvider?,
);

class Options$Query$SystemServerProvider
    extends graphql.QueryOptions<Query$SystemServerProvider> {
  Options$Query$SystemServerProvider({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$SystemServerProvider? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$SystemServerProvider? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null
                        ? null
                        : _parserFn$Query$SystemServerProvider(data),
                  ),
          onError: onError,
          document: documentNodeQuerySystemServerProvider,
          parserFn: _parserFn$Query$SystemServerProvider,
        );

  final OnQueryComplete$Query$SystemServerProvider? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$SystemServerProvider
    extends graphql.WatchQueryOptions<Query$SystemServerProvider> {
  WatchOptions$Query$SystemServerProvider({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$SystemServerProvider? typedOptimisticResult,
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
          document: documentNodeQuerySystemServerProvider,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$SystemServerProvider,
        );
}

class FetchMoreOptions$Query$SystemServerProvider
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$SystemServerProvider(
      {required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQuerySystemServerProvider,
        );
}

extension ClientExtension$Query$SystemServerProvider on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$SystemServerProvider>>
      query$SystemServerProvider(
              [Options$Query$SystemServerProvider? options]) async =>
          await this.query(options ?? Options$Query$SystemServerProvider());
  graphql.ObservableQuery<Query$SystemServerProvider>
      watchQuery$SystemServerProvider(
              [WatchOptions$Query$SystemServerProvider? options]) =>
          this.watchQuery(options ?? WatchOptions$Query$SystemServerProvider());
  void writeQuery$SystemServerProvider({
    required Query$SystemServerProvider data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation: graphql.Operation(
                document: documentNodeQuerySystemServerProvider)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$SystemServerProvider? readQuery$SystemServerProvider(
      {bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation: graphql.Operation(
              document: documentNodeQuerySystemServerProvider)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$SystemServerProvider.fromJson(result);
  }
}

class Query$SystemServerProvider$system {
  Query$SystemServerProvider$system({
    required this.provider,
    this.$__typename = 'System',
  });

  factory Query$SystemServerProvider$system.fromJson(
      Map<String, dynamic> json) {
    final l$provider = json['provider'];
    final l$$__typename = json['__typename'];
    return Query$SystemServerProvider$system(
      provider: Query$SystemServerProvider$system$provider.fromJson(
          (l$provider as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$SystemServerProvider$system$provider provider;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$provider = provider;
    _resultData['provider'] = l$provider.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$provider = provider;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$provider,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$SystemServerProvider$system) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$provider = provider;
    final lOther$provider = other.provider;
    if (l$provider != lOther$provider) {
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

extension UtilityExtension$Query$SystemServerProvider$system
    on Query$SystemServerProvider$system {
  CopyWith$Query$SystemServerProvider$system<Query$SystemServerProvider$system>
      get copyWith => CopyWith$Query$SystemServerProvider$system(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$SystemServerProvider$system<TRes> {
  factory CopyWith$Query$SystemServerProvider$system(
    Query$SystemServerProvider$system instance,
    TRes Function(Query$SystemServerProvider$system) then,
  ) = _CopyWithImpl$Query$SystemServerProvider$system;

  factory CopyWith$Query$SystemServerProvider$system.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemServerProvider$system;

  TRes call({
    Query$SystemServerProvider$system$provider? provider,
    String? $__typename,
  });
  CopyWith$Query$SystemServerProvider$system$provider<TRes> get provider;
}

class _CopyWithImpl$Query$SystemServerProvider$system<TRes>
    implements CopyWith$Query$SystemServerProvider$system<TRes> {
  _CopyWithImpl$Query$SystemServerProvider$system(
    this._instance,
    this._then,
  );

  final Query$SystemServerProvider$system _instance;

  final TRes Function(Query$SystemServerProvider$system) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? provider = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$SystemServerProvider$system(
        provider: provider == _undefined || provider == null
            ? _instance.provider
            : (provider as Query$SystemServerProvider$system$provider),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$SystemServerProvider$system$provider<TRes> get provider {
    final local$provider = _instance.provider;
    return CopyWith$Query$SystemServerProvider$system$provider(
        local$provider, (e) => call(provider: e));
  }
}

class _CopyWithStubImpl$Query$SystemServerProvider$system<TRes>
    implements CopyWith$Query$SystemServerProvider$system<TRes> {
  _CopyWithStubImpl$Query$SystemServerProvider$system(this._res);

  TRes _res;

  call({
    Query$SystemServerProvider$system$provider? provider,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$SystemServerProvider$system$provider<TRes> get provider =>
      CopyWith$Query$SystemServerProvider$system$provider.stub(_res);
}

class Query$SystemServerProvider$system$provider {
  Query$SystemServerProvider$system$provider({
    required this.provider,
    this.$__typename = 'SystemProviderInfo',
  });

  factory Query$SystemServerProvider$system$provider.fromJson(
      Map<String, dynamic> json) {
    final l$provider = json['provider'];
    final l$$__typename = json['__typename'];
    return Query$SystemServerProvider$system$provider(
      provider: fromJson$Enum$ServerProvider((l$provider as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final Enum$ServerProvider provider;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$provider = provider;
    _resultData['provider'] = toJson$Enum$ServerProvider(l$provider);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$provider = provider;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$provider,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$SystemServerProvider$system$provider) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$provider = provider;
    final lOther$provider = other.provider;
    if (l$provider != lOther$provider) {
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

extension UtilityExtension$Query$SystemServerProvider$system$provider
    on Query$SystemServerProvider$system$provider {
  CopyWith$Query$SystemServerProvider$system$provider<
          Query$SystemServerProvider$system$provider>
      get copyWith => CopyWith$Query$SystemServerProvider$system$provider(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$SystemServerProvider$system$provider<TRes> {
  factory CopyWith$Query$SystemServerProvider$system$provider(
    Query$SystemServerProvider$system$provider instance,
    TRes Function(Query$SystemServerProvider$system$provider) then,
  ) = _CopyWithImpl$Query$SystemServerProvider$system$provider;

  factory CopyWith$Query$SystemServerProvider$system$provider.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemServerProvider$system$provider;

  TRes call({
    Enum$ServerProvider? provider,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$SystemServerProvider$system$provider<TRes>
    implements CopyWith$Query$SystemServerProvider$system$provider<TRes> {
  _CopyWithImpl$Query$SystemServerProvider$system$provider(
    this._instance,
    this._then,
  );

  final Query$SystemServerProvider$system$provider _instance;

  final TRes Function(Query$SystemServerProvider$system$provider) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? provider = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$SystemServerProvider$system$provider(
        provider: provider == _undefined || provider == null
            ? _instance.provider
            : (provider as Enum$ServerProvider),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$SystemServerProvider$system$provider<TRes>
    implements CopyWith$Query$SystemServerProvider$system$provider<TRes> {
  _CopyWithStubImpl$Query$SystemServerProvider$system$provider(this._res);

  TRes _res;

  call({
    Enum$ServerProvider? provider,
    String? $__typename,
  }) =>
      _res;
}

class Query$SystemDnsProvider {
  Query$SystemDnsProvider({
    required this.system,
    this.$__typename = 'Query',
  });

  factory Query$SystemDnsProvider.fromJson(Map<String, dynamic> json) {
    final l$system = json['system'];
    final l$$__typename = json['__typename'];
    return Query$SystemDnsProvider(
      system: Query$SystemDnsProvider$system.fromJson(
          (l$system as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$SystemDnsProvider$system system;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$system = system;
    _resultData['system'] = l$system.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$system = system;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$system,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$SystemDnsProvider) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$system = system;
    final lOther$system = other.system;
    if (l$system != lOther$system) {
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

extension UtilityExtension$Query$SystemDnsProvider on Query$SystemDnsProvider {
  CopyWith$Query$SystemDnsProvider<Query$SystemDnsProvider> get copyWith =>
      CopyWith$Query$SystemDnsProvider(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$SystemDnsProvider<TRes> {
  factory CopyWith$Query$SystemDnsProvider(
    Query$SystemDnsProvider instance,
    TRes Function(Query$SystemDnsProvider) then,
  ) = _CopyWithImpl$Query$SystemDnsProvider;

  factory CopyWith$Query$SystemDnsProvider.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemDnsProvider;

  TRes call({
    Query$SystemDnsProvider$system? system,
    String? $__typename,
  });
  CopyWith$Query$SystemDnsProvider$system<TRes> get system;
}

class _CopyWithImpl$Query$SystemDnsProvider<TRes>
    implements CopyWith$Query$SystemDnsProvider<TRes> {
  _CopyWithImpl$Query$SystemDnsProvider(
    this._instance,
    this._then,
  );

  final Query$SystemDnsProvider _instance;

  final TRes Function(Query$SystemDnsProvider) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? system = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$SystemDnsProvider(
        system: system == _undefined || system == null
            ? _instance.system
            : (system as Query$SystemDnsProvider$system),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$SystemDnsProvider$system<TRes> get system {
    final local$system = _instance.system;
    return CopyWith$Query$SystemDnsProvider$system(
        local$system, (e) => call(system: e));
  }
}

class _CopyWithStubImpl$Query$SystemDnsProvider<TRes>
    implements CopyWith$Query$SystemDnsProvider<TRes> {
  _CopyWithStubImpl$Query$SystemDnsProvider(this._res);

  TRes _res;

  call({
    Query$SystemDnsProvider$system? system,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$SystemDnsProvider$system<TRes> get system =>
      CopyWith$Query$SystemDnsProvider$system.stub(_res);
}

const documentNodeQuerySystemDnsProvider = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'SystemDnsProvider'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'system'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'domainInfo'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'provider'),
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
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$SystemDnsProvider _parserFn$Query$SystemDnsProvider(
        Map<String, dynamic> data) =>
    Query$SystemDnsProvider.fromJson(data);
typedef OnQueryComplete$Query$SystemDnsProvider = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$SystemDnsProvider?,
);

class Options$Query$SystemDnsProvider
    extends graphql.QueryOptions<Query$SystemDnsProvider> {
  Options$Query$SystemDnsProvider({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$SystemDnsProvider? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$SystemDnsProvider? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null
                        ? null
                        : _parserFn$Query$SystemDnsProvider(data),
                  ),
          onError: onError,
          document: documentNodeQuerySystemDnsProvider,
          parserFn: _parserFn$Query$SystemDnsProvider,
        );

  final OnQueryComplete$Query$SystemDnsProvider? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$SystemDnsProvider
    extends graphql.WatchQueryOptions<Query$SystemDnsProvider> {
  WatchOptions$Query$SystemDnsProvider({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$SystemDnsProvider? typedOptimisticResult,
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
          document: documentNodeQuerySystemDnsProvider,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$SystemDnsProvider,
        );
}

class FetchMoreOptions$Query$SystemDnsProvider
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$SystemDnsProvider(
      {required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQuerySystemDnsProvider,
        );
}

extension ClientExtension$Query$SystemDnsProvider on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$SystemDnsProvider>> query$SystemDnsProvider(
          [Options$Query$SystemDnsProvider? options]) async =>
      await this.query(options ?? Options$Query$SystemDnsProvider());
  graphql.ObservableQuery<Query$SystemDnsProvider> watchQuery$SystemDnsProvider(
          [WatchOptions$Query$SystemDnsProvider? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$SystemDnsProvider());
  void writeQuery$SystemDnsProvider({
    required Query$SystemDnsProvider data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation: graphql.Operation(
                document: documentNodeQuerySystemDnsProvider)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$SystemDnsProvider? readQuery$SystemDnsProvider(
      {bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQuerySystemDnsProvider)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$SystemDnsProvider.fromJson(result);
  }
}

class Query$SystemDnsProvider$system {
  Query$SystemDnsProvider$system({
    required this.domainInfo,
    this.$__typename = 'System',
  });

  factory Query$SystemDnsProvider$system.fromJson(Map<String, dynamic> json) {
    final l$domainInfo = json['domainInfo'];
    final l$$__typename = json['__typename'];
    return Query$SystemDnsProvider$system(
      domainInfo: Query$SystemDnsProvider$system$domainInfo.fromJson(
          (l$domainInfo as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$SystemDnsProvider$system$domainInfo domainInfo;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$domainInfo = domainInfo;
    _resultData['domainInfo'] = l$domainInfo.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$domainInfo = domainInfo;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$domainInfo,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$SystemDnsProvider$system) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$domainInfo = domainInfo;
    final lOther$domainInfo = other.domainInfo;
    if (l$domainInfo != lOther$domainInfo) {
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

extension UtilityExtension$Query$SystemDnsProvider$system
    on Query$SystemDnsProvider$system {
  CopyWith$Query$SystemDnsProvider$system<Query$SystemDnsProvider$system>
      get copyWith => CopyWith$Query$SystemDnsProvider$system(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$SystemDnsProvider$system<TRes> {
  factory CopyWith$Query$SystemDnsProvider$system(
    Query$SystemDnsProvider$system instance,
    TRes Function(Query$SystemDnsProvider$system) then,
  ) = _CopyWithImpl$Query$SystemDnsProvider$system;

  factory CopyWith$Query$SystemDnsProvider$system.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemDnsProvider$system;

  TRes call({
    Query$SystemDnsProvider$system$domainInfo? domainInfo,
    String? $__typename,
  });
  CopyWith$Query$SystemDnsProvider$system$domainInfo<TRes> get domainInfo;
}

class _CopyWithImpl$Query$SystemDnsProvider$system<TRes>
    implements CopyWith$Query$SystemDnsProvider$system<TRes> {
  _CopyWithImpl$Query$SystemDnsProvider$system(
    this._instance,
    this._then,
  );

  final Query$SystemDnsProvider$system _instance;

  final TRes Function(Query$SystemDnsProvider$system) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? domainInfo = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$SystemDnsProvider$system(
        domainInfo: domainInfo == _undefined || domainInfo == null
            ? _instance.domainInfo
            : (domainInfo as Query$SystemDnsProvider$system$domainInfo),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$SystemDnsProvider$system$domainInfo<TRes> get domainInfo {
    final local$domainInfo = _instance.domainInfo;
    return CopyWith$Query$SystemDnsProvider$system$domainInfo(
        local$domainInfo, (e) => call(domainInfo: e));
  }
}

class _CopyWithStubImpl$Query$SystemDnsProvider$system<TRes>
    implements CopyWith$Query$SystemDnsProvider$system<TRes> {
  _CopyWithStubImpl$Query$SystemDnsProvider$system(this._res);

  TRes _res;

  call({
    Query$SystemDnsProvider$system$domainInfo? domainInfo,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$SystemDnsProvider$system$domainInfo<TRes> get domainInfo =>
      CopyWith$Query$SystemDnsProvider$system$domainInfo.stub(_res);
}

class Query$SystemDnsProvider$system$domainInfo {
  Query$SystemDnsProvider$system$domainInfo({
    required this.provider,
    this.$__typename = 'SystemDomainInfo',
  });

  factory Query$SystemDnsProvider$system$domainInfo.fromJson(
      Map<String, dynamic> json) {
    final l$provider = json['provider'];
    final l$$__typename = json['__typename'];
    return Query$SystemDnsProvider$system$domainInfo(
      provider: fromJson$Enum$DnsProvider((l$provider as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final Enum$DnsProvider provider;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$provider = provider;
    _resultData['provider'] = toJson$Enum$DnsProvider(l$provider);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$provider = provider;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$provider,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$SystemDnsProvider$system$domainInfo) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$provider = provider;
    final lOther$provider = other.provider;
    if (l$provider != lOther$provider) {
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

extension UtilityExtension$Query$SystemDnsProvider$system$domainInfo
    on Query$SystemDnsProvider$system$domainInfo {
  CopyWith$Query$SystemDnsProvider$system$domainInfo<
          Query$SystemDnsProvider$system$domainInfo>
      get copyWith => CopyWith$Query$SystemDnsProvider$system$domainInfo(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$SystemDnsProvider$system$domainInfo<TRes> {
  factory CopyWith$Query$SystemDnsProvider$system$domainInfo(
    Query$SystemDnsProvider$system$domainInfo instance,
    TRes Function(Query$SystemDnsProvider$system$domainInfo) then,
  ) = _CopyWithImpl$Query$SystemDnsProvider$system$domainInfo;

  factory CopyWith$Query$SystemDnsProvider$system$domainInfo.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemDnsProvider$system$domainInfo;

  TRes call({
    Enum$DnsProvider? provider,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$SystemDnsProvider$system$domainInfo<TRes>
    implements CopyWith$Query$SystemDnsProvider$system$domainInfo<TRes> {
  _CopyWithImpl$Query$SystemDnsProvider$system$domainInfo(
    this._instance,
    this._then,
  );

  final Query$SystemDnsProvider$system$domainInfo _instance;

  final TRes Function(Query$SystemDnsProvider$system$domainInfo) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? provider = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$SystemDnsProvider$system$domainInfo(
        provider: provider == _undefined || provider == null
            ? _instance.provider
            : (provider as Enum$DnsProvider),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$SystemDnsProvider$system$domainInfo<TRes>
    implements CopyWith$Query$SystemDnsProvider$system$domainInfo<TRes> {
  _CopyWithStubImpl$Query$SystemDnsProvider$system$domainInfo(this._res);

  TRes _res;

  call({
    Enum$DnsProvider? provider,
    String? $__typename,
  }) =>
      _res;
}

class Query$GetApiTokens {
  Query$GetApiTokens({
    required this.api,
    this.$__typename = 'Query',
  });

  factory Query$GetApiTokens.fromJson(Map<String, dynamic> json) {
    final l$api = json['api'];
    final l$$__typename = json['__typename'];
    return Query$GetApiTokens(
      api: Query$GetApiTokens$api.fromJson((l$api as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetApiTokens$api api;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$api = api;
    _resultData['api'] = l$api.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$api = api;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$api,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetApiTokens) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$api = api;
    final lOther$api = other.api;
    if (l$api != lOther$api) {
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

extension UtilityExtension$Query$GetApiTokens on Query$GetApiTokens {
  CopyWith$Query$GetApiTokens<Query$GetApiTokens> get copyWith =>
      CopyWith$Query$GetApiTokens(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetApiTokens<TRes> {
  factory CopyWith$Query$GetApiTokens(
    Query$GetApiTokens instance,
    TRes Function(Query$GetApiTokens) then,
  ) = _CopyWithImpl$Query$GetApiTokens;

  factory CopyWith$Query$GetApiTokens.stub(TRes res) =
      _CopyWithStubImpl$Query$GetApiTokens;

  TRes call({
    Query$GetApiTokens$api? api,
    String? $__typename,
  });
  CopyWith$Query$GetApiTokens$api<TRes> get api;
}

class _CopyWithImpl$Query$GetApiTokens<TRes>
    implements CopyWith$Query$GetApiTokens<TRes> {
  _CopyWithImpl$Query$GetApiTokens(
    this._instance,
    this._then,
  );

  final Query$GetApiTokens _instance;

  final TRes Function(Query$GetApiTokens) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? api = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetApiTokens(
        api: api == _undefined || api == null
            ? _instance.api
            : (api as Query$GetApiTokens$api),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$GetApiTokens$api<TRes> get api {
    final local$api = _instance.api;
    return CopyWith$Query$GetApiTokens$api(local$api, (e) => call(api: e));
  }
}

class _CopyWithStubImpl$Query$GetApiTokens<TRes>
    implements CopyWith$Query$GetApiTokens<TRes> {
  _CopyWithStubImpl$Query$GetApiTokens(this._res);

  TRes _res;

  call({
    Query$GetApiTokens$api? api,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$GetApiTokens$api<TRes> get api =>
      CopyWith$Query$GetApiTokens$api.stub(_res);
}

const documentNodeQueryGetApiTokens = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetApiTokens'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'api'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'devices'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'creationDate'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'isCaller'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'name'),
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
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetApiTokens _parserFn$Query$GetApiTokens(Map<String, dynamic> data) =>
    Query$GetApiTokens.fromJson(data);
typedef OnQueryComplete$Query$GetApiTokens = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetApiTokens?,
);

class Options$Query$GetApiTokens
    extends graphql.QueryOptions<Query$GetApiTokens> {
  Options$Query$GetApiTokens({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetApiTokens? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetApiTokens? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetApiTokens(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetApiTokens,
          parserFn: _parserFn$Query$GetApiTokens,
        );

  final OnQueryComplete$Query$GetApiTokens? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetApiTokens
    extends graphql.WatchQueryOptions<Query$GetApiTokens> {
  WatchOptions$Query$GetApiTokens({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetApiTokens? typedOptimisticResult,
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
          document: documentNodeQueryGetApiTokens,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetApiTokens,
        );
}

class FetchMoreOptions$Query$GetApiTokens extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetApiTokens(
      {required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryGetApiTokens,
        );
}

extension ClientExtension$Query$GetApiTokens on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetApiTokens>> query$GetApiTokens(
          [Options$Query$GetApiTokens? options]) async =>
      await this.query(options ?? Options$Query$GetApiTokens());
  graphql.ObservableQuery<Query$GetApiTokens> watchQuery$GetApiTokens(
          [WatchOptions$Query$GetApiTokens? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetApiTokens());
  void writeQuery$GetApiTokens({
    required Query$GetApiTokens data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryGetApiTokens)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetApiTokens? readQuery$GetApiTokens({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetApiTokens)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetApiTokens.fromJson(result);
  }
}

class Query$GetApiTokens$api {
  Query$GetApiTokens$api({
    required this.devices,
    this.$__typename = 'Api',
  });

  factory Query$GetApiTokens$api.fromJson(Map<String, dynamic> json) {
    final l$devices = json['devices'];
    final l$$__typename = json['__typename'];
    return Query$GetApiTokens$api(
      devices: (l$devices as List<dynamic>)
          .map((e) => Query$GetApiTokens$api$devices.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetApiTokens$api$devices> devices;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$devices = devices;
    _resultData['devices'] = l$devices.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$devices = devices;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$devices.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetApiTokens$api) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$devices = devices;
    final lOther$devices = other.devices;
    if (l$devices.length != lOther$devices.length) {
      return false;
    }
    for (int i = 0; i < l$devices.length; i++) {
      final l$devices$entry = l$devices[i];
      final lOther$devices$entry = lOther$devices[i];
      if (l$devices$entry != lOther$devices$entry) {
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

extension UtilityExtension$Query$GetApiTokens$api on Query$GetApiTokens$api {
  CopyWith$Query$GetApiTokens$api<Query$GetApiTokens$api> get copyWith =>
      CopyWith$Query$GetApiTokens$api(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetApiTokens$api<TRes> {
  factory CopyWith$Query$GetApiTokens$api(
    Query$GetApiTokens$api instance,
    TRes Function(Query$GetApiTokens$api) then,
  ) = _CopyWithImpl$Query$GetApiTokens$api;

  factory CopyWith$Query$GetApiTokens$api.stub(TRes res) =
      _CopyWithStubImpl$Query$GetApiTokens$api;

  TRes call({
    List<Query$GetApiTokens$api$devices>? devices,
    String? $__typename,
  });
  TRes devices(
      Iterable<Query$GetApiTokens$api$devices> Function(
              Iterable<
                  CopyWith$Query$GetApiTokens$api$devices<
                      Query$GetApiTokens$api$devices>>)
          _fn);
}

class _CopyWithImpl$Query$GetApiTokens$api<TRes>
    implements CopyWith$Query$GetApiTokens$api<TRes> {
  _CopyWithImpl$Query$GetApiTokens$api(
    this._instance,
    this._then,
  );

  final Query$GetApiTokens$api _instance;

  final TRes Function(Query$GetApiTokens$api) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? devices = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetApiTokens$api(
        devices: devices == _undefined || devices == null
            ? _instance.devices
            : (devices as List<Query$GetApiTokens$api$devices>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  TRes devices(
          Iterable<Query$GetApiTokens$api$devices> Function(
                  Iterable<
                      CopyWith$Query$GetApiTokens$api$devices<
                          Query$GetApiTokens$api$devices>>)
              _fn) =>
      call(
          devices: _fn(_instance.devices
              .map((e) => CopyWith$Query$GetApiTokens$api$devices(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$GetApiTokens$api<TRes>
    implements CopyWith$Query$GetApiTokens$api<TRes> {
  _CopyWithStubImpl$Query$GetApiTokens$api(this._res);

  TRes _res;

  call({
    List<Query$GetApiTokens$api$devices>? devices,
    String? $__typename,
  }) =>
      _res;
  devices(_fn) => _res;
}

class Query$GetApiTokens$api$devices {
  Query$GetApiTokens$api$devices({
    required this.creationDate,
    required this.isCaller,
    required this.name,
    this.$__typename = 'ApiDevice',
  });

  factory Query$GetApiTokens$api$devices.fromJson(Map<String, dynamic> json) {
    final l$creationDate = json['creationDate'];
    final l$isCaller = json['isCaller'];
    final l$name = json['name'];
    final l$$__typename = json['__typename'];
    return Query$GetApiTokens$api$devices(
      creationDate: dateTimeFromJson(l$creationDate),
      isCaller: (l$isCaller as bool),
      name: (l$name as String),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime creationDate;

  final bool isCaller;

  final String name;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$creationDate = creationDate;
    _resultData['creationDate'] = dateTimeToJson(l$creationDate);
    final l$isCaller = isCaller;
    _resultData['isCaller'] = l$isCaller;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$creationDate = creationDate;
    final l$isCaller = isCaller;
    final l$name = name;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$creationDate,
      l$isCaller,
      l$name,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetApiTokens$api$devices) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$creationDate = creationDate;
    final lOther$creationDate = other.creationDate;
    if (l$creationDate != lOther$creationDate) {
      return false;
    }
    final l$isCaller = isCaller;
    final lOther$isCaller = other.isCaller;
    if (l$isCaller != lOther$isCaller) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
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

extension UtilityExtension$Query$GetApiTokens$api$devices
    on Query$GetApiTokens$api$devices {
  CopyWith$Query$GetApiTokens$api$devices<Query$GetApiTokens$api$devices>
      get copyWith => CopyWith$Query$GetApiTokens$api$devices(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetApiTokens$api$devices<TRes> {
  factory CopyWith$Query$GetApiTokens$api$devices(
    Query$GetApiTokens$api$devices instance,
    TRes Function(Query$GetApiTokens$api$devices) then,
  ) = _CopyWithImpl$Query$GetApiTokens$api$devices;

  factory CopyWith$Query$GetApiTokens$api$devices.stub(TRes res) =
      _CopyWithStubImpl$Query$GetApiTokens$api$devices;

  TRes call({
    DateTime? creationDate,
    bool? isCaller,
    String? name,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetApiTokens$api$devices<TRes>
    implements CopyWith$Query$GetApiTokens$api$devices<TRes> {
  _CopyWithImpl$Query$GetApiTokens$api$devices(
    this._instance,
    this._then,
  );

  final Query$GetApiTokens$api$devices _instance;

  final TRes Function(Query$GetApiTokens$api$devices) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? creationDate = _undefined,
    Object? isCaller = _undefined,
    Object? name = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetApiTokens$api$devices(
        creationDate: creationDate == _undefined || creationDate == null
            ? _instance.creationDate
            : (creationDate as DateTime),
        isCaller: isCaller == _undefined || isCaller == null
            ? _instance.isCaller
            : (isCaller as bool),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetApiTokens$api$devices<TRes>
    implements CopyWith$Query$GetApiTokens$api$devices<TRes> {
  _CopyWithStubImpl$Query$GetApiTokens$api$devices(this._res);

  TRes _res;

  call({
    DateTime? creationDate,
    bool? isCaller,
    String? name,
    String? $__typename,
  }) =>
      _res;
}

class Query$RecoveryKey {
  Query$RecoveryKey({
    required this.api,
    this.$__typename = 'Query',
  });

  factory Query$RecoveryKey.fromJson(Map<String, dynamic> json) {
    final l$api = json['api'];
    final l$$__typename = json['__typename'];
    return Query$RecoveryKey(
      api: Query$RecoveryKey$api.fromJson((l$api as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$RecoveryKey$api api;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$api = api;
    _resultData['api'] = l$api.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$api = api;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$api,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$RecoveryKey) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$api = api;
    final lOther$api = other.api;
    if (l$api != lOther$api) {
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

extension UtilityExtension$Query$RecoveryKey on Query$RecoveryKey {
  CopyWith$Query$RecoveryKey<Query$RecoveryKey> get copyWith =>
      CopyWith$Query$RecoveryKey(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$RecoveryKey<TRes> {
  factory CopyWith$Query$RecoveryKey(
    Query$RecoveryKey instance,
    TRes Function(Query$RecoveryKey) then,
  ) = _CopyWithImpl$Query$RecoveryKey;

  factory CopyWith$Query$RecoveryKey.stub(TRes res) =
      _CopyWithStubImpl$Query$RecoveryKey;

  TRes call({
    Query$RecoveryKey$api? api,
    String? $__typename,
  });
  CopyWith$Query$RecoveryKey$api<TRes> get api;
}

class _CopyWithImpl$Query$RecoveryKey<TRes>
    implements CopyWith$Query$RecoveryKey<TRes> {
  _CopyWithImpl$Query$RecoveryKey(
    this._instance,
    this._then,
  );

  final Query$RecoveryKey _instance;

  final TRes Function(Query$RecoveryKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? api = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$RecoveryKey(
        api: api == _undefined || api == null
            ? _instance.api
            : (api as Query$RecoveryKey$api),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$RecoveryKey$api<TRes> get api {
    final local$api = _instance.api;
    return CopyWith$Query$RecoveryKey$api(local$api, (e) => call(api: e));
  }
}

class _CopyWithStubImpl$Query$RecoveryKey<TRes>
    implements CopyWith$Query$RecoveryKey<TRes> {
  _CopyWithStubImpl$Query$RecoveryKey(this._res);

  TRes _res;

  call({
    Query$RecoveryKey$api? api,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$RecoveryKey$api<TRes> get api =>
      CopyWith$Query$RecoveryKey$api.stub(_res);
}

const documentNodeQueryRecoveryKey = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'RecoveryKey'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'api'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'recoveryKey'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'creationDate'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'exists'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'expirationDate'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'usesLeft'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'valid'),
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
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$RecoveryKey _parserFn$Query$RecoveryKey(Map<String, dynamic> data) =>
    Query$RecoveryKey.fromJson(data);
typedef OnQueryComplete$Query$RecoveryKey = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$RecoveryKey?,
);

class Options$Query$RecoveryKey
    extends graphql.QueryOptions<Query$RecoveryKey> {
  Options$Query$RecoveryKey({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$RecoveryKey? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$RecoveryKey? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$RecoveryKey(data),
                  ),
          onError: onError,
          document: documentNodeQueryRecoveryKey,
          parserFn: _parserFn$Query$RecoveryKey,
        );

  final OnQueryComplete$Query$RecoveryKey? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$RecoveryKey
    extends graphql.WatchQueryOptions<Query$RecoveryKey> {
  WatchOptions$Query$RecoveryKey({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$RecoveryKey? typedOptimisticResult,
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
          document: documentNodeQueryRecoveryKey,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$RecoveryKey,
        );
}

class FetchMoreOptions$Query$RecoveryKey extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$RecoveryKey({required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryRecoveryKey,
        );
}

extension ClientExtension$Query$RecoveryKey on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$RecoveryKey>> query$RecoveryKey(
          [Options$Query$RecoveryKey? options]) async =>
      await this.query(options ?? Options$Query$RecoveryKey());
  graphql.ObservableQuery<Query$RecoveryKey> watchQuery$RecoveryKey(
          [WatchOptions$Query$RecoveryKey? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$RecoveryKey());
  void writeQuery$RecoveryKey({
    required Query$RecoveryKey data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryRecoveryKey)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$RecoveryKey? readQuery$RecoveryKey({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryRecoveryKey)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$RecoveryKey.fromJson(result);
  }
}

class Query$RecoveryKey$api {
  Query$RecoveryKey$api({
    required this.recoveryKey,
    this.$__typename = 'Api',
  });

  factory Query$RecoveryKey$api.fromJson(Map<String, dynamic> json) {
    final l$recoveryKey = json['recoveryKey'];
    final l$$__typename = json['__typename'];
    return Query$RecoveryKey$api(
      recoveryKey: Query$RecoveryKey$api$recoveryKey.fromJson(
          (l$recoveryKey as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$RecoveryKey$api$recoveryKey recoveryKey;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$recoveryKey = recoveryKey;
    _resultData['recoveryKey'] = l$recoveryKey.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$recoveryKey = recoveryKey;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$recoveryKey,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$RecoveryKey$api) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$recoveryKey = recoveryKey;
    final lOther$recoveryKey = other.recoveryKey;
    if (l$recoveryKey != lOther$recoveryKey) {
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

extension UtilityExtension$Query$RecoveryKey$api on Query$RecoveryKey$api {
  CopyWith$Query$RecoveryKey$api<Query$RecoveryKey$api> get copyWith =>
      CopyWith$Query$RecoveryKey$api(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$RecoveryKey$api<TRes> {
  factory CopyWith$Query$RecoveryKey$api(
    Query$RecoveryKey$api instance,
    TRes Function(Query$RecoveryKey$api) then,
  ) = _CopyWithImpl$Query$RecoveryKey$api;

  factory CopyWith$Query$RecoveryKey$api.stub(TRes res) =
      _CopyWithStubImpl$Query$RecoveryKey$api;

  TRes call({
    Query$RecoveryKey$api$recoveryKey? recoveryKey,
    String? $__typename,
  });
  CopyWith$Query$RecoveryKey$api$recoveryKey<TRes> get recoveryKey;
}

class _CopyWithImpl$Query$RecoveryKey$api<TRes>
    implements CopyWith$Query$RecoveryKey$api<TRes> {
  _CopyWithImpl$Query$RecoveryKey$api(
    this._instance,
    this._then,
  );

  final Query$RecoveryKey$api _instance;

  final TRes Function(Query$RecoveryKey$api) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? recoveryKey = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$RecoveryKey$api(
        recoveryKey: recoveryKey == _undefined || recoveryKey == null
            ? _instance.recoveryKey
            : (recoveryKey as Query$RecoveryKey$api$recoveryKey),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$RecoveryKey$api$recoveryKey<TRes> get recoveryKey {
    final local$recoveryKey = _instance.recoveryKey;
    return CopyWith$Query$RecoveryKey$api$recoveryKey(
        local$recoveryKey, (e) => call(recoveryKey: e));
  }
}

class _CopyWithStubImpl$Query$RecoveryKey$api<TRes>
    implements CopyWith$Query$RecoveryKey$api<TRes> {
  _CopyWithStubImpl$Query$RecoveryKey$api(this._res);

  TRes _res;

  call({
    Query$RecoveryKey$api$recoveryKey? recoveryKey,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$RecoveryKey$api$recoveryKey<TRes> get recoveryKey =>
      CopyWith$Query$RecoveryKey$api$recoveryKey.stub(_res);
}

class Query$RecoveryKey$api$recoveryKey {
  Query$RecoveryKey$api$recoveryKey({
    this.creationDate,
    required this.exists,
    this.expirationDate,
    this.usesLeft,
    required this.valid,
    this.$__typename = 'ApiRecoveryKeyStatus',
  });

  factory Query$RecoveryKey$api$recoveryKey.fromJson(
      Map<String, dynamic> json) {
    final l$creationDate = json['creationDate'];
    final l$exists = json['exists'];
    final l$expirationDate = json['expirationDate'];
    final l$usesLeft = json['usesLeft'];
    final l$valid = json['valid'];
    final l$$__typename = json['__typename'];
    return Query$RecoveryKey$api$recoveryKey(
      creationDate:
          l$creationDate == null ? null : dateTimeFromJson(l$creationDate),
      exists: (l$exists as bool),
      expirationDate:
          l$expirationDate == null ? null : dateTimeFromJson(l$expirationDate),
      usesLeft: (l$usesLeft as int?),
      valid: (l$valid as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime? creationDate;

  final bool exists;

  final DateTime? expirationDate;

  final int? usesLeft;

  final bool valid;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$creationDate = creationDate;
    _resultData['creationDate'] =
        l$creationDate == null ? null : dateTimeToJson(l$creationDate);
    final l$exists = exists;
    _resultData['exists'] = l$exists;
    final l$expirationDate = expirationDate;
    _resultData['expirationDate'] =
        l$expirationDate == null ? null : dateTimeToJson(l$expirationDate);
    final l$usesLeft = usesLeft;
    _resultData['usesLeft'] = l$usesLeft;
    final l$valid = valid;
    _resultData['valid'] = l$valid;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$creationDate = creationDate;
    final l$exists = exists;
    final l$expirationDate = expirationDate;
    final l$usesLeft = usesLeft;
    final l$valid = valid;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$creationDate,
      l$exists,
      l$expirationDate,
      l$usesLeft,
      l$valid,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$RecoveryKey$api$recoveryKey) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$creationDate = creationDate;
    final lOther$creationDate = other.creationDate;
    if (l$creationDate != lOther$creationDate) {
      return false;
    }
    final l$exists = exists;
    final lOther$exists = other.exists;
    if (l$exists != lOther$exists) {
      return false;
    }
    final l$expirationDate = expirationDate;
    final lOther$expirationDate = other.expirationDate;
    if (l$expirationDate != lOther$expirationDate) {
      return false;
    }
    final l$usesLeft = usesLeft;
    final lOther$usesLeft = other.usesLeft;
    if (l$usesLeft != lOther$usesLeft) {
      return false;
    }
    final l$valid = valid;
    final lOther$valid = other.valid;
    if (l$valid != lOther$valid) {
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

extension UtilityExtension$Query$RecoveryKey$api$recoveryKey
    on Query$RecoveryKey$api$recoveryKey {
  CopyWith$Query$RecoveryKey$api$recoveryKey<Query$RecoveryKey$api$recoveryKey>
      get copyWith => CopyWith$Query$RecoveryKey$api$recoveryKey(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$RecoveryKey$api$recoveryKey<TRes> {
  factory CopyWith$Query$RecoveryKey$api$recoveryKey(
    Query$RecoveryKey$api$recoveryKey instance,
    TRes Function(Query$RecoveryKey$api$recoveryKey) then,
  ) = _CopyWithImpl$Query$RecoveryKey$api$recoveryKey;

  factory CopyWith$Query$RecoveryKey$api$recoveryKey.stub(TRes res) =
      _CopyWithStubImpl$Query$RecoveryKey$api$recoveryKey;

  TRes call({
    DateTime? creationDate,
    bool? exists,
    DateTime? expirationDate,
    int? usesLeft,
    bool? valid,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$RecoveryKey$api$recoveryKey<TRes>
    implements CopyWith$Query$RecoveryKey$api$recoveryKey<TRes> {
  _CopyWithImpl$Query$RecoveryKey$api$recoveryKey(
    this._instance,
    this._then,
  );

  final Query$RecoveryKey$api$recoveryKey _instance;

  final TRes Function(Query$RecoveryKey$api$recoveryKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? creationDate = _undefined,
    Object? exists = _undefined,
    Object? expirationDate = _undefined,
    Object? usesLeft = _undefined,
    Object? valid = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$RecoveryKey$api$recoveryKey(
        creationDate: creationDate == _undefined
            ? _instance.creationDate
            : (creationDate as DateTime?),
        exists: exists == _undefined || exists == null
            ? _instance.exists
            : (exists as bool),
        expirationDate: expirationDate == _undefined
            ? _instance.expirationDate
            : (expirationDate as DateTime?),
        usesLeft:
            usesLeft == _undefined ? _instance.usesLeft : (usesLeft as int?),
        valid: valid == _undefined || valid == null
            ? _instance.valid
            : (valid as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$RecoveryKey$api$recoveryKey<TRes>
    implements CopyWith$Query$RecoveryKey$api$recoveryKey<TRes> {
  _CopyWithStubImpl$Query$RecoveryKey$api$recoveryKey(this._res);

  TRes _res;

  call({
    DateTime? creationDate,
    bool? exists,
    DateTime? expirationDate,
    int? usesLeft,
    bool? valid,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$GetNewRecoveryApiKey {
  factory Variables$Mutation$GetNewRecoveryApiKey(
          {Input$RecoveryKeyLimitsInput? limits}) =>
      Variables$Mutation$GetNewRecoveryApiKey._({
        if (limits != null) r'limits': limits,
      });

  Variables$Mutation$GetNewRecoveryApiKey._(this._$data);

  factory Variables$Mutation$GetNewRecoveryApiKey.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('limits')) {
      final l$limits = data['limits'];
      result$data['limits'] = l$limits == null
          ? null
          : Input$RecoveryKeyLimitsInput.fromJson(
              (l$limits as Map<String, dynamic>));
    }
    return Variables$Mutation$GetNewRecoveryApiKey._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$RecoveryKeyLimitsInput? get limits =>
      (_$data['limits'] as Input$RecoveryKeyLimitsInput?);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('limits')) {
      final l$limits = limits;
      result$data['limits'] = l$limits?.toJson();
    }
    return result$data;
  }

  CopyWith$Variables$Mutation$GetNewRecoveryApiKey<
          Variables$Mutation$GetNewRecoveryApiKey>
      get copyWith => CopyWith$Variables$Mutation$GetNewRecoveryApiKey(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$GetNewRecoveryApiKey) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$limits = limits;
    final lOther$limits = other.limits;
    if (_$data.containsKey('limits') != other._$data.containsKey('limits')) {
      return false;
    }
    if (l$limits != lOther$limits) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$limits = limits;
    return Object.hashAll([_$data.containsKey('limits') ? l$limits : const {}]);
  }
}

abstract class CopyWith$Variables$Mutation$GetNewRecoveryApiKey<TRes> {
  factory CopyWith$Variables$Mutation$GetNewRecoveryApiKey(
    Variables$Mutation$GetNewRecoveryApiKey instance,
    TRes Function(Variables$Mutation$GetNewRecoveryApiKey) then,
  ) = _CopyWithImpl$Variables$Mutation$GetNewRecoveryApiKey;

  factory CopyWith$Variables$Mutation$GetNewRecoveryApiKey.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$GetNewRecoveryApiKey;

  TRes call({Input$RecoveryKeyLimitsInput? limits});
}

class _CopyWithImpl$Variables$Mutation$GetNewRecoveryApiKey<TRes>
    implements CopyWith$Variables$Mutation$GetNewRecoveryApiKey<TRes> {
  _CopyWithImpl$Variables$Mutation$GetNewRecoveryApiKey(
    this._instance,
    this._then,
  );

  final Variables$Mutation$GetNewRecoveryApiKey _instance;

  final TRes Function(Variables$Mutation$GetNewRecoveryApiKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? limits = _undefined}) =>
      _then(Variables$Mutation$GetNewRecoveryApiKey._({
        ..._instance._$data,
        if (limits != _undefined)
          'limits': (limits as Input$RecoveryKeyLimitsInput?),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$GetNewRecoveryApiKey<TRes>
    implements CopyWith$Variables$Mutation$GetNewRecoveryApiKey<TRes> {
  _CopyWithStubImpl$Variables$Mutation$GetNewRecoveryApiKey(this._res);

  TRes _res;

  call({Input$RecoveryKeyLimitsInput? limits}) => _res;
}

class Mutation$GetNewRecoveryApiKey {
  Mutation$GetNewRecoveryApiKey({
    required this.getNewRecoveryApiKey,
    this.$__typename = 'Mutation',
  });

  factory Mutation$GetNewRecoveryApiKey.fromJson(Map<String, dynamic> json) {
    final l$getNewRecoveryApiKey = json['getNewRecoveryApiKey'];
    final l$$__typename = json['__typename'];
    return Mutation$GetNewRecoveryApiKey(
      getNewRecoveryApiKey:
          Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey.fromJson(
              (l$getNewRecoveryApiKey as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey getNewRecoveryApiKey;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getNewRecoveryApiKey = getNewRecoveryApiKey;
    _resultData['getNewRecoveryApiKey'] = l$getNewRecoveryApiKey.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getNewRecoveryApiKey = getNewRecoveryApiKey;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getNewRecoveryApiKey,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$GetNewRecoveryApiKey) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$getNewRecoveryApiKey = getNewRecoveryApiKey;
    final lOther$getNewRecoveryApiKey = other.getNewRecoveryApiKey;
    if (l$getNewRecoveryApiKey != lOther$getNewRecoveryApiKey) {
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

extension UtilityExtension$Mutation$GetNewRecoveryApiKey
    on Mutation$GetNewRecoveryApiKey {
  CopyWith$Mutation$GetNewRecoveryApiKey<Mutation$GetNewRecoveryApiKey>
      get copyWith => CopyWith$Mutation$GetNewRecoveryApiKey(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$GetNewRecoveryApiKey<TRes> {
  factory CopyWith$Mutation$GetNewRecoveryApiKey(
    Mutation$GetNewRecoveryApiKey instance,
    TRes Function(Mutation$GetNewRecoveryApiKey) then,
  ) = _CopyWithImpl$Mutation$GetNewRecoveryApiKey;

  factory CopyWith$Mutation$GetNewRecoveryApiKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$GetNewRecoveryApiKey;

  TRes call({
    Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey? getNewRecoveryApiKey,
    String? $__typename,
  });
  CopyWith$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey<TRes>
      get getNewRecoveryApiKey;
}

class _CopyWithImpl$Mutation$GetNewRecoveryApiKey<TRes>
    implements CopyWith$Mutation$GetNewRecoveryApiKey<TRes> {
  _CopyWithImpl$Mutation$GetNewRecoveryApiKey(
    this._instance,
    this._then,
  );

  final Mutation$GetNewRecoveryApiKey _instance;

  final TRes Function(Mutation$GetNewRecoveryApiKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getNewRecoveryApiKey = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$GetNewRecoveryApiKey(
        getNewRecoveryApiKey:
            getNewRecoveryApiKey == _undefined || getNewRecoveryApiKey == null
                ? _instance.getNewRecoveryApiKey
                : (getNewRecoveryApiKey
                    as Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey<TRes>
      get getNewRecoveryApiKey {
    final local$getNewRecoveryApiKey = _instance.getNewRecoveryApiKey;
    return CopyWith$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey(
        local$getNewRecoveryApiKey, (e) => call(getNewRecoveryApiKey: e));
  }
}

class _CopyWithStubImpl$Mutation$GetNewRecoveryApiKey<TRes>
    implements CopyWith$Mutation$GetNewRecoveryApiKey<TRes> {
  _CopyWithStubImpl$Mutation$GetNewRecoveryApiKey(this._res);

  TRes _res;

  call({
    Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey? getNewRecoveryApiKey,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey<TRes>
      get getNewRecoveryApiKey =>
          CopyWith$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey.stub(
              _res);
}

const documentNodeMutationGetNewRecoveryApiKey = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'GetNewRecoveryApiKey'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'limits')),
        type: NamedTypeNode(
          name: NameNode(value: 'RecoveryKeyLimitsInput'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getNewRecoveryApiKey'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'limits'),
            value: VariableNode(name: NameNode(value: 'limits')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'basicMutationReturnFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: 'key'),
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
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$GetNewRecoveryApiKey _parserFn$Mutation$GetNewRecoveryApiKey(
        Map<String, dynamic> data) =>
    Mutation$GetNewRecoveryApiKey.fromJson(data);
typedef OnMutationCompleted$Mutation$GetNewRecoveryApiKey = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$GetNewRecoveryApiKey?,
);

class Options$Mutation$GetNewRecoveryApiKey
    extends graphql.MutationOptions<Mutation$GetNewRecoveryApiKey> {
  Options$Mutation$GetNewRecoveryApiKey({
    String? operationName,
    Variables$Mutation$GetNewRecoveryApiKey? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$GetNewRecoveryApiKey? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$GetNewRecoveryApiKey? onCompleted,
    graphql.OnMutationUpdate<Mutation$GetNewRecoveryApiKey>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables?.toJson() ?? {},
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$GetNewRecoveryApiKey(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationGetNewRecoveryApiKey,
          parserFn: _parserFn$Mutation$GetNewRecoveryApiKey,
        );

  final OnMutationCompleted$Mutation$GetNewRecoveryApiKey?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$GetNewRecoveryApiKey
    extends graphql.WatchQueryOptions<Mutation$GetNewRecoveryApiKey> {
  WatchOptions$Mutation$GetNewRecoveryApiKey({
    String? operationName,
    Variables$Mutation$GetNewRecoveryApiKey? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$GetNewRecoveryApiKey? typedOptimisticResult,
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
          document: documentNodeMutationGetNewRecoveryApiKey,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$GetNewRecoveryApiKey,
        );
}

extension ClientExtension$Mutation$GetNewRecoveryApiKey
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$GetNewRecoveryApiKey>>
      mutate$GetNewRecoveryApiKey(
              [Options$Mutation$GetNewRecoveryApiKey? options]) async =>
          await this.mutate(options ?? Options$Mutation$GetNewRecoveryApiKey());
  graphql.ObservableQuery<Mutation$GetNewRecoveryApiKey>
      watchMutation$GetNewRecoveryApiKey(
              [WatchOptions$Mutation$GetNewRecoveryApiKey? options]) =>
          this.watchMutation(
              options ?? WatchOptions$Mutation$GetNewRecoveryApiKey());
}

class Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey
    implements Fragment$basicMutationReturnFields$$ApiKeyMutationReturn {
  Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ApiKeyMutationReturn',
    this.key,
  });

  factory Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$key = json['key'];
    return Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      key: (l$key as String?),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final String? key;

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
    final l$key = key;
    _resultData['key'] = l$key;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$key = key;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
      l$key,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey) ||
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
    final l$key = key;
    final lOther$key = other.key;
    if (l$key != lOther$key) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey
    on Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey {
  CopyWith$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey<
          Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey>
      get copyWith =>
          CopyWith$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey<
    TRes> {
  factory CopyWith$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey(
    Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey instance,
    TRes Function(Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey) then,
  ) = _CopyWithImpl$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey;

  factory CopyWith$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    String? key,
  });
}

class _CopyWithImpl$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey<TRes>
    implements
        CopyWith$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey<TRes> {
  _CopyWithImpl$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey(
    this._instance,
    this._then,
  );

  final Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey _instance;

  final TRes Function(Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? key = _undefined,
  }) =>
      _then(Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
        key: key == _undefined ? _instance.key : (key as String?),
      ));
}

class _CopyWithStubImpl$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey<TRes>
    implements
        CopyWith$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey<TRes> {
  _CopyWithStubImpl$Mutation$GetNewRecoveryApiKey$getNewRecoveryApiKey(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    String? key,
  }) =>
      _res;
}

class Variables$Mutation$UseRecoveryApiKey {
  factory Variables$Mutation$UseRecoveryApiKey(
          {required Input$UseRecoveryKeyInput input}) =>
      Variables$Mutation$UseRecoveryApiKey._({
        r'input': input,
      });

  Variables$Mutation$UseRecoveryApiKey._(this._$data);

  factory Variables$Mutation$UseRecoveryApiKey.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] =
        Input$UseRecoveryKeyInput.fromJson((l$input as Map<String, dynamic>));
    return Variables$Mutation$UseRecoveryApiKey._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$UseRecoveryKeyInput get input =>
      (_$data['input'] as Input$UseRecoveryKeyInput);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$UseRecoveryApiKey<
          Variables$Mutation$UseRecoveryApiKey>
      get copyWith => CopyWith$Variables$Mutation$UseRecoveryApiKey(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$UseRecoveryApiKey) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$UseRecoveryApiKey<TRes> {
  factory CopyWith$Variables$Mutation$UseRecoveryApiKey(
    Variables$Mutation$UseRecoveryApiKey instance,
    TRes Function(Variables$Mutation$UseRecoveryApiKey) then,
  ) = _CopyWithImpl$Variables$Mutation$UseRecoveryApiKey;

  factory CopyWith$Variables$Mutation$UseRecoveryApiKey.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$UseRecoveryApiKey;

  TRes call({Input$UseRecoveryKeyInput? input});
}

class _CopyWithImpl$Variables$Mutation$UseRecoveryApiKey<TRes>
    implements CopyWith$Variables$Mutation$UseRecoveryApiKey<TRes> {
  _CopyWithImpl$Variables$Mutation$UseRecoveryApiKey(
    this._instance,
    this._then,
  );

  final Variables$Mutation$UseRecoveryApiKey _instance;

  final TRes Function(Variables$Mutation$UseRecoveryApiKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$UseRecoveryApiKey._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$UseRecoveryKeyInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$UseRecoveryApiKey<TRes>
    implements CopyWith$Variables$Mutation$UseRecoveryApiKey<TRes> {
  _CopyWithStubImpl$Variables$Mutation$UseRecoveryApiKey(this._res);

  TRes _res;

  call({Input$UseRecoveryKeyInput? input}) => _res;
}

class Mutation$UseRecoveryApiKey {
  Mutation$UseRecoveryApiKey({
    required this.useRecoveryApiKey,
    this.$__typename = 'Mutation',
  });

  factory Mutation$UseRecoveryApiKey.fromJson(Map<String, dynamic> json) {
    final l$useRecoveryApiKey = json['useRecoveryApiKey'];
    final l$$__typename = json['__typename'];
    return Mutation$UseRecoveryApiKey(
      useRecoveryApiKey: Mutation$UseRecoveryApiKey$useRecoveryApiKey.fromJson(
          (l$useRecoveryApiKey as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$UseRecoveryApiKey$useRecoveryApiKey useRecoveryApiKey;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$useRecoveryApiKey = useRecoveryApiKey;
    _resultData['useRecoveryApiKey'] = l$useRecoveryApiKey.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$useRecoveryApiKey = useRecoveryApiKey;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$useRecoveryApiKey,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$UseRecoveryApiKey) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$useRecoveryApiKey = useRecoveryApiKey;
    final lOther$useRecoveryApiKey = other.useRecoveryApiKey;
    if (l$useRecoveryApiKey != lOther$useRecoveryApiKey) {
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

extension UtilityExtension$Mutation$UseRecoveryApiKey
    on Mutation$UseRecoveryApiKey {
  CopyWith$Mutation$UseRecoveryApiKey<Mutation$UseRecoveryApiKey>
      get copyWith => CopyWith$Mutation$UseRecoveryApiKey(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$UseRecoveryApiKey<TRes> {
  factory CopyWith$Mutation$UseRecoveryApiKey(
    Mutation$UseRecoveryApiKey instance,
    TRes Function(Mutation$UseRecoveryApiKey) then,
  ) = _CopyWithImpl$Mutation$UseRecoveryApiKey;

  factory CopyWith$Mutation$UseRecoveryApiKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UseRecoveryApiKey;

  TRes call({
    Mutation$UseRecoveryApiKey$useRecoveryApiKey? useRecoveryApiKey,
    String? $__typename,
  });
  CopyWith$Mutation$UseRecoveryApiKey$useRecoveryApiKey<TRes>
      get useRecoveryApiKey;
}

class _CopyWithImpl$Mutation$UseRecoveryApiKey<TRes>
    implements CopyWith$Mutation$UseRecoveryApiKey<TRes> {
  _CopyWithImpl$Mutation$UseRecoveryApiKey(
    this._instance,
    this._then,
  );

  final Mutation$UseRecoveryApiKey _instance;

  final TRes Function(Mutation$UseRecoveryApiKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? useRecoveryApiKey = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$UseRecoveryApiKey(
        useRecoveryApiKey:
            useRecoveryApiKey == _undefined || useRecoveryApiKey == null
                ? _instance.useRecoveryApiKey
                : (useRecoveryApiKey
                    as Mutation$UseRecoveryApiKey$useRecoveryApiKey),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$UseRecoveryApiKey$useRecoveryApiKey<TRes>
      get useRecoveryApiKey {
    final local$useRecoveryApiKey = _instance.useRecoveryApiKey;
    return CopyWith$Mutation$UseRecoveryApiKey$useRecoveryApiKey(
        local$useRecoveryApiKey, (e) => call(useRecoveryApiKey: e));
  }
}

class _CopyWithStubImpl$Mutation$UseRecoveryApiKey<TRes>
    implements CopyWith$Mutation$UseRecoveryApiKey<TRes> {
  _CopyWithStubImpl$Mutation$UseRecoveryApiKey(this._res);

  TRes _res;

  call({
    Mutation$UseRecoveryApiKey$useRecoveryApiKey? useRecoveryApiKey,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$UseRecoveryApiKey$useRecoveryApiKey<TRes>
      get useRecoveryApiKey =>
          CopyWith$Mutation$UseRecoveryApiKey$useRecoveryApiKey.stub(_res);
}

const documentNodeMutationUseRecoveryApiKey = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'UseRecoveryApiKey'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'UseRecoveryKeyInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'useRecoveryApiKey'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'basicMutationReturnFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: 'token'),
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
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$UseRecoveryApiKey _parserFn$Mutation$UseRecoveryApiKey(
        Map<String, dynamic> data) =>
    Mutation$UseRecoveryApiKey.fromJson(data);
typedef OnMutationCompleted$Mutation$UseRecoveryApiKey = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$UseRecoveryApiKey?,
);

class Options$Mutation$UseRecoveryApiKey
    extends graphql.MutationOptions<Mutation$UseRecoveryApiKey> {
  Options$Mutation$UseRecoveryApiKey({
    String? operationName,
    required Variables$Mutation$UseRecoveryApiKey variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UseRecoveryApiKey? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UseRecoveryApiKey? onCompleted,
    graphql.OnMutationUpdate<Mutation$UseRecoveryApiKey>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$UseRecoveryApiKey(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationUseRecoveryApiKey,
          parserFn: _parserFn$Mutation$UseRecoveryApiKey,
        );

  final OnMutationCompleted$Mutation$UseRecoveryApiKey? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$UseRecoveryApiKey
    extends graphql.WatchQueryOptions<Mutation$UseRecoveryApiKey> {
  WatchOptions$Mutation$UseRecoveryApiKey({
    String? operationName,
    required Variables$Mutation$UseRecoveryApiKey variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UseRecoveryApiKey? typedOptimisticResult,
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
          document: documentNodeMutationUseRecoveryApiKey,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$UseRecoveryApiKey,
        );
}

extension ClientExtension$Mutation$UseRecoveryApiKey on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$UseRecoveryApiKey>>
      mutate$UseRecoveryApiKey(
              Options$Mutation$UseRecoveryApiKey options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$UseRecoveryApiKey>
      watchMutation$UseRecoveryApiKey(
              WatchOptions$Mutation$UseRecoveryApiKey options) =>
          this.watchMutation(options);
}

class Mutation$UseRecoveryApiKey$useRecoveryApiKey
    implements
        Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn {
  Mutation$UseRecoveryApiKey$useRecoveryApiKey({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'DeviceApiTokenMutationReturn',
    this.token,
  });

  factory Mutation$UseRecoveryApiKey$useRecoveryApiKey.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$token = json['token'];
    return Mutation$UseRecoveryApiKey$useRecoveryApiKey(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      token: (l$token as String?),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final String? token;

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
    final l$token = token;
    _resultData['token'] = l$token;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$token = token;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
      l$token,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$UseRecoveryApiKey$useRecoveryApiKey) ||
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
    final l$token = token;
    final lOther$token = other.token;
    if (l$token != lOther$token) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$UseRecoveryApiKey$useRecoveryApiKey
    on Mutation$UseRecoveryApiKey$useRecoveryApiKey {
  CopyWith$Mutation$UseRecoveryApiKey$useRecoveryApiKey<
          Mutation$UseRecoveryApiKey$useRecoveryApiKey>
      get copyWith => CopyWith$Mutation$UseRecoveryApiKey$useRecoveryApiKey(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$UseRecoveryApiKey$useRecoveryApiKey<TRes> {
  factory CopyWith$Mutation$UseRecoveryApiKey$useRecoveryApiKey(
    Mutation$UseRecoveryApiKey$useRecoveryApiKey instance,
    TRes Function(Mutation$UseRecoveryApiKey$useRecoveryApiKey) then,
  ) = _CopyWithImpl$Mutation$UseRecoveryApiKey$useRecoveryApiKey;

  factory CopyWith$Mutation$UseRecoveryApiKey$useRecoveryApiKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UseRecoveryApiKey$useRecoveryApiKey;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    String? token,
  });
}

class _CopyWithImpl$Mutation$UseRecoveryApiKey$useRecoveryApiKey<TRes>
    implements CopyWith$Mutation$UseRecoveryApiKey$useRecoveryApiKey<TRes> {
  _CopyWithImpl$Mutation$UseRecoveryApiKey$useRecoveryApiKey(
    this._instance,
    this._then,
  );

  final Mutation$UseRecoveryApiKey$useRecoveryApiKey _instance;

  final TRes Function(Mutation$UseRecoveryApiKey$useRecoveryApiKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? token = _undefined,
  }) =>
      _then(Mutation$UseRecoveryApiKey$useRecoveryApiKey(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
        token: token == _undefined ? _instance.token : (token as String?),
      ));
}

class _CopyWithStubImpl$Mutation$UseRecoveryApiKey$useRecoveryApiKey<TRes>
    implements CopyWith$Mutation$UseRecoveryApiKey$useRecoveryApiKey<TRes> {
  _CopyWithStubImpl$Mutation$UseRecoveryApiKey$useRecoveryApiKey(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    String? token,
  }) =>
      _res;
}

class Mutation$RefreshDeviceApiToken {
  Mutation$RefreshDeviceApiToken({
    required this.refreshDeviceApiToken,
    this.$__typename = 'Mutation',
  });

  factory Mutation$RefreshDeviceApiToken.fromJson(Map<String, dynamic> json) {
    final l$refreshDeviceApiToken = json['refreshDeviceApiToken'];
    final l$$__typename = json['__typename'];
    return Mutation$RefreshDeviceApiToken(
      refreshDeviceApiToken:
          Mutation$RefreshDeviceApiToken$refreshDeviceApiToken.fromJson(
              (l$refreshDeviceApiToken as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$RefreshDeviceApiToken$refreshDeviceApiToken
      refreshDeviceApiToken;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$refreshDeviceApiToken = refreshDeviceApiToken;
    _resultData['refreshDeviceApiToken'] = l$refreshDeviceApiToken.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$refreshDeviceApiToken = refreshDeviceApiToken;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$refreshDeviceApiToken,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RefreshDeviceApiToken) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$refreshDeviceApiToken = refreshDeviceApiToken;
    final lOther$refreshDeviceApiToken = other.refreshDeviceApiToken;
    if (l$refreshDeviceApiToken != lOther$refreshDeviceApiToken) {
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

extension UtilityExtension$Mutation$RefreshDeviceApiToken
    on Mutation$RefreshDeviceApiToken {
  CopyWith$Mutation$RefreshDeviceApiToken<Mutation$RefreshDeviceApiToken>
      get copyWith => CopyWith$Mutation$RefreshDeviceApiToken(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$RefreshDeviceApiToken<TRes> {
  factory CopyWith$Mutation$RefreshDeviceApiToken(
    Mutation$RefreshDeviceApiToken instance,
    TRes Function(Mutation$RefreshDeviceApiToken) then,
  ) = _CopyWithImpl$Mutation$RefreshDeviceApiToken;

  factory CopyWith$Mutation$RefreshDeviceApiToken.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RefreshDeviceApiToken;

  TRes call({
    Mutation$RefreshDeviceApiToken$refreshDeviceApiToken? refreshDeviceApiToken,
    String? $__typename,
  });
  CopyWith$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken<TRes>
      get refreshDeviceApiToken;
}

class _CopyWithImpl$Mutation$RefreshDeviceApiToken<TRes>
    implements CopyWith$Mutation$RefreshDeviceApiToken<TRes> {
  _CopyWithImpl$Mutation$RefreshDeviceApiToken(
    this._instance,
    this._then,
  );

  final Mutation$RefreshDeviceApiToken _instance;

  final TRes Function(Mutation$RefreshDeviceApiToken) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? refreshDeviceApiToken = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$RefreshDeviceApiToken(
        refreshDeviceApiToken:
            refreshDeviceApiToken == _undefined || refreshDeviceApiToken == null
                ? _instance.refreshDeviceApiToken
                : (refreshDeviceApiToken
                    as Mutation$RefreshDeviceApiToken$refreshDeviceApiToken),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken<TRes>
      get refreshDeviceApiToken {
    final local$refreshDeviceApiToken = _instance.refreshDeviceApiToken;
    return CopyWith$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken(
        local$refreshDeviceApiToken, (e) => call(refreshDeviceApiToken: e));
  }
}

class _CopyWithStubImpl$Mutation$RefreshDeviceApiToken<TRes>
    implements CopyWith$Mutation$RefreshDeviceApiToken<TRes> {
  _CopyWithStubImpl$Mutation$RefreshDeviceApiToken(this._res);

  TRes _res;

  call({
    Mutation$RefreshDeviceApiToken$refreshDeviceApiToken? refreshDeviceApiToken,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken<TRes>
      get refreshDeviceApiToken =>
          CopyWith$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken.stub(
              _res);
}

const documentNodeMutationRefreshDeviceApiToken = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'RefreshDeviceApiToken'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'refreshDeviceApiToken'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'basicMutationReturnFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: 'token'),
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
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$RefreshDeviceApiToken _parserFn$Mutation$RefreshDeviceApiToken(
        Map<String, dynamic> data) =>
    Mutation$RefreshDeviceApiToken.fromJson(data);
typedef OnMutationCompleted$Mutation$RefreshDeviceApiToken = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$RefreshDeviceApiToken?,
);

class Options$Mutation$RefreshDeviceApiToken
    extends graphql.MutationOptions<Mutation$RefreshDeviceApiToken> {
  Options$Mutation$RefreshDeviceApiToken({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RefreshDeviceApiToken? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$RefreshDeviceApiToken? onCompleted,
    graphql.OnMutationUpdate<Mutation$RefreshDeviceApiToken>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$RefreshDeviceApiToken(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationRefreshDeviceApiToken,
          parserFn: _parserFn$Mutation$RefreshDeviceApiToken,
        );

  final OnMutationCompleted$Mutation$RefreshDeviceApiToken?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$RefreshDeviceApiToken
    extends graphql.WatchQueryOptions<Mutation$RefreshDeviceApiToken> {
  WatchOptions$Mutation$RefreshDeviceApiToken({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RefreshDeviceApiToken? typedOptimisticResult,
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
          document: documentNodeMutationRefreshDeviceApiToken,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$RefreshDeviceApiToken,
        );
}

extension ClientExtension$Mutation$RefreshDeviceApiToken
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RefreshDeviceApiToken>>
      mutate$RefreshDeviceApiToken(
              [Options$Mutation$RefreshDeviceApiToken? options]) async =>
          await this
              .mutate(options ?? Options$Mutation$RefreshDeviceApiToken());
  graphql.ObservableQuery<Mutation$RefreshDeviceApiToken>
      watchMutation$RefreshDeviceApiToken(
              [WatchOptions$Mutation$RefreshDeviceApiToken? options]) =>
          this.watchMutation(
              options ?? WatchOptions$Mutation$RefreshDeviceApiToken());
}

class Mutation$RefreshDeviceApiToken$refreshDeviceApiToken
    implements
        Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn {
  Mutation$RefreshDeviceApiToken$refreshDeviceApiToken({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'DeviceApiTokenMutationReturn',
    this.token,
  });

  factory Mutation$RefreshDeviceApiToken$refreshDeviceApiToken.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$token = json['token'];
    return Mutation$RefreshDeviceApiToken$refreshDeviceApiToken(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      token: (l$token as String?),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final String? token;

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
    final l$token = token;
    _resultData['token'] = l$token;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$token = token;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
      l$token,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RefreshDeviceApiToken$refreshDeviceApiToken) ||
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
    final l$token = token;
    final lOther$token = other.token;
    if (l$token != lOther$token) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken
    on Mutation$RefreshDeviceApiToken$refreshDeviceApiToken {
  CopyWith$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken<
          Mutation$RefreshDeviceApiToken$refreshDeviceApiToken>
      get copyWith =>
          CopyWith$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken<
    TRes> {
  factory CopyWith$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken(
    Mutation$RefreshDeviceApiToken$refreshDeviceApiToken instance,
    TRes Function(Mutation$RefreshDeviceApiToken$refreshDeviceApiToken) then,
  ) = _CopyWithImpl$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken;

  factory CopyWith$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    String? token,
  });
}

class _CopyWithImpl$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken<TRes>
    implements
        CopyWith$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken<TRes> {
  _CopyWithImpl$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken(
    this._instance,
    this._then,
  );

  final Mutation$RefreshDeviceApiToken$refreshDeviceApiToken _instance;

  final TRes Function(Mutation$RefreshDeviceApiToken$refreshDeviceApiToken)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? token = _undefined,
  }) =>
      _then(Mutation$RefreshDeviceApiToken$refreshDeviceApiToken(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
        token: token == _undefined ? _instance.token : (token as String?),
      ));
}

class _CopyWithStubImpl$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken<
        TRes>
    implements
        CopyWith$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken<TRes> {
  _CopyWithStubImpl$Mutation$RefreshDeviceApiToken$refreshDeviceApiToken(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    String? token,
  }) =>
      _res;
}

class Variables$Mutation$DeleteDeviceApiToken {
  factory Variables$Mutation$DeleteDeviceApiToken({required String device}) =>
      Variables$Mutation$DeleteDeviceApiToken._({
        r'device': device,
      });

  Variables$Mutation$DeleteDeviceApiToken._(this._$data);

  factory Variables$Mutation$DeleteDeviceApiToken.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$device = data['device'];
    result$data['device'] = (l$device as String);
    return Variables$Mutation$DeleteDeviceApiToken._(result$data);
  }

  Map<String, dynamic> _$data;

  String get device => (_$data['device'] as String);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$device = device;
    result$data['device'] = l$device;
    return result$data;
  }

  CopyWith$Variables$Mutation$DeleteDeviceApiToken<
          Variables$Mutation$DeleteDeviceApiToken>
      get copyWith => CopyWith$Variables$Mutation$DeleteDeviceApiToken(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$DeleteDeviceApiToken) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$device = device;
    final lOther$device = other.device;
    if (l$device != lOther$device) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$device = device;
    return Object.hashAll([l$device]);
  }
}

abstract class CopyWith$Variables$Mutation$DeleteDeviceApiToken<TRes> {
  factory CopyWith$Variables$Mutation$DeleteDeviceApiToken(
    Variables$Mutation$DeleteDeviceApiToken instance,
    TRes Function(Variables$Mutation$DeleteDeviceApiToken) then,
  ) = _CopyWithImpl$Variables$Mutation$DeleteDeviceApiToken;

  factory CopyWith$Variables$Mutation$DeleteDeviceApiToken.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$DeleteDeviceApiToken;

  TRes call({String? device});
}

class _CopyWithImpl$Variables$Mutation$DeleteDeviceApiToken<TRes>
    implements CopyWith$Variables$Mutation$DeleteDeviceApiToken<TRes> {
  _CopyWithImpl$Variables$Mutation$DeleteDeviceApiToken(
    this._instance,
    this._then,
  );

  final Variables$Mutation$DeleteDeviceApiToken _instance;

  final TRes Function(Variables$Mutation$DeleteDeviceApiToken) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? device = _undefined}) =>
      _then(Variables$Mutation$DeleteDeviceApiToken._({
        ..._instance._$data,
        if (device != _undefined && device != null)
          'device': (device as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$DeleteDeviceApiToken<TRes>
    implements CopyWith$Variables$Mutation$DeleteDeviceApiToken<TRes> {
  _CopyWithStubImpl$Variables$Mutation$DeleteDeviceApiToken(this._res);

  TRes _res;

  call({String? device}) => _res;
}

class Mutation$DeleteDeviceApiToken {
  Mutation$DeleteDeviceApiToken({
    required this.deleteDeviceApiToken,
    this.$__typename = 'Mutation',
  });

  factory Mutation$DeleteDeviceApiToken.fromJson(Map<String, dynamic> json) {
    final l$deleteDeviceApiToken = json['deleteDeviceApiToken'];
    final l$$__typename = json['__typename'];
    return Mutation$DeleteDeviceApiToken(
      deleteDeviceApiToken:
          Mutation$DeleteDeviceApiToken$deleteDeviceApiToken.fromJson(
              (l$deleteDeviceApiToken as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$DeleteDeviceApiToken$deleteDeviceApiToken deleteDeviceApiToken;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteDeviceApiToken = deleteDeviceApiToken;
    _resultData['deleteDeviceApiToken'] = l$deleteDeviceApiToken.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteDeviceApiToken = deleteDeviceApiToken;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$deleteDeviceApiToken,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$DeleteDeviceApiToken) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteDeviceApiToken = deleteDeviceApiToken;
    final lOther$deleteDeviceApiToken = other.deleteDeviceApiToken;
    if (l$deleteDeviceApiToken != lOther$deleteDeviceApiToken) {
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

extension UtilityExtension$Mutation$DeleteDeviceApiToken
    on Mutation$DeleteDeviceApiToken {
  CopyWith$Mutation$DeleteDeviceApiToken<Mutation$DeleteDeviceApiToken>
      get copyWith => CopyWith$Mutation$DeleteDeviceApiToken(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$DeleteDeviceApiToken<TRes> {
  factory CopyWith$Mutation$DeleteDeviceApiToken(
    Mutation$DeleteDeviceApiToken instance,
    TRes Function(Mutation$DeleteDeviceApiToken) then,
  ) = _CopyWithImpl$Mutation$DeleteDeviceApiToken;

  factory CopyWith$Mutation$DeleteDeviceApiToken.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DeleteDeviceApiToken;

  TRes call({
    Mutation$DeleteDeviceApiToken$deleteDeviceApiToken? deleteDeviceApiToken,
    String? $__typename,
  });
  CopyWith$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken<TRes>
      get deleteDeviceApiToken;
}

class _CopyWithImpl$Mutation$DeleteDeviceApiToken<TRes>
    implements CopyWith$Mutation$DeleteDeviceApiToken<TRes> {
  _CopyWithImpl$Mutation$DeleteDeviceApiToken(
    this._instance,
    this._then,
  );

  final Mutation$DeleteDeviceApiToken _instance;

  final TRes Function(Mutation$DeleteDeviceApiToken) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? deleteDeviceApiToken = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$DeleteDeviceApiToken(
        deleteDeviceApiToken:
            deleteDeviceApiToken == _undefined || deleteDeviceApiToken == null
                ? _instance.deleteDeviceApiToken
                : (deleteDeviceApiToken
                    as Mutation$DeleteDeviceApiToken$deleteDeviceApiToken),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken<TRes>
      get deleteDeviceApiToken {
    final local$deleteDeviceApiToken = _instance.deleteDeviceApiToken;
    return CopyWith$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken(
        local$deleteDeviceApiToken, (e) => call(deleteDeviceApiToken: e));
  }
}

class _CopyWithStubImpl$Mutation$DeleteDeviceApiToken<TRes>
    implements CopyWith$Mutation$DeleteDeviceApiToken<TRes> {
  _CopyWithStubImpl$Mutation$DeleteDeviceApiToken(this._res);

  TRes _res;

  call({
    Mutation$DeleteDeviceApiToken$deleteDeviceApiToken? deleteDeviceApiToken,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken<TRes>
      get deleteDeviceApiToken =>
          CopyWith$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken.stub(
              _res);
}

const documentNodeMutationDeleteDeviceApiToken = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'DeleteDeviceApiToken'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'device')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'deleteDeviceApiToken'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'device'),
            value: VariableNode(name: NameNode(value: 'device')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
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
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$DeleteDeviceApiToken _parserFn$Mutation$DeleteDeviceApiToken(
        Map<String, dynamic> data) =>
    Mutation$DeleteDeviceApiToken.fromJson(data);
typedef OnMutationCompleted$Mutation$DeleteDeviceApiToken = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$DeleteDeviceApiToken?,
);

class Options$Mutation$DeleteDeviceApiToken
    extends graphql.MutationOptions<Mutation$DeleteDeviceApiToken> {
  Options$Mutation$DeleteDeviceApiToken({
    String? operationName,
    required Variables$Mutation$DeleteDeviceApiToken variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DeleteDeviceApiToken? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$DeleteDeviceApiToken? onCompleted,
    graphql.OnMutationUpdate<Mutation$DeleteDeviceApiToken>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$DeleteDeviceApiToken(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationDeleteDeviceApiToken,
          parserFn: _parserFn$Mutation$DeleteDeviceApiToken,
        );

  final OnMutationCompleted$Mutation$DeleteDeviceApiToken?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$DeleteDeviceApiToken
    extends graphql.WatchQueryOptions<Mutation$DeleteDeviceApiToken> {
  WatchOptions$Mutation$DeleteDeviceApiToken({
    String? operationName,
    required Variables$Mutation$DeleteDeviceApiToken variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DeleteDeviceApiToken? typedOptimisticResult,
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
          document: documentNodeMutationDeleteDeviceApiToken,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$DeleteDeviceApiToken,
        );
}

extension ClientExtension$Mutation$DeleteDeviceApiToken
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$DeleteDeviceApiToken>>
      mutate$DeleteDeviceApiToken(
              Options$Mutation$DeleteDeviceApiToken options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$DeleteDeviceApiToken>
      watchMutation$DeleteDeviceApiToken(
              WatchOptions$Mutation$DeleteDeviceApiToken options) =>
          this.watchMutation(options);
}

class Mutation$DeleteDeviceApiToken$deleteDeviceApiToken
    implements Fragment$basicMutationReturnFields$$GenericMutationReturn {
  Mutation$DeleteDeviceApiToken$deleteDeviceApiToken({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Mutation$DeleteDeviceApiToken$deleteDeviceApiToken.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$DeleteDeviceApiToken$deleteDeviceApiToken(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$DeleteDeviceApiToken$deleteDeviceApiToken) ||
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

extension UtilityExtension$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken
    on Mutation$DeleteDeviceApiToken$deleteDeviceApiToken {
  CopyWith$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken<
          Mutation$DeleteDeviceApiToken$deleteDeviceApiToken>
      get copyWith =>
          CopyWith$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken<
    TRes> {
  factory CopyWith$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken(
    Mutation$DeleteDeviceApiToken$deleteDeviceApiToken instance,
    TRes Function(Mutation$DeleteDeviceApiToken$deleteDeviceApiToken) then,
  ) = _CopyWithImpl$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken;

  factory CopyWith$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken<TRes>
    implements
        CopyWith$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken<TRes> {
  _CopyWithImpl$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken(
    this._instance,
    this._then,
  );

  final Mutation$DeleteDeviceApiToken$deleteDeviceApiToken _instance;

  final TRes Function(Mutation$DeleteDeviceApiToken$deleteDeviceApiToken) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$DeleteDeviceApiToken$deleteDeviceApiToken(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken<TRes>
    implements
        CopyWith$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken<TRes> {
  _CopyWithStubImpl$Mutation$DeleteDeviceApiToken$deleteDeviceApiToken(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Mutation$GetNewDeviceApiKey {
  Mutation$GetNewDeviceApiKey({
    required this.getNewDeviceApiKey,
    this.$__typename = 'Mutation',
  });

  factory Mutation$GetNewDeviceApiKey.fromJson(Map<String, dynamic> json) {
    final l$getNewDeviceApiKey = json['getNewDeviceApiKey'];
    final l$$__typename = json['__typename'];
    return Mutation$GetNewDeviceApiKey(
      getNewDeviceApiKey:
          Mutation$GetNewDeviceApiKey$getNewDeviceApiKey.fromJson(
              (l$getNewDeviceApiKey as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$GetNewDeviceApiKey$getNewDeviceApiKey getNewDeviceApiKey;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getNewDeviceApiKey = getNewDeviceApiKey;
    _resultData['getNewDeviceApiKey'] = l$getNewDeviceApiKey.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getNewDeviceApiKey = getNewDeviceApiKey;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getNewDeviceApiKey,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$GetNewDeviceApiKey) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$getNewDeviceApiKey = getNewDeviceApiKey;
    final lOther$getNewDeviceApiKey = other.getNewDeviceApiKey;
    if (l$getNewDeviceApiKey != lOther$getNewDeviceApiKey) {
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

extension UtilityExtension$Mutation$GetNewDeviceApiKey
    on Mutation$GetNewDeviceApiKey {
  CopyWith$Mutation$GetNewDeviceApiKey<Mutation$GetNewDeviceApiKey>
      get copyWith => CopyWith$Mutation$GetNewDeviceApiKey(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$GetNewDeviceApiKey<TRes> {
  factory CopyWith$Mutation$GetNewDeviceApiKey(
    Mutation$GetNewDeviceApiKey instance,
    TRes Function(Mutation$GetNewDeviceApiKey) then,
  ) = _CopyWithImpl$Mutation$GetNewDeviceApiKey;

  factory CopyWith$Mutation$GetNewDeviceApiKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$GetNewDeviceApiKey;

  TRes call({
    Mutation$GetNewDeviceApiKey$getNewDeviceApiKey? getNewDeviceApiKey,
    String? $__typename,
  });
  CopyWith$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey<TRes>
      get getNewDeviceApiKey;
}

class _CopyWithImpl$Mutation$GetNewDeviceApiKey<TRes>
    implements CopyWith$Mutation$GetNewDeviceApiKey<TRes> {
  _CopyWithImpl$Mutation$GetNewDeviceApiKey(
    this._instance,
    this._then,
  );

  final Mutation$GetNewDeviceApiKey _instance;

  final TRes Function(Mutation$GetNewDeviceApiKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getNewDeviceApiKey = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$GetNewDeviceApiKey(
        getNewDeviceApiKey:
            getNewDeviceApiKey == _undefined || getNewDeviceApiKey == null
                ? _instance.getNewDeviceApiKey
                : (getNewDeviceApiKey
                    as Mutation$GetNewDeviceApiKey$getNewDeviceApiKey),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey<TRes>
      get getNewDeviceApiKey {
    final local$getNewDeviceApiKey = _instance.getNewDeviceApiKey;
    return CopyWith$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey(
        local$getNewDeviceApiKey, (e) => call(getNewDeviceApiKey: e));
  }
}

class _CopyWithStubImpl$Mutation$GetNewDeviceApiKey<TRes>
    implements CopyWith$Mutation$GetNewDeviceApiKey<TRes> {
  _CopyWithStubImpl$Mutation$GetNewDeviceApiKey(this._res);

  TRes _res;

  call({
    Mutation$GetNewDeviceApiKey$getNewDeviceApiKey? getNewDeviceApiKey,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey<TRes>
      get getNewDeviceApiKey =>
          CopyWith$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey.stub(_res);
}

const documentNodeMutationGetNewDeviceApiKey = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'GetNewDeviceApiKey'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getNewDeviceApiKey'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'basicMutationReturnFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: 'key'),
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
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$GetNewDeviceApiKey _parserFn$Mutation$GetNewDeviceApiKey(
        Map<String, dynamic> data) =>
    Mutation$GetNewDeviceApiKey.fromJson(data);
typedef OnMutationCompleted$Mutation$GetNewDeviceApiKey = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$GetNewDeviceApiKey?,
);

class Options$Mutation$GetNewDeviceApiKey
    extends graphql.MutationOptions<Mutation$GetNewDeviceApiKey> {
  Options$Mutation$GetNewDeviceApiKey({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$GetNewDeviceApiKey? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$GetNewDeviceApiKey? onCompleted,
    graphql.OnMutationUpdate<Mutation$GetNewDeviceApiKey>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$GetNewDeviceApiKey(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationGetNewDeviceApiKey,
          parserFn: _parserFn$Mutation$GetNewDeviceApiKey,
        );

  final OnMutationCompleted$Mutation$GetNewDeviceApiKey? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$GetNewDeviceApiKey
    extends graphql.WatchQueryOptions<Mutation$GetNewDeviceApiKey> {
  WatchOptions$Mutation$GetNewDeviceApiKey({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$GetNewDeviceApiKey? typedOptimisticResult,
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
          document: documentNodeMutationGetNewDeviceApiKey,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$GetNewDeviceApiKey,
        );
}

extension ClientExtension$Mutation$GetNewDeviceApiKey on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$GetNewDeviceApiKey>>
      mutate$GetNewDeviceApiKey(
              [Options$Mutation$GetNewDeviceApiKey? options]) async =>
          await this.mutate(options ?? Options$Mutation$GetNewDeviceApiKey());
  graphql.ObservableQuery<
      Mutation$GetNewDeviceApiKey> watchMutation$GetNewDeviceApiKey(
          [WatchOptions$Mutation$GetNewDeviceApiKey? options]) =>
      this.watchMutation(options ?? WatchOptions$Mutation$GetNewDeviceApiKey());
}

class Mutation$GetNewDeviceApiKey$getNewDeviceApiKey
    implements Fragment$basicMutationReturnFields$$ApiKeyMutationReturn {
  Mutation$GetNewDeviceApiKey$getNewDeviceApiKey({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ApiKeyMutationReturn',
    this.key,
  });

  factory Mutation$GetNewDeviceApiKey$getNewDeviceApiKey.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$key = json['key'];
    return Mutation$GetNewDeviceApiKey$getNewDeviceApiKey(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      key: (l$key as String?),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final String? key;

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
    final l$key = key;
    _resultData['key'] = l$key;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$key = key;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
      l$key,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$GetNewDeviceApiKey$getNewDeviceApiKey) ||
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
    final l$key = key;
    final lOther$key = other.key;
    if (l$key != lOther$key) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey
    on Mutation$GetNewDeviceApiKey$getNewDeviceApiKey {
  CopyWith$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey<
          Mutation$GetNewDeviceApiKey$getNewDeviceApiKey>
      get copyWith => CopyWith$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey<TRes> {
  factory CopyWith$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey(
    Mutation$GetNewDeviceApiKey$getNewDeviceApiKey instance,
    TRes Function(Mutation$GetNewDeviceApiKey$getNewDeviceApiKey) then,
  ) = _CopyWithImpl$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey;

  factory CopyWith$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    String? key,
  });
}

class _CopyWithImpl$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey<TRes>
    implements CopyWith$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey<TRes> {
  _CopyWithImpl$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey(
    this._instance,
    this._then,
  );

  final Mutation$GetNewDeviceApiKey$getNewDeviceApiKey _instance;

  final TRes Function(Mutation$GetNewDeviceApiKey$getNewDeviceApiKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? key = _undefined,
  }) =>
      _then(Mutation$GetNewDeviceApiKey$getNewDeviceApiKey(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
        key: key == _undefined ? _instance.key : (key as String?),
      ));
}

class _CopyWithStubImpl$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey<TRes>
    implements CopyWith$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey<TRes> {
  _CopyWithStubImpl$Mutation$GetNewDeviceApiKey$getNewDeviceApiKey(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    String? key,
  }) =>
      _res;
}

class Mutation$InvalidateNewDeviceApiKey {
  Mutation$InvalidateNewDeviceApiKey({
    required this.invalidateNewDeviceApiKey,
    this.$__typename = 'Mutation',
  });

  factory Mutation$InvalidateNewDeviceApiKey.fromJson(
      Map<String, dynamic> json) {
    final l$invalidateNewDeviceApiKey = json['invalidateNewDeviceApiKey'];
    final l$$__typename = json['__typename'];
    return Mutation$InvalidateNewDeviceApiKey(
      invalidateNewDeviceApiKey:
          Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey.fromJson(
              (l$invalidateNewDeviceApiKey as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey
      invalidateNewDeviceApiKey;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$invalidateNewDeviceApiKey = invalidateNewDeviceApiKey;
    _resultData['invalidateNewDeviceApiKey'] =
        l$invalidateNewDeviceApiKey.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$invalidateNewDeviceApiKey = invalidateNewDeviceApiKey;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$invalidateNewDeviceApiKey,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$InvalidateNewDeviceApiKey) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$invalidateNewDeviceApiKey = invalidateNewDeviceApiKey;
    final lOther$invalidateNewDeviceApiKey = other.invalidateNewDeviceApiKey;
    if (l$invalidateNewDeviceApiKey != lOther$invalidateNewDeviceApiKey) {
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

extension UtilityExtension$Mutation$InvalidateNewDeviceApiKey
    on Mutation$InvalidateNewDeviceApiKey {
  CopyWith$Mutation$InvalidateNewDeviceApiKey<
          Mutation$InvalidateNewDeviceApiKey>
      get copyWith => CopyWith$Mutation$InvalidateNewDeviceApiKey(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$InvalidateNewDeviceApiKey<TRes> {
  factory CopyWith$Mutation$InvalidateNewDeviceApiKey(
    Mutation$InvalidateNewDeviceApiKey instance,
    TRes Function(Mutation$InvalidateNewDeviceApiKey) then,
  ) = _CopyWithImpl$Mutation$InvalidateNewDeviceApiKey;

  factory CopyWith$Mutation$InvalidateNewDeviceApiKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$InvalidateNewDeviceApiKey;

  TRes call({
    Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey?
        invalidateNewDeviceApiKey,
    String? $__typename,
  });
  CopyWith$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey<TRes>
      get invalidateNewDeviceApiKey;
}

class _CopyWithImpl$Mutation$InvalidateNewDeviceApiKey<TRes>
    implements CopyWith$Mutation$InvalidateNewDeviceApiKey<TRes> {
  _CopyWithImpl$Mutation$InvalidateNewDeviceApiKey(
    this._instance,
    this._then,
  );

  final Mutation$InvalidateNewDeviceApiKey _instance;

  final TRes Function(Mutation$InvalidateNewDeviceApiKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? invalidateNewDeviceApiKey = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$InvalidateNewDeviceApiKey(
        invalidateNewDeviceApiKey: invalidateNewDeviceApiKey == _undefined ||
                invalidateNewDeviceApiKey == null
            ? _instance.invalidateNewDeviceApiKey
            : (invalidateNewDeviceApiKey
                as Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey<TRes>
      get invalidateNewDeviceApiKey {
    final local$invalidateNewDeviceApiKey = _instance.invalidateNewDeviceApiKey;
    return CopyWith$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey(
        local$invalidateNewDeviceApiKey,
        (e) => call(invalidateNewDeviceApiKey: e));
  }
}

class _CopyWithStubImpl$Mutation$InvalidateNewDeviceApiKey<TRes>
    implements CopyWith$Mutation$InvalidateNewDeviceApiKey<TRes> {
  _CopyWithStubImpl$Mutation$InvalidateNewDeviceApiKey(this._res);

  TRes _res;

  call({
    Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey?
        invalidateNewDeviceApiKey,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey<TRes>
      get invalidateNewDeviceApiKey =>
          CopyWith$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey
              .stub(_res);
}

const documentNodeMutationInvalidateNewDeviceApiKey =
    DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'InvalidateNewDeviceApiKey'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'invalidateNewDeviceApiKey'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
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
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$InvalidateNewDeviceApiKey _parserFn$Mutation$InvalidateNewDeviceApiKey(
        Map<String, dynamic> data) =>
    Mutation$InvalidateNewDeviceApiKey.fromJson(data);
typedef OnMutationCompleted$Mutation$InvalidateNewDeviceApiKey = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$InvalidateNewDeviceApiKey?,
);

class Options$Mutation$InvalidateNewDeviceApiKey
    extends graphql.MutationOptions<Mutation$InvalidateNewDeviceApiKey> {
  Options$Mutation$InvalidateNewDeviceApiKey({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$InvalidateNewDeviceApiKey? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$InvalidateNewDeviceApiKey? onCompleted,
    graphql.OnMutationUpdate<Mutation$InvalidateNewDeviceApiKey>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$InvalidateNewDeviceApiKey(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationInvalidateNewDeviceApiKey,
          parserFn: _parserFn$Mutation$InvalidateNewDeviceApiKey,
        );

  final OnMutationCompleted$Mutation$InvalidateNewDeviceApiKey?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$InvalidateNewDeviceApiKey
    extends graphql.WatchQueryOptions<Mutation$InvalidateNewDeviceApiKey> {
  WatchOptions$Mutation$InvalidateNewDeviceApiKey({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$InvalidateNewDeviceApiKey? typedOptimisticResult,
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
          document: documentNodeMutationInvalidateNewDeviceApiKey,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$InvalidateNewDeviceApiKey,
        );
}

extension ClientExtension$Mutation$InvalidateNewDeviceApiKey
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$InvalidateNewDeviceApiKey>>
      mutate$InvalidateNewDeviceApiKey(
              [Options$Mutation$InvalidateNewDeviceApiKey? options]) async =>
          await this
              .mutate(options ?? Options$Mutation$InvalidateNewDeviceApiKey());
  graphql.ObservableQuery<Mutation$InvalidateNewDeviceApiKey>
      watchMutation$InvalidateNewDeviceApiKey(
              [WatchOptions$Mutation$InvalidateNewDeviceApiKey? options]) =>
          this.watchMutation(
              options ?? WatchOptions$Mutation$InvalidateNewDeviceApiKey());
}

class Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey
    implements Fragment$basicMutationReturnFields$$GenericMutationReturn {
  Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'GenericMutationReturn',
  });

  factory Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey(
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey) ||
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

extension UtilityExtension$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey
    on Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey {
  CopyWith$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey<
          Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey>
      get copyWith =>
          CopyWith$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey<
    TRes> {
  factory CopyWith$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey(
    Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey instance,
    TRes Function(Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey)
        then,
  ) = _CopyWithImpl$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey;

  factory CopyWith$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey<
        TRes>
    implements
        CopyWith$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey<
            TRes> {
  _CopyWithImpl$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey(
    this._instance,
    this._then,
  );

  final Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey _instance;

  final TRes Function(
      Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey<
        TRes>
    implements
        CopyWith$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey<
            TRes> {
  _CopyWithStubImpl$Mutation$InvalidateNewDeviceApiKey$invalidateNewDeviceApiKey(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$AuthorizeWithNewDeviceApiKey {
  factory Variables$Mutation$AuthorizeWithNewDeviceApiKey(
          {required Input$UseNewDeviceKeyInput input}) =>
      Variables$Mutation$AuthorizeWithNewDeviceApiKey._({
        r'input': input,
      });

  Variables$Mutation$AuthorizeWithNewDeviceApiKey._(this._$data);

  factory Variables$Mutation$AuthorizeWithNewDeviceApiKey.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] =
        Input$UseNewDeviceKeyInput.fromJson((l$input as Map<String, dynamic>));
    return Variables$Mutation$AuthorizeWithNewDeviceApiKey._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$UseNewDeviceKeyInput get input =>
      (_$data['input'] as Input$UseNewDeviceKeyInput);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$AuthorizeWithNewDeviceApiKey<
          Variables$Mutation$AuthorizeWithNewDeviceApiKey>
      get copyWith => CopyWith$Variables$Mutation$AuthorizeWithNewDeviceApiKey(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$AuthorizeWithNewDeviceApiKey) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$AuthorizeWithNewDeviceApiKey<TRes> {
  factory CopyWith$Variables$Mutation$AuthorizeWithNewDeviceApiKey(
    Variables$Mutation$AuthorizeWithNewDeviceApiKey instance,
    TRes Function(Variables$Mutation$AuthorizeWithNewDeviceApiKey) then,
  ) = _CopyWithImpl$Variables$Mutation$AuthorizeWithNewDeviceApiKey;

  factory CopyWith$Variables$Mutation$AuthorizeWithNewDeviceApiKey.stub(
          TRes res) =
      _CopyWithStubImpl$Variables$Mutation$AuthorizeWithNewDeviceApiKey;

  TRes call({Input$UseNewDeviceKeyInput? input});
}

class _CopyWithImpl$Variables$Mutation$AuthorizeWithNewDeviceApiKey<TRes>
    implements CopyWith$Variables$Mutation$AuthorizeWithNewDeviceApiKey<TRes> {
  _CopyWithImpl$Variables$Mutation$AuthorizeWithNewDeviceApiKey(
    this._instance,
    this._then,
  );

  final Variables$Mutation$AuthorizeWithNewDeviceApiKey _instance;

  final TRes Function(Variables$Mutation$AuthorizeWithNewDeviceApiKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$AuthorizeWithNewDeviceApiKey._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$UseNewDeviceKeyInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$AuthorizeWithNewDeviceApiKey<TRes>
    implements CopyWith$Variables$Mutation$AuthorizeWithNewDeviceApiKey<TRes> {
  _CopyWithStubImpl$Variables$Mutation$AuthorizeWithNewDeviceApiKey(this._res);

  TRes _res;

  call({Input$UseNewDeviceKeyInput? input}) => _res;
}

class Mutation$AuthorizeWithNewDeviceApiKey {
  Mutation$AuthorizeWithNewDeviceApiKey({
    required this.authorizeWithNewDeviceApiKey,
    this.$__typename = 'Mutation',
  });

  factory Mutation$AuthorizeWithNewDeviceApiKey.fromJson(
      Map<String, dynamic> json) {
    final l$authorizeWithNewDeviceApiKey = json['authorizeWithNewDeviceApiKey'];
    final l$$__typename = json['__typename'];
    return Mutation$AuthorizeWithNewDeviceApiKey(
      authorizeWithNewDeviceApiKey:
          Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey
              .fromJson(
                  (l$authorizeWithNewDeviceApiKey as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey
      authorizeWithNewDeviceApiKey;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$authorizeWithNewDeviceApiKey = authorizeWithNewDeviceApiKey;
    _resultData['authorizeWithNewDeviceApiKey'] =
        l$authorizeWithNewDeviceApiKey.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$authorizeWithNewDeviceApiKey = authorizeWithNewDeviceApiKey;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$authorizeWithNewDeviceApiKey,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$AuthorizeWithNewDeviceApiKey) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$authorizeWithNewDeviceApiKey = authorizeWithNewDeviceApiKey;
    final lOther$authorizeWithNewDeviceApiKey =
        other.authorizeWithNewDeviceApiKey;
    if (l$authorizeWithNewDeviceApiKey != lOther$authorizeWithNewDeviceApiKey) {
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

extension UtilityExtension$Mutation$AuthorizeWithNewDeviceApiKey
    on Mutation$AuthorizeWithNewDeviceApiKey {
  CopyWith$Mutation$AuthorizeWithNewDeviceApiKey<
          Mutation$AuthorizeWithNewDeviceApiKey>
      get copyWith => CopyWith$Mutation$AuthorizeWithNewDeviceApiKey(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$AuthorizeWithNewDeviceApiKey<TRes> {
  factory CopyWith$Mutation$AuthorizeWithNewDeviceApiKey(
    Mutation$AuthorizeWithNewDeviceApiKey instance,
    TRes Function(Mutation$AuthorizeWithNewDeviceApiKey) then,
  ) = _CopyWithImpl$Mutation$AuthorizeWithNewDeviceApiKey;

  factory CopyWith$Mutation$AuthorizeWithNewDeviceApiKey.stub(TRes res) =
      _CopyWithStubImpl$Mutation$AuthorizeWithNewDeviceApiKey;

  TRes call({
    Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey?
        authorizeWithNewDeviceApiKey,
    String? $__typename,
  });
  CopyWith$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey<
      TRes> get authorizeWithNewDeviceApiKey;
}

class _CopyWithImpl$Mutation$AuthorizeWithNewDeviceApiKey<TRes>
    implements CopyWith$Mutation$AuthorizeWithNewDeviceApiKey<TRes> {
  _CopyWithImpl$Mutation$AuthorizeWithNewDeviceApiKey(
    this._instance,
    this._then,
  );

  final Mutation$AuthorizeWithNewDeviceApiKey _instance;

  final TRes Function(Mutation$AuthorizeWithNewDeviceApiKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? authorizeWithNewDeviceApiKey = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$AuthorizeWithNewDeviceApiKey(
        authorizeWithNewDeviceApiKey: authorizeWithNewDeviceApiKey ==
                    _undefined ||
                authorizeWithNewDeviceApiKey == null
            ? _instance.authorizeWithNewDeviceApiKey
            : (authorizeWithNewDeviceApiKey
                as Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey<
      TRes> get authorizeWithNewDeviceApiKey {
    final local$authorizeWithNewDeviceApiKey =
        _instance.authorizeWithNewDeviceApiKey;
    return CopyWith$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey(
        local$authorizeWithNewDeviceApiKey,
        (e) => call(authorizeWithNewDeviceApiKey: e));
  }
}

class _CopyWithStubImpl$Mutation$AuthorizeWithNewDeviceApiKey<TRes>
    implements CopyWith$Mutation$AuthorizeWithNewDeviceApiKey<TRes> {
  _CopyWithStubImpl$Mutation$AuthorizeWithNewDeviceApiKey(this._res);

  TRes _res;

  call({
    Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey?
        authorizeWithNewDeviceApiKey,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey<
          TRes>
      get authorizeWithNewDeviceApiKey =>
          CopyWith$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey
              .stub(_res);
}

const documentNodeMutationAuthorizeWithNewDeviceApiKey =
    DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'AuthorizeWithNewDeviceApiKey'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'UseNewDeviceKeyInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'authorizeWithNewDeviceApiKey'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'basicMutationReturnFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: 'token'),
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
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionbasicMutationReturnFields,
]);
Mutation$AuthorizeWithNewDeviceApiKey
    _parserFn$Mutation$AuthorizeWithNewDeviceApiKey(
            Map<String, dynamic> data) =>
        Mutation$AuthorizeWithNewDeviceApiKey.fromJson(data);
typedef OnMutationCompleted$Mutation$AuthorizeWithNewDeviceApiKey
    = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$AuthorizeWithNewDeviceApiKey?,
);

class Options$Mutation$AuthorizeWithNewDeviceApiKey
    extends graphql.MutationOptions<Mutation$AuthorizeWithNewDeviceApiKey> {
  Options$Mutation$AuthorizeWithNewDeviceApiKey({
    String? operationName,
    required Variables$Mutation$AuthorizeWithNewDeviceApiKey variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$AuthorizeWithNewDeviceApiKey? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$AuthorizeWithNewDeviceApiKey? onCompleted,
    graphql.OnMutationUpdate<Mutation$AuthorizeWithNewDeviceApiKey>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$AuthorizeWithNewDeviceApiKey(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationAuthorizeWithNewDeviceApiKey,
          parserFn: _parserFn$Mutation$AuthorizeWithNewDeviceApiKey,
        );

  final OnMutationCompleted$Mutation$AuthorizeWithNewDeviceApiKey?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$AuthorizeWithNewDeviceApiKey
    extends graphql.WatchQueryOptions<Mutation$AuthorizeWithNewDeviceApiKey> {
  WatchOptions$Mutation$AuthorizeWithNewDeviceApiKey({
    String? operationName,
    required Variables$Mutation$AuthorizeWithNewDeviceApiKey variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$AuthorizeWithNewDeviceApiKey? typedOptimisticResult,
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
          document: documentNodeMutationAuthorizeWithNewDeviceApiKey,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$AuthorizeWithNewDeviceApiKey,
        );
}

extension ClientExtension$Mutation$AuthorizeWithNewDeviceApiKey
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$AuthorizeWithNewDeviceApiKey>>
      mutate$AuthorizeWithNewDeviceApiKey(
              Options$Mutation$AuthorizeWithNewDeviceApiKey options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$AuthorizeWithNewDeviceApiKey>
      watchMutation$AuthorizeWithNewDeviceApiKey(
              WatchOptions$Mutation$AuthorizeWithNewDeviceApiKey options) =>
          this.watchMutation(options);
}

class Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey
    implements
        Fragment$basicMutationReturnFields$$DeviceApiTokenMutationReturn {
  Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'DeviceApiTokenMutationReturn',
    this.token,
  });

  factory Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$token = json['token'];
    return Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      token: (l$token as String?),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final String? token;

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
    final l$token = token;
    _resultData['token'] = l$token;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$token = token;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
      l$token,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey) ||
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
    final l$token = token;
    final lOther$token = other.token;
    if (l$token != lOther$token) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey
    on Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey {
  CopyWith$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey<
          Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey>
      get copyWith =>
          CopyWith$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey<
    TRes> {
  factory CopyWith$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey(
    Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey instance,
    TRes Function(
            Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey)
        then,
  ) = _CopyWithImpl$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey;

  factory CopyWith$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    String? token,
  });
}

class _CopyWithImpl$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey<
        TRes>
    implements
        CopyWith$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey<
            TRes> {
  _CopyWithImpl$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey(
    this._instance,
    this._then,
  );

  final Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey
      _instance;

  final TRes Function(
      Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? token = _undefined,
  }) =>
      _then(Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey(
        code:
            code == _undefined || code == null ? _instance.code : (code as int),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        success: success == _undefined || success == null
            ? _instance.success
            : (success as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
        token: token == _undefined ? _instance.token : (token as String?),
      ));
}

class _CopyWithStubImpl$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey<
        TRes>
    implements
        CopyWith$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey<
            TRes> {
  _CopyWithStubImpl$Mutation$AuthorizeWithNewDeviceApiKey$authorizeWithNewDeviceApiKey(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    String? token,
  }) =>
      _res;
}
