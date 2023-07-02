import 'dart:async';
import 'disk_volumes.graphql.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'schema.graphql.dart';
import 'server_api.graphql.dart';
import 'server_settings.graphql.dart';

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

class Query$AllServices {
  Query$AllServices({
    required this.services,
    this.$__typename = 'Query',
  });

  factory Query$AllServices.fromJson(Map<String, dynamic> json) {
    final l$services = json['services'];
    final l$$__typename = json['__typename'];
    return Query$AllServices(
      services: Query$AllServices$services.fromJson(
          (l$services as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$AllServices$services services;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$services = services;
    _resultData['services'] = l$services.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$services = services;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$services,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$AllServices) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$services = services;
    final lOther$services = other.services;
    if (l$services != lOther$services) {
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

extension UtilityExtension$Query$AllServices on Query$AllServices {
  CopyWith$Query$AllServices<Query$AllServices> get copyWith =>
      CopyWith$Query$AllServices(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$AllServices<TRes> {
  factory CopyWith$Query$AllServices(
    Query$AllServices instance,
    TRes Function(Query$AllServices) then,
  ) = _CopyWithImpl$Query$AllServices;

  factory CopyWith$Query$AllServices.stub(TRes res) =
      _CopyWithStubImpl$Query$AllServices;

  TRes call({
    Query$AllServices$services? services,
    String? $__typename,
  });
  CopyWith$Query$AllServices$services<TRes> get services;
}

class _CopyWithImpl$Query$AllServices<TRes>
    implements CopyWith$Query$AllServices<TRes> {
  _CopyWithImpl$Query$AllServices(
    this._instance,
    this._then,
  );

  final Query$AllServices _instance;

  final TRes Function(Query$AllServices) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? services = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$AllServices(
        services: services == _undefined || services == null
            ? _instance.services
            : (services as Query$AllServices$services),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$AllServices$services<TRes> get services {
    final local$services = _instance.services;
    return CopyWith$Query$AllServices$services(
        local$services, (e) => call(services: e));
  }
}

class _CopyWithStubImpl$Query$AllServices<TRes>
    implements CopyWith$Query$AllServices<TRes> {
  _CopyWithStubImpl$Query$AllServices(this._res);

  TRes _res;

  call({
    Query$AllServices$services? services,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$AllServices$services<TRes> get services =>
      CopyWith$Query$AllServices$services.stub(_res);
}

const documentNodeQueryAllServices = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'AllServices'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'services'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'allServices'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'description'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'displayName'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'dnsRecords'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FragmentSpreadNode(
                    name: NameNode(value: 'fragmentDnsRecords'),
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
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'isEnabled'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'isMovable'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'isRequired'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'canBeBackedUp'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'backupDescription'),
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
                name: NameNode(value: 'storageUsage'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'title'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'usedSpace'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'volume'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
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
                name: NameNode(value: 'svgIcon'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'url'),
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
  fragmentDefinitionfragmentDnsRecords,
]);
Query$AllServices _parserFn$Query$AllServices(Map<String, dynamic> data) =>
    Query$AllServices.fromJson(data);
typedef OnQueryComplete$Query$AllServices = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$AllServices?,
);

class Options$Query$AllServices
    extends graphql.QueryOptions<Query$AllServices> {
  Options$Query$AllServices({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$AllServices? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$AllServices? onComplete,
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
                    data == null ? null : _parserFn$Query$AllServices(data),
                  ),
          onError: onError,
          document: documentNodeQueryAllServices,
          parserFn: _parserFn$Query$AllServices,
        );

  final OnQueryComplete$Query$AllServices? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$AllServices
    extends graphql.WatchQueryOptions<Query$AllServices> {
  WatchOptions$Query$AllServices({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$AllServices? typedOptimisticResult,
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
          document: documentNodeQueryAllServices,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$AllServices,
        );
}

class FetchMoreOptions$Query$AllServices extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$AllServices({required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryAllServices,
        );
}

extension ClientExtension$Query$AllServices on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$AllServices>> query$AllServices(
          [Options$Query$AllServices? options]) async =>
      await this.query(options ?? Options$Query$AllServices());
  graphql.ObservableQuery<Query$AllServices> watchQuery$AllServices(
          [WatchOptions$Query$AllServices? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$AllServices());
  void writeQuery$AllServices({
    required Query$AllServices data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryAllServices)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$AllServices? readQuery$AllServices({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryAllServices)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$AllServices.fromJson(result);
  }
}

class Query$AllServices$services {
  Query$AllServices$services({
    required this.allServices,
    this.$__typename = 'Services',
  });

  factory Query$AllServices$services.fromJson(Map<String, dynamic> json) {
    final l$allServices = json['allServices'];
    final l$$__typename = json['__typename'];
    return Query$AllServices$services(
      allServices: (l$allServices as List<dynamic>)
          .map((e) => Query$AllServices$services$allServices.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$AllServices$services$allServices> allServices;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$allServices = allServices;
    _resultData['allServices'] = l$allServices.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$allServices = allServices;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$allServices.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$AllServices$services) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$allServices = allServices;
    final lOther$allServices = other.allServices;
    if (l$allServices.length != lOther$allServices.length) {
      return false;
    }
    for (int i = 0; i < l$allServices.length; i++) {
      final l$allServices$entry = l$allServices[i];
      final lOther$allServices$entry = lOther$allServices[i];
      if (l$allServices$entry != lOther$allServices$entry) {
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

extension UtilityExtension$Query$AllServices$services
    on Query$AllServices$services {
  CopyWith$Query$AllServices$services<Query$AllServices$services>
      get copyWith => CopyWith$Query$AllServices$services(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$AllServices$services<TRes> {
  factory CopyWith$Query$AllServices$services(
    Query$AllServices$services instance,
    TRes Function(Query$AllServices$services) then,
  ) = _CopyWithImpl$Query$AllServices$services;

  factory CopyWith$Query$AllServices$services.stub(TRes res) =
      _CopyWithStubImpl$Query$AllServices$services;

  TRes call({
    List<Query$AllServices$services$allServices>? allServices,
    String? $__typename,
  });
  TRes allServices(
      Iterable<Query$AllServices$services$allServices> Function(
              Iterable<
                  CopyWith$Query$AllServices$services$allServices<
                      Query$AllServices$services$allServices>>)
          _fn);
}

class _CopyWithImpl$Query$AllServices$services<TRes>
    implements CopyWith$Query$AllServices$services<TRes> {
  _CopyWithImpl$Query$AllServices$services(
    this._instance,
    this._then,
  );

  final Query$AllServices$services _instance;

  final TRes Function(Query$AllServices$services) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? allServices = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$AllServices$services(
        allServices: allServices == _undefined || allServices == null
            ? _instance.allServices
            : (allServices as List<Query$AllServices$services$allServices>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  TRes allServices(
          Iterable<Query$AllServices$services$allServices> Function(
                  Iterable<
                      CopyWith$Query$AllServices$services$allServices<
                          Query$AllServices$services$allServices>>)
              _fn) =>
      call(
          allServices: _fn(_instance.allServices
              .map((e) => CopyWith$Query$AllServices$services$allServices(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$AllServices$services<TRes>
    implements CopyWith$Query$AllServices$services<TRes> {
  _CopyWithStubImpl$Query$AllServices$services(this._res);

  TRes _res;

  call({
    List<Query$AllServices$services$allServices>? allServices,
    String? $__typename,
  }) =>
      _res;
  allServices(_fn) => _res;
}

class Query$AllServices$services$allServices {
  Query$AllServices$services$allServices({
    required this.description,
    required this.displayName,
    this.dnsRecords,
    required this.id,
    required this.isEnabled,
    required this.isMovable,
    required this.isRequired,
    required this.canBeBackedUp,
    required this.backupDescription,
    required this.status,
    required this.storageUsage,
    required this.svgIcon,
    this.url,
    this.$__typename = 'Service',
  });

  factory Query$AllServices$services$allServices.fromJson(
      Map<String, dynamic> json) {
    final l$description = json['description'];
    final l$displayName = json['displayName'];
    final l$dnsRecords = json['dnsRecords'];
    final l$id = json['id'];
    final l$isEnabled = json['isEnabled'];
    final l$isMovable = json['isMovable'];
    final l$isRequired = json['isRequired'];
    final l$canBeBackedUp = json['canBeBackedUp'];
    final l$backupDescription = json['backupDescription'];
    final l$status = json['status'];
    final l$storageUsage = json['storageUsage'];
    final l$svgIcon = json['svgIcon'];
    final l$url = json['url'];
    final l$$__typename = json['__typename'];
    return Query$AllServices$services$allServices(
      description: (l$description as String),
      displayName: (l$displayName as String),
      dnsRecords: (l$dnsRecords as List<dynamic>?)
          ?.map((e) =>
              Fragment$fragmentDnsRecords.fromJson((e as Map<String, dynamic>)))
          .toList(),
      id: (l$id as String),
      isEnabled: (l$isEnabled as bool),
      isMovable: (l$isMovable as bool),
      isRequired: (l$isRequired as bool),
      canBeBackedUp: (l$canBeBackedUp as bool),
      backupDescription: (l$backupDescription as String),
      status: fromJson$Enum$ServiceStatusEnum((l$status as String)),
      storageUsage:
          Query$AllServices$services$allServices$storageUsage.fromJson(
              (l$storageUsage as Map<String, dynamic>)),
      svgIcon: (l$svgIcon as String),
      url: (l$url as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String description;

  final String displayName;

  final List<Fragment$fragmentDnsRecords>? dnsRecords;

  final String id;

  final bool isEnabled;

  final bool isMovable;

  final bool isRequired;

  final bool canBeBackedUp;

  final String backupDescription;

  final Enum$ServiceStatusEnum status;

  final Query$AllServices$services$allServices$storageUsage storageUsage;

  final String svgIcon;

  final String? url;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$description = description;
    _resultData['description'] = l$description;
    final l$displayName = displayName;
    _resultData['displayName'] = l$displayName;
    final l$dnsRecords = dnsRecords;
    _resultData['dnsRecords'] = l$dnsRecords?.map((e) => e.toJson()).toList();
    final l$id = id;
    _resultData['id'] = l$id;
    final l$isEnabled = isEnabled;
    _resultData['isEnabled'] = l$isEnabled;
    final l$isMovable = isMovable;
    _resultData['isMovable'] = l$isMovable;
    final l$isRequired = isRequired;
    _resultData['isRequired'] = l$isRequired;
    final l$canBeBackedUp = canBeBackedUp;
    _resultData['canBeBackedUp'] = l$canBeBackedUp;
    final l$backupDescription = backupDescription;
    _resultData['backupDescription'] = l$backupDescription;
    final l$status = status;
    _resultData['status'] = toJson$Enum$ServiceStatusEnum(l$status);
    final l$storageUsage = storageUsage;
    _resultData['storageUsage'] = l$storageUsage.toJson();
    final l$svgIcon = svgIcon;
    _resultData['svgIcon'] = l$svgIcon;
    final l$url = url;
    _resultData['url'] = l$url;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$description = description;
    final l$displayName = displayName;
    final l$dnsRecords = dnsRecords;
    final l$id = id;
    final l$isEnabled = isEnabled;
    final l$isMovable = isMovable;
    final l$isRequired = isRequired;
    final l$canBeBackedUp = canBeBackedUp;
    final l$backupDescription = backupDescription;
    final l$status = status;
    final l$storageUsage = storageUsage;
    final l$svgIcon = svgIcon;
    final l$url = url;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$description,
      l$displayName,
      l$dnsRecords == null ? null : Object.hashAll(l$dnsRecords.map((v) => v)),
      l$id,
      l$isEnabled,
      l$isMovable,
      l$isRequired,
      l$canBeBackedUp,
      l$backupDescription,
      l$status,
      l$storageUsage,
      l$svgIcon,
      l$url,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$AllServices$services$allServices) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) {
      return false;
    }
    final l$dnsRecords = dnsRecords;
    final lOther$dnsRecords = other.dnsRecords;
    if (l$dnsRecords != null && lOther$dnsRecords != null) {
      if (l$dnsRecords.length != lOther$dnsRecords.length) {
        return false;
      }
      for (int i = 0; i < l$dnsRecords.length; i++) {
        final l$dnsRecords$entry = l$dnsRecords[i];
        final lOther$dnsRecords$entry = lOther$dnsRecords[i];
        if (l$dnsRecords$entry != lOther$dnsRecords$entry) {
          return false;
        }
      }
    } else if (l$dnsRecords != lOther$dnsRecords) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$isEnabled = isEnabled;
    final lOther$isEnabled = other.isEnabled;
    if (l$isEnabled != lOther$isEnabled) {
      return false;
    }
    final l$isMovable = isMovable;
    final lOther$isMovable = other.isMovable;
    if (l$isMovable != lOther$isMovable) {
      return false;
    }
    final l$isRequired = isRequired;
    final lOther$isRequired = other.isRequired;
    if (l$isRequired != lOther$isRequired) {
      return false;
    }
    final l$canBeBackedUp = canBeBackedUp;
    final lOther$canBeBackedUp = other.canBeBackedUp;
    if (l$canBeBackedUp != lOther$canBeBackedUp) {
      return false;
    }
    final l$backupDescription = backupDescription;
    final lOther$backupDescription = other.backupDescription;
    if (l$backupDescription != lOther$backupDescription) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$storageUsage = storageUsage;
    final lOther$storageUsage = other.storageUsage;
    if (l$storageUsage != lOther$storageUsage) {
      return false;
    }
    final l$svgIcon = svgIcon;
    final lOther$svgIcon = other.svgIcon;
    if (l$svgIcon != lOther$svgIcon) {
      return false;
    }
    final l$url = url;
    final lOther$url = other.url;
    if (l$url != lOther$url) {
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

extension UtilityExtension$Query$AllServices$services$allServices
    on Query$AllServices$services$allServices {
  CopyWith$Query$AllServices$services$allServices<
          Query$AllServices$services$allServices>
      get copyWith => CopyWith$Query$AllServices$services$allServices(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$AllServices$services$allServices<TRes> {
  factory CopyWith$Query$AllServices$services$allServices(
    Query$AllServices$services$allServices instance,
    TRes Function(Query$AllServices$services$allServices) then,
  ) = _CopyWithImpl$Query$AllServices$services$allServices;

  factory CopyWith$Query$AllServices$services$allServices.stub(TRes res) =
      _CopyWithStubImpl$Query$AllServices$services$allServices;

  TRes call({
    String? description,
    String? displayName,
    List<Fragment$fragmentDnsRecords>? dnsRecords,
    String? id,
    bool? isEnabled,
    bool? isMovable,
    bool? isRequired,
    bool? canBeBackedUp,
    String? backupDescription,
    Enum$ServiceStatusEnum? status,
    Query$AllServices$services$allServices$storageUsage? storageUsage,
    String? svgIcon,
    String? url,
    String? $__typename,
  });
  TRes dnsRecords(
      Iterable<Fragment$fragmentDnsRecords>? Function(
              Iterable<
                  CopyWith$Fragment$fragmentDnsRecords<
                      Fragment$fragmentDnsRecords>>?)
          _fn);
  CopyWith$Query$AllServices$services$allServices$storageUsage<TRes>
      get storageUsage;
}

class _CopyWithImpl$Query$AllServices$services$allServices<TRes>
    implements CopyWith$Query$AllServices$services$allServices<TRes> {
  _CopyWithImpl$Query$AllServices$services$allServices(
    this._instance,
    this._then,
  );

  final Query$AllServices$services$allServices _instance;

  final TRes Function(Query$AllServices$services$allServices) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? description = _undefined,
    Object? displayName = _undefined,
    Object? dnsRecords = _undefined,
    Object? id = _undefined,
    Object? isEnabled = _undefined,
    Object? isMovable = _undefined,
    Object? isRequired = _undefined,
    Object? canBeBackedUp = _undefined,
    Object? backupDescription = _undefined,
    Object? status = _undefined,
    Object? storageUsage = _undefined,
    Object? svgIcon = _undefined,
    Object? url = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$AllServices$services$allServices(
        description: description == _undefined || description == null
            ? _instance.description
            : (description as String),
        displayName: displayName == _undefined || displayName == null
            ? _instance.displayName
            : (displayName as String),
        dnsRecords: dnsRecords == _undefined
            ? _instance.dnsRecords
            : (dnsRecords as List<Fragment$fragmentDnsRecords>?),
        id: id == _undefined || id == null ? _instance.id : (id as String),
        isEnabled: isEnabled == _undefined || isEnabled == null
            ? _instance.isEnabled
            : (isEnabled as bool),
        isMovable: isMovable == _undefined || isMovable == null
            ? _instance.isMovable
            : (isMovable as bool),
        isRequired: isRequired == _undefined || isRequired == null
            ? _instance.isRequired
            : (isRequired as bool),
        canBeBackedUp: canBeBackedUp == _undefined || canBeBackedUp == null
            ? _instance.canBeBackedUp
            : (canBeBackedUp as bool),
        backupDescription:
            backupDescription == _undefined || backupDescription == null
                ? _instance.backupDescription
                : (backupDescription as String),
        status: status == _undefined || status == null
            ? _instance.status
            : (status as Enum$ServiceStatusEnum),
        storageUsage: storageUsage == _undefined || storageUsage == null
            ? _instance.storageUsage
            : (storageUsage
                as Query$AllServices$services$allServices$storageUsage),
        svgIcon: svgIcon == _undefined || svgIcon == null
            ? _instance.svgIcon
            : (svgIcon as String),
        url: url == _undefined ? _instance.url : (url as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  TRes dnsRecords(
          Iterable<Fragment$fragmentDnsRecords>? Function(
                  Iterable<
                      CopyWith$Fragment$fragmentDnsRecords<
                          Fragment$fragmentDnsRecords>>?)
              _fn) =>
      call(
          dnsRecords: _fn(_instance.dnsRecords
              ?.map((e) => CopyWith$Fragment$fragmentDnsRecords(
                    e,
                    (i) => i,
                  )))?.toList());
  CopyWith$Query$AllServices$services$allServices$storageUsage<TRes>
      get storageUsage {
    final local$storageUsage = _instance.storageUsage;
    return CopyWith$Query$AllServices$services$allServices$storageUsage(
        local$storageUsage, (e) => call(storageUsage: e));
  }
}

class _CopyWithStubImpl$Query$AllServices$services$allServices<TRes>
    implements CopyWith$Query$AllServices$services$allServices<TRes> {
  _CopyWithStubImpl$Query$AllServices$services$allServices(this._res);

  TRes _res;

  call({
    String? description,
    String? displayName,
    List<Fragment$fragmentDnsRecords>? dnsRecords,
    String? id,
    bool? isEnabled,
    bool? isMovable,
    bool? isRequired,
    bool? canBeBackedUp,
    String? backupDescription,
    Enum$ServiceStatusEnum? status,
    Query$AllServices$services$allServices$storageUsage? storageUsage,
    String? svgIcon,
    String? url,
    String? $__typename,
  }) =>
      _res;
  dnsRecords(_fn) => _res;
  CopyWith$Query$AllServices$services$allServices$storageUsage<TRes>
      get storageUsage =>
          CopyWith$Query$AllServices$services$allServices$storageUsage.stub(
              _res);
}

class Query$AllServices$services$allServices$storageUsage {
  Query$AllServices$services$allServices$storageUsage({
    required this.title,
    required this.usedSpace,
    this.volume,
    this.$__typename = 'ServiceStorageUsage',
  });

  factory Query$AllServices$services$allServices$storageUsage.fromJson(
      Map<String, dynamic> json) {
    final l$title = json['title'];
    final l$usedSpace = json['usedSpace'];
    final l$volume = json['volume'];
    final l$$__typename = json['__typename'];
    return Query$AllServices$services$allServices$storageUsage(
      title: (l$title as String),
      usedSpace: (l$usedSpace as String),
      volume: l$volume == null
          ? null
          : Query$AllServices$services$allServices$storageUsage$volume.fromJson(
              (l$volume as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String title;

  final String usedSpace;

  final Query$AllServices$services$allServices$storageUsage$volume? volume;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$title = title;
    _resultData['title'] = l$title;
    final l$usedSpace = usedSpace;
    _resultData['usedSpace'] = l$usedSpace;
    final l$volume = volume;
    _resultData['volume'] = l$volume?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$title = title;
    final l$usedSpace = usedSpace;
    final l$volume = volume;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$title,
      l$usedSpace,
      l$volume,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$AllServices$services$allServices$storageUsage) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$usedSpace = usedSpace;
    final lOther$usedSpace = other.usedSpace;
    if (l$usedSpace != lOther$usedSpace) {
      return false;
    }
    final l$volume = volume;
    final lOther$volume = other.volume;
    if (l$volume != lOther$volume) {
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

extension UtilityExtension$Query$AllServices$services$allServices$storageUsage
    on Query$AllServices$services$allServices$storageUsage {
  CopyWith$Query$AllServices$services$allServices$storageUsage<
          Query$AllServices$services$allServices$storageUsage>
      get copyWith =>
          CopyWith$Query$AllServices$services$allServices$storageUsage(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$AllServices$services$allServices$storageUsage<
    TRes> {
  factory CopyWith$Query$AllServices$services$allServices$storageUsage(
    Query$AllServices$services$allServices$storageUsage instance,
    TRes Function(Query$AllServices$services$allServices$storageUsage) then,
  ) = _CopyWithImpl$Query$AllServices$services$allServices$storageUsage;

  factory CopyWith$Query$AllServices$services$allServices$storageUsage.stub(
          TRes res) =
      _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage;

  TRes call({
    String? title,
    String? usedSpace,
    Query$AllServices$services$allServices$storageUsage$volume? volume,
    String? $__typename,
  });
  CopyWith$Query$AllServices$services$allServices$storageUsage$volume<TRes>
      get volume;
}

class _CopyWithImpl$Query$AllServices$services$allServices$storageUsage<TRes>
    implements
        CopyWith$Query$AllServices$services$allServices$storageUsage<TRes> {
  _CopyWithImpl$Query$AllServices$services$allServices$storageUsage(
    this._instance,
    this._then,
  );

  final Query$AllServices$services$allServices$storageUsage _instance;

  final TRes Function(Query$AllServices$services$allServices$storageUsage)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? title = _undefined,
    Object? usedSpace = _undefined,
    Object? volume = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$AllServices$services$allServices$storageUsage(
        title: title == _undefined || title == null
            ? _instance.title
            : (title as String),
        usedSpace: usedSpace == _undefined || usedSpace == null
            ? _instance.usedSpace
            : (usedSpace as String),
        volume: volume == _undefined
            ? _instance.volume
            : (volume
                as Query$AllServices$services$allServices$storageUsage$volume?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$AllServices$services$allServices$storageUsage$volume<TRes>
      get volume {
    final local$volume = _instance.volume;
    return local$volume == null
        ? CopyWith$Query$AllServices$services$allServices$storageUsage$volume
            .stub(_then(_instance))
        : CopyWith$Query$AllServices$services$allServices$storageUsage$volume(
            local$volume, (e) => call(volume: e));
  }
}

class _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage<
        TRes>
    implements
        CopyWith$Query$AllServices$services$allServices$storageUsage<TRes> {
  _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage(
      this._res);

  TRes _res;

  call({
    String? title,
    String? usedSpace,
    Query$AllServices$services$allServices$storageUsage$volume? volume,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$AllServices$services$allServices$storageUsage$volume<TRes>
      get volume =>
          CopyWith$Query$AllServices$services$allServices$storageUsage$volume
              .stub(_res);
}

class Query$AllServices$services$allServices$storageUsage$volume {
  Query$AllServices$services$allServices$storageUsage$volume({
    required this.name,
    this.$__typename = 'StorageVolume',
  });

  factory Query$AllServices$services$allServices$storageUsage$volume.fromJson(
      Map<String, dynamic> json) {
    final l$name = json['name'];
    final l$$__typename = json['__typename'];
    return Query$AllServices$services$allServices$storageUsage$volume(
      name: (l$name as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String name;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$name = name;
    _resultData['name'] = l$name;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$name = name;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$name,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Query$AllServices$services$allServices$storageUsage$volume) ||
        runtimeType != other.runtimeType) {
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

extension UtilityExtension$Query$AllServices$services$allServices$storageUsage$volume
    on Query$AllServices$services$allServices$storageUsage$volume {
  CopyWith$Query$AllServices$services$allServices$storageUsage$volume<
          Query$AllServices$services$allServices$storageUsage$volume>
      get copyWith =>
          CopyWith$Query$AllServices$services$allServices$storageUsage$volume(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$AllServices$services$allServices$storageUsage$volume<
    TRes> {
  factory CopyWith$Query$AllServices$services$allServices$storageUsage$volume(
    Query$AllServices$services$allServices$storageUsage$volume instance,
    TRes Function(Query$AllServices$services$allServices$storageUsage$volume)
        then,
  ) = _CopyWithImpl$Query$AllServices$services$allServices$storageUsage$volume;

  factory CopyWith$Query$AllServices$services$allServices$storageUsage$volume.stub(
          TRes res) =
      _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage$volume;

  TRes call({
    String? name,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$AllServices$services$allServices$storageUsage$volume<
        TRes>
    implements
        CopyWith$Query$AllServices$services$allServices$storageUsage$volume<
            TRes> {
  _CopyWithImpl$Query$AllServices$services$allServices$storageUsage$volume(
    this._instance,
    this._then,
  );

  final Query$AllServices$services$allServices$storageUsage$volume _instance;

  final TRes Function(
      Query$AllServices$services$allServices$storageUsage$volume) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? name = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$AllServices$services$allServices$storageUsage$volume(
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage$volume<
        TRes>
    implements
        CopyWith$Query$AllServices$services$allServices$storageUsage$volume<
            TRes> {
  _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage$volume(
      this._res);

  TRes _res;

  call({
    String? name,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$EnableService {
  factory Variables$Mutation$EnableService({required String serviceId}) =>
      Variables$Mutation$EnableService._({
        r'serviceId': serviceId,
      });

  Variables$Mutation$EnableService._(this._$data);

  factory Variables$Mutation$EnableService.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$serviceId = data['serviceId'];
    result$data['serviceId'] = (l$serviceId as String);
    return Variables$Mutation$EnableService._(result$data);
  }

  Map<String, dynamic> _$data;

  String get serviceId => (_$data['serviceId'] as String);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$serviceId = serviceId;
    result$data['serviceId'] = l$serviceId;
    return result$data;
  }

  CopyWith$Variables$Mutation$EnableService<Variables$Mutation$EnableService>
      get copyWith => CopyWith$Variables$Mutation$EnableService(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$EnableService) ||
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

abstract class CopyWith$Variables$Mutation$EnableService<TRes> {
  factory CopyWith$Variables$Mutation$EnableService(
    Variables$Mutation$EnableService instance,
    TRes Function(Variables$Mutation$EnableService) then,
  ) = _CopyWithImpl$Variables$Mutation$EnableService;

  factory CopyWith$Variables$Mutation$EnableService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$EnableService;

  TRes call({String? serviceId});
}

class _CopyWithImpl$Variables$Mutation$EnableService<TRes>
    implements CopyWith$Variables$Mutation$EnableService<TRes> {
  _CopyWithImpl$Variables$Mutation$EnableService(
    this._instance,
    this._then,
  );

  final Variables$Mutation$EnableService _instance;

  final TRes Function(Variables$Mutation$EnableService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? serviceId = _undefined}) =>
      _then(Variables$Mutation$EnableService._({
        ..._instance._$data,
        if (serviceId != _undefined && serviceId != null)
          'serviceId': (serviceId as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$EnableService<TRes>
    implements CopyWith$Variables$Mutation$EnableService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$EnableService(this._res);

  TRes _res;

  call({String? serviceId}) => _res;
}

class Mutation$EnableService {
  Mutation$EnableService({
    required this.enableService,
    this.$__typename = 'Mutation',
  });

  factory Mutation$EnableService.fromJson(Map<String, dynamic> json) {
    final l$enableService = json['enableService'];
    final l$$__typename = json['__typename'];
    return Mutation$EnableService(
      enableService: Mutation$EnableService$enableService.fromJson(
          (l$enableService as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$EnableService$enableService enableService;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$enableService = enableService;
    _resultData['enableService'] = l$enableService.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$enableService = enableService;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$enableService,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$EnableService) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$enableService = enableService;
    final lOther$enableService = other.enableService;
    if (l$enableService != lOther$enableService) {
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

extension UtilityExtension$Mutation$EnableService on Mutation$EnableService {
  CopyWith$Mutation$EnableService<Mutation$EnableService> get copyWith =>
      CopyWith$Mutation$EnableService(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$EnableService<TRes> {
  factory CopyWith$Mutation$EnableService(
    Mutation$EnableService instance,
    TRes Function(Mutation$EnableService) then,
  ) = _CopyWithImpl$Mutation$EnableService;

  factory CopyWith$Mutation$EnableService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$EnableService;

  TRes call({
    Mutation$EnableService$enableService? enableService,
    String? $__typename,
  });
  CopyWith$Mutation$EnableService$enableService<TRes> get enableService;
}

class _CopyWithImpl$Mutation$EnableService<TRes>
    implements CopyWith$Mutation$EnableService<TRes> {
  _CopyWithImpl$Mutation$EnableService(
    this._instance,
    this._then,
  );

  final Mutation$EnableService _instance;

  final TRes Function(Mutation$EnableService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? enableService = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$EnableService(
        enableService: enableService == _undefined || enableService == null
            ? _instance.enableService
            : (enableService as Mutation$EnableService$enableService),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$EnableService$enableService<TRes> get enableService {
    final local$enableService = _instance.enableService;
    return CopyWith$Mutation$EnableService$enableService(
        local$enableService, (e) => call(enableService: e));
  }
}

class _CopyWithStubImpl$Mutation$EnableService<TRes>
    implements CopyWith$Mutation$EnableService<TRes> {
  _CopyWithStubImpl$Mutation$EnableService(this._res);

  TRes _res;

  call({
    Mutation$EnableService$enableService? enableService,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$EnableService$enableService<TRes> get enableService =>
      CopyWith$Mutation$EnableService$enableService.stub(_res);
}

const documentNodeMutationEnableService = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'EnableService'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'serviceId')),
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
        name: NameNode(value: 'enableService'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'serviceId'),
            value: VariableNode(name: NameNode(value: 'serviceId')),
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
Mutation$EnableService _parserFn$Mutation$EnableService(
        Map<String, dynamic> data) =>
    Mutation$EnableService.fromJson(data);
typedef OnMutationCompleted$Mutation$EnableService = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$EnableService?,
);

class Options$Mutation$EnableService
    extends graphql.MutationOptions<Mutation$EnableService> {
  Options$Mutation$EnableService({
    String? operationName,
    required Variables$Mutation$EnableService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$EnableService? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$EnableService? onCompleted,
    graphql.OnMutationUpdate<Mutation$EnableService>? update,
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
                        : _parserFn$Mutation$EnableService(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationEnableService,
          parserFn: _parserFn$Mutation$EnableService,
        );

  final OnMutationCompleted$Mutation$EnableService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$EnableService
    extends graphql.WatchQueryOptions<Mutation$EnableService> {
  WatchOptions$Mutation$EnableService({
    String? operationName,
    required Variables$Mutation$EnableService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$EnableService? typedOptimisticResult,
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
          document: documentNodeMutationEnableService,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$EnableService,
        );
}

extension ClientExtension$Mutation$EnableService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$EnableService>> mutate$EnableService(
          Options$Mutation$EnableService options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$EnableService> watchMutation$EnableService(
          WatchOptions$Mutation$EnableService options) =>
      this.watchMutation(options);
}

class Mutation$EnableService$enableService
    implements Fragment$basicMutationReturnFields$$ServiceMutationReturn {
  Mutation$EnableService$enableService({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ServiceMutationReturn',
  });

  factory Mutation$EnableService$enableService.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$EnableService$enableService(
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
    if (!(other is Mutation$EnableService$enableService) ||
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

extension UtilityExtension$Mutation$EnableService$enableService
    on Mutation$EnableService$enableService {
  CopyWith$Mutation$EnableService$enableService<
          Mutation$EnableService$enableService>
      get copyWith => CopyWith$Mutation$EnableService$enableService(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$EnableService$enableService<TRes> {
  factory CopyWith$Mutation$EnableService$enableService(
    Mutation$EnableService$enableService instance,
    TRes Function(Mutation$EnableService$enableService) then,
  ) = _CopyWithImpl$Mutation$EnableService$enableService;

  factory CopyWith$Mutation$EnableService$enableService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$EnableService$enableService;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$EnableService$enableService<TRes>
    implements CopyWith$Mutation$EnableService$enableService<TRes> {
  _CopyWithImpl$Mutation$EnableService$enableService(
    this._instance,
    this._then,
  );

  final Mutation$EnableService$enableService _instance;

  final TRes Function(Mutation$EnableService$enableService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$EnableService$enableService(
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

class _CopyWithStubImpl$Mutation$EnableService$enableService<TRes>
    implements CopyWith$Mutation$EnableService$enableService<TRes> {
  _CopyWithStubImpl$Mutation$EnableService$enableService(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$DisableService {
  factory Variables$Mutation$DisableService({required String serviceId}) =>
      Variables$Mutation$DisableService._({
        r'serviceId': serviceId,
      });

  Variables$Mutation$DisableService._(this._$data);

  factory Variables$Mutation$DisableService.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$serviceId = data['serviceId'];
    result$data['serviceId'] = (l$serviceId as String);
    return Variables$Mutation$DisableService._(result$data);
  }

  Map<String, dynamic> _$data;

  String get serviceId => (_$data['serviceId'] as String);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$serviceId = serviceId;
    result$data['serviceId'] = l$serviceId;
    return result$data;
  }

  CopyWith$Variables$Mutation$DisableService<Variables$Mutation$DisableService>
      get copyWith => CopyWith$Variables$Mutation$DisableService(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$DisableService) ||
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

abstract class CopyWith$Variables$Mutation$DisableService<TRes> {
  factory CopyWith$Variables$Mutation$DisableService(
    Variables$Mutation$DisableService instance,
    TRes Function(Variables$Mutation$DisableService) then,
  ) = _CopyWithImpl$Variables$Mutation$DisableService;

  factory CopyWith$Variables$Mutation$DisableService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$DisableService;

  TRes call({String? serviceId});
}

class _CopyWithImpl$Variables$Mutation$DisableService<TRes>
    implements CopyWith$Variables$Mutation$DisableService<TRes> {
  _CopyWithImpl$Variables$Mutation$DisableService(
    this._instance,
    this._then,
  );

  final Variables$Mutation$DisableService _instance;

  final TRes Function(Variables$Mutation$DisableService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? serviceId = _undefined}) =>
      _then(Variables$Mutation$DisableService._({
        ..._instance._$data,
        if (serviceId != _undefined && serviceId != null)
          'serviceId': (serviceId as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$DisableService<TRes>
    implements CopyWith$Variables$Mutation$DisableService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$DisableService(this._res);

  TRes _res;

  call({String? serviceId}) => _res;
}

class Mutation$DisableService {
  Mutation$DisableService({
    required this.disableService,
    this.$__typename = 'Mutation',
  });

  factory Mutation$DisableService.fromJson(Map<String, dynamic> json) {
    final l$disableService = json['disableService'];
    final l$$__typename = json['__typename'];
    return Mutation$DisableService(
      disableService: Mutation$DisableService$disableService.fromJson(
          (l$disableService as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$DisableService$disableService disableService;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$disableService = disableService;
    _resultData['disableService'] = l$disableService.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$disableService = disableService;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$disableService,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$DisableService) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$disableService = disableService;
    final lOther$disableService = other.disableService;
    if (l$disableService != lOther$disableService) {
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

extension UtilityExtension$Mutation$DisableService on Mutation$DisableService {
  CopyWith$Mutation$DisableService<Mutation$DisableService> get copyWith =>
      CopyWith$Mutation$DisableService(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$DisableService<TRes> {
  factory CopyWith$Mutation$DisableService(
    Mutation$DisableService instance,
    TRes Function(Mutation$DisableService) then,
  ) = _CopyWithImpl$Mutation$DisableService;

  factory CopyWith$Mutation$DisableService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DisableService;

  TRes call({
    Mutation$DisableService$disableService? disableService,
    String? $__typename,
  });
  CopyWith$Mutation$DisableService$disableService<TRes> get disableService;
}

class _CopyWithImpl$Mutation$DisableService<TRes>
    implements CopyWith$Mutation$DisableService<TRes> {
  _CopyWithImpl$Mutation$DisableService(
    this._instance,
    this._then,
  );

  final Mutation$DisableService _instance;

  final TRes Function(Mutation$DisableService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? disableService = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$DisableService(
        disableService: disableService == _undefined || disableService == null
            ? _instance.disableService
            : (disableService as Mutation$DisableService$disableService),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$DisableService$disableService<TRes> get disableService {
    final local$disableService = _instance.disableService;
    return CopyWith$Mutation$DisableService$disableService(
        local$disableService, (e) => call(disableService: e));
  }
}

class _CopyWithStubImpl$Mutation$DisableService<TRes>
    implements CopyWith$Mutation$DisableService<TRes> {
  _CopyWithStubImpl$Mutation$DisableService(this._res);

  TRes _res;

  call({
    Mutation$DisableService$disableService? disableService,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$DisableService$disableService<TRes> get disableService =>
      CopyWith$Mutation$DisableService$disableService.stub(_res);
}

const documentNodeMutationDisableService = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'DisableService'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'serviceId')),
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
        name: NameNode(value: 'disableService'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'serviceId'),
            value: VariableNode(name: NameNode(value: 'serviceId')),
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
Mutation$DisableService _parserFn$Mutation$DisableService(
        Map<String, dynamic> data) =>
    Mutation$DisableService.fromJson(data);
typedef OnMutationCompleted$Mutation$DisableService = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$DisableService?,
);

class Options$Mutation$DisableService
    extends graphql.MutationOptions<Mutation$DisableService> {
  Options$Mutation$DisableService({
    String? operationName,
    required Variables$Mutation$DisableService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DisableService? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$DisableService? onCompleted,
    graphql.OnMutationUpdate<Mutation$DisableService>? update,
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
                        : _parserFn$Mutation$DisableService(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationDisableService,
          parserFn: _parserFn$Mutation$DisableService,
        );

  final OnMutationCompleted$Mutation$DisableService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$DisableService
    extends graphql.WatchQueryOptions<Mutation$DisableService> {
  WatchOptions$Mutation$DisableService({
    String? operationName,
    required Variables$Mutation$DisableService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DisableService? typedOptimisticResult,
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
          document: documentNodeMutationDisableService,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$DisableService,
        );
}

extension ClientExtension$Mutation$DisableService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$DisableService>> mutate$DisableService(
          Options$Mutation$DisableService options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$DisableService> watchMutation$DisableService(
          WatchOptions$Mutation$DisableService options) =>
      this.watchMutation(options);
}

class Mutation$DisableService$disableService
    implements Fragment$basicMutationReturnFields$$ServiceMutationReturn {
  Mutation$DisableService$disableService({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ServiceMutationReturn',
  });

  factory Mutation$DisableService$disableService.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$DisableService$disableService(
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
    if (!(other is Mutation$DisableService$disableService) ||
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

extension UtilityExtension$Mutation$DisableService$disableService
    on Mutation$DisableService$disableService {
  CopyWith$Mutation$DisableService$disableService<
          Mutation$DisableService$disableService>
      get copyWith => CopyWith$Mutation$DisableService$disableService(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$DisableService$disableService<TRes> {
  factory CopyWith$Mutation$DisableService$disableService(
    Mutation$DisableService$disableService instance,
    TRes Function(Mutation$DisableService$disableService) then,
  ) = _CopyWithImpl$Mutation$DisableService$disableService;

  factory CopyWith$Mutation$DisableService$disableService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DisableService$disableService;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$DisableService$disableService<TRes>
    implements CopyWith$Mutation$DisableService$disableService<TRes> {
  _CopyWithImpl$Mutation$DisableService$disableService(
    this._instance,
    this._then,
  );

  final Mutation$DisableService$disableService _instance;

  final TRes Function(Mutation$DisableService$disableService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$DisableService$disableService(
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

class _CopyWithStubImpl$Mutation$DisableService$disableService<TRes>
    implements CopyWith$Mutation$DisableService$disableService<TRes> {
  _CopyWithStubImpl$Mutation$DisableService$disableService(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$StopService {
  factory Variables$Mutation$StopService({required String serviceId}) =>
      Variables$Mutation$StopService._({
        r'serviceId': serviceId,
      });

  Variables$Mutation$StopService._(this._$data);

  factory Variables$Mutation$StopService.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$serviceId = data['serviceId'];
    result$data['serviceId'] = (l$serviceId as String);
    return Variables$Mutation$StopService._(result$data);
  }

  Map<String, dynamic> _$data;

  String get serviceId => (_$data['serviceId'] as String);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$serviceId = serviceId;
    result$data['serviceId'] = l$serviceId;
    return result$data;
  }

  CopyWith$Variables$Mutation$StopService<Variables$Mutation$StopService>
      get copyWith => CopyWith$Variables$Mutation$StopService(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$StopService) ||
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

abstract class CopyWith$Variables$Mutation$StopService<TRes> {
  factory CopyWith$Variables$Mutation$StopService(
    Variables$Mutation$StopService instance,
    TRes Function(Variables$Mutation$StopService) then,
  ) = _CopyWithImpl$Variables$Mutation$StopService;

  factory CopyWith$Variables$Mutation$StopService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$StopService;

  TRes call({String? serviceId});
}

class _CopyWithImpl$Variables$Mutation$StopService<TRes>
    implements CopyWith$Variables$Mutation$StopService<TRes> {
  _CopyWithImpl$Variables$Mutation$StopService(
    this._instance,
    this._then,
  );

  final Variables$Mutation$StopService _instance;

  final TRes Function(Variables$Mutation$StopService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? serviceId = _undefined}) =>
      _then(Variables$Mutation$StopService._({
        ..._instance._$data,
        if (serviceId != _undefined && serviceId != null)
          'serviceId': (serviceId as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$StopService<TRes>
    implements CopyWith$Variables$Mutation$StopService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$StopService(this._res);

  TRes _res;

  call({String? serviceId}) => _res;
}

class Mutation$StopService {
  Mutation$StopService({
    required this.stopService,
    this.$__typename = 'Mutation',
  });

  factory Mutation$StopService.fromJson(Map<String, dynamic> json) {
    final l$stopService = json['stopService'];
    final l$$__typename = json['__typename'];
    return Mutation$StopService(
      stopService: Mutation$StopService$stopService.fromJson(
          (l$stopService as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$StopService$stopService stopService;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$stopService = stopService;
    _resultData['stopService'] = l$stopService.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$stopService = stopService;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$stopService,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$StopService) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$stopService = stopService;
    final lOther$stopService = other.stopService;
    if (l$stopService != lOther$stopService) {
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

extension UtilityExtension$Mutation$StopService on Mutation$StopService {
  CopyWith$Mutation$StopService<Mutation$StopService> get copyWith =>
      CopyWith$Mutation$StopService(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$StopService<TRes> {
  factory CopyWith$Mutation$StopService(
    Mutation$StopService instance,
    TRes Function(Mutation$StopService) then,
  ) = _CopyWithImpl$Mutation$StopService;

  factory CopyWith$Mutation$StopService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StopService;

  TRes call({
    Mutation$StopService$stopService? stopService,
    String? $__typename,
  });
  CopyWith$Mutation$StopService$stopService<TRes> get stopService;
}

class _CopyWithImpl$Mutation$StopService<TRes>
    implements CopyWith$Mutation$StopService<TRes> {
  _CopyWithImpl$Mutation$StopService(
    this._instance,
    this._then,
  );

  final Mutation$StopService _instance;

  final TRes Function(Mutation$StopService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? stopService = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$StopService(
        stopService: stopService == _undefined || stopService == null
            ? _instance.stopService
            : (stopService as Mutation$StopService$stopService),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$StopService$stopService<TRes> get stopService {
    final local$stopService = _instance.stopService;
    return CopyWith$Mutation$StopService$stopService(
        local$stopService, (e) => call(stopService: e));
  }
}

class _CopyWithStubImpl$Mutation$StopService<TRes>
    implements CopyWith$Mutation$StopService<TRes> {
  _CopyWithStubImpl$Mutation$StopService(this._res);

  TRes _res;

  call({
    Mutation$StopService$stopService? stopService,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$StopService$stopService<TRes> get stopService =>
      CopyWith$Mutation$StopService$stopService.stub(_res);
}

const documentNodeMutationStopService = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'StopService'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'serviceId')),
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
        name: NameNode(value: 'stopService'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'serviceId'),
            value: VariableNode(name: NameNode(value: 'serviceId')),
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
Mutation$StopService _parserFn$Mutation$StopService(
        Map<String, dynamic> data) =>
    Mutation$StopService.fromJson(data);
typedef OnMutationCompleted$Mutation$StopService = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$StopService?,
);

class Options$Mutation$StopService
    extends graphql.MutationOptions<Mutation$StopService> {
  Options$Mutation$StopService({
    String? operationName,
    required Variables$Mutation$StopService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$StopService? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$StopService? onCompleted,
    graphql.OnMutationUpdate<Mutation$StopService>? update,
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
                    data == null ? null : _parserFn$Mutation$StopService(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationStopService,
          parserFn: _parserFn$Mutation$StopService,
        );

  final OnMutationCompleted$Mutation$StopService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$StopService
    extends graphql.WatchQueryOptions<Mutation$StopService> {
  WatchOptions$Mutation$StopService({
    String? operationName,
    required Variables$Mutation$StopService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$StopService? typedOptimisticResult,
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
          document: documentNodeMutationStopService,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$StopService,
        );
}

extension ClientExtension$Mutation$StopService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$StopService>> mutate$StopService(
          Options$Mutation$StopService options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$StopService> watchMutation$StopService(
          WatchOptions$Mutation$StopService options) =>
      this.watchMutation(options);
}

class Mutation$StopService$stopService
    implements Fragment$basicMutationReturnFields$$ServiceMutationReturn {
  Mutation$StopService$stopService({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ServiceMutationReturn',
  });

  factory Mutation$StopService$stopService.fromJson(Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$StopService$stopService(
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
    if (!(other is Mutation$StopService$stopService) ||
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

extension UtilityExtension$Mutation$StopService$stopService
    on Mutation$StopService$stopService {
  CopyWith$Mutation$StopService$stopService<Mutation$StopService$stopService>
      get copyWith => CopyWith$Mutation$StopService$stopService(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$StopService$stopService<TRes> {
  factory CopyWith$Mutation$StopService$stopService(
    Mutation$StopService$stopService instance,
    TRes Function(Mutation$StopService$stopService) then,
  ) = _CopyWithImpl$Mutation$StopService$stopService;

  factory CopyWith$Mutation$StopService$stopService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StopService$stopService;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$StopService$stopService<TRes>
    implements CopyWith$Mutation$StopService$stopService<TRes> {
  _CopyWithImpl$Mutation$StopService$stopService(
    this._instance,
    this._then,
  );

  final Mutation$StopService$stopService _instance;

  final TRes Function(Mutation$StopService$stopService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$StopService$stopService(
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

class _CopyWithStubImpl$Mutation$StopService$stopService<TRes>
    implements CopyWith$Mutation$StopService$stopService<TRes> {
  _CopyWithStubImpl$Mutation$StopService$stopService(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$StartService {
  factory Variables$Mutation$StartService({required String serviceId}) =>
      Variables$Mutation$StartService._({
        r'serviceId': serviceId,
      });

  Variables$Mutation$StartService._(this._$data);

  factory Variables$Mutation$StartService.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$serviceId = data['serviceId'];
    result$data['serviceId'] = (l$serviceId as String);
    return Variables$Mutation$StartService._(result$data);
  }

  Map<String, dynamic> _$data;

  String get serviceId => (_$data['serviceId'] as String);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$serviceId = serviceId;
    result$data['serviceId'] = l$serviceId;
    return result$data;
  }

  CopyWith$Variables$Mutation$StartService<Variables$Mutation$StartService>
      get copyWith => CopyWith$Variables$Mutation$StartService(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$StartService) ||
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

abstract class CopyWith$Variables$Mutation$StartService<TRes> {
  factory CopyWith$Variables$Mutation$StartService(
    Variables$Mutation$StartService instance,
    TRes Function(Variables$Mutation$StartService) then,
  ) = _CopyWithImpl$Variables$Mutation$StartService;

  factory CopyWith$Variables$Mutation$StartService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$StartService;

  TRes call({String? serviceId});
}

class _CopyWithImpl$Variables$Mutation$StartService<TRes>
    implements CopyWith$Variables$Mutation$StartService<TRes> {
  _CopyWithImpl$Variables$Mutation$StartService(
    this._instance,
    this._then,
  );

  final Variables$Mutation$StartService _instance;

  final TRes Function(Variables$Mutation$StartService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? serviceId = _undefined}) =>
      _then(Variables$Mutation$StartService._({
        ..._instance._$data,
        if (serviceId != _undefined && serviceId != null)
          'serviceId': (serviceId as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$StartService<TRes>
    implements CopyWith$Variables$Mutation$StartService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$StartService(this._res);

  TRes _res;

  call({String? serviceId}) => _res;
}

class Mutation$StartService {
  Mutation$StartService({
    required this.startService,
    this.$__typename = 'Mutation',
  });

  factory Mutation$StartService.fromJson(Map<String, dynamic> json) {
    final l$startService = json['startService'];
    final l$$__typename = json['__typename'];
    return Mutation$StartService(
      startService: Mutation$StartService$startService.fromJson(
          (l$startService as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$StartService$startService startService;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$startService = startService;
    _resultData['startService'] = l$startService.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$startService = startService;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$startService,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$StartService) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$startService = startService;
    final lOther$startService = other.startService;
    if (l$startService != lOther$startService) {
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

extension UtilityExtension$Mutation$StartService on Mutation$StartService {
  CopyWith$Mutation$StartService<Mutation$StartService> get copyWith =>
      CopyWith$Mutation$StartService(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$StartService<TRes> {
  factory CopyWith$Mutation$StartService(
    Mutation$StartService instance,
    TRes Function(Mutation$StartService) then,
  ) = _CopyWithImpl$Mutation$StartService;

  factory CopyWith$Mutation$StartService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StartService;

  TRes call({
    Mutation$StartService$startService? startService,
    String? $__typename,
  });
  CopyWith$Mutation$StartService$startService<TRes> get startService;
}

class _CopyWithImpl$Mutation$StartService<TRes>
    implements CopyWith$Mutation$StartService<TRes> {
  _CopyWithImpl$Mutation$StartService(
    this._instance,
    this._then,
  );

  final Mutation$StartService _instance;

  final TRes Function(Mutation$StartService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? startService = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$StartService(
        startService: startService == _undefined || startService == null
            ? _instance.startService
            : (startService as Mutation$StartService$startService),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$StartService$startService<TRes> get startService {
    final local$startService = _instance.startService;
    return CopyWith$Mutation$StartService$startService(
        local$startService, (e) => call(startService: e));
  }
}

class _CopyWithStubImpl$Mutation$StartService<TRes>
    implements CopyWith$Mutation$StartService<TRes> {
  _CopyWithStubImpl$Mutation$StartService(this._res);

  TRes _res;

  call({
    Mutation$StartService$startService? startService,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$StartService$startService<TRes> get startService =>
      CopyWith$Mutation$StartService$startService.stub(_res);
}

const documentNodeMutationStartService = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'StartService'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'serviceId')),
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
        name: NameNode(value: 'startService'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'serviceId'),
            value: VariableNode(name: NameNode(value: 'serviceId')),
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
Mutation$StartService _parserFn$Mutation$StartService(
        Map<String, dynamic> data) =>
    Mutation$StartService.fromJson(data);
typedef OnMutationCompleted$Mutation$StartService = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$StartService?,
);

class Options$Mutation$StartService
    extends graphql.MutationOptions<Mutation$StartService> {
  Options$Mutation$StartService({
    String? operationName,
    required Variables$Mutation$StartService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$StartService? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$StartService? onCompleted,
    graphql.OnMutationUpdate<Mutation$StartService>? update,
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
                    data == null ? null : _parserFn$Mutation$StartService(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationStartService,
          parserFn: _parserFn$Mutation$StartService,
        );

  final OnMutationCompleted$Mutation$StartService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$StartService
    extends graphql.WatchQueryOptions<Mutation$StartService> {
  WatchOptions$Mutation$StartService({
    String? operationName,
    required Variables$Mutation$StartService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$StartService? typedOptimisticResult,
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
          document: documentNodeMutationStartService,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$StartService,
        );
}

extension ClientExtension$Mutation$StartService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$StartService>> mutate$StartService(
          Options$Mutation$StartService options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$StartService> watchMutation$StartService(
          WatchOptions$Mutation$StartService options) =>
      this.watchMutation(options);
}

class Mutation$StartService$startService
    implements Fragment$basicMutationReturnFields$$ServiceMutationReturn {
  Mutation$StartService$startService({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ServiceMutationReturn',
  });

  factory Mutation$StartService$startService.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$StartService$startService(
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
    if (!(other is Mutation$StartService$startService) ||
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

extension UtilityExtension$Mutation$StartService$startService
    on Mutation$StartService$startService {
  CopyWith$Mutation$StartService$startService<
          Mutation$StartService$startService>
      get copyWith => CopyWith$Mutation$StartService$startService(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$StartService$startService<TRes> {
  factory CopyWith$Mutation$StartService$startService(
    Mutation$StartService$startService instance,
    TRes Function(Mutation$StartService$startService) then,
  ) = _CopyWithImpl$Mutation$StartService$startService;

  factory CopyWith$Mutation$StartService$startService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StartService$startService;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$StartService$startService<TRes>
    implements CopyWith$Mutation$StartService$startService<TRes> {
  _CopyWithImpl$Mutation$StartService$startService(
    this._instance,
    this._then,
  );

  final Mutation$StartService$startService _instance;

  final TRes Function(Mutation$StartService$startService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$StartService$startService(
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

class _CopyWithStubImpl$Mutation$StartService$startService<TRes>
    implements CopyWith$Mutation$StartService$startService<TRes> {
  _CopyWithStubImpl$Mutation$StartService$startService(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$RestartService {
  factory Variables$Mutation$RestartService({required String serviceId}) =>
      Variables$Mutation$RestartService._({
        r'serviceId': serviceId,
      });

  Variables$Mutation$RestartService._(this._$data);

  factory Variables$Mutation$RestartService.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$serviceId = data['serviceId'];
    result$data['serviceId'] = (l$serviceId as String);
    return Variables$Mutation$RestartService._(result$data);
  }

  Map<String, dynamic> _$data;

  String get serviceId => (_$data['serviceId'] as String);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$serviceId = serviceId;
    result$data['serviceId'] = l$serviceId;
    return result$data;
  }

  CopyWith$Variables$Mutation$RestartService<Variables$Mutation$RestartService>
      get copyWith => CopyWith$Variables$Mutation$RestartService(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$RestartService) ||
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

abstract class CopyWith$Variables$Mutation$RestartService<TRes> {
  factory CopyWith$Variables$Mutation$RestartService(
    Variables$Mutation$RestartService instance,
    TRes Function(Variables$Mutation$RestartService) then,
  ) = _CopyWithImpl$Variables$Mutation$RestartService;

  factory CopyWith$Variables$Mutation$RestartService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$RestartService;

  TRes call({String? serviceId});
}

class _CopyWithImpl$Variables$Mutation$RestartService<TRes>
    implements CopyWith$Variables$Mutation$RestartService<TRes> {
  _CopyWithImpl$Variables$Mutation$RestartService(
    this._instance,
    this._then,
  );

  final Variables$Mutation$RestartService _instance;

  final TRes Function(Variables$Mutation$RestartService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? serviceId = _undefined}) =>
      _then(Variables$Mutation$RestartService._({
        ..._instance._$data,
        if (serviceId != _undefined && serviceId != null)
          'serviceId': (serviceId as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$RestartService<TRes>
    implements CopyWith$Variables$Mutation$RestartService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$RestartService(this._res);

  TRes _res;

  call({String? serviceId}) => _res;
}

class Mutation$RestartService {
  Mutation$RestartService({
    required this.restartService,
    this.$__typename = 'Mutation',
  });

  factory Mutation$RestartService.fromJson(Map<String, dynamic> json) {
    final l$restartService = json['restartService'];
    final l$$__typename = json['__typename'];
    return Mutation$RestartService(
      restartService: Mutation$RestartService$restartService.fromJson(
          (l$restartService as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$RestartService$restartService restartService;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$restartService = restartService;
    _resultData['restartService'] = l$restartService.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$restartService = restartService;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$restartService,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RestartService) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$restartService = restartService;
    final lOther$restartService = other.restartService;
    if (l$restartService != lOther$restartService) {
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

extension UtilityExtension$Mutation$RestartService on Mutation$RestartService {
  CopyWith$Mutation$RestartService<Mutation$RestartService> get copyWith =>
      CopyWith$Mutation$RestartService(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$RestartService<TRes> {
  factory CopyWith$Mutation$RestartService(
    Mutation$RestartService instance,
    TRes Function(Mutation$RestartService) then,
  ) = _CopyWithImpl$Mutation$RestartService;

  factory CopyWith$Mutation$RestartService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RestartService;

  TRes call({
    Mutation$RestartService$restartService? restartService,
    String? $__typename,
  });
  CopyWith$Mutation$RestartService$restartService<TRes> get restartService;
}

class _CopyWithImpl$Mutation$RestartService<TRes>
    implements CopyWith$Mutation$RestartService<TRes> {
  _CopyWithImpl$Mutation$RestartService(
    this._instance,
    this._then,
  );

  final Mutation$RestartService _instance;

  final TRes Function(Mutation$RestartService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? restartService = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$RestartService(
        restartService: restartService == _undefined || restartService == null
            ? _instance.restartService
            : (restartService as Mutation$RestartService$restartService),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$RestartService$restartService<TRes> get restartService {
    final local$restartService = _instance.restartService;
    return CopyWith$Mutation$RestartService$restartService(
        local$restartService, (e) => call(restartService: e));
  }
}

class _CopyWithStubImpl$Mutation$RestartService<TRes>
    implements CopyWith$Mutation$RestartService<TRes> {
  _CopyWithStubImpl$Mutation$RestartService(this._res);

  TRes _res;

  call({
    Mutation$RestartService$restartService? restartService,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$RestartService$restartService<TRes> get restartService =>
      CopyWith$Mutation$RestartService$restartService.stub(_res);
}

const documentNodeMutationRestartService = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'RestartService'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'serviceId')),
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
        name: NameNode(value: 'restartService'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'serviceId'),
            value: VariableNode(name: NameNode(value: 'serviceId')),
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
Mutation$RestartService _parserFn$Mutation$RestartService(
        Map<String, dynamic> data) =>
    Mutation$RestartService.fromJson(data);
typedef OnMutationCompleted$Mutation$RestartService = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$RestartService?,
);

class Options$Mutation$RestartService
    extends graphql.MutationOptions<Mutation$RestartService> {
  Options$Mutation$RestartService({
    String? operationName,
    required Variables$Mutation$RestartService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RestartService? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$RestartService? onCompleted,
    graphql.OnMutationUpdate<Mutation$RestartService>? update,
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
                        : _parserFn$Mutation$RestartService(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationRestartService,
          parserFn: _parserFn$Mutation$RestartService,
        );

  final OnMutationCompleted$Mutation$RestartService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$RestartService
    extends graphql.WatchQueryOptions<Mutation$RestartService> {
  WatchOptions$Mutation$RestartService({
    String? operationName,
    required Variables$Mutation$RestartService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RestartService? typedOptimisticResult,
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
          document: documentNodeMutationRestartService,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$RestartService,
        );
}

extension ClientExtension$Mutation$RestartService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RestartService>> mutate$RestartService(
          Options$Mutation$RestartService options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$RestartService> watchMutation$RestartService(
          WatchOptions$Mutation$RestartService options) =>
      this.watchMutation(options);
}

class Mutation$RestartService$restartService
    implements Fragment$basicMutationReturnFields$$ServiceMutationReturn {
  Mutation$RestartService$restartService({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ServiceMutationReturn',
  });

  factory Mutation$RestartService$restartService.fromJson(
      Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$RestartService$restartService(
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
    if (!(other is Mutation$RestartService$restartService) ||
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

extension UtilityExtension$Mutation$RestartService$restartService
    on Mutation$RestartService$restartService {
  CopyWith$Mutation$RestartService$restartService<
          Mutation$RestartService$restartService>
      get copyWith => CopyWith$Mutation$RestartService$restartService(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$RestartService$restartService<TRes> {
  factory CopyWith$Mutation$RestartService$restartService(
    Mutation$RestartService$restartService instance,
    TRes Function(Mutation$RestartService$restartService) then,
  ) = _CopyWithImpl$Mutation$RestartService$restartService;

  factory CopyWith$Mutation$RestartService$restartService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RestartService$restartService;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$RestartService$restartService<TRes>
    implements CopyWith$Mutation$RestartService$restartService<TRes> {
  _CopyWithImpl$Mutation$RestartService$restartService(
    this._instance,
    this._then,
  );

  final Mutation$RestartService$restartService _instance;

  final TRes Function(Mutation$RestartService$restartService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$RestartService$restartService(
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

class _CopyWithStubImpl$Mutation$RestartService$restartService<TRes>
    implements CopyWith$Mutation$RestartService$restartService<TRes> {
  _CopyWithStubImpl$Mutation$RestartService$restartService(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$MoveService {
  factory Variables$Mutation$MoveService(
          {required Input$MoveServiceInput input}) =>
      Variables$Mutation$MoveService._({
        r'input': input,
      });

  Variables$Mutation$MoveService._(this._$data);

  factory Variables$Mutation$MoveService.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] =
        Input$MoveServiceInput.fromJson((l$input as Map<String, dynamic>));
    return Variables$Mutation$MoveService._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$MoveServiceInput get input =>
      (_$data['input'] as Input$MoveServiceInput);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$MoveService<Variables$Mutation$MoveService>
      get copyWith => CopyWith$Variables$Mutation$MoveService(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$MoveService) ||
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

abstract class CopyWith$Variables$Mutation$MoveService<TRes> {
  factory CopyWith$Variables$Mutation$MoveService(
    Variables$Mutation$MoveService instance,
    TRes Function(Variables$Mutation$MoveService) then,
  ) = _CopyWithImpl$Variables$Mutation$MoveService;

  factory CopyWith$Variables$Mutation$MoveService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$MoveService;

  TRes call({Input$MoveServiceInput? input});
}

class _CopyWithImpl$Variables$Mutation$MoveService<TRes>
    implements CopyWith$Variables$Mutation$MoveService<TRes> {
  _CopyWithImpl$Variables$Mutation$MoveService(
    this._instance,
    this._then,
  );

  final Variables$Mutation$MoveService _instance;

  final TRes Function(Variables$Mutation$MoveService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$MoveService._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$MoveServiceInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$MoveService<TRes>
    implements CopyWith$Variables$Mutation$MoveService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$MoveService(this._res);

  TRes _res;

  call({Input$MoveServiceInput? input}) => _res;
}

class Mutation$MoveService {
  Mutation$MoveService({
    required this.moveService,
    this.$__typename = 'Mutation',
  });

  factory Mutation$MoveService.fromJson(Map<String, dynamic> json) {
    final l$moveService = json['moveService'];
    final l$$__typename = json['__typename'];
    return Mutation$MoveService(
      moveService: Mutation$MoveService$moveService.fromJson(
          (l$moveService as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$MoveService$moveService moveService;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$moveService = moveService;
    _resultData['moveService'] = l$moveService.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$moveService = moveService;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$moveService,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$MoveService) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$moveService = moveService;
    final lOther$moveService = other.moveService;
    if (l$moveService != lOther$moveService) {
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

extension UtilityExtension$Mutation$MoveService on Mutation$MoveService {
  CopyWith$Mutation$MoveService<Mutation$MoveService> get copyWith =>
      CopyWith$Mutation$MoveService(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$MoveService<TRes> {
  factory CopyWith$Mutation$MoveService(
    Mutation$MoveService instance,
    TRes Function(Mutation$MoveService) then,
  ) = _CopyWithImpl$Mutation$MoveService;

  factory CopyWith$Mutation$MoveService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MoveService;

  TRes call({
    Mutation$MoveService$moveService? moveService,
    String? $__typename,
  });
  CopyWith$Mutation$MoveService$moveService<TRes> get moveService;
}

class _CopyWithImpl$Mutation$MoveService<TRes>
    implements CopyWith$Mutation$MoveService<TRes> {
  _CopyWithImpl$Mutation$MoveService(
    this._instance,
    this._then,
  );

  final Mutation$MoveService _instance;

  final TRes Function(Mutation$MoveService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? moveService = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$MoveService(
        moveService: moveService == _undefined || moveService == null
            ? _instance.moveService
            : (moveService as Mutation$MoveService$moveService),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$MoveService$moveService<TRes> get moveService {
    final local$moveService = _instance.moveService;
    return CopyWith$Mutation$MoveService$moveService(
        local$moveService, (e) => call(moveService: e));
  }
}

class _CopyWithStubImpl$Mutation$MoveService<TRes>
    implements CopyWith$Mutation$MoveService<TRes> {
  _CopyWithStubImpl$Mutation$MoveService(this._res);

  TRes _res;

  call({
    Mutation$MoveService$moveService? moveService,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$MoveService$moveService<TRes> get moveService =>
      CopyWith$Mutation$MoveService$moveService.stub(_res);
}

const documentNodeMutationMoveService = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'MoveService'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'MoveServiceInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'moveService'),
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
            name: NameNode(value: 'job'),
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
  fragmentDefinitionbasicMutationReturnFields,
  fragmentDefinitionbasicApiJobsFields,
]);
Mutation$MoveService _parserFn$Mutation$MoveService(
        Map<String, dynamic> data) =>
    Mutation$MoveService.fromJson(data);
typedef OnMutationCompleted$Mutation$MoveService = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$MoveService?,
);

class Options$Mutation$MoveService
    extends graphql.MutationOptions<Mutation$MoveService> {
  Options$Mutation$MoveService({
    String? operationName,
    required Variables$Mutation$MoveService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$MoveService? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$MoveService? onCompleted,
    graphql.OnMutationUpdate<Mutation$MoveService>? update,
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
                    data == null ? null : _parserFn$Mutation$MoveService(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationMoveService,
          parserFn: _parserFn$Mutation$MoveService,
        );

  final OnMutationCompleted$Mutation$MoveService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$MoveService
    extends graphql.WatchQueryOptions<Mutation$MoveService> {
  WatchOptions$Mutation$MoveService({
    String? operationName,
    required Variables$Mutation$MoveService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$MoveService? typedOptimisticResult,
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
          document: documentNodeMutationMoveService,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$MoveService,
        );
}

extension ClientExtension$Mutation$MoveService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$MoveService>> mutate$MoveService(
          Options$Mutation$MoveService options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$MoveService> watchMutation$MoveService(
          WatchOptions$Mutation$MoveService options) =>
      this.watchMutation(options);
}

class Mutation$MoveService$moveService
    implements Fragment$basicMutationReturnFields$$ServiceJobMutationReturn {
  Mutation$MoveService$moveService({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ServiceJobMutationReturn',
    this.job,
  });

  factory Mutation$MoveService$moveService.fromJson(Map<String, dynamic> json) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$job = json['job'];
    return Mutation$MoveService$moveService(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      job: l$job == null
          ? null
          : Fragment$basicApiJobsFields.fromJson(
              (l$job as Map<String, dynamic>)),
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
    return Object.hashAll([
      l$code,
      l$message,
      l$success,
      l$$__typename,
      l$job,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$MoveService$moveService) ||
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

extension UtilityExtension$Mutation$MoveService$moveService
    on Mutation$MoveService$moveService {
  CopyWith$Mutation$MoveService$moveService<Mutation$MoveService$moveService>
      get copyWith => CopyWith$Mutation$MoveService$moveService(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$MoveService$moveService<TRes> {
  factory CopyWith$Mutation$MoveService$moveService(
    Mutation$MoveService$moveService instance,
    TRes Function(Mutation$MoveService$moveService) then,
  ) = _CopyWithImpl$Mutation$MoveService$moveService;

  factory CopyWith$Mutation$MoveService$moveService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MoveService$moveService;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$basicApiJobsFields? job,
  });
  CopyWith$Fragment$basicApiJobsFields<TRes> get job;
}

class _CopyWithImpl$Mutation$MoveService$moveService<TRes>
    implements CopyWith$Mutation$MoveService$moveService<TRes> {
  _CopyWithImpl$Mutation$MoveService$moveService(
    this._instance,
    this._then,
  );

  final Mutation$MoveService$moveService _instance;

  final TRes Function(Mutation$MoveService$moveService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? job = _undefined,
  }) =>
      _then(Mutation$MoveService$moveService(
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
        job: job == _undefined
            ? _instance.job
            : (job as Fragment$basicApiJobsFields?),
      ));
  CopyWith$Fragment$basicApiJobsFields<TRes> get job {
    final local$job = _instance.job;
    return local$job == null
        ? CopyWith$Fragment$basicApiJobsFields.stub(_then(_instance))
        : CopyWith$Fragment$basicApiJobsFields(local$job, (e) => call(job: e));
  }
}

class _CopyWithStubImpl$Mutation$MoveService$moveService<TRes>
    implements CopyWith$Mutation$MoveService$moveService<TRes> {
  _CopyWithStubImpl$Mutation$MoveService$moveService(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$basicApiJobsFields? job,
  }) =>
      _res;
  CopyWith$Fragment$basicApiJobsFields<TRes> get job =>
      CopyWith$Fragment$basicApiJobsFields.stub(_res);
}
