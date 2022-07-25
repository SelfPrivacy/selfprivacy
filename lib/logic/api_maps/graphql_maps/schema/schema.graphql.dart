import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/utils/scalars.dart';
part 'schema.graphql.g.dart';

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

enum Enum$Severity {
  @JsonValue('INFO')
  INFO,
  @JsonValue('WARNING')
  WARNING,
  @JsonValue('ERROR')
  ERROR,
  @JsonValue('CRITICAL')
  CRITICAL,
  @JsonValue('SUCCESS')
  SUCCESS,
  $unknown
}

const possibleTypesMap = {
  'MutationReturnInterface': {
    'ApiKeyMutationReturn',
    'DeviceApiTokenMutationReturn',
    'GenericMutationReturn'
  }
};
DateTime? _nullable$dateTimeFromJson(dynamic data) =>
    data == null ? null : dateTimeFromJson(data);
dynamic _nullable$dateTimeToJson(DateTime? data) =>
    data == null ? null : dateTimeToJson(data);
