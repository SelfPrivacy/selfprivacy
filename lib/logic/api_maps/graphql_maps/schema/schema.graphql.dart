import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:selfprivacy/utils/scalars.dart';

class Input$AutoUpgradeSettingsInput {
  factory Input$AutoUpgradeSettingsInput({
    bool? enableAutoUpgrade,
    bool? allowReboot,
  }) =>
      Input$AutoUpgradeSettingsInput._({
        if (enableAutoUpgrade != null) r'enableAutoUpgrade': enableAutoUpgrade,
        if (allowReboot != null) r'allowReboot': allowReboot,
      });

  Input$AutoUpgradeSettingsInput._(this._$data);

  factory Input$AutoUpgradeSettingsInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('enableAutoUpgrade')) {
      final l$enableAutoUpgrade = data['enableAutoUpgrade'];
      result$data['enableAutoUpgrade'] = (l$enableAutoUpgrade as bool?);
    }
    if (data.containsKey('allowReboot')) {
      final l$allowReboot = data['allowReboot'];
      result$data['allowReboot'] = (l$allowReboot as bool?);
    }
    return Input$AutoUpgradeSettingsInput._(result$data);
  }

  Map<String, dynamic> _$data;

  bool? get enableAutoUpgrade => (_$data['enableAutoUpgrade'] as bool?);
  bool? get allowReboot => (_$data['allowReboot'] as bool?);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('enableAutoUpgrade')) {
      final l$enableAutoUpgrade = enableAutoUpgrade;
      result$data['enableAutoUpgrade'] = l$enableAutoUpgrade;
    }
    if (_$data.containsKey('allowReboot')) {
      final l$allowReboot = allowReboot;
      result$data['allowReboot'] = l$allowReboot;
    }
    return result$data;
  }

  CopyWith$Input$AutoUpgradeSettingsInput<Input$AutoUpgradeSettingsInput>
      get copyWith => CopyWith$Input$AutoUpgradeSettingsInput(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$AutoUpgradeSettingsInput) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$enableAutoUpgrade = enableAutoUpgrade;
    final lOther$enableAutoUpgrade = other.enableAutoUpgrade;
    if (_$data.containsKey('enableAutoUpgrade') !=
        other._$data.containsKey('enableAutoUpgrade')) {
      return false;
    }
    if (l$enableAutoUpgrade != lOther$enableAutoUpgrade) {
      return false;
    }
    final l$allowReboot = allowReboot;
    final lOther$allowReboot = other.allowReboot;
    if (_$data.containsKey('allowReboot') !=
        other._$data.containsKey('allowReboot')) {
      return false;
    }
    if (l$allowReboot != lOther$allowReboot) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$enableAutoUpgrade = enableAutoUpgrade;
    final l$allowReboot = allowReboot;
    return Object.hashAll([
      _$data.containsKey('enableAutoUpgrade') ? l$enableAutoUpgrade : const {},
      _$data.containsKey('allowReboot') ? l$allowReboot : const {},
    ]);
  }
}

abstract class CopyWith$Input$AutoUpgradeSettingsInput<TRes> {
  factory CopyWith$Input$AutoUpgradeSettingsInput(
    Input$AutoUpgradeSettingsInput instance,
    TRes Function(Input$AutoUpgradeSettingsInput) then,
  ) = _CopyWithImpl$Input$AutoUpgradeSettingsInput;

  factory CopyWith$Input$AutoUpgradeSettingsInput.stub(TRes res) =
      _CopyWithStubImpl$Input$AutoUpgradeSettingsInput;

  TRes call({
    bool? enableAutoUpgrade,
    bool? allowReboot,
  });
}

class _CopyWithImpl$Input$AutoUpgradeSettingsInput<TRes>
    implements CopyWith$Input$AutoUpgradeSettingsInput<TRes> {
  _CopyWithImpl$Input$AutoUpgradeSettingsInput(
    this._instance,
    this._then,
  );

  final Input$AutoUpgradeSettingsInput _instance;

  final TRes Function(Input$AutoUpgradeSettingsInput) _then;

  static const _undefined = {};

  TRes call({
    Object? enableAutoUpgrade = _undefined,
    Object? allowReboot = _undefined,
  }) =>
      _then(Input$AutoUpgradeSettingsInput._({
        ..._instance._$data,
        if (enableAutoUpgrade != _undefined)
          'enableAutoUpgrade': (enableAutoUpgrade as bool?),
        if (allowReboot != _undefined) 'allowReboot': (allowReboot as bool?),
      }));
}

class _CopyWithStubImpl$Input$AutoUpgradeSettingsInput<TRes>
    implements CopyWith$Input$AutoUpgradeSettingsInput<TRes> {
  _CopyWithStubImpl$Input$AutoUpgradeSettingsInput(this._res);

  TRes _res;

  call({
    bool? enableAutoUpgrade,
    bool? allowReboot,
  }) =>
      _res;
}

class Input$MigrateToBindsInput {
  factory Input$MigrateToBindsInput({
    required String emailBlockDevice,
    required String bitwardenBlockDevice,
    required String giteaBlockDevice,
    required String nextcloudBlockDevice,
    required String pleromaBlockDevice,
  }) =>
      Input$MigrateToBindsInput._({
        r'emailBlockDevice': emailBlockDevice,
        r'bitwardenBlockDevice': bitwardenBlockDevice,
        r'giteaBlockDevice': giteaBlockDevice,
        r'nextcloudBlockDevice': nextcloudBlockDevice,
        r'pleromaBlockDevice': pleromaBlockDevice,
      });

  Input$MigrateToBindsInput._(this._$data);

  factory Input$MigrateToBindsInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$emailBlockDevice = data['emailBlockDevice'];
    result$data['emailBlockDevice'] = (l$emailBlockDevice as String);
    final l$bitwardenBlockDevice = data['bitwardenBlockDevice'];
    result$data['bitwardenBlockDevice'] = (l$bitwardenBlockDevice as String);
    final l$giteaBlockDevice = data['giteaBlockDevice'];
    result$data['giteaBlockDevice'] = (l$giteaBlockDevice as String);
    final l$nextcloudBlockDevice = data['nextcloudBlockDevice'];
    result$data['nextcloudBlockDevice'] = (l$nextcloudBlockDevice as String);
    final l$pleromaBlockDevice = data['pleromaBlockDevice'];
    result$data['pleromaBlockDevice'] = (l$pleromaBlockDevice as String);
    return Input$MigrateToBindsInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get emailBlockDevice => (_$data['emailBlockDevice'] as String);
  String get bitwardenBlockDevice => (_$data['bitwardenBlockDevice'] as String);
  String get giteaBlockDevice => (_$data['giteaBlockDevice'] as String);
  String get nextcloudBlockDevice => (_$data['nextcloudBlockDevice'] as String);
  String get pleromaBlockDevice => (_$data['pleromaBlockDevice'] as String);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$emailBlockDevice = emailBlockDevice;
    result$data['emailBlockDevice'] = l$emailBlockDevice;
    final l$bitwardenBlockDevice = bitwardenBlockDevice;
    result$data['bitwardenBlockDevice'] = l$bitwardenBlockDevice;
    final l$giteaBlockDevice = giteaBlockDevice;
    result$data['giteaBlockDevice'] = l$giteaBlockDevice;
    final l$nextcloudBlockDevice = nextcloudBlockDevice;
    result$data['nextcloudBlockDevice'] = l$nextcloudBlockDevice;
    final l$pleromaBlockDevice = pleromaBlockDevice;
    result$data['pleromaBlockDevice'] = l$pleromaBlockDevice;
    return result$data;
  }

  CopyWith$Input$MigrateToBindsInput<Input$MigrateToBindsInput> get copyWith =>
      CopyWith$Input$MigrateToBindsInput(
        this,
        (i) => i,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$MigrateToBindsInput) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$emailBlockDevice = emailBlockDevice;
    final lOther$emailBlockDevice = other.emailBlockDevice;
    if (l$emailBlockDevice != lOther$emailBlockDevice) {
      return false;
    }
    final l$bitwardenBlockDevice = bitwardenBlockDevice;
    final lOther$bitwardenBlockDevice = other.bitwardenBlockDevice;
    if (l$bitwardenBlockDevice != lOther$bitwardenBlockDevice) {
      return false;
    }
    final l$giteaBlockDevice = giteaBlockDevice;
    final lOther$giteaBlockDevice = other.giteaBlockDevice;
    if (l$giteaBlockDevice != lOther$giteaBlockDevice) {
      return false;
    }
    final l$nextcloudBlockDevice = nextcloudBlockDevice;
    final lOther$nextcloudBlockDevice = other.nextcloudBlockDevice;
    if (l$nextcloudBlockDevice != lOther$nextcloudBlockDevice) {
      return false;
    }
    final l$pleromaBlockDevice = pleromaBlockDevice;
    final lOther$pleromaBlockDevice = other.pleromaBlockDevice;
    if (l$pleromaBlockDevice != lOther$pleromaBlockDevice) {
      return false;
    }
    return true;
  }

  @override
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
      l$pleromaBlockDevice,
    ]);
  }
}

abstract class CopyWith$Input$MigrateToBindsInput<TRes> {
  factory CopyWith$Input$MigrateToBindsInput(
    Input$MigrateToBindsInput instance,
    TRes Function(Input$MigrateToBindsInput) then,
  ) = _CopyWithImpl$Input$MigrateToBindsInput;

  factory CopyWith$Input$MigrateToBindsInput.stub(TRes res) =
      _CopyWithStubImpl$Input$MigrateToBindsInput;

  TRes call({
    String? emailBlockDevice,
    String? bitwardenBlockDevice,
    String? giteaBlockDevice,
    String? nextcloudBlockDevice,
    String? pleromaBlockDevice,
  });
}

class _CopyWithImpl$Input$MigrateToBindsInput<TRes>
    implements CopyWith$Input$MigrateToBindsInput<TRes> {
  _CopyWithImpl$Input$MigrateToBindsInput(
    this._instance,
    this._then,
  );

  final Input$MigrateToBindsInput _instance;

  final TRes Function(Input$MigrateToBindsInput) _then;

  static const _undefined = {};

  TRes call({
    Object? emailBlockDevice = _undefined,
    Object? bitwardenBlockDevice = _undefined,
    Object? giteaBlockDevice = _undefined,
    Object? nextcloudBlockDevice = _undefined,
    Object? pleromaBlockDevice = _undefined,
  }) =>
      _then(Input$MigrateToBindsInput._({
        ..._instance._$data,
        if (emailBlockDevice != _undefined && emailBlockDevice != null)
          'emailBlockDevice': (emailBlockDevice as String),
        if (bitwardenBlockDevice != _undefined && bitwardenBlockDevice != null)
          'bitwardenBlockDevice': (bitwardenBlockDevice as String),
        if (giteaBlockDevice != _undefined && giteaBlockDevice != null)
          'giteaBlockDevice': (giteaBlockDevice as String),
        if (nextcloudBlockDevice != _undefined && nextcloudBlockDevice != null)
          'nextcloudBlockDevice': (nextcloudBlockDevice as String),
        if (pleromaBlockDevice != _undefined && pleromaBlockDevice != null)
          'pleromaBlockDevice': (pleromaBlockDevice as String),
      }));
}

class _CopyWithStubImpl$Input$MigrateToBindsInput<TRes>
    implements CopyWith$Input$MigrateToBindsInput<TRes> {
  _CopyWithStubImpl$Input$MigrateToBindsInput(this._res);

  TRes _res;

  call({
    String? emailBlockDevice,
    String? bitwardenBlockDevice,
    String? giteaBlockDevice,
    String? nextcloudBlockDevice,
    String? pleromaBlockDevice,
  }) =>
      _res;
}

class Input$MoveServiceInput {
  factory Input$MoveServiceInput({
    required String serviceId,
    required String location,
  }) =>
      Input$MoveServiceInput._({
        r'serviceId': serviceId,
        r'location': location,
      });

  Input$MoveServiceInput._(this._$data);

  factory Input$MoveServiceInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$serviceId = data['serviceId'];
    result$data['serviceId'] = (l$serviceId as String);
    final l$location = data['location'];
    result$data['location'] = (l$location as String);
    return Input$MoveServiceInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get serviceId => (_$data['serviceId'] as String);
  String get location => (_$data['location'] as String);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$serviceId = serviceId;
    result$data['serviceId'] = l$serviceId;
    final l$location = location;
    result$data['location'] = l$location;
    return result$data;
  }

  CopyWith$Input$MoveServiceInput<Input$MoveServiceInput> get copyWith =>
      CopyWith$Input$MoveServiceInput(
        this,
        (i) => i,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$MoveServiceInput) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$serviceId = serviceId;
    final lOther$serviceId = other.serviceId;
    if (l$serviceId != lOther$serviceId) {
      return false;
    }
    final l$location = location;
    final lOther$location = other.location;
    if (l$location != lOther$location) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$serviceId = serviceId;
    final l$location = location;
    return Object.hashAll([
      l$serviceId,
      l$location,
    ]);
  }
}

abstract class CopyWith$Input$MoveServiceInput<TRes> {
  factory CopyWith$Input$MoveServiceInput(
    Input$MoveServiceInput instance,
    TRes Function(Input$MoveServiceInput) then,
  ) = _CopyWithImpl$Input$MoveServiceInput;

  factory CopyWith$Input$MoveServiceInput.stub(TRes res) =
      _CopyWithStubImpl$Input$MoveServiceInput;

  TRes call({
    String? serviceId,
    String? location,
  });
}

class _CopyWithImpl$Input$MoveServiceInput<TRes>
    implements CopyWith$Input$MoveServiceInput<TRes> {
  _CopyWithImpl$Input$MoveServiceInput(
    this._instance,
    this._then,
  );

  final Input$MoveServiceInput _instance;

  final TRes Function(Input$MoveServiceInput) _then;

  static const _undefined = {};

  TRes call({
    Object? serviceId = _undefined,
    Object? location = _undefined,
  }) =>
      _then(Input$MoveServiceInput._({
        ..._instance._$data,
        if (serviceId != _undefined && serviceId != null)
          'serviceId': (serviceId as String),
        if (location != _undefined && location != null)
          'location': (location as String),
      }));
}

class _CopyWithStubImpl$Input$MoveServiceInput<TRes>
    implements CopyWith$Input$MoveServiceInput<TRes> {
  _CopyWithStubImpl$Input$MoveServiceInput(this._res);

  TRes _res;

  call({
    String? serviceId,
    String? location,
  }) =>
      _res;
}

class Input$RecoveryKeyLimitsInput {
  factory Input$RecoveryKeyLimitsInput({
    DateTime? expirationDate,
    int? uses,
  }) =>
      Input$RecoveryKeyLimitsInput._({
        if (expirationDate != null) r'expirationDate': expirationDate,
        if (uses != null) r'uses': uses,
      });

  Input$RecoveryKeyLimitsInput._(this._$data);

  factory Input$RecoveryKeyLimitsInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('expirationDate')) {
      final l$expirationDate = data['expirationDate'];
      result$data['expirationDate'] =
          l$expirationDate == null ? null : dateTimeFromJson(l$expirationDate);
    }
    if (data.containsKey('uses')) {
      final l$uses = data['uses'];
      result$data['uses'] = (l$uses as int?);
    }
    return Input$RecoveryKeyLimitsInput._(result$data);
  }

  Map<String, dynamic> _$data;

  DateTime? get expirationDate => (_$data['expirationDate'] as DateTime?);
  int? get uses => (_$data['uses'] as int?);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('expirationDate')) {
      final l$expirationDate = expirationDate;
      result$data['expirationDate'] =
          l$expirationDate == null ? null : dateTimeToJson(l$expirationDate);
    }
    if (_$data.containsKey('uses')) {
      final l$uses = uses;
      result$data['uses'] = l$uses;
    }
    return result$data;
  }

  CopyWith$Input$RecoveryKeyLimitsInput<Input$RecoveryKeyLimitsInput>
      get copyWith => CopyWith$Input$RecoveryKeyLimitsInput(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$RecoveryKeyLimitsInput) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$expirationDate = expirationDate;
    final lOther$expirationDate = other.expirationDate;
    if (_$data.containsKey('expirationDate') !=
        other._$data.containsKey('expirationDate')) {
      return false;
    }
    if (l$expirationDate != lOther$expirationDate) {
      return false;
    }
    final l$uses = uses;
    final lOther$uses = other.uses;
    if (_$data.containsKey('uses') != other._$data.containsKey('uses')) {
      return false;
    }
    if (l$uses != lOther$uses) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$expirationDate = expirationDate;
    final l$uses = uses;
    return Object.hashAll([
      _$data.containsKey('expirationDate') ? l$expirationDate : const {},
      _$data.containsKey('uses') ? l$uses : const {},
    ]);
  }
}

abstract class CopyWith$Input$RecoveryKeyLimitsInput<TRes> {
  factory CopyWith$Input$RecoveryKeyLimitsInput(
    Input$RecoveryKeyLimitsInput instance,
    TRes Function(Input$RecoveryKeyLimitsInput) then,
  ) = _CopyWithImpl$Input$RecoveryKeyLimitsInput;

  factory CopyWith$Input$RecoveryKeyLimitsInput.stub(TRes res) =
      _CopyWithStubImpl$Input$RecoveryKeyLimitsInput;

  TRes call({
    DateTime? expirationDate,
    int? uses,
  });
}

class _CopyWithImpl$Input$RecoveryKeyLimitsInput<TRes>
    implements CopyWith$Input$RecoveryKeyLimitsInput<TRes> {
  _CopyWithImpl$Input$RecoveryKeyLimitsInput(
    this._instance,
    this._then,
  );

  final Input$RecoveryKeyLimitsInput _instance;

  final TRes Function(Input$RecoveryKeyLimitsInput) _then;

  static const _undefined = {};

  TRes call({
    Object? expirationDate = _undefined,
    Object? uses = _undefined,
  }) =>
      _then(Input$RecoveryKeyLimitsInput._({
        ..._instance._$data,
        if (expirationDate != _undefined)
          'expirationDate': (expirationDate as DateTime?),
        if (uses != _undefined) 'uses': (uses as int?),
      }));
}

class _CopyWithStubImpl$Input$RecoveryKeyLimitsInput<TRes>
    implements CopyWith$Input$RecoveryKeyLimitsInput<TRes> {
  _CopyWithStubImpl$Input$RecoveryKeyLimitsInput(this._res);

  TRes _res;

  call({
    DateTime? expirationDate,
    int? uses,
  }) =>
      _res;
}

class Input$SshMutationInput {
  factory Input$SshMutationInput({
    required String username,
    required String sshKey,
  }) =>
      Input$SshMutationInput._({
        r'username': username,
        r'sshKey': sshKey,
      });

  Input$SshMutationInput._(this._$data);

  factory Input$SshMutationInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$username = data['username'];
    result$data['username'] = (l$username as String);
    final l$sshKey = data['sshKey'];
    result$data['sshKey'] = (l$sshKey as String);
    return Input$SshMutationInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get username => (_$data['username'] as String);
  String get sshKey => (_$data['sshKey'] as String);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$username = username;
    result$data['username'] = l$username;
    final l$sshKey = sshKey;
    result$data['sshKey'] = l$sshKey;
    return result$data;
  }

  CopyWith$Input$SshMutationInput<Input$SshMutationInput> get copyWith =>
      CopyWith$Input$SshMutationInput(
        this,
        (i) => i,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$SshMutationInput) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) {
      return false;
    }
    final l$sshKey = sshKey;
    final lOther$sshKey = other.sshKey;
    if (l$sshKey != lOther$sshKey) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$username = username;
    final l$sshKey = sshKey;
    return Object.hashAll([
      l$username,
      l$sshKey,
    ]);
  }
}

abstract class CopyWith$Input$SshMutationInput<TRes> {
  factory CopyWith$Input$SshMutationInput(
    Input$SshMutationInput instance,
    TRes Function(Input$SshMutationInput) then,
  ) = _CopyWithImpl$Input$SshMutationInput;

  factory CopyWith$Input$SshMutationInput.stub(TRes res) =
      _CopyWithStubImpl$Input$SshMutationInput;

  TRes call({
    String? username,
    String? sshKey,
  });
}

class _CopyWithImpl$Input$SshMutationInput<TRes>
    implements CopyWith$Input$SshMutationInput<TRes> {
  _CopyWithImpl$Input$SshMutationInput(
    this._instance,
    this._then,
  );

  final Input$SshMutationInput _instance;

  final TRes Function(Input$SshMutationInput) _then;

  static const _undefined = {};

  TRes call({
    Object? username = _undefined,
    Object? sshKey = _undefined,
  }) =>
      _then(Input$SshMutationInput._({
        ..._instance._$data,
        if (username != _undefined && username != null)
          'username': (username as String),
        if (sshKey != _undefined && sshKey != null)
          'sshKey': (sshKey as String),
      }));
}

class _CopyWithStubImpl$Input$SshMutationInput<TRes>
    implements CopyWith$Input$SshMutationInput<TRes> {
  _CopyWithStubImpl$Input$SshMutationInput(this._res);

  TRes _res;

  call({
    String? username,
    String? sshKey,
  }) =>
      _res;
}

class Input$UseNewDeviceKeyInput {
  factory Input$UseNewDeviceKeyInput({
    required String key,
    required String deviceName,
  }) =>
      Input$UseNewDeviceKeyInput._({
        r'key': key,
        r'deviceName': deviceName,
      });

  Input$UseNewDeviceKeyInput._(this._$data);

  factory Input$UseNewDeviceKeyInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$key = data['key'];
    result$data['key'] = (l$key as String);
    final l$deviceName = data['deviceName'];
    result$data['deviceName'] = (l$deviceName as String);
    return Input$UseNewDeviceKeyInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get key => (_$data['key'] as String);
  String get deviceName => (_$data['deviceName'] as String);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$key = key;
    result$data['key'] = l$key;
    final l$deviceName = deviceName;
    result$data['deviceName'] = l$deviceName;
    return result$data;
  }

  CopyWith$Input$UseNewDeviceKeyInput<Input$UseNewDeviceKeyInput>
      get copyWith => CopyWith$Input$UseNewDeviceKeyInput(
            this,
            (i) => i,
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$UseNewDeviceKeyInput) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$key = key;
    final lOther$key = other.key;
    if (l$key != lOther$key) {
      return false;
    }
    final l$deviceName = deviceName;
    final lOther$deviceName = other.deviceName;
    if (l$deviceName != lOther$deviceName) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$key = key;
    final l$deviceName = deviceName;
    return Object.hashAll([
      l$key,
      l$deviceName,
    ]);
  }
}

abstract class CopyWith$Input$UseNewDeviceKeyInput<TRes> {
  factory CopyWith$Input$UseNewDeviceKeyInput(
    Input$UseNewDeviceKeyInput instance,
    TRes Function(Input$UseNewDeviceKeyInput) then,
  ) = _CopyWithImpl$Input$UseNewDeviceKeyInput;

  factory CopyWith$Input$UseNewDeviceKeyInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UseNewDeviceKeyInput;

  TRes call({
    String? key,
    String? deviceName,
  });
}

class _CopyWithImpl$Input$UseNewDeviceKeyInput<TRes>
    implements CopyWith$Input$UseNewDeviceKeyInput<TRes> {
  _CopyWithImpl$Input$UseNewDeviceKeyInput(
    this._instance,
    this._then,
  );

  final Input$UseNewDeviceKeyInput _instance;

  final TRes Function(Input$UseNewDeviceKeyInput) _then;

  static const _undefined = {};

  TRes call({
    Object? key = _undefined,
    Object? deviceName = _undefined,
  }) =>
      _then(Input$UseNewDeviceKeyInput._({
        ..._instance._$data,
        if (key != _undefined && key != null) 'key': (key as String),
        if (deviceName != _undefined && deviceName != null)
          'deviceName': (deviceName as String),
      }));
}

class _CopyWithStubImpl$Input$UseNewDeviceKeyInput<TRes>
    implements CopyWith$Input$UseNewDeviceKeyInput<TRes> {
  _CopyWithStubImpl$Input$UseNewDeviceKeyInput(this._res);

  TRes _res;

  call({
    String? key,
    String? deviceName,
  }) =>
      _res;
}

class Input$UseRecoveryKeyInput {
  factory Input$UseRecoveryKeyInput({
    required String key,
    required String deviceName,
  }) =>
      Input$UseRecoveryKeyInput._({
        r'key': key,
        r'deviceName': deviceName,
      });

  Input$UseRecoveryKeyInput._(this._$data);

  factory Input$UseRecoveryKeyInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$key = data['key'];
    result$data['key'] = (l$key as String);
    final l$deviceName = data['deviceName'];
    result$data['deviceName'] = (l$deviceName as String);
    return Input$UseRecoveryKeyInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get key => (_$data['key'] as String);
  String get deviceName => (_$data['deviceName'] as String);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$key = key;
    result$data['key'] = l$key;
    final l$deviceName = deviceName;
    result$data['deviceName'] = l$deviceName;
    return result$data;
  }

  CopyWith$Input$UseRecoveryKeyInput<Input$UseRecoveryKeyInput> get copyWith =>
      CopyWith$Input$UseRecoveryKeyInput(
        this,
        (i) => i,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$UseRecoveryKeyInput) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$key = key;
    final lOther$key = other.key;
    if (l$key != lOther$key) {
      return false;
    }
    final l$deviceName = deviceName;
    final lOther$deviceName = other.deviceName;
    if (l$deviceName != lOther$deviceName) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$key = key;
    final l$deviceName = deviceName;
    return Object.hashAll([
      l$key,
      l$deviceName,
    ]);
  }
}

abstract class CopyWith$Input$UseRecoveryKeyInput<TRes> {
  factory CopyWith$Input$UseRecoveryKeyInput(
    Input$UseRecoveryKeyInput instance,
    TRes Function(Input$UseRecoveryKeyInput) then,
  ) = _CopyWithImpl$Input$UseRecoveryKeyInput;

  factory CopyWith$Input$UseRecoveryKeyInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UseRecoveryKeyInput;

  TRes call({
    String? key,
    String? deviceName,
  });
}

class _CopyWithImpl$Input$UseRecoveryKeyInput<TRes>
    implements CopyWith$Input$UseRecoveryKeyInput<TRes> {
  _CopyWithImpl$Input$UseRecoveryKeyInput(
    this._instance,
    this._then,
  );

  final Input$UseRecoveryKeyInput _instance;

  final TRes Function(Input$UseRecoveryKeyInput) _then;

  static const _undefined = {};

  TRes call({
    Object? key = _undefined,
    Object? deviceName = _undefined,
  }) =>
      _then(Input$UseRecoveryKeyInput._({
        ..._instance._$data,
        if (key != _undefined && key != null) 'key': (key as String),
        if (deviceName != _undefined && deviceName != null)
          'deviceName': (deviceName as String),
      }));
}

class _CopyWithStubImpl$Input$UseRecoveryKeyInput<TRes>
    implements CopyWith$Input$UseRecoveryKeyInput<TRes> {
  _CopyWithStubImpl$Input$UseRecoveryKeyInput(this._res);

  TRes _res;

  call({
    String? key,
    String? deviceName,
  }) =>
      _res;
}

class Input$UserMutationInput {
  factory Input$UserMutationInput({
    required String username,
    required String password,
  }) =>
      Input$UserMutationInput._({
        r'username': username,
        r'password': password,
      });

  Input$UserMutationInput._(this._$data);

  factory Input$UserMutationInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$username = data['username'];
    result$data['username'] = (l$username as String);
    final l$password = data['password'];
    result$data['password'] = (l$password as String);
    return Input$UserMutationInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get username => (_$data['username'] as String);
  String get password => (_$data['password'] as String);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$username = username;
    result$data['username'] = l$username;
    final l$password = password;
    result$data['password'] = l$password;
    return result$data;
  }

  CopyWith$Input$UserMutationInput<Input$UserMutationInput> get copyWith =>
      CopyWith$Input$UserMutationInput(
        this,
        (i) => i,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$UserMutationInput) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) {
      return false;
    }
    final l$password = password;
    final lOther$password = other.password;
    if (l$password != lOther$password) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$username = username;
    final l$password = password;
    return Object.hashAll([
      l$username,
      l$password,
    ]);
  }
}

abstract class CopyWith$Input$UserMutationInput<TRes> {
  factory CopyWith$Input$UserMutationInput(
    Input$UserMutationInput instance,
    TRes Function(Input$UserMutationInput) then,
  ) = _CopyWithImpl$Input$UserMutationInput;

  factory CopyWith$Input$UserMutationInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UserMutationInput;

  TRes call({
    String? username,
    String? password,
  });
}

class _CopyWithImpl$Input$UserMutationInput<TRes>
    implements CopyWith$Input$UserMutationInput<TRes> {
  _CopyWithImpl$Input$UserMutationInput(
    this._instance,
    this._then,
  );

  final Input$UserMutationInput _instance;

  final TRes Function(Input$UserMutationInput) _then;

  static const _undefined = {};

  TRes call({
    Object? username = _undefined,
    Object? password = _undefined,
  }) =>
      _then(Input$UserMutationInput._({
        ..._instance._$data,
        if (username != _undefined && username != null)
          'username': (username as String),
        if (password != _undefined && password != null)
          'password': (password as String),
      }));
}

class _CopyWithStubImpl$Input$UserMutationInput<TRes>
    implements CopyWith$Input$UserMutationInput<TRes> {
  _CopyWithStubImpl$Input$UserMutationInput(this._res);

  TRes _res;

  call({
    String? username,
    String? password,
  }) =>
      _res;
}

enum Enum$DnsProvider { CLOUDFLARE, DESEC, $unknown }

String toJson$Enum$DnsProvider(Enum$DnsProvider e) {
  switch (e) {
    case Enum$DnsProvider.CLOUDFLARE:
      return r'CLOUDFLARE';
    case Enum$DnsProvider.DESEC:
      return r'DESEC';
    case Enum$DnsProvider.$unknown:
      return r'$unknown';
  }
}

Enum$DnsProvider fromJson$Enum$DnsProvider(String value) {
  switch (value) {
    case r'CLOUDFLARE':
      return Enum$DnsProvider.CLOUDFLARE;
    case r'DESEC':
      return Enum$DnsProvider.DESEC;
    default:
      return Enum$DnsProvider.$unknown;
  }
}

enum Enum$ServerProvider { HETZNER, DIGITALOCEAN, $unknown }

String toJson$Enum$ServerProvider(Enum$ServerProvider e) {
  switch (e) {
    case Enum$ServerProvider.HETZNER:
      return r'HETZNER';
    case Enum$ServerProvider.DIGITALOCEAN:
      return r'DIGITALOCEAN';
    case Enum$ServerProvider.$unknown:
      return r'$unknown';
  }
}

Enum$ServerProvider fromJson$Enum$ServerProvider(String value) {
  switch (value) {
    case r'HETZNER':
      return Enum$ServerProvider.HETZNER;
    case r'DIGITALOCEAN':
      return Enum$ServerProvider.DIGITALOCEAN;
    default:
      return Enum$ServerProvider.$unknown;
  }
}

enum Enum$ServiceStatusEnum {
  ACTIVATING,
  ACTIVE,
  DEACTIVATING,
  FAILED,
  INACTIVE,
  OFF,
  RELOADING,
  $unknown
}

String toJson$Enum$ServiceStatusEnum(Enum$ServiceStatusEnum e) {
  switch (e) {
    case Enum$ServiceStatusEnum.ACTIVATING:
      return r'ACTIVATING';
    case Enum$ServiceStatusEnum.ACTIVE:
      return r'ACTIVE';
    case Enum$ServiceStatusEnum.DEACTIVATING:
      return r'DEACTIVATING';
    case Enum$ServiceStatusEnum.FAILED:
      return r'FAILED';
    case Enum$ServiceStatusEnum.INACTIVE:
      return r'INACTIVE';
    case Enum$ServiceStatusEnum.OFF:
      return r'OFF';
    case Enum$ServiceStatusEnum.RELOADING:
      return r'RELOADING';
    case Enum$ServiceStatusEnum.$unknown:
      return r'$unknown';
  }
}

Enum$ServiceStatusEnum fromJson$Enum$ServiceStatusEnum(String value) {
  switch (value) {
    case r'ACTIVATING':
      return Enum$ServiceStatusEnum.ACTIVATING;
    case r'ACTIVE':
      return Enum$ServiceStatusEnum.ACTIVE;
    case r'DEACTIVATING':
      return Enum$ServiceStatusEnum.DEACTIVATING;
    case r'FAILED':
      return Enum$ServiceStatusEnum.FAILED;
    case r'INACTIVE':
      return Enum$ServiceStatusEnum.INACTIVE;
    case r'OFF':
      return Enum$ServiceStatusEnum.OFF;
    case r'RELOADING':
      return Enum$ServiceStatusEnum.RELOADING;
    default:
      return Enum$ServiceStatusEnum.$unknown;
  }
}

enum Enum$Severity { CRITICAL, ERROR, INFO, SUCCESS, WARNING, $unknown }

String toJson$Enum$Severity(Enum$Severity e) {
  switch (e) {
    case Enum$Severity.CRITICAL:
      return r'CRITICAL';
    case Enum$Severity.ERROR:
      return r'ERROR';
    case Enum$Severity.INFO:
      return r'INFO';
    case Enum$Severity.SUCCESS:
      return r'SUCCESS';
    case Enum$Severity.WARNING:
      return r'WARNING';
    case Enum$Severity.$unknown:
      return r'$unknown';
  }
}

Enum$Severity fromJson$Enum$Severity(String value) {
  switch (value) {
    case r'CRITICAL':
      return Enum$Severity.CRITICAL;
    case r'ERROR':
      return Enum$Severity.ERROR;
    case r'INFO':
      return Enum$Severity.INFO;
    case r'SUCCESS':
      return Enum$Severity.SUCCESS;
    case r'WARNING':
      return Enum$Severity.WARNING;
    default:
      return Enum$Severity.$unknown;
  }
}

enum Enum$UserType { NORMAL, PRIMARY, ROOT, $unknown }

String toJson$Enum$UserType(Enum$UserType e) {
  switch (e) {
    case Enum$UserType.NORMAL:
      return r'NORMAL';
    case Enum$UserType.PRIMARY:
      return r'PRIMARY';
    case Enum$UserType.ROOT:
      return r'ROOT';
    case Enum$UserType.$unknown:
      return r'$unknown';
  }
}

Enum$UserType fromJson$Enum$UserType(String value) {
  switch (value) {
    case r'NORMAL':
      return Enum$UserType.NORMAL;
    case r'PRIMARY':
      return Enum$UserType.PRIMARY;
    case r'ROOT':
      return Enum$UserType.ROOT;
    default:
      return Enum$UserType.$unknown;
  }
}

class Fragment$dnsRecordFields {
  Fragment$dnsRecordFields({
    required this.content,
    required this.name,
    this.priority,
    required this.recordType,
    required this.ttl,
    required this.$__typename,
  });

  factory Fragment$dnsRecordFields.fromJson(Map<String, dynamic> json) {
    final l$content = json['content'];
    final l$name = json['name'];
    final l$priority = json['priority'];
    final l$recordType = json['recordType'];
    final l$ttl = json['ttl'];
    final l$$__typename = json['__typename'];
    return Fragment$dnsRecordFields(
      content: (l$content as String),
      name: (l$name as String),
      priority: (l$priority as int?),
      recordType: (l$recordType as String),
      ttl: (l$ttl as int),
      $__typename: (l$$__typename as String),
    );
  }

  final String content;

  final String name;

  final int? priority;

  final String recordType;

  final int ttl;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$content = content;
    _resultData['content'] = l$content;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$priority = priority;
    _resultData['priority'] = l$priority;
    final l$recordType = recordType;
    _resultData['recordType'] = l$recordType;
    final l$ttl = ttl;
    _resultData['ttl'] = l$ttl;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$content = content;
    final l$name = name;
    final l$priority = priority;
    final l$recordType = recordType;
    final l$ttl = ttl;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$content,
      l$name,
      l$priority,
      l$recordType,
      l$ttl,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$dnsRecordFields) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$content = content;
    final lOther$content = other.content;
    if (l$content != lOther$content) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$priority = priority;
    final lOther$priority = other.priority;
    if (l$priority != lOther$priority) {
      return false;
    }
    final l$recordType = recordType;
    final lOther$recordType = other.recordType;
    if (l$recordType != lOther$recordType) {
      return false;
    }
    final l$ttl = ttl;
    final lOther$ttl = other.ttl;
    if (l$ttl != lOther$ttl) {
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

extension UtilityExtension$Fragment$dnsRecordFields
    on Fragment$dnsRecordFields {
  CopyWith$Fragment$dnsRecordFields<Fragment$dnsRecordFields> get copyWith =>
      CopyWith$Fragment$dnsRecordFields(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Fragment$dnsRecordFields<TRes> {
  factory CopyWith$Fragment$dnsRecordFields(
    Fragment$dnsRecordFields instance,
    TRes Function(Fragment$dnsRecordFields) then,
  ) = _CopyWithImpl$Fragment$dnsRecordFields;

  factory CopyWith$Fragment$dnsRecordFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$dnsRecordFields;

  TRes call({
    String? content,
    String? name,
    int? priority,
    String? recordType,
    int? ttl,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$dnsRecordFields<TRes>
    implements CopyWith$Fragment$dnsRecordFields<TRes> {
  _CopyWithImpl$Fragment$dnsRecordFields(
    this._instance,
    this._then,
  );

  final Fragment$dnsRecordFields _instance;

  final TRes Function(Fragment$dnsRecordFields) _then;

  static const _undefined = {};

  TRes call({
    Object? content = _undefined,
    Object? name = _undefined,
    Object? priority = _undefined,
    Object? recordType = _undefined,
    Object? ttl = _undefined,
    Object? $__typename = _undefined,
  }) =>
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
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$dnsRecordFields<TRes>
    implements CopyWith$Fragment$dnsRecordFields<TRes> {
  _CopyWithStubImpl$Fragment$dnsRecordFields(this._res);

  TRes _res;

  call({
    String? content,
    String? name,
    int? priority,
    String? recordType,
    int? ttl,
    String? $__typename,
  }) =>
      _res;
}

const fragmentDefinitiondnsRecordFields = FragmentDefinitionNode(
  name: NameNode(value: 'dnsRecordFields'),
  typeCondition: TypeConditionNode(
      on: NamedTypeNode(
    name: NameNode(value: 'DnsRecord'),
    isNonNull: false,
  )),
  directives: [],
  selectionSet: SelectionSetNode(selections: [
    FieldNode(
      name: NameNode(value: 'content'),
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
      name: NameNode(value: 'priority'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'recordType'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'ttl'),
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
const documentNodeFragmentdnsRecordFields = DocumentNode(definitions: [
  fragmentDefinitiondnsRecordFields,
]);

extension ClientExtension$Fragment$dnsRecordFields on graphql.GraphQLClient {
  void writeFragment$dnsRecordFields({
    required Fragment$dnsRecordFields data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) =>
      this.writeFragment(
        graphql.FragmentRequest(
          idFields: idFields,
          fragment: const graphql.Fragment(
            fragmentName: 'dnsRecordFields',
            document: documentNodeFragmentdnsRecordFields,
          ),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Fragment$dnsRecordFields? readFragment$dnsRecordFields({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'dnsRecordFields',
          document: documentNodeFragmentdnsRecordFields,
        ),
      ),
      optimistic: optimistic,
    );
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
    'UserMutationReturn',
  },
  'StorageUsageInterface': {'ServiceStorageUsage'},
};
