import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/utils/scalars.dart';
part 'schema.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Input$AutoUpgradeSettingsInput {
  Input$AutoUpgradeSettingsInput({this.enableAutoUpgrade, this.allowReboot});

  @override
  factory Input$AutoUpgradeSettingsInput.fromJson(Map<String, dynamic> json) =>
      _$Input$AutoUpgradeSettingsInputFromJson(json);

  final bool? enableAutoUpgrade;

  final bool? allowReboot;

  Map<String, dynamic> toJson() => _$Input$AutoUpgradeSettingsInputToJson(this);
  int get hashCode {
    final l$enableAutoUpgrade = enableAutoUpgrade;
    final l$allowReboot = allowReboot;
    return Object.hashAll([l$enableAutoUpgrade, l$allowReboot]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Input$AutoUpgradeSettingsInput) ||
        runtimeType != other.runtimeType) return false;
    final l$enableAutoUpgrade = enableAutoUpgrade;
    final lOther$enableAutoUpgrade = other.enableAutoUpgrade;
    if (l$enableAutoUpgrade != lOther$enableAutoUpgrade) return false;
    final l$allowReboot = allowReboot;
    final lOther$allowReboot = other.allowReboot;
    if (l$allowReboot != lOther$allowReboot) return false;
    return true;
  }

  CopyWith$Input$AutoUpgradeSettingsInput<Input$AutoUpgradeSettingsInput>
      get copyWith => CopyWith$Input$AutoUpgradeSettingsInput(this, (i) => i);
}

abstract class CopyWith$Input$AutoUpgradeSettingsInput<TRes> {
  factory CopyWith$Input$AutoUpgradeSettingsInput(
          Input$AutoUpgradeSettingsInput instance,
          TRes Function(Input$AutoUpgradeSettingsInput) then) =
      _CopyWithImpl$Input$AutoUpgradeSettingsInput;

  factory CopyWith$Input$AutoUpgradeSettingsInput.stub(TRes res) =
      _CopyWithStubImpl$Input$AutoUpgradeSettingsInput;

  TRes call({bool? enableAutoUpgrade, bool? allowReboot});
}

class _CopyWithImpl$Input$AutoUpgradeSettingsInput<TRes>
    implements CopyWith$Input$AutoUpgradeSettingsInput<TRes> {
  _CopyWithImpl$Input$AutoUpgradeSettingsInput(this._instance, this._then);

  final Input$AutoUpgradeSettingsInput _instance;

  final TRes Function(Input$AutoUpgradeSettingsInput) _then;

  static const _undefined = {};

  TRes call(
          {Object? enableAutoUpgrade = _undefined,
          Object? allowReboot = _undefined}) =>
      _then(Input$AutoUpgradeSettingsInput(
          enableAutoUpgrade: enableAutoUpgrade == _undefined
              ? _instance.enableAutoUpgrade
              : (enableAutoUpgrade as bool?),
          allowReboot: allowReboot == _undefined
              ? _instance.allowReboot
              : (allowReboot as bool?)));
}

class _CopyWithStubImpl$Input$AutoUpgradeSettingsInput<TRes>
    implements CopyWith$Input$AutoUpgradeSettingsInput<TRes> {
  _CopyWithStubImpl$Input$AutoUpgradeSettingsInput(this._res);

  TRes _res;

  call({bool? enableAutoUpgrade, bool? allowReboot}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Input$MigrateToBindsInput {
  Input$MigrateToBindsInput(
      {required this.emailBlockDevice,
      required this.bitwardenBlockDevice,
      required this.giteaBlockDevice,
      required this.nextcloudBlockDevice,
      required this.pleromaBlockDevice});

  @override
  factory Input$MigrateToBindsInput.fromJson(Map<String, dynamic> json) =>
      _$Input$MigrateToBindsInputFromJson(json);

  final String emailBlockDevice;

  final String bitwardenBlockDevice;

  final String giteaBlockDevice;

  final String nextcloudBlockDevice;

  final String pleromaBlockDevice;

  Map<String, dynamic> toJson() => _$Input$MigrateToBindsInputToJson(this);
  int get hashCode {
    final l$emailBlockDevice = emailBlockDevice;
    final l$bitwardenBlockDevice = bitwardenBlockDevice;
    final l$giteaBlockDevice = giteaBlockDevice;
    final l$nextcloudBlockDevice = nextcloudBlockDevice;
    final l$pleromaBlockDevice = pleromaBlockDevice;
    return Object.hashAll([
      l$emailBlockDevice,
      l$bitwardenBlockDevice,
      l$giteaBlockDevice,
      l$nextcloudBlockDevice,
      l$pleromaBlockDevice
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Input$MigrateToBindsInput) ||
        runtimeType != other.runtimeType) return false;
    final l$emailBlockDevice = emailBlockDevice;
    final lOther$emailBlockDevice = other.emailBlockDevice;
    if (l$emailBlockDevice != lOther$emailBlockDevice) return false;
    final l$bitwardenBlockDevice = bitwardenBlockDevice;
    final lOther$bitwardenBlockDevice = other.bitwardenBlockDevice;
    if (l$bitwardenBlockDevice != lOther$bitwardenBlockDevice) return false;
    final l$giteaBlockDevice = giteaBlockDevice;
    final lOther$giteaBlockDevice = other.giteaBlockDevice;
    if (l$giteaBlockDevice != lOther$giteaBlockDevice) return false;
    final l$nextcloudBlockDevice = nextcloudBlockDevice;
    final lOther$nextcloudBlockDevice = other.nextcloudBlockDevice;
    if (l$nextcloudBlockDevice != lOther$nextcloudBlockDevice) return false;
    final l$pleromaBlockDevice = pleromaBlockDevice;
    final lOther$pleromaBlockDevice = other.pleromaBlockDevice;
    if (l$pleromaBlockDevice != lOther$pleromaBlockDevice) return false;
    return true;
  }

  CopyWith$Input$MigrateToBindsInput<Input$MigrateToBindsInput> get copyWith =>
      CopyWith$Input$MigrateToBindsInput(this, (i) => i);
}

abstract class CopyWith$Input$MigrateToBindsInput<TRes> {
  factory CopyWith$Input$MigrateToBindsInput(Input$MigrateToBindsInput instance,
          TRes Function(Input$MigrateToBindsInput) then) =
      _CopyWithImpl$Input$MigrateToBindsInput;

  factory CopyWith$Input$MigrateToBindsInput.stub(TRes res) =
      _CopyWithStubImpl$Input$MigrateToBindsInput;

  TRes call(
      {String? emailBlockDevice,
      String? bitwardenBlockDevice,
      String? giteaBlockDevice,
      String? nextcloudBlockDevice,
      String? pleromaBlockDevice});
}

class _CopyWithImpl$Input$MigrateToBindsInput<TRes>
    implements CopyWith$Input$MigrateToBindsInput<TRes> {
  _CopyWithImpl$Input$MigrateToBindsInput(this._instance, this._then);

  final Input$MigrateToBindsInput _instance;

  final TRes Function(Input$MigrateToBindsInput) _then;

  static const _undefined = {};

  TRes call(
          {Object? emailBlockDevice = _undefined,
          Object? bitwardenBlockDevice = _undefined,
          Object? giteaBlockDevice = _undefined,
          Object? nextcloudBlockDevice = _undefined,
          Object? pleromaBlockDevice = _undefined}) =>
      _then(Input$MigrateToBindsInput(
          emailBlockDevice:
              emailBlockDevice == _undefined || emailBlockDevice == null
                  ? _instance.emailBlockDevice
                  : (emailBlockDevice as String),
          bitwardenBlockDevice:
              bitwardenBlockDevice == _undefined || bitwardenBlockDevice == null
                  ? _instance.bitwardenBlockDevice
                  : (bitwardenBlockDevice as String),
          giteaBlockDevice:
              giteaBlockDevice == _undefined || giteaBlockDevice == null
                  ? _instance.giteaBlockDevice
                  : (giteaBlockDevice as String),
          nextcloudBlockDevice:
              nextcloudBlockDevice == _undefined || nextcloudBlockDevice == null
                  ? _instance.nextcloudBlockDevice
                  : (nextcloudBlockDevice as String),
          pleromaBlockDevice:
              pleromaBlockDevice == _undefined || pleromaBlockDevice == null
                  ? _instance.pleromaBlockDevice
                  : (pleromaBlockDevice as String)));
}

class _CopyWithStubImpl$Input$MigrateToBindsInput<TRes>
    implements CopyWith$Input$MigrateToBindsInput<TRes> {
  _CopyWithStubImpl$Input$MigrateToBindsInput(this._res);

  TRes _res;

  call(
          {String? emailBlockDevice,
          String? bitwardenBlockDevice,
          String? giteaBlockDevice,
          String? nextcloudBlockDevice,
          String? pleromaBlockDevice}) =>
      _res;
}

@JsonSerializable(explicitToJson: true)
class Input$MoveServiceInput {
  Input$MoveServiceInput({required this.serviceId, required this.location});

  @override
  factory Input$MoveServiceInput.fromJson(Map<String, dynamic> json) =>
      _$Input$MoveServiceInputFromJson(json);

  final String serviceId;

  final String location;

  Map<String, dynamic> toJson() => _$Input$MoveServiceInputToJson(this);
  int get hashCode {
    final l$serviceId = serviceId;
    final l$location = location;
    return Object.hashAll([l$serviceId, l$location]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Input$MoveServiceInput) || runtimeType != other.runtimeType)
      return false;
    final l$serviceId = serviceId;
    final lOther$serviceId = other.serviceId;
    if (l$serviceId != lOther$serviceId) return false;
    final l$location = location;
    final lOther$location = other.location;
    if (l$location != lOther$location) return false;
    return true;
  }

  CopyWith$Input$MoveServiceInput<Input$MoveServiceInput> get copyWith =>
      CopyWith$Input$MoveServiceInput(this, (i) => i);
}

abstract class CopyWith$Input$MoveServiceInput<TRes> {
  factory CopyWith$Input$MoveServiceInput(Input$MoveServiceInput instance,
          TRes Function(Input$MoveServiceInput) then) =
      _CopyWithImpl$Input$MoveServiceInput;

  factory CopyWith$Input$MoveServiceInput.stub(TRes res) =
      _CopyWithStubImpl$Input$MoveServiceInput;

  TRes call({String? serviceId, String? location});
}

class _CopyWithImpl$Input$MoveServiceInput<TRes>
    implements CopyWith$Input$MoveServiceInput<TRes> {
  _CopyWithImpl$Input$MoveServiceInput(this._instance, this._then);

  final Input$MoveServiceInput _instance;

  final TRes Function(Input$MoveServiceInput) _then;

  static const _undefined = {};

  TRes call({Object? serviceId = _undefined, Object? location = _undefined}) =>
      _then(Input$MoveServiceInput(
          serviceId: serviceId == _undefined || serviceId == null
              ? _instance.serviceId
              : (serviceId as String),
          location: location == _undefined || location == null
              ? _instance.location
              : (location as String)));
}

class _CopyWithStubImpl$Input$MoveServiceInput<TRes>
    implements CopyWith$Input$MoveServiceInput<TRes> {
  _CopyWithStubImpl$Input$MoveServiceInput(this._res);

  TRes _res;

  call({String? serviceId, String? location}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Input$RecoveryKeyLimitsInput {
  Input$RecoveryKeyLimitsInput({this.expirationDate, this.uses});

  @override
  factory Input$RecoveryKeyLimitsInput.fromJson(Map<String, dynamic> json) =>
      _$Input$RecoveryKeyLimitsInputFromJson(json);

  @JsonKey(
      fromJson: _nullable$dateTimeFromJson, toJson: _nullable$dateTimeToJson)
  final DateTime? expirationDate;

  final int? uses;

  Map<String, dynamic> toJson() => _$Input$RecoveryKeyLimitsInputToJson(this);
  int get hashCode {
    final l$expirationDate = expirationDate;
    final l$uses = uses;
    return Object.hashAll([l$expirationDate, l$uses]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Input$RecoveryKeyLimitsInput) ||
        runtimeType != other.runtimeType) return false;
    final l$expirationDate = expirationDate;
    final lOther$expirationDate = other.expirationDate;
    if (l$expirationDate != lOther$expirationDate) return false;
    final l$uses = uses;
    final lOther$uses = other.uses;
    if (l$uses != lOther$uses) return false;
    return true;
  }

  CopyWith$Input$RecoveryKeyLimitsInput<Input$RecoveryKeyLimitsInput>
      get copyWith => CopyWith$Input$RecoveryKeyLimitsInput(this, (i) => i);
}

abstract class CopyWith$Input$RecoveryKeyLimitsInput<TRes> {
  factory CopyWith$Input$RecoveryKeyLimitsInput(
          Input$RecoveryKeyLimitsInput instance,
          TRes Function(Input$RecoveryKeyLimitsInput) then) =
      _CopyWithImpl$Input$RecoveryKeyLimitsInput;

  factory CopyWith$Input$RecoveryKeyLimitsInput.stub(TRes res) =
      _CopyWithStubImpl$Input$RecoveryKeyLimitsInput;

  TRes call({DateTime? expirationDate, int? uses});
}

class _CopyWithImpl$Input$RecoveryKeyLimitsInput<TRes>
    implements CopyWith$Input$RecoveryKeyLimitsInput<TRes> {
  _CopyWithImpl$Input$RecoveryKeyLimitsInput(this._instance, this._then);

  final Input$RecoveryKeyLimitsInput _instance;

  final TRes Function(Input$RecoveryKeyLimitsInput) _then;

  static const _undefined = {};

  TRes call({Object? expirationDate = _undefined, Object? uses = _undefined}) =>
      _then(Input$RecoveryKeyLimitsInput(
          expirationDate: expirationDate == _undefined
              ? _instance.expirationDate
              : (expirationDate as DateTime?),
          uses: uses == _undefined ? _instance.uses : (uses as int?)));
}

class _CopyWithStubImpl$Input$RecoveryKeyLimitsInput<TRes>
    implements CopyWith$Input$RecoveryKeyLimitsInput<TRes> {
  _CopyWithStubImpl$Input$RecoveryKeyLimitsInput(this._res);

  TRes _res;

  call({DateTime? expirationDate, int? uses}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Input$SshMutationInput {
  Input$SshMutationInput({required this.username, required this.sshKey});

  @override
  factory Input$SshMutationInput.fromJson(Map<String, dynamic> json) =>
      _$Input$SshMutationInputFromJson(json);

  final String username;

  final String sshKey;

  Map<String, dynamic> toJson() => _$Input$SshMutationInputToJson(this);
  int get hashCode {
    final l$username = username;
    final l$sshKey = sshKey;
    return Object.hashAll([l$username, l$sshKey]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Input$SshMutationInput) || runtimeType != other.runtimeType)
      return false;
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) return false;
    final l$sshKey = sshKey;
    final lOther$sshKey = other.sshKey;
    if (l$sshKey != lOther$sshKey) return false;
    return true;
  }

  CopyWith$Input$SshMutationInput<Input$SshMutationInput> get copyWith =>
      CopyWith$Input$SshMutationInput(this, (i) => i);
}

abstract class CopyWith$Input$SshMutationInput<TRes> {
  factory CopyWith$Input$SshMutationInput(Input$SshMutationInput instance,
          TRes Function(Input$SshMutationInput) then) =
      _CopyWithImpl$Input$SshMutationInput;

  factory CopyWith$Input$SshMutationInput.stub(TRes res) =
      _CopyWithStubImpl$Input$SshMutationInput;

  TRes call({String? username, String? sshKey});
}

class _CopyWithImpl$Input$SshMutationInput<TRes>
    implements CopyWith$Input$SshMutationInput<TRes> {
  _CopyWithImpl$Input$SshMutationInput(this._instance, this._then);

  final Input$SshMutationInput _instance;

  final TRes Function(Input$SshMutationInput) _then;

  static const _undefined = {};

  TRes call({Object? username = _undefined, Object? sshKey = _undefined}) =>
      _then(Input$SshMutationInput(
          username: username == _undefined || username == null
              ? _instance.username
              : (username as String),
          sshKey: sshKey == _undefined || sshKey == null
              ? _instance.sshKey
              : (sshKey as String)));
}

class _CopyWithStubImpl$Input$SshMutationInput<TRes>
    implements CopyWith$Input$SshMutationInput<TRes> {
  _CopyWithStubImpl$Input$SshMutationInput(this._res);

  TRes _res;

  call({String? username, String? sshKey}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Input$UseNewDeviceKeyInput {
  Input$UseNewDeviceKeyInput({required this.key, required this.deviceName});

  @override
  factory Input$UseNewDeviceKeyInput.fromJson(Map<String, dynamic> json) =>
      _$Input$UseNewDeviceKeyInputFromJson(json);

  final String key;

  final String deviceName;

  Map<String, dynamic> toJson() => _$Input$UseNewDeviceKeyInputToJson(this);
  int get hashCode {
    final l$key = key;
    final l$deviceName = deviceName;
    return Object.hashAll([l$key, l$deviceName]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Input$UseNewDeviceKeyInput) ||
        runtimeType != other.runtimeType) return false;
    final l$key = key;
    final lOther$key = other.key;
    if (l$key != lOther$key) return false;
    final l$deviceName = deviceName;
    final lOther$deviceName = other.deviceName;
    if (l$deviceName != lOther$deviceName) return false;
    return true;
  }

  CopyWith$Input$UseNewDeviceKeyInput<Input$UseNewDeviceKeyInput>
      get copyWith => CopyWith$Input$UseNewDeviceKeyInput(this, (i) => i);
}

abstract class CopyWith$Input$UseNewDeviceKeyInput<TRes> {
  factory CopyWith$Input$UseNewDeviceKeyInput(
          Input$UseNewDeviceKeyInput instance,
          TRes Function(Input$UseNewDeviceKeyInput) then) =
      _CopyWithImpl$Input$UseNewDeviceKeyInput;

  factory CopyWith$Input$UseNewDeviceKeyInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UseNewDeviceKeyInput;

  TRes call({String? key, String? deviceName});
}

class _CopyWithImpl$Input$UseNewDeviceKeyInput<TRes>
    implements CopyWith$Input$UseNewDeviceKeyInput<TRes> {
  _CopyWithImpl$Input$UseNewDeviceKeyInput(this._instance, this._then);

  final Input$UseNewDeviceKeyInput _instance;

  final TRes Function(Input$UseNewDeviceKeyInput) _then;

  static const _undefined = {};

  TRes call({Object? key = _undefined, Object? deviceName = _undefined}) =>
      _then(Input$UseNewDeviceKeyInput(
          key: key == _undefined || key == null
              ? _instance.key
              : (key as String),
          deviceName: deviceName == _undefined || deviceName == null
              ? _instance.deviceName
              : (deviceName as String)));
}

class _CopyWithStubImpl$Input$UseNewDeviceKeyInput<TRes>
    implements CopyWith$Input$UseNewDeviceKeyInput<TRes> {
  _CopyWithStubImpl$Input$UseNewDeviceKeyInput(this._res);

  TRes _res;

  call({String? key, String? deviceName}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Input$UseRecoveryKeyInput {
  Input$UseRecoveryKeyInput({required this.key, required this.deviceName});

  @override
  factory Input$UseRecoveryKeyInput.fromJson(Map<String, dynamic> json) =>
      _$Input$UseRecoveryKeyInputFromJson(json);

  final String key;

  final String deviceName;

  Map<String, dynamic> toJson() => _$Input$UseRecoveryKeyInputToJson(this);
  int get hashCode {
    final l$key = key;
    final l$deviceName = deviceName;
    return Object.hashAll([l$key, l$deviceName]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Input$UseRecoveryKeyInput) ||
        runtimeType != other.runtimeType) return false;
    final l$key = key;
    final lOther$key = other.key;
    if (l$key != lOther$key) return false;
    final l$deviceName = deviceName;
    final lOther$deviceName = other.deviceName;
    if (l$deviceName != lOther$deviceName) return false;
    return true;
  }

  CopyWith$Input$UseRecoveryKeyInput<Input$UseRecoveryKeyInput> get copyWith =>
      CopyWith$Input$UseRecoveryKeyInput(this, (i) => i);
}

abstract class CopyWith$Input$UseRecoveryKeyInput<TRes> {
  factory CopyWith$Input$UseRecoveryKeyInput(Input$UseRecoveryKeyInput instance,
          TRes Function(Input$UseRecoveryKeyInput) then) =
      _CopyWithImpl$Input$UseRecoveryKeyInput;

  factory CopyWith$Input$UseRecoveryKeyInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UseRecoveryKeyInput;

  TRes call({String? key, String? deviceName});
}

class _CopyWithImpl$Input$UseRecoveryKeyInput<TRes>
    implements CopyWith$Input$UseRecoveryKeyInput<TRes> {
  _CopyWithImpl$Input$UseRecoveryKeyInput(this._instance, this._then);

  final Input$UseRecoveryKeyInput _instance;

  final TRes Function(Input$UseRecoveryKeyInput) _then;

  static const _undefined = {};

  TRes call({Object? key = _undefined, Object? deviceName = _undefined}) =>
      _then(Input$UseRecoveryKeyInput(
          key: key == _undefined || key == null
              ? _instance.key
              : (key as String),
          deviceName: deviceName == _undefined || deviceName == null
              ? _instance.deviceName
              : (deviceName as String)));
}

class _CopyWithStubImpl$Input$UseRecoveryKeyInput<TRes>
    implements CopyWith$Input$UseRecoveryKeyInput<TRes> {
  _CopyWithStubImpl$Input$UseRecoveryKeyInput(this._res);

  TRes _res;

  call({String? key, String? deviceName}) => _res;
}

@JsonSerializable(explicitToJson: true)
class Input$UserMutationInput {
  Input$UserMutationInput({required this.username, required this.password});

  @override
  factory Input$UserMutationInput.fromJson(Map<String, dynamic> json) =>
      _$Input$UserMutationInputFromJson(json);

  final String username;

  final String password;

  Map<String, dynamic> toJson() => _$Input$UserMutationInputToJson(this);
  int get hashCode {
    final l$username = username;
    final l$password = password;
    return Object.hashAll([l$username, l$password]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Input$UserMutationInput) || runtimeType != other.runtimeType)
      return false;
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) return false;
    final l$password = password;
    final lOther$password = other.password;
    if (l$password != lOther$password) return false;
    return true;
  }

  CopyWith$Input$UserMutationInput<Input$UserMutationInput> get copyWith =>
      CopyWith$Input$UserMutationInput(this, (i) => i);
}

abstract class CopyWith$Input$UserMutationInput<TRes> {
  factory CopyWith$Input$UserMutationInput(Input$UserMutationInput instance,
          TRes Function(Input$UserMutationInput) then) =
      _CopyWithImpl$Input$UserMutationInput;

  factory CopyWith$Input$UserMutationInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UserMutationInput;

  TRes call({String? username, String? password});
}

class _CopyWithImpl$Input$UserMutationInput<TRes>
    implements CopyWith$Input$UserMutationInput<TRes> {
  _CopyWithImpl$Input$UserMutationInput(this._instance, this._then);

  final Input$UserMutationInput _instance;

  final TRes Function(Input$UserMutationInput) _then;

  static const _undefined = {};

  TRes call({Object? username = _undefined, Object? password = _undefined}) =>
      _then(Input$UserMutationInput(
          username: username == _undefined || username == null
              ? _instance.username
              : (username as String),
          password: password == _undefined || password == null
              ? _instance.password
              : (password as String)));
}

class _CopyWithStubImpl$Input$UserMutationInput<TRes>
    implements CopyWith$Input$UserMutationInput<TRes> {
  _CopyWithStubImpl$Input$UserMutationInput(this._res);

  TRes _res;

  call({String? username, String? password}) => _res;
}

enum Enum$DnsProvider {
  @JsonValue('CLOUDFLARE')
  CLOUDFLARE,
  $unknown
}

enum Enum$ServerProvider {
  @JsonValue('HETZNER')
  HETZNER,
  $unknown
}

enum Enum$ServiceStatusEnum {
  @JsonValue('ACTIVATING')
  ACTIVATING,
  @JsonValue('ACTIVE')
  ACTIVE,
  @JsonValue('DEACTIVATING')
  DEACTIVATING,
  @JsonValue('FAILED')
  FAILED,
  @JsonValue('INACTIVE')
  INACTIVE,
  @JsonValue('OFF')
  OFF,
  @JsonValue('RELOADING')
  RELOADING,
  $unknown
}

enum Enum$Severity {
  @JsonValue('CRITICAL')
  CRITICAL,
  @JsonValue('ERROR')
  ERROR,
  @JsonValue('INFO')
  INFO,
  @JsonValue('SUCCESS')
  SUCCESS,
  @JsonValue('WARNING')
  WARNING,
  $unknown
}

enum Enum$UserType {
  @JsonValue('NORMAL')
  NORMAL,
  @JsonValue('PRIMARY')
  PRIMARY,
  @JsonValue('ROOT')
  ROOT,
  $unknown
}

@JsonSerializable(explicitToJson: true)
class Fragment$dnsRecordFields {
  Fragment$dnsRecordFields(
      {required this.content,
      required this.name,
      this.priority,
      required this.recordType,
      required this.ttl,
      required this.$__typename});

  @override
  factory Fragment$dnsRecordFields.fromJson(Map<String, dynamic> json) =>
      _$Fragment$dnsRecordFieldsFromJson(json);

  final String content;

  final String name;

  final int? priority;

  final String recordType;

  final int ttl;

  @JsonKey(name: '__typename')
  final String $__typename;

  Map<String, dynamic> toJson() => _$Fragment$dnsRecordFieldsToJson(this);
  int get hashCode {
    final l$content = content;
    final l$name = name;
    final l$priority = priority;
    final l$recordType = recordType;
    final l$ttl = ttl;
    final l$$__typename = $__typename;
    return Object.hashAll(
        [l$content, l$name, l$priority, l$recordType, l$ttl, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!(other is Fragment$dnsRecordFields) ||
        runtimeType != other.runtimeType) return false;
    final l$content = content;
    final lOther$content = other.content;
    if (l$content != lOther$content) return false;
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) return false;
    final l$priority = priority;
    final lOther$priority = other.priority;
    if (l$priority != lOther$priority) return false;
    final l$recordType = recordType;
    final lOther$recordType = other.recordType;
    if (l$recordType != lOther$recordType) return false;
    final l$ttl = ttl;
    final lOther$ttl = other.ttl;
    if (l$ttl != lOther$ttl) return false;
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) return false;
    return true;
  }
}

extension UtilityExtension$Fragment$dnsRecordFields
    on Fragment$dnsRecordFields {
  CopyWith$Fragment$dnsRecordFields<Fragment$dnsRecordFields> get copyWith =>
      CopyWith$Fragment$dnsRecordFields(this, (i) => i);
}

abstract class CopyWith$Fragment$dnsRecordFields<TRes> {
  factory CopyWith$Fragment$dnsRecordFields(Fragment$dnsRecordFields instance,
          TRes Function(Fragment$dnsRecordFields) then) =
      _CopyWithImpl$Fragment$dnsRecordFields;

  factory CopyWith$Fragment$dnsRecordFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$dnsRecordFields;

  TRes call(
      {String? content,
      String? name,
      int? priority,
      String? recordType,
      int? ttl,
      String? $__typename});
}

class _CopyWithImpl$Fragment$dnsRecordFields<TRes>
    implements CopyWith$Fragment$dnsRecordFields<TRes> {
  _CopyWithImpl$Fragment$dnsRecordFields(this._instance, this._then);

  final Fragment$dnsRecordFields _instance;

  final TRes Function(Fragment$dnsRecordFields) _then;

  static const _undefined = {};

  TRes call(
          {Object? content = _undefined,
          Object? name = _undefined,
          Object? priority = _undefined,
          Object? recordType = _undefined,
          Object? ttl = _undefined,
          Object? $__typename = _undefined}) =>
      _then(Fragment$dnsRecordFields(
          content: content == _undefined || content == null
              ? _instance.content
              : (content as String),
          name: name == _undefined || name == null
              ? _instance.name
              : (name as String),
          priority:
              priority == _undefined ? _instance.priority : (priority as int?),
          recordType: recordType == _undefined || recordType == null
              ? _instance.recordType
              : (recordType as String),
          ttl: ttl == _undefined || ttl == null ? _instance.ttl : (ttl as int),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String)));
}

class _CopyWithStubImpl$Fragment$dnsRecordFields<TRes>
    implements CopyWith$Fragment$dnsRecordFields<TRes> {
  _CopyWithStubImpl$Fragment$dnsRecordFields(this._res);

  TRes _res;

  call(
          {String? content,
          String? name,
          int? priority,
          String? recordType,
          int? ttl,
          String? $__typename}) =>
      _res;
}

const fragmentDefinitiondnsRecordFields = FragmentDefinitionNode(
    name: NameNode(value: 'dnsRecordFields'),
    typeCondition: TypeConditionNode(
        on: NamedTypeNode(
            name: NameNode(value: 'DnsRecord'), isNonNull: false)),
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
          name: NameNode(value: 'content'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null),
      FieldNode(
          name: NameNode(value: 'name'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null),
      FieldNode(
          name: NameNode(value: 'priority'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null),
      FieldNode(
          name: NameNode(value: 'recordType'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null),
      FieldNode(
          name: NameNode(value: 'ttl'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null),
      FieldNode(
          name: NameNode(value: '__typename'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null)
    ]));
const documentNodeFragmentdnsRecordFields = DocumentNode(definitions: [
  fragmentDefinitiondnsRecordFields,
]);

extension ClientExtension$Fragment$dnsRecordFields on graphql.GraphQLClient {
  void writeFragment$dnsRecordFields(
          {required Fragment$dnsRecordFields data,
          required Map<String, dynamic> idFields,
          bool broadcast = true}) =>
      this.writeFragment(
          graphql.FragmentRequest(
              idFields: idFields,
              fragment: const graphql.Fragment(
                  fragmentName: 'dnsRecordFields',
                  document: documentNodeFragmentdnsRecordFields)),
          data: data.toJson(),
          broadcast: broadcast);
  Fragment$dnsRecordFields? readFragment$dnsRecordFields(
      {required Map<String, dynamic> idFields, bool optimistic = true}) {
    final result = this.readFragment(
        graphql.FragmentRequest(
            idFields: idFields,
            fragment: const graphql.Fragment(
                fragmentName: 'dnsRecordFields',
                document: documentNodeFragmentdnsRecordFields)),
        optimistic: optimistic);
    return result == null ? null : Fragment$dnsRecordFields.fromJson(result);
  }
}

const possibleTypesMap = {
  'MutationReturnInterface': {
    'ApiKeyMutationReturn',
    'AutoUpgradeSettingsMutationReturn',
    'DeviceApiTokenMutationReturn',
    'GenericJobButationReturn',
    'GenericMutationReturn',
    'ServiceJobMutationReturn',
    'ServiceMutationReturn',
    'TimezoneMutationReturn',
    'UserMutationReturn'
  },
  'StorageUsageInterface': {'ServiceStorageUsage'}
};
DateTime? _nullable$dateTimeFromJson(dynamic data) =>
    data == null ? null : dateTimeFromJson(data);
dynamic _nullable$dateTimeToJson(DateTime? data) =>
    data == null ? null : dateTimeToJson(data);
