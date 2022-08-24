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

  Input$AutoUpgradeSettingsInput copyWith(
          {bool? Function()? enableAutoUpgrade,
          bool? Function()? allowReboot}) =>
      Input$AutoUpgradeSettingsInput(
          enableAutoUpgrade: enableAutoUpgrade == null
              ? this.enableAutoUpgrade
              : enableAutoUpgrade(),
          allowReboot: allowReboot == null ? this.allowReboot : allowReboot());
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

  Input$MigrateToBindsInput copyWith(
          {String? emailBlockDevice,
          String? bitwardenBlockDevice,
          String? giteaBlockDevice,
          String? nextcloudBlockDevice,
          String? pleromaBlockDevice}) =>
      Input$MigrateToBindsInput(
          emailBlockDevice: emailBlockDevice == null
              ? this.emailBlockDevice
              : emailBlockDevice,
          bitwardenBlockDevice: bitwardenBlockDevice == null
              ? this.bitwardenBlockDevice
              : bitwardenBlockDevice,
          giteaBlockDevice: giteaBlockDevice == null
              ? this.giteaBlockDevice
              : giteaBlockDevice,
          nextcloudBlockDevice: nextcloudBlockDevice == null
              ? this.nextcloudBlockDevice
              : nextcloudBlockDevice,
          pleromaBlockDevice: pleromaBlockDevice == null
              ? this.pleromaBlockDevice
              : pleromaBlockDevice);
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

  Input$MoveServiceInput copyWith({String? serviceId, String? location}) =>
      Input$MoveServiceInput(
          serviceId: serviceId == null ? this.serviceId : serviceId,
          location: location == null ? this.location : location);
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

  Input$RecoveryKeyLimitsInput copyWith(
          {DateTime? Function()? expirationDate, int? Function()? uses}) =>
      Input$RecoveryKeyLimitsInput(
          expirationDate:
              expirationDate == null ? this.expirationDate : expirationDate(),
          uses: uses == null ? this.uses : uses());
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

  Input$SshMutationInput copyWith({String? username, String? sshKey}) =>
      Input$SshMutationInput(
          username: username == null ? this.username : username,
          sshKey: sshKey == null ? this.sshKey : sshKey);
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

  Input$UseNewDeviceKeyInput copyWith({String? key, String? deviceName}) =>
      Input$UseNewDeviceKeyInput(
          key: key == null ? this.key : key,
          deviceName: deviceName == null ? this.deviceName : deviceName);
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

  Input$UseRecoveryKeyInput copyWith({String? key, String? deviceName}) =>
      Input$UseRecoveryKeyInput(
          key: key == null ? this.key : key,
          deviceName: deviceName == null ? this.deviceName : deviceName);
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

  Input$UserMutationInput copyWith({String? username, String? password}) =>
      Input$UserMutationInput(
          username: username == null ? this.username : username,
          password: password == null ? this.password : password);
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
