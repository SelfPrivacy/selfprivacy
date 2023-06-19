import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'schema.graphql.dart';
import 'services.graphql.dart';

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

class Query$SystemSettings {
  Query$SystemSettings({
    required this.system,
    this.$__typename = 'Query',
  });

  factory Query$SystemSettings.fromJson(Map<String, dynamic> json) {
    final l$system = json['system'];
    final l$$__typename = json['__typename'];
    return Query$SystemSettings(
      system: Query$SystemSettings$system.fromJson(
          (l$system as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$SystemSettings$system system;

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
    if (!(other is Query$SystemSettings) || runtimeType != other.runtimeType) {
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

extension UtilityExtension$Query$SystemSettings on Query$SystemSettings {
  CopyWith$Query$SystemSettings<Query$SystemSettings> get copyWith =>
      CopyWith$Query$SystemSettings(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$SystemSettings<TRes> {
  factory CopyWith$Query$SystemSettings(
    Query$SystemSettings instance,
    TRes Function(Query$SystemSettings) then,
  ) = _CopyWithImpl$Query$SystemSettings;

  factory CopyWith$Query$SystemSettings.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemSettings;

  TRes call({
    Query$SystemSettings$system? system,
    String? $__typename,
  });
  CopyWith$Query$SystemSettings$system<TRes> get system;
}

class _CopyWithImpl$Query$SystemSettings<TRes>
    implements CopyWith$Query$SystemSettings<TRes> {
  _CopyWithImpl$Query$SystemSettings(
    this._instance,
    this._then,
  );

  final Query$SystemSettings _instance;

  final TRes Function(Query$SystemSettings) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? system = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$SystemSettings(
        system: system == _undefined || system == null
            ? _instance.system
            : (system as Query$SystemSettings$system),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$SystemSettings$system<TRes> get system {
    final local$system = _instance.system;
    return CopyWith$Query$SystemSettings$system(
        local$system, (e) => call(system: e));
  }
}

class _CopyWithStubImpl$Query$SystemSettings<TRes>
    implements CopyWith$Query$SystemSettings<TRes> {
  _CopyWithStubImpl$Query$SystemSettings(this._res);

  TRes _res;

  call({
    Query$SystemSettings$system? system,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$SystemSettings$system<TRes> get system =>
      CopyWith$Query$SystemSettings$system.stub(_res);
}

const documentNodeQuerySystemSettings = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'SystemSettings'),
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
            name: NameNode(value: 'settings'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'autoUpgrade'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'allowReboot'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'enable'),
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
                name: NameNode(value: 'ssh'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'enable'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'passwordAuthentication'),
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
                name: NameNode(value: 'timezone'),
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
Query$SystemSettings _parserFn$Query$SystemSettings(
        Map<String, dynamic> data) =>
    Query$SystemSettings.fromJson(data);
typedef OnQueryComplete$Query$SystemSettings = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$SystemSettings?,
);

class Options$Query$SystemSettings
    extends graphql.QueryOptions<Query$SystemSettings> {
  Options$Query$SystemSettings({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$SystemSettings? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$SystemSettings? onComplete,
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
                    data == null ? null : _parserFn$Query$SystemSettings(data),
                  ),
          onError: onError,
          document: documentNodeQuerySystemSettings,
          parserFn: _parserFn$Query$SystemSettings,
        );

  final OnQueryComplete$Query$SystemSettings? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$SystemSettings
    extends graphql.WatchQueryOptions<Query$SystemSettings> {
  WatchOptions$Query$SystemSettings({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$SystemSettings? typedOptimisticResult,
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
          document: documentNodeQuerySystemSettings,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$SystemSettings,
        );
}

class FetchMoreOptions$Query$SystemSettings extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$SystemSettings(
      {required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQuerySystemSettings,
        );
}

extension ClientExtension$Query$SystemSettings on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$SystemSettings>> query$SystemSettings(
          [Options$Query$SystemSettings? options]) async =>
      await this.query(options ?? Options$Query$SystemSettings());
  graphql.ObservableQuery<Query$SystemSettings> watchQuery$SystemSettings(
          [WatchOptions$Query$SystemSettings? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$SystemSettings());
  void writeQuery$SystemSettings({
    required Query$SystemSettings data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQuerySystemSettings)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$SystemSettings? readQuery$SystemSettings({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQuerySystemSettings)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$SystemSettings.fromJson(result);
  }
}

class Query$SystemSettings$system {
  Query$SystemSettings$system({
    required this.settings,
    this.$__typename = 'System',
  });

  factory Query$SystemSettings$system.fromJson(Map<String, dynamic> json) {
    final l$settings = json['settings'];
    final l$$__typename = json['__typename'];
    return Query$SystemSettings$system(
      settings: Query$SystemSettings$system$settings.fromJson(
          (l$settings as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$SystemSettings$system$settings settings;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$settings = settings;
    _resultData['settings'] = l$settings.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$settings = settings;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$settings,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$SystemSettings$system) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$settings = settings;
    final lOther$settings = other.settings;
    if (l$settings != lOther$settings) {
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

extension UtilityExtension$Query$SystemSettings$system
    on Query$SystemSettings$system {
  CopyWith$Query$SystemSettings$system<Query$SystemSettings$system>
      get copyWith => CopyWith$Query$SystemSettings$system(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$SystemSettings$system<TRes> {
  factory CopyWith$Query$SystemSettings$system(
    Query$SystemSettings$system instance,
    TRes Function(Query$SystemSettings$system) then,
  ) = _CopyWithImpl$Query$SystemSettings$system;

  factory CopyWith$Query$SystemSettings$system.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemSettings$system;

  TRes call({
    Query$SystemSettings$system$settings? settings,
    String? $__typename,
  });
  CopyWith$Query$SystemSettings$system$settings<TRes> get settings;
}

class _CopyWithImpl$Query$SystemSettings$system<TRes>
    implements CopyWith$Query$SystemSettings$system<TRes> {
  _CopyWithImpl$Query$SystemSettings$system(
    this._instance,
    this._then,
  );

  final Query$SystemSettings$system _instance;

  final TRes Function(Query$SystemSettings$system) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? settings = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$SystemSettings$system(
        settings: settings == _undefined || settings == null
            ? _instance.settings
            : (settings as Query$SystemSettings$system$settings),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$SystemSettings$system$settings<TRes> get settings {
    final local$settings = _instance.settings;
    return CopyWith$Query$SystemSettings$system$settings(
        local$settings, (e) => call(settings: e));
  }
}

class _CopyWithStubImpl$Query$SystemSettings$system<TRes>
    implements CopyWith$Query$SystemSettings$system<TRes> {
  _CopyWithStubImpl$Query$SystemSettings$system(this._res);

  TRes _res;

  call({
    Query$SystemSettings$system$settings? settings,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$SystemSettings$system$settings<TRes> get settings =>
      CopyWith$Query$SystemSettings$system$settings.stub(_res);
}

class Query$SystemSettings$system$settings {
  Query$SystemSettings$system$settings({
    required this.autoUpgrade,
    required this.ssh,
    required this.timezone,
    this.$__typename = 'SystemSettings',
  });

  factory Query$SystemSettings$system$settings.fromJson(
      Map<String, dynamic> json) {
    final l$autoUpgrade = json['autoUpgrade'];
    final l$ssh = json['ssh'];
    final l$timezone = json['timezone'];
    final l$$__typename = json['__typename'];
    return Query$SystemSettings$system$settings(
      autoUpgrade: Query$SystemSettings$system$settings$autoUpgrade.fromJson(
          (l$autoUpgrade as Map<String, dynamic>)),
      ssh: Query$SystemSettings$system$settings$ssh.fromJson(
          (l$ssh as Map<String, dynamic>)),
      timezone: (l$timezone as String),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$SystemSettings$system$settings$autoUpgrade autoUpgrade;

  final Query$SystemSettings$system$settings$ssh ssh;

  final String timezone;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$autoUpgrade = autoUpgrade;
    _resultData['autoUpgrade'] = l$autoUpgrade.toJson();
    final l$ssh = ssh;
    _resultData['ssh'] = l$ssh.toJson();
    final l$timezone = timezone;
    _resultData['timezone'] = l$timezone;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$autoUpgrade = autoUpgrade;
    final l$ssh = ssh;
    final l$timezone = timezone;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$autoUpgrade,
      l$ssh,
      l$timezone,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$SystemSettings$system$settings) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$autoUpgrade = autoUpgrade;
    final lOther$autoUpgrade = other.autoUpgrade;
    if (l$autoUpgrade != lOther$autoUpgrade) {
      return false;
    }
    final l$ssh = ssh;
    final lOther$ssh = other.ssh;
    if (l$ssh != lOther$ssh) {
      return false;
    }
    final l$timezone = timezone;
    final lOther$timezone = other.timezone;
    if (l$timezone != lOther$timezone) {
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

extension UtilityExtension$Query$SystemSettings$system$settings
    on Query$SystemSettings$system$settings {
  CopyWith$Query$SystemSettings$system$settings<
          Query$SystemSettings$system$settings>
      get copyWith => CopyWith$Query$SystemSettings$system$settings(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$SystemSettings$system$settings<TRes> {
  factory CopyWith$Query$SystemSettings$system$settings(
    Query$SystemSettings$system$settings instance,
    TRes Function(Query$SystemSettings$system$settings) then,
  ) = _CopyWithImpl$Query$SystemSettings$system$settings;

  factory CopyWith$Query$SystemSettings$system$settings.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemSettings$system$settings;

  TRes call({
    Query$SystemSettings$system$settings$autoUpgrade? autoUpgrade,
    Query$SystemSettings$system$settings$ssh? ssh,
    String? timezone,
    String? $__typename,
  });
  CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes>
      get autoUpgrade;
  CopyWith$Query$SystemSettings$system$settings$ssh<TRes> get ssh;
}

class _CopyWithImpl$Query$SystemSettings$system$settings<TRes>
    implements CopyWith$Query$SystemSettings$system$settings<TRes> {
  _CopyWithImpl$Query$SystemSettings$system$settings(
    this._instance,
    this._then,
  );

  final Query$SystemSettings$system$settings _instance;

  final TRes Function(Query$SystemSettings$system$settings) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? autoUpgrade = _undefined,
    Object? ssh = _undefined,
    Object? timezone = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$SystemSettings$system$settings(
        autoUpgrade: autoUpgrade == _undefined || autoUpgrade == null
            ? _instance.autoUpgrade
            : (autoUpgrade as Query$SystemSettings$system$settings$autoUpgrade),
        ssh: ssh == _undefined || ssh == null
            ? _instance.ssh
            : (ssh as Query$SystemSettings$system$settings$ssh),
        timezone: timezone == _undefined || timezone == null
            ? _instance.timezone
            : (timezone as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes>
      get autoUpgrade {
    final local$autoUpgrade = _instance.autoUpgrade;
    return CopyWith$Query$SystemSettings$system$settings$autoUpgrade(
        local$autoUpgrade, (e) => call(autoUpgrade: e));
  }

  CopyWith$Query$SystemSettings$system$settings$ssh<TRes> get ssh {
    final local$ssh = _instance.ssh;
    return CopyWith$Query$SystemSettings$system$settings$ssh(
        local$ssh, (e) => call(ssh: e));
  }
}

class _CopyWithStubImpl$Query$SystemSettings$system$settings<TRes>
    implements CopyWith$Query$SystemSettings$system$settings<TRes> {
  _CopyWithStubImpl$Query$SystemSettings$system$settings(this._res);

  TRes _res;

  call({
    Query$SystemSettings$system$settings$autoUpgrade? autoUpgrade,
    Query$SystemSettings$system$settings$ssh? ssh,
    String? timezone,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes>
      get autoUpgrade =>
          CopyWith$Query$SystemSettings$system$settings$autoUpgrade.stub(_res);
  CopyWith$Query$SystemSettings$system$settings$ssh<TRes> get ssh =>
      CopyWith$Query$SystemSettings$system$settings$ssh.stub(_res);
}

class Query$SystemSettings$system$settings$autoUpgrade {
  Query$SystemSettings$system$settings$autoUpgrade({
    required this.allowReboot,
    required this.enable,
    this.$__typename = 'AutoUpgradeOptions',
  });

  factory Query$SystemSettings$system$settings$autoUpgrade.fromJson(
      Map<String, dynamic> json) {
    final l$allowReboot = json['allowReboot'];
    final l$enable = json['enable'];
    final l$$__typename = json['__typename'];
    return Query$SystemSettings$system$settings$autoUpgrade(
      allowReboot: (l$allowReboot as bool),
      enable: (l$enable as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final bool allowReboot;

  final bool enable;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$allowReboot = allowReboot;
    _resultData['allowReboot'] = l$allowReboot;
    final l$enable = enable;
    _resultData['enable'] = l$enable;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$allowReboot = allowReboot;
    final l$enable = enable;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$allowReboot,
      l$enable,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$SystemSettings$system$settings$autoUpgrade) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$allowReboot = allowReboot;
    final lOther$allowReboot = other.allowReboot;
    if (l$allowReboot != lOther$allowReboot) {
      return false;
    }
    final l$enable = enable;
    final lOther$enable = other.enable;
    if (l$enable != lOther$enable) {
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

extension UtilityExtension$Query$SystemSettings$system$settings$autoUpgrade
    on Query$SystemSettings$system$settings$autoUpgrade {
  CopyWith$Query$SystemSettings$system$settings$autoUpgrade<
          Query$SystemSettings$system$settings$autoUpgrade>
      get copyWith => CopyWith$Query$SystemSettings$system$settings$autoUpgrade(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes> {
  factory CopyWith$Query$SystemSettings$system$settings$autoUpgrade(
    Query$SystemSettings$system$settings$autoUpgrade instance,
    TRes Function(Query$SystemSettings$system$settings$autoUpgrade) then,
  ) = _CopyWithImpl$Query$SystemSettings$system$settings$autoUpgrade;

  factory CopyWith$Query$SystemSettings$system$settings$autoUpgrade.stub(
          TRes res) =
      _CopyWithStubImpl$Query$SystemSettings$system$settings$autoUpgrade;

  TRes call({
    bool? allowReboot,
    bool? enable,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$SystemSettings$system$settings$autoUpgrade<TRes>
    implements CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes> {
  _CopyWithImpl$Query$SystemSettings$system$settings$autoUpgrade(
    this._instance,
    this._then,
  );

  final Query$SystemSettings$system$settings$autoUpgrade _instance;

  final TRes Function(Query$SystemSettings$system$settings$autoUpgrade) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? allowReboot = _undefined,
    Object? enable = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$SystemSettings$system$settings$autoUpgrade(
        allowReboot: allowReboot == _undefined || allowReboot == null
            ? _instance.allowReboot
            : (allowReboot as bool),
        enable: enable == _undefined || enable == null
            ? _instance.enable
            : (enable as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$SystemSettings$system$settings$autoUpgrade<TRes>
    implements CopyWith$Query$SystemSettings$system$settings$autoUpgrade<TRes> {
  _CopyWithStubImpl$Query$SystemSettings$system$settings$autoUpgrade(this._res);

  TRes _res;

  call({
    bool? allowReboot,
    bool? enable,
    String? $__typename,
  }) =>
      _res;
}

class Query$SystemSettings$system$settings$ssh {
  Query$SystemSettings$system$settings$ssh({
    required this.enable,
    required this.passwordAuthentication,
    this.$__typename = 'SshSettings',
  });

  factory Query$SystemSettings$system$settings$ssh.fromJson(
      Map<String, dynamic> json) {
    final l$enable = json['enable'];
    final l$passwordAuthentication = json['passwordAuthentication'];
    final l$$__typename = json['__typename'];
    return Query$SystemSettings$system$settings$ssh(
      enable: (l$enable as bool),
      passwordAuthentication: (l$passwordAuthentication as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final bool enable;

  final bool passwordAuthentication;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$enable = enable;
    _resultData['enable'] = l$enable;
    final l$passwordAuthentication = passwordAuthentication;
    _resultData['passwordAuthentication'] = l$passwordAuthentication;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$enable = enable;
    final l$passwordAuthentication = passwordAuthentication;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$enable,
      l$passwordAuthentication,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$SystemSettings$system$settings$ssh) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$enable = enable;
    final lOther$enable = other.enable;
    if (l$enable != lOther$enable) {
      return false;
    }
    final l$passwordAuthentication = passwordAuthentication;
    final lOther$passwordAuthentication = other.passwordAuthentication;
    if (l$passwordAuthentication != lOther$passwordAuthentication) {
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

extension UtilityExtension$Query$SystemSettings$system$settings$ssh
    on Query$SystemSettings$system$settings$ssh {
  CopyWith$Query$SystemSettings$system$settings$ssh<
          Query$SystemSettings$system$settings$ssh>
      get copyWith => CopyWith$Query$SystemSettings$system$settings$ssh(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$SystemSettings$system$settings$ssh<TRes> {
  factory CopyWith$Query$SystemSettings$system$settings$ssh(
    Query$SystemSettings$system$settings$ssh instance,
    TRes Function(Query$SystemSettings$system$settings$ssh) then,
  ) = _CopyWithImpl$Query$SystemSettings$system$settings$ssh;

  factory CopyWith$Query$SystemSettings$system$settings$ssh.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemSettings$system$settings$ssh;

  TRes call({
    bool? enable,
    bool? passwordAuthentication,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$SystemSettings$system$settings$ssh<TRes>
    implements CopyWith$Query$SystemSettings$system$settings$ssh<TRes> {
  _CopyWithImpl$Query$SystemSettings$system$settings$ssh(
    this._instance,
    this._then,
  );

  final Query$SystemSettings$system$settings$ssh _instance;

  final TRes Function(Query$SystemSettings$system$settings$ssh) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? enable = _undefined,
    Object? passwordAuthentication = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$SystemSettings$system$settings$ssh(
        enable: enable == _undefined || enable == null
            ? _instance.enable
            : (enable as bool),
        passwordAuthentication: passwordAuthentication == _undefined ||
                passwordAuthentication == null
            ? _instance.passwordAuthentication
            : (passwordAuthentication as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$SystemSettings$system$settings$ssh<TRes>
    implements CopyWith$Query$SystemSettings$system$settings$ssh<TRes> {
  _CopyWithStubImpl$Query$SystemSettings$system$settings$ssh(this._res);

  TRes _res;

  call({
    bool? enable,
    bool? passwordAuthentication,
    String? $__typename,
  }) =>
      _res;
}

class Query$SystemIsUsingBinds {
  Query$SystemIsUsingBinds({
    required this.system,
    this.$__typename = 'Query',
  });

  factory Query$SystemIsUsingBinds.fromJson(Map<String, dynamic> json) {
    final l$system = json['system'];
    final l$$__typename = json['__typename'];
    return Query$SystemIsUsingBinds(
      system: Query$SystemIsUsingBinds$system.fromJson(
          (l$system as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$SystemIsUsingBinds$system system;

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
    if (!(other is Query$SystemIsUsingBinds) ||
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

extension UtilityExtension$Query$SystemIsUsingBinds
    on Query$SystemIsUsingBinds {
  CopyWith$Query$SystemIsUsingBinds<Query$SystemIsUsingBinds> get copyWith =>
      CopyWith$Query$SystemIsUsingBinds(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$SystemIsUsingBinds<TRes> {
  factory CopyWith$Query$SystemIsUsingBinds(
    Query$SystemIsUsingBinds instance,
    TRes Function(Query$SystemIsUsingBinds) then,
  ) = _CopyWithImpl$Query$SystemIsUsingBinds;

  factory CopyWith$Query$SystemIsUsingBinds.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemIsUsingBinds;

  TRes call({
    Query$SystemIsUsingBinds$system? system,
    String? $__typename,
  });
  CopyWith$Query$SystemIsUsingBinds$system<TRes> get system;
}

class _CopyWithImpl$Query$SystemIsUsingBinds<TRes>
    implements CopyWith$Query$SystemIsUsingBinds<TRes> {
  _CopyWithImpl$Query$SystemIsUsingBinds(
    this._instance,
    this._then,
  );

  final Query$SystemIsUsingBinds _instance;

  final TRes Function(Query$SystemIsUsingBinds) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? system = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$SystemIsUsingBinds(
        system: system == _undefined || system == null
            ? _instance.system
            : (system as Query$SystemIsUsingBinds$system),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$SystemIsUsingBinds$system<TRes> get system {
    final local$system = _instance.system;
    return CopyWith$Query$SystemIsUsingBinds$system(
        local$system, (e) => call(system: e));
  }
}

class _CopyWithStubImpl$Query$SystemIsUsingBinds<TRes>
    implements CopyWith$Query$SystemIsUsingBinds<TRes> {
  _CopyWithStubImpl$Query$SystemIsUsingBinds(this._res);

  TRes _res;

  call({
    Query$SystemIsUsingBinds$system? system,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$SystemIsUsingBinds$system<TRes> get system =>
      CopyWith$Query$SystemIsUsingBinds$system.stub(_res);
}

const documentNodeQuerySystemIsUsingBinds = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'SystemIsUsingBinds'),
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
            name: NameNode(value: 'info'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'usingBinds'),
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
Query$SystemIsUsingBinds _parserFn$Query$SystemIsUsingBinds(
        Map<String, dynamic> data) =>
    Query$SystemIsUsingBinds.fromJson(data);
typedef OnQueryComplete$Query$SystemIsUsingBinds = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$SystemIsUsingBinds?,
);

class Options$Query$SystemIsUsingBinds
    extends graphql.QueryOptions<Query$SystemIsUsingBinds> {
  Options$Query$SystemIsUsingBinds({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$SystemIsUsingBinds? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$SystemIsUsingBinds? onComplete,
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
                        : _parserFn$Query$SystemIsUsingBinds(data),
                  ),
          onError: onError,
          document: documentNodeQuerySystemIsUsingBinds,
          parserFn: _parserFn$Query$SystemIsUsingBinds,
        );

  final OnQueryComplete$Query$SystemIsUsingBinds? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$SystemIsUsingBinds
    extends graphql.WatchQueryOptions<Query$SystemIsUsingBinds> {
  WatchOptions$Query$SystemIsUsingBinds({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$SystemIsUsingBinds? typedOptimisticResult,
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
          document: documentNodeQuerySystemIsUsingBinds,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$SystemIsUsingBinds,
        );
}

class FetchMoreOptions$Query$SystemIsUsingBinds
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$SystemIsUsingBinds(
      {required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQuerySystemIsUsingBinds,
        );
}

extension ClientExtension$Query$SystemIsUsingBinds on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$SystemIsUsingBinds>>
      query$SystemIsUsingBinds(
              [Options$Query$SystemIsUsingBinds? options]) async =>
          await this.query(options ?? Options$Query$SystemIsUsingBinds());
  graphql.ObservableQuery<Query$SystemIsUsingBinds>
      watchQuery$SystemIsUsingBinds(
              [WatchOptions$Query$SystemIsUsingBinds? options]) =>
          this.watchQuery(options ?? WatchOptions$Query$SystemIsUsingBinds());
  void writeQuery$SystemIsUsingBinds({
    required Query$SystemIsUsingBinds data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation: graphql.Operation(
                document: documentNodeQuerySystemIsUsingBinds)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$SystemIsUsingBinds? readQuery$SystemIsUsingBinds(
      {bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQuerySystemIsUsingBinds)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$SystemIsUsingBinds.fromJson(result);
  }
}

class Query$SystemIsUsingBinds$system {
  Query$SystemIsUsingBinds$system({
    required this.info,
    this.$__typename = 'System',
  });

  factory Query$SystemIsUsingBinds$system.fromJson(Map<String, dynamic> json) {
    final l$info = json['info'];
    final l$$__typename = json['__typename'];
    return Query$SystemIsUsingBinds$system(
      info: Query$SystemIsUsingBinds$system$info.fromJson(
          (l$info as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$SystemIsUsingBinds$system$info info;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$info = info;
    _resultData['info'] = l$info.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$info = info;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$info,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$SystemIsUsingBinds$system) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$info = info;
    final lOther$info = other.info;
    if (l$info != lOther$info) {
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

extension UtilityExtension$Query$SystemIsUsingBinds$system
    on Query$SystemIsUsingBinds$system {
  CopyWith$Query$SystemIsUsingBinds$system<Query$SystemIsUsingBinds$system>
      get copyWith => CopyWith$Query$SystemIsUsingBinds$system(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$SystemIsUsingBinds$system<TRes> {
  factory CopyWith$Query$SystemIsUsingBinds$system(
    Query$SystemIsUsingBinds$system instance,
    TRes Function(Query$SystemIsUsingBinds$system) then,
  ) = _CopyWithImpl$Query$SystemIsUsingBinds$system;

  factory CopyWith$Query$SystemIsUsingBinds$system.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemIsUsingBinds$system;

  TRes call({
    Query$SystemIsUsingBinds$system$info? info,
    String? $__typename,
  });
  CopyWith$Query$SystemIsUsingBinds$system$info<TRes> get info;
}

class _CopyWithImpl$Query$SystemIsUsingBinds$system<TRes>
    implements CopyWith$Query$SystemIsUsingBinds$system<TRes> {
  _CopyWithImpl$Query$SystemIsUsingBinds$system(
    this._instance,
    this._then,
  );

  final Query$SystemIsUsingBinds$system _instance;

  final TRes Function(Query$SystemIsUsingBinds$system) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? info = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$SystemIsUsingBinds$system(
        info: info == _undefined || info == null
            ? _instance.info
            : (info as Query$SystemIsUsingBinds$system$info),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$SystemIsUsingBinds$system$info<TRes> get info {
    final local$info = _instance.info;
    return CopyWith$Query$SystemIsUsingBinds$system$info(
        local$info, (e) => call(info: e));
  }
}

class _CopyWithStubImpl$Query$SystemIsUsingBinds$system<TRes>
    implements CopyWith$Query$SystemIsUsingBinds$system<TRes> {
  _CopyWithStubImpl$Query$SystemIsUsingBinds$system(this._res);

  TRes _res;

  call({
    Query$SystemIsUsingBinds$system$info? info,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$SystemIsUsingBinds$system$info<TRes> get info =>
      CopyWith$Query$SystemIsUsingBinds$system$info.stub(_res);
}

class Query$SystemIsUsingBinds$system$info {
  Query$SystemIsUsingBinds$system$info({
    required this.usingBinds,
    this.$__typename = 'SystemInfo',
  });

  factory Query$SystemIsUsingBinds$system$info.fromJson(
      Map<String, dynamic> json) {
    final l$usingBinds = json['usingBinds'];
    final l$$__typename = json['__typename'];
    return Query$SystemIsUsingBinds$system$info(
      usingBinds: (l$usingBinds as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final bool usingBinds;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$usingBinds = usingBinds;
    _resultData['usingBinds'] = l$usingBinds;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$usingBinds = usingBinds;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$usingBinds,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$SystemIsUsingBinds$system$info) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$usingBinds = usingBinds;
    final lOther$usingBinds = other.usingBinds;
    if (l$usingBinds != lOther$usingBinds) {
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

extension UtilityExtension$Query$SystemIsUsingBinds$system$info
    on Query$SystemIsUsingBinds$system$info {
  CopyWith$Query$SystemIsUsingBinds$system$info<
          Query$SystemIsUsingBinds$system$info>
      get copyWith => CopyWith$Query$SystemIsUsingBinds$system$info(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$SystemIsUsingBinds$system$info<TRes> {
  factory CopyWith$Query$SystemIsUsingBinds$system$info(
    Query$SystemIsUsingBinds$system$info instance,
    TRes Function(Query$SystemIsUsingBinds$system$info) then,
  ) = _CopyWithImpl$Query$SystemIsUsingBinds$system$info;

  factory CopyWith$Query$SystemIsUsingBinds$system$info.stub(TRes res) =
      _CopyWithStubImpl$Query$SystemIsUsingBinds$system$info;

  TRes call({
    bool? usingBinds,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$SystemIsUsingBinds$system$info<TRes>
    implements CopyWith$Query$SystemIsUsingBinds$system$info<TRes> {
  _CopyWithImpl$Query$SystemIsUsingBinds$system$info(
    this._instance,
    this._then,
  );

  final Query$SystemIsUsingBinds$system$info _instance;

  final TRes Function(Query$SystemIsUsingBinds$system$info) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? usingBinds = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$SystemIsUsingBinds$system$info(
        usingBinds: usingBinds == _undefined || usingBinds == null
            ? _instance.usingBinds
            : (usingBinds as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$SystemIsUsingBinds$system$info<TRes>
    implements CopyWith$Query$SystemIsUsingBinds$system$info<TRes> {
  _CopyWithStubImpl$Query$SystemIsUsingBinds$system$info(this._res);

  TRes _res;

  call({
    bool? usingBinds,
    String? $__typename,
  }) =>
      _res;
}

class Query$DomainInfo {
  Query$DomainInfo({
    required this.system,
    this.$__typename = 'Query',
  });

  factory Query$DomainInfo.fromJson(Map<String, dynamic> json) {
    final l$system = json['system'];
    final l$$__typename = json['__typename'];
    return Query$DomainInfo(
      system:
          Query$DomainInfo$system.fromJson((l$system as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$DomainInfo$system system;

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
    if (!(other is Query$DomainInfo) || runtimeType != other.runtimeType) {
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

extension UtilityExtension$Query$DomainInfo on Query$DomainInfo {
  CopyWith$Query$DomainInfo<Query$DomainInfo> get copyWith =>
      CopyWith$Query$DomainInfo(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$DomainInfo<TRes> {
  factory CopyWith$Query$DomainInfo(
    Query$DomainInfo instance,
    TRes Function(Query$DomainInfo) then,
  ) = _CopyWithImpl$Query$DomainInfo;

  factory CopyWith$Query$DomainInfo.stub(TRes res) =
      _CopyWithStubImpl$Query$DomainInfo;

  TRes call({
    Query$DomainInfo$system? system,
    String? $__typename,
  });
  CopyWith$Query$DomainInfo$system<TRes> get system;
}

class _CopyWithImpl$Query$DomainInfo<TRes>
    implements CopyWith$Query$DomainInfo<TRes> {
  _CopyWithImpl$Query$DomainInfo(
    this._instance,
    this._then,
  );

  final Query$DomainInfo _instance;

  final TRes Function(Query$DomainInfo) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? system = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$DomainInfo(
        system: system == _undefined || system == null
            ? _instance.system
            : (system as Query$DomainInfo$system),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$DomainInfo$system<TRes> get system {
    final local$system = _instance.system;
    return CopyWith$Query$DomainInfo$system(
        local$system, (e) => call(system: e));
  }
}

class _CopyWithStubImpl$Query$DomainInfo<TRes>
    implements CopyWith$Query$DomainInfo<TRes> {
  _CopyWithStubImpl$Query$DomainInfo(this._res);

  TRes _res;

  call({
    Query$DomainInfo$system? system,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$DomainInfo$system<TRes> get system =>
      CopyWith$Query$DomainInfo$system.stub(_res);
}

const documentNodeQueryDomainInfo = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'DomainInfo'),
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
                name: NameNode(value: 'domain'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'hostname'),
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
                name: NameNode(value: 'requiredDnsRecords'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FragmentSpreadNode(
                    name: NameNode(value: 'dnsRecordFields'),
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
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitiondnsRecordFields,
]);
Query$DomainInfo _parserFn$Query$DomainInfo(Map<String, dynamic> data) =>
    Query$DomainInfo.fromJson(data);
typedef OnQueryComplete$Query$DomainInfo = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$DomainInfo?,
);

class Options$Query$DomainInfo extends graphql.QueryOptions<Query$DomainInfo> {
  Options$Query$DomainInfo({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$DomainInfo? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$DomainInfo? onComplete,
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
                    data == null ? null : _parserFn$Query$DomainInfo(data),
                  ),
          onError: onError,
          document: documentNodeQueryDomainInfo,
          parserFn: _parserFn$Query$DomainInfo,
        );

  final OnQueryComplete$Query$DomainInfo? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$DomainInfo
    extends graphql.WatchQueryOptions<Query$DomainInfo> {
  WatchOptions$Query$DomainInfo({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$DomainInfo? typedOptimisticResult,
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
          document: documentNodeQueryDomainInfo,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$DomainInfo,
        );
}

class FetchMoreOptions$Query$DomainInfo extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$DomainInfo({required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryDomainInfo,
        );
}

extension ClientExtension$Query$DomainInfo on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$DomainInfo>> query$DomainInfo(
          [Options$Query$DomainInfo? options]) async =>
      await this.query(options ?? Options$Query$DomainInfo());
  graphql.ObservableQuery<Query$DomainInfo> watchQuery$DomainInfo(
          [WatchOptions$Query$DomainInfo? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$DomainInfo());
  void writeQuery$DomainInfo({
    required Query$DomainInfo data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryDomainInfo)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$DomainInfo? readQuery$DomainInfo({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryDomainInfo)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$DomainInfo.fromJson(result);
  }
}

class Query$DomainInfo$system {
  Query$DomainInfo$system({
    required this.domainInfo,
    this.$__typename = 'System',
  });

  factory Query$DomainInfo$system.fromJson(Map<String, dynamic> json) {
    final l$domainInfo = json['domainInfo'];
    final l$$__typename = json['__typename'];
    return Query$DomainInfo$system(
      domainInfo: Query$DomainInfo$system$domainInfo.fromJson(
          (l$domainInfo as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$DomainInfo$system$domainInfo domainInfo;

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
    if (!(other is Query$DomainInfo$system) ||
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

extension UtilityExtension$Query$DomainInfo$system on Query$DomainInfo$system {
  CopyWith$Query$DomainInfo$system<Query$DomainInfo$system> get copyWith =>
      CopyWith$Query$DomainInfo$system(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$DomainInfo$system<TRes> {
  factory CopyWith$Query$DomainInfo$system(
    Query$DomainInfo$system instance,
    TRes Function(Query$DomainInfo$system) then,
  ) = _CopyWithImpl$Query$DomainInfo$system;

  factory CopyWith$Query$DomainInfo$system.stub(TRes res) =
      _CopyWithStubImpl$Query$DomainInfo$system;

  TRes call({
    Query$DomainInfo$system$domainInfo? domainInfo,
    String? $__typename,
  });
  CopyWith$Query$DomainInfo$system$domainInfo<TRes> get domainInfo;
}

class _CopyWithImpl$Query$DomainInfo$system<TRes>
    implements CopyWith$Query$DomainInfo$system<TRes> {
  _CopyWithImpl$Query$DomainInfo$system(
    this._instance,
    this._then,
  );

  final Query$DomainInfo$system _instance;

  final TRes Function(Query$DomainInfo$system) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? domainInfo = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$DomainInfo$system(
        domainInfo: domainInfo == _undefined || domainInfo == null
            ? _instance.domainInfo
            : (domainInfo as Query$DomainInfo$system$domainInfo),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$DomainInfo$system$domainInfo<TRes> get domainInfo {
    final local$domainInfo = _instance.domainInfo;
    return CopyWith$Query$DomainInfo$system$domainInfo(
        local$domainInfo, (e) => call(domainInfo: e));
  }
}

class _CopyWithStubImpl$Query$DomainInfo$system<TRes>
    implements CopyWith$Query$DomainInfo$system<TRes> {
  _CopyWithStubImpl$Query$DomainInfo$system(this._res);

  TRes _res;

  call({
    Query$DomainInfo$system$domainInfo? domainInfo,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$DomainInfo$system$domainInfo<TRes> get domainInfo =>
      CopyWith$Query$DomainInfo$system$domainInfo.stub(_res);
}

class Query$DomainInfo$system$domainInfo {
  Query$DomainInfo$system$domainInfo({
    required this.domain,
    required this.hostname,
    required this.provider,
    required this.requiredDnsRecords,
    this.$__typename = 'SystemDomainInfo',
  });

  factory Query$DomainInfo$system$domainInfo.fromJson(
      Map<String, dynamic> json) {
    final l$domain = json['domain'];
    final l$hostname = json['hostname'];
    final l$provider = json['provider'];
    final l$requiredDnsRecords = json['requiredDnsRecords'];
    final l$$__typename = json['__typename'];
    return Query$DomainInfo$system$domainInfo(
      domain: (l$domain as String),
      hostname: (l$hostname as String),
      provider: fromJson$Enum$DnsProvider((l$provider as String)),
      requiredDnsRecords: (l$requiredDnsRecords as List<dynamic>)
          .map((e) =>
              Fragment$dnsRecordFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String domain;

  final String hostname;

  final Enum$DnsProvider provider;

  final List<Fragment$dnsRecordFields> requiredDnsRecords;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$domain = domain;
    _resultData['domain'] = l$domain;
    final l$hostname = hostname;
    _resultData['hostname'] = l$hostname;
    final l$provider = provider;
    _resultData['provider'] = toJson$Enum$DnsProvider(l$provider);
    final l$requiredDnsRecords = requiredDnsRecords;
    _resultData['requiredDnsRecords'] =
        l$requiredDnsRecords.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$domain = domain;
    final l$hostname = hostname;
    final l$provider = provider;
    final l$requiredDnsRecords = requiredDnsRecords;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$domain,
      l$hostname,
      l$provider,
      Object.hashAll(l$requiredDnsRecords.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$DomainInfo$system$domainInfo) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$domain = domain;
    final lOther$domain = other.domain;
    if (l$domain != lOther$domain) {
      return false;
    }
    final l$hostname = hostname;
    final lOther$hostname = other.hostname;
    if (l$hostname != lOther$hostname) {
      return false;
    }
    final l$provider = provider;
    final lOther$provider = other.provider;
    if (l$provider != lOther$provider) {
      return false;
    }
    final l$requiredDnsRecords = requiredDnsRecords;
    final lOther$requiredDnsRecords = other.requiredDnsRecords;
    if (l$requiredDnsRecords.length != lOther$requiredDnsRecords.length) {
      return false;
    }
    for (int i = 0; i < l$requiredDnsRecords.length; i++) {
      final l$requiredDnsRecords$entry = l$requiredDnsRecords[i];
      final lOther$requiredDnsRecords$entry = lOther$requiredDnsRecords[i];
      if (l$requiredDnsRecords$entry != lOther$requiredDnsRecords$entry) {
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

extension UtilityExtension$Query$DomainInfo$system$domainInfo
    on Query$DomainInfo$system$domainInfo {
  CopyWith$Query$DomainInfo$system$domainInfo<
          Query$DomainInfo$system$domainInfo>
      get copyWith => CopyWith$Query$DomainInfo$system$domainInfo(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$DomainInfo$system$domainInfo<TRes> {
  factory CopyWith$Query$DomainInfo$system$domainInfo(
    Query$DomainInfo$system$domainInfo instance,
    TRes Function(Query$DomainInfo$system$domainInfo) then,
  ) = _CopyWithImpl$Query$DomainInfo$system$domainInfo;

  factory CopyWith$Query$DomainInfo$system$domainInfo.stub(TRes res) =
      _CopyWithStubImpl$Query$DomainInfo$system$domainInfo;

  TRes call({
    String? domain,
    String? hostname,
    Enum$DnsProvider? provider,
    List<Fragment$dnsRecordFields>? requiredDnsRecords,
    String? $__typename,
  });
  TRes requiredDnsRecords(
      Iterable<Fragment$dnsRecordFields> Function(
              Iterable<
                  CopyWith$Fragment$dnsRecordFields<Fragment$dnsRecordFields>>)
          _fn);
}

class _CopyWithImpl$Query$DomainInfo$system$domainInfo<TRes>
    implements CopyWith$Query$DomainInfo$system$domainInfo<TRes> {
  _CopyWithImpl$Query$DomainInfo$system$domainInfo(
    this._instance,
    this._then,
  );

  final Query$DomainInfo$system$domainInfo _instance;

  final TRes Function(Query$DomainInfo$system$domainInfo) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? domain = _undefined,
    Object? hostname = _undefined,
    Object? provider = _undefined,
    Object? requiredDnsRecords = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$DomainInfo$system$domainInfo(
        domain: domain == _undefined || domain == null
            ? _instance.domain
            : (domain as String),
        hostname: hostname == _undefined || hostname == null
            ? _instance.hostname
            : (hostname as String),
        provider: provider == _undefined || provider == null
            ? _instance.provider
            : (provider as Enum$DnsProvider),
        requiredDnsRecords:
            requiredDnsRecords == _undefined || requiredDnsRecords == null
                ? _instance.requiredDnsRecords
                : (requiredDnsRecords as List<Fragment$dnsRecordFields>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  TRes requiredDnsRecords(
          Iterable<Fragment$dnsRecordFields> Function(
                  Iterable<
                      CopyWith$Fragment$dnsRecordFields<
                          Fragment$dnsRecordFields>>)
              _fn) =>
      call(
          requiredDnsRecords: _fn(_instance.requiredDnsRecords
              .map((e) => CopyWith$Fragment$dnsRecordFields(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$DomainInfo$system$domainInfo<TRes>
    implements CopyWith$Query$DomainInfo$system$domainInfo<TRes> {
  _CopyWithStubImpl$Query$DomainInfo$system$domainInfo(this._res);

  TRes _res;

  call({
    String? domain,
    String? hostname,
    Enum$DnsProvider? provider,
    List<Fragment$dnsRecordFields>? requiredDnsRecords,
    String? $__typename,
  }) =>
      _res;
  requiredDnsRecords(_fn) => _res;
}

class Variables$Mutation$ChangeTimezone {
  factory Variables$Mutation$ChangeTimezone({required String timezone}) =>
      Variables$Mutation$ChangeTimezone._({
        r'timezone': timezone,
      });

  Variables$Mutation$ChangeTimezone._(this._$data);

  factory Variables$Mutation$ChangeTimezone.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$timezone = data['timezone'];
    result$data['timezone'] = (l$timezone as String);
    return Variables$Mutation$ChangeTimezone._(result$data);
  }

  Map<String, dynamic> _$data;

  String get timezone => (_$data['timezone'] as String);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$timezone = timezone;
    result$data['timezone'] = l$timezone;
    return result$data;
  }

  CopyWith$Variables$Mutation$ChangeTimezone<Variables$Mutation$ChangeTimezone>
      get copyWith => CopyWith$Variables$Mutation$ChangeTimezone(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$ChangeTimezone) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$timezone = timezone;
    final lOther$timezone = other.timezone;
    if (l$timezone != lOther$timezone) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$timezone = timezone;
    return Object.hashAll([l$timezone]);
  }
}

abstract class CopyWith$Variables$Mutation$ChangeTimezone<TRes> {
  factory CopyWith$Variables$Mutation$ChangeTimezone(
    Variables$Mutation$ChangeTimezone instance,
    TRes Function(Variables$Mutation$ChangeTimezone) then,
  ) = _CopyWithImpl$Variables$Mutation$ChangeTimezone;

  factory CopyWith$Variables$Mutation$ChangeTimezone.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ChangeTimezone;

  TRes call({String? timezone});
}

class _CopyWithImpl$Variables$Mutation$ChangeTimezone<TRes>
    implements CopyWith$Variables$Mutation$ChangeTimezone<TRes> {
  _CopyWithImpl$Variables$Mutation$ChangeTimezone(
    this._instance,
    this._then,
  );

  final Variables$Mutation$ChangeTimezone _instance;

  final TRes Function(Variables$Mutation$ChangeTimezone) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? timezone = _undefined}) =>
      _then(Variables$Mutation$ChangeTimezone._({
        ..._instance._$data,
        if (timezone != _undefined && timezone != null)
          'timezone': (timezone as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$ChangeTimezone<TRes>
    implements CopyWith$Variables$Mutation$ChangeTimezone<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ChangeTimezone(this._res);

  TRes _res;

  call({String? timezone}) => _res;
}

class Mutation$ChangeTimezone {
  Mutation$ChangeTimezone({
    required this.changeTimezone,
    this.$__typename = 'Mutation',
  });

  factory Mutation$ChangeTimezone.fromJson(Map<String, dynamic> json) {
    final l$changeTimezone = json['changeTimezone'];
    final l$$__typename = json['__typename'];
    return Mutation$ChangeTimezone(
      changeTimezone: Mutation$ChangeTimezone$changeTimezone.fromJson(
          (l$changeTimezone as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$ChangeTimezone$changeTimezone changeTimezone;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$changeTimezone = changeTimezone;
    _resultData['changeTimezone'] = l$changeTimezone.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$changeTimezone = changeTimezone;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$changeTimezone,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$ChangeTimezone) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$changeTimezone = changeTimezone;
    final lOther$changeTimezone = other.changeTimezone;
    if (l$changeTimezone != lOther$changeTimezone) {
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

extension UtilityExtension$Mutation$ChangeTimezone on Mutation$ChangeTimezone {
  CopyWith$Mutation$ChangeTimezone<Mutation$ChangeTimezone> get copyWith =>
      CopyWith$Mutation$ChangeTimezone(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$ChangeTimezone<TRes> {
  factory CopyWith$Mutation$ChangeTimezone(
    Mutation$ChangeTimezone instance,
    TRes Function(Mutation$ChangeTimezone) then,
  ) = _CopyWithImpl$Mutation$ChangeTimezone;

  factory CopyWith$Mutation$ChangeTimezone.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ChangeTimezone;

  TRes call({
    Mutation$ChangeTimezone$changeTimezone? changeTimezone,
    String? $__typename,
  });
  CopyWith$Mutation$ChangeTimezone$changeTimezone<TRes> get changeTimezone;
}

class _CopyWithImpl$Mutation$ChangeTimezone<TRes>
    implements CopyWith$Mutation$ChangeTimezone<TRes> {
  _CopyWithImpl$Mutation$ChangeTimezone(
    this._instance,
    this._then,
  );

  final Mutation$ChangeTimezone _instance;

  final TRes Function(Mutation$ChangeTimezone) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? changeTimezone = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$ChangeTimezone(
        changeTimezone: changeTimezone == _undefined || changeTimezone == null
            ? _instance.changeTimezone
            : (changeTimezone as Mutation$ChangeTimezone$changeTimezone),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$ChangeTimezone$changeTimezone<TRes> get changeTimezone {
    final local$changeTimezone = _instance.changeTimezone;
    return CopyWith$Mutation$ChangeTimezone$changeTimezone(
        local$changeTimezone, (e) => call(changeTimezone: e));
  }
}

class _CopyWithStubImpl$Mutation$ChangeTimezone<TRes>
    implements CopyWith$Mutation$ChangeTimezone<TRes> {
  _CopyWithStubImpl$Mutation$ChangeTimezone(this._res);

  TRes _res;

  call({
    Mutation$ChangeTimezone$changeTimezone? changeTimezone,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$ChangeTimezone$changeTimezone<TRes> get changeTimezone =>
      CopyWith$Mutation$ChangeTimezone$changeTimezone.stub(_res);
}

const documentNodeMutationChangeTimezone = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'ChangeTimezone'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'timezone')),
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
        name: NameNode(value: 'changeTimezone'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'timezone'),
            value: VariableNode(name: NameNode(value: 'timezone')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'basicMutationReturnFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: 'timezone'),
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
Mutation$ChangeTimezone _parserFn$Mutation$ChangeTimezone(
        Map<String, dynamic> data) =>
    Mutation$ChangeTimezone.fromJson(data);
typedef OnMutationCompleted$Mutation$ChangeTimezone = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$ChangeTimezone?,
);

class Options$Mutation$ChangeTimezone
    extends graphql.MutationOptions<Mutation$ChangeTimezone> {
  Options$Mutation$ChangeTimezone({
    String? operationName,
    required Variables$Mutation$ChangeTimezone variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ChangeTimezone? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$ChangeTimezone? onCompleted,
    graphql.OnMutationUpdate<Mutation$ChangeTimezone>? update,
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
                        : _parserFn$Mutation$ChangeTimezone(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationChangeTimezone,
          parserFn: _parserFn$Mutation$ChangeTimezone,
        );

  final OnMutationCompleted$Mutation$ChangeTimezone? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$ChangeTimezone
    extends graphql.WatchQueryOptions<Mutation$ChangeTimezone> {
  WatchOptions$Mutation$ChangeTimezone({
    String? operationName,
    required Variables$Mutation$ChangeTimezone variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ChangeTimezone? typedOptimisticResult,
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
          document: documentNodeMutationChangeTimezone,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$ChangeTimezone,
        );
}

extension ClientExtension$Mutation$ChangeTimezone on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$ChangeTimezone>> mutate$ChangeTimezone(
          Options$Mutation$ChangeTimezone options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$ChangeTimezone> watchMutation$ChangeTimezone(
          WatchOptions$Mutation$ChangeTimezone options) =>
      this.watchMutation(options);
}

class Mutation$ChangeTimezone$changeTimezone
    implements Fragment$basicMutationReturnFields$$TimezoneMutationReturn {
  Mutation$ChangeTimezone$changeTimezone({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'TimezoneMutationReturn',
    this.timezone,
  });

  factory Mutation$ChangeTimezone$changeTimezone.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$timezone = json['timezone'];
    return Mutation$ChangeTimezone$changeTimezone(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      timezone: (l$timezone as String?),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final String? timezone;

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
    final l$timezone = timezone;
    _resultData['timezone'] = l$timezone;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$timezone = timezone;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
      l$timezone,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$ChangeTimezone$changeTimezone) ||
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
    final l$timezone = timezone;
    final lOther$timezone = other.timezone;
    if (l$timezone != lOther$timezone) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$ChangeTimezone$changeTimezone
    on Mutation$ChangeTimezone$changeTimezone {
  CopyWith$Mutation$ChangeTimezone$changeTimezone<
          Mutation$ChangeTimezone$changeTimezone>
      get copyWith => CopyWith$Mutation$ChangeTimezone$changeTimezone(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$ChangeTimezone$changeTimezone<TRes> {
  factory CopyWith$Mutation$ChangeTimezone$changeTimezone(
    Mutation$ChangeTimezone$changeTimezone instance,
    TRes Function(Mutation$ChangeTimezone$changeTimezone) then,
  ) = _CopyWithImpl$Mutation$ChangeTimezone$changeTimezone;

  factory CopyWith$Mutation$ChangeTimezone$changeTimezone.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ChangeTimezone$changeTimezone;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    String? timezone,
  });
}

class _CopyWithImpl$Mutation$ChangeTimezone$changeTimezone<TRes>
    implements CopyWith$Mutation$ChangeTimezone$changeTimezone<TRes> {
  _CopyWithImpl$Mutation$ChangeTimezone$changeTimezone(
    this._instance,
    this._then,
  );

  final Mutation$ChangeTimezone$changeTimezone _instance;

  final TRes Function(Mutation$ChangeTimezone$changeTimezone) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? timezone = _undefined,
  }) =>
      _then(Mutation$ChangeTimezone$changeTimezone(
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
        timezone:
            timezone == _undefined ? _instance.timezone : (timezone as String?),
      ));
}

class _CopyWithStubImpl$Mutation$ChangeTimezone$changeTimezone<TRes>
    implements CopyWith$Mutation$ChangeTimezone$changeTimezone<TRes> {
  _CopyWithStubImpl$Mutation$ChangeTimezone$changeTimezone(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    String? timezone,
  }) =>
      _res;
}

class Variables$Mutation$ChangeAutoUpgradeSettings {
  factory Variables$Mutation$ChangeAutoUpgradeSettings(
          {required Input$AutoUpgradeSettingsInput settings}) =>
      Variables$Mutation$ChangeAutoUpgradeSettings._({
        r'settings': settings,
      });

  Variables$Mutation$ChangeAutoUpgradeSettings._(this._$data);

  factory Variables$Mutation$ChangeAutoUpgradeSettings.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$settings = data['settings'];
    result$data['settings'] = Input$AutoUpgradeSettingsInput.fromJson(
        (l$settings as Map<String, dynamic>));
    return Variables$Mutation$ChangeAutoUpgradeSettings._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$AutoUpgradeSettingsInput get settings =>
      (_$data['settings'] as Input$AutoUpgradeSettingsInput);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$settings = settings;
    result$data['settings'] = l$settings.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings<
          Variables$Mutation$ChangeAutoUpgradeSettings>
      get copyWith => CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$ChangeAutoUpgradeSettings) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$settings = settings;
    final lOther$settings = other.settings;
    if (l$settings != lOther$settings) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$settings = settings;
    return Object.hashAll([l$settings]);
  }
}

abstract class CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings<TRes> {
  factory CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings(
    Variables$Mutation$ChangeAutoUpgradeSettings instance,
    TRes Function(Variables$Mutation$ChangeAutoUpgradeSettings) then,
  ) = _CopyWithImpl$Variables$Mutation$ChangeAutoUpgradeSettings;

  factory CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ChangeAutoUpgradeSettings;

  TRes call({Input$AutoUpgradeSettingsInput? settings});
}

class _CopyWithImpl$Variables$Mutation$ChangeAutoUpgradeSettings<TRes>
    implements CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings<TRes> {
  _CopyWithImpl$Variables$Mutation$ChangeAutoUpgradeSettings(
    this._instance,
    this._then,
  );

  final Variables$Mutation$ChangeAutoUpgradeSettings _instance;

  final TRes Function(Variables$Mutation$ChangeAutoUpgradeSettings) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? settings = _undefined}) =>
      _then(Variables$Mutation$ChangeAutoUpgradeSettings._({
        ..._instance._$data,
        if (settings != _undefined && settings != null)
          'settings': (settings as Input$AutoUpgradeSettingsInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$ChangeAutoUpgradeSettings<TRes>
    implements CopyWith$Variables$Mutation$ChangeAutoUpgradeSettings<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ChangeAutoUpgradeSettings(this._res);

  TRes _res;

  call({Input$AutoUpgradeSettingsInput? settings}) => _res;
}

class Mutation$ChangeAutoUpgradeSettings {
  Mutation$ChangeAutoUpgradeSettings({
    required this.changeAutoUpgradeSettings,
    this.$__typename = 'Mutation',
  });

  factory Mutation$ChangeAutoUpgradeSettings.fromJson(
      Map<String, dynamic> json) {
    final l$changeAutoUpgradeSettings = json['changeAutoUpgradeSettings'];
    final l$$__typename = json['__typename'];
    return Mutation$ChangeAutoUpgradeSettings(
      changeAutoUpgradeSettings:
          Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings.fromJson(
              (l$changeAutoUpgradeSettings as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings
      changeAutoUpgradeSettings;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$changeAutoUpgradeSettings = changeAutoUpgradeSettings;
    _resultData['changeAutoUpgradeSettings'] =
        l$changeAutoUpgradeSettings.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$changeAutoUpgradeSettings = changeAutoUpgradeSettings;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$changeAutoUpgradeSettings,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$ChangeAutoUpgradeSettings) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$changeAutoUpgradeSettings = changeAutoUpgradeSettings;
    final lOther$changeAutoUpgradeSettings = other.changeAutoUpgradeSettings;
    if (l$changeAutoUpgradeSettings != lOther$changeAutoUpgradeSettings) {
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

extension UtilityExtension$Mutation$ChangeAutoUpgradeSettings
    on Mutation$ChangeAutoUpgradeSettings {
  CopyWith$Mutation$ChangeAutoUpgradeSettings<
          Mutation$ChangeAutoUpgradeSettings>
      get copyWith => CopyWith$Mutation$ChangeAutoUpgradeSettings(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$ChangeAutoUpgradeSettings<TRes> {
  factory CopyWith$Mutation$ChangeAutoUpgradeSettings(
    Mutation$ChangeAutoUpgradeSettings instance,
    TRes Function(Mutation$ChangeAutoUpgradeSettings) then,
  ) = _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings;

  factory CopyWith$Mutation$ChangeAutoUpgradeSettings.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings;

  TRes call({
    Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings?
        changeAutoUpgradeSettings,
    String? $__typename,
  });
  CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<TRes>
      get changeAutoUpgradeSettings;
}

class _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings<TRes>
    implements CopyWith$Mutation$ChangeAutoUpgradeSettings<TRes> {
  _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings(
    this._instance,
    this._then,
  );

  final Mutation$ChangeAutoUpgradeSettings _instance;

  final TRes Function(Mutation$ChangeAutoUpgradeSettings) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? changeAutoUpgradeSettings = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$ChangeAutoUpgradeSettings(
        changeAutoUpgradeSettings: changeAutoUpgradeSettings == _undefined ||
                changeAutoUpgradeSettings == null
            ? _instance.changeAutoUpgradeSettings
            : (changeAutoUpgradeSettings
                as Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<TRes>
      get changeAutoUpgradeSettings {
    final local$changeAutoUpgradeSettings = _instance.changeAutoUpgradeSettings;
    return CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings(
        local$changeAutoUpgradeSettings,
        (e) => call(changeAutoUpgradeSettings: e));
  }
}

class _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings<TRes>
    implements CopyWith$Mutation$ChangeAutoUpgradeSettings<TRes> {
  _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings(this._res);

  TRes _res;

  call({
    Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings?
        changeAutoUpgradeSettings,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<TRes>
      get changeAutoUpgradeSettings =>
          CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings
              .stub(_res);
}

const documentNodeMutationChangeAutoUpgradeSettings =
    DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'ChangeAutoUpgradeSettings'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'settings')),
        type: NamedTypeNode(
          name: NameNode(value: 'AutoUpgradeSettingsInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'changeAutoUpgradeSettings'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'settings'),
            value: VariableNode(name: NameNode(value: 'settings')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'basicMutationReturnFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: 'allowReboot'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'enableAutoUpgrade'),
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
Mutation$ChangeAutoUpgradeSettings _parserFn$Mutation$ChangeAutoUpgradeSettings(
        Map<String, dynamic> data) =>
    Mutation$ChangeAutoUpgradeSettings.fromJson(data);
typedef OnMutationCompleted$Mutation$ChangeAutoUpgradeSettings = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$ChangeAutoUpgradeSettings?,
);

class Options$Mutation$ChangeAutoUpgradeSettings
    extends graphql.MutationOptions<Mutation$ChangeAutoUpgradeSettings> {
  Options$Mutation$ChangeAutoUpgradeSettings({
    String? operationName,
    required Variables$Mutation$ChangeAutoUpgradeSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ChangeAutoUpgradeSettings? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$ChangeAutoUpgradeSettings? onCompleted,
    graphql.OnMutationUpdate<Mutation$ChangeAutoUpgradeSettings>? update,
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
                        : _parserFn$Mutation$ChangeAutoUpgradeSettings(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationChangeAutoUpgradeSettings,
          parserFn: _parserFn$Mutation$ChangeAutoUpgradeSettings,
        );

  final OnMutationCompleted$Mutation$ChangeAutoUpgradeSettings?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$ChangeAutoUpgradeSettings
    extends graphql.WatchQueryOptions<Mutation$ChangeAutoUpgradeSettings> {
  WatchOptions$Mutation$ChangeAutoUpgradeSettings({
    String? operationName,
    required Variables$Mutation$ChangeAutoUpgradeSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ChangeAutoUpgradeSettings? typedOptimisticResult,
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
          document: documentNodeMutationChangeAutoUpgradeSettings,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$ChangeAutoUpgradeSettings,
        );
}

extension ClientExtension$Mutation$ChangeAutoUpgradeSettings
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$ChangeAutoUpgradeSettings>>
      mutate$ChangeAutoUpgradeSettings(
              Options$Mutation$ChangeAutoUpgradeSettings options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$ChangeAutoUpgradeSettings>
      watchMutation$ChangeAutoUpgradeSettings(
              WatchOptions$Mutation$ChangeAutoUpgradeSettings options) =>
          this.watchMutation(options);
}

class Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings
    implements
        Fragment$basicMutationReturnFields$$AutoUpgradeSettingsMutationReturn {
  Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'AutoUpgradeSettingsMutationReturn',
    required this.allowReboot,
    required this.enableAutoUpgrade,
  });

  factory Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$allowReboot = json['allowReboot'];
    final l$enableAutoUpgrade = json['enableAutoUpgrade'];
    return Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      allowReboot: (l$allowReboot as bool),
      enableAutoUpgrade: (l$enableAutoUpgrade as bool),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final bool allowReboot;

  final bool enableAutoUpgrade;

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
    final l$allowReboot = allowReboot;
    _resultData['allowReboot'] = l$allowReboot;
    final l$enableAutoUpgrade = enableAutoUpgrade;
    _resultData['enableAutoUpgrade'] = l$enableAutoUpgrade;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$allowReboot = allowReboot;
    final l$enableAutoUpgrade = enableAutoUpgrade;
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
      l$allowReboot,
      l$enableAutoUpgrade,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings) ||
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
    final l$allowReboot = allowReboot;
    final lOther$allowReboot = other.allowReboot;
    if (l$allowReboot != lOther$allowReboot) {
      return false;
    }
    final l$enableAutoUpgrade = enableAutoUpgrade;
    final lOther$enableAutoUpgrade = other.enableAutoUpgrade;
    if (l$enableAutoUpgrade != lOther$enableAutoUpgrade) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings
    on Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings {
  CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<
          Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings>
      get copyWith =>
          CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<
    TRes> {
  factory CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings(
    Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings instance,
    TRes Function(Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings)
        then,
  ) = _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings;

  factory CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    bool? allowReboot,
    bool? enableAutoUpgrade,
  });
}

class _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<
        TRes>
    implements
        CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<
            TRes> {
  _CopyWithImpl$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings(
    this._instance,
    this._then,
  );

  final Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings _instance;

  final TRes Function(
      Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? allowReboot = _undefined,
    Object? enableAutoUpgrade = _undefined,
  }) =>
      _then(Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings(
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
        allowReboot: allowReboot == _undefined || allowReboot == null
            ? _instance.allowReboot
            : (allowReboot as bool),
        enableAutoUpgrade:
            enableAutoUpgrade == _undefined || enableAutoUpgrade == null
                ? _instance.enableAutoUpgrade
                : (enableAutoUpgrade as bool),
      ));
}

class _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<
        TRes>
    implements
        CopyWith$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings<
            TRes> {
  _CopyWithStubImpl$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings(
      this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    bool? allowReboot,
    bool? enableAutoUpgrade,
  }) =>
      _res;
}
