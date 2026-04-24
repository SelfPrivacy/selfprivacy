import 'package:selfprivacy/utils/scalars.dart';

class Input$AutoUpgradeSettingsInput {
  factory Input$AutoUpgradeSettingsInput({
    bool? enableAutoUpgrade,
    bool? allowReboot,
  }) => Input$AutoUpgradeSettingsInput._({
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
  get copyWith => CopyWith$Input$AutoUpgradeSettingsInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$AutoUpgradeSettingsInput ||
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

  TRes call({bool? enableAutoUpgrade, bool? allowReboot});
}

class _CopyWithImpl$Input$AutoUpgradeSettingsInput<TRes>
    implements CopyWith$Input$AutoUpgradeSettingsInput<TRes> {
  _CopyWithImpl$Input$AutoUpgradeSettingsInput(this._instance, this._then);

  final Input$AutoUpgradeSettingsInput _instance;

  final TRes Function(Input$AutoUpgradeSettingsInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? enableAutoUpgrade = _undefined,
    Object? allowReboot = _undefined,
  }) => _then(
    Input$AutoUpgradeSettingsInput._({
      ..._instance._$data,
      if (enableAutoUpgrade != _undefined)
        'enableAutoUpgrade': (enableAutoUpgrade as bool?),
      if (allowReboot != _undefined) 'allowReboot': (allowReboot as bool?),
    }),
  );
}

class _CopyWithStubImpl$Input$AutoUpgradeSettingsInput<TRes>
    implements CopyWith$Input$AutoUpgradeSettingsInput<TRes> {
  _CopyWithStubImpl$Input$AutoUpgradeSettingsInput(this._res);

  TRes _res;

  call({bool? enableAutoUpgrade, bool? allowReboot}) => _res;
}

class Input$AutobackupQuotasInput {
  factory Input$AutobackupQuotasInput({
    required int last,
    required int daily,
    required int weekly,
    required int monthly,
    required int yearly,
  }) => Input$AutobackupQuotasInput._({
    r'last': last,
    r'daily': daily,
    r'weekly': weekly,
    r'monthly': monthly,
    r'yearly': yearly,
  });

  Input$AutobackupQuotasInput._(this._$data);

  factory Input$AutobackupQuotasInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$last = data['last'];
    result$data['last'] = (l$last as int);
    final l$daily = data['daily'];
    result$data['daily'] = (l$daily as int);
    final l$weekly = data['weekly'];
    result$data['weekly'] = (l$weekly as int);
    final l$monthly = data['monthly'];
    result$data['monthly'] = (l$monthly as int);
    final l$yearly = data['yearly'];
    result$data['yearly'] = (l$yearly as int);
    return Input$AutobackupQuotasInput._(result$data);
  }

  Map<String, dynamic> _$data;

  int get last => (_$data['last'] as int);

  int get daily => (_$data['daily'] as int);

  int get weekly => (_$data['weekly'] as int);

  int get monthly => (_$data['monthly'] as int);

  int get yearly => (_$data['yearly'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$last = last;
    result$data['last'] = l$last;
    final l$daily = daily;
    result$data['daily'] = l$daily;
    final l$weekly = weekly;
    result$data['weekly'] = l$weekly;
    final l$monthly = monthly;
    result$data['monthly'] = l$monthly;
    final l$yearly = yearly;
    result$data['yearly'] = l$yearly;
    return result$data;
  }

  CopyWith$Input$AutobackupQuotasInput<Input$AutobackupQuotasInput>
  get copyWith => CopyWith$Input$AutobackupQuotasInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$AutobackupQuotasInput ||
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
    return true;
  }

  @override
  int get hashCode {
    final l$last = last;
    final l$daily = daily;
    final l$weekly = weekly;
    final l$monthly = monthly;
    final l$yearly = yearly;
    return Object.hashAll([l$last, l$daily, l$weekly, l$monthly, l$yearly]);
  }
}

abstract class CopyWith$Input$AutobackupQuotasInput<TRes> {
  factory CopyWith$Input$AutobackupQuotasInput(
    Input$AutobackupQuotasInput instance,
    TRes Function(Input$AutobackupQuotasInput) then,
  ) = _CopyWithImpl$Input$AutobackupQuotasInput;

  factory CopyWith$Input$AutobackupQuotasInput.stub(TRes res) =
      _CopyWithStubImpl$Input$AutobackupQuotasInput;

  TRes call({int? last, int? daily, int? weekly, int? monthly, int? yearly});
}

class _CopyWithImpl$Input$AutobackupQuotasInput<TRes>
    implements CopyWith$Input$AutobackupQuotasInput<TRes> {
  _CopyWithImpl$Input$AutobackupQuotasInput(this._instance, this._then);

  final Input$AutobackupQuotasInput _instance;

  final TRes Function(Input$AutobackupQuotasInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? last = _undefined,
    Object? daily = _undefined,
    Object? weekly = _undefined,
    Object? monthly = _undefined,
    Object? yearly = _undefined,
  }) => _then(
    Input$AutobackupQuotasInput._({
      ..._instance._$data,
      if (last != _undefined && last != null) 'last': (last as int),
      if (daily != _undefined && daily != null) 'daily': (daily as int),
      if (weekly != _undefined && weekly != null) 'weekly': (weekly as int),
      if (monthly != _undefined && monthly != null) 'monthly': (monthly as int),
      if (yearly != _undefined && yearly != null) 'yearly': (yearly as int),
    }),
  );
}

class _CopyWithStubImpl$Input$AutobackupQuotasInput<TRes>
    implements CopyWith$Input$AutobackupQuotasInput<TRes> {
  _CopyWithStubImpl$Input$AutobackupQuotasInput(this._res);

  TRes _res;

  call({int? last, int? daily, int? weekly, int? monthly, int? yearly}) => _res;
}

class Input$InitializeRepositoryInput {
  factory Input$InitializeRepositoryInput({
    required Enum$BackupProvider provider,
    required String locationId,
    required String locationName,
    required String login,
    required String password,
    String? localSecret,
  }) => Input$InitializeRepositoryInput._({
    r'provider': provider,
    r'locationId': locationId,
    r'locationName': locationName,
    r'login': login,
    r'password': password,
    if (localSecret != null) r'localSecret': localSecret,
  });

  Input$InitializeRepositoryInput._(this._$data);

  factory Input$InitializeRepositoryInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$provider = data['provider'];
    result$data['provider'] = fromJson$Enum$BackupProvider(
      (l$provider as String),
    );
    final l$locationId = data['locationId'];
    result$data['locationId'] = (l$locationId as String);
    final l$locationName = data['locationName'];
    result$data['locationName'] = (l$locationName as String);
    final l$login = data['login'];
    result$data['login'] = (l$login as String);
    final l$password = data['password'];
    result$data['password'] = (l$password as String);
    if (data.containsKey('localSecret')) {
      final l$localSecret = data['localSecret'];
      result$data['localSecret'] = (l$localSecret as String?);
    }
    return Input$InitializeRepositoryInput._(result$data);
  }

  Map<String, dynamic> _$data;

  Enum$BackupProvider get provider =>
      (_$data['provider'] as Enum$BackupProvider);

  String get locationId => (_$data['locationId'] as String);

  String get locationName => (_$data['locationName'] as String);

  String get login => (_$data['login'] as String);

  String get password => (_$data['password'] as String);

  String? get localSecret => (_$data['localSecret'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$provider = provider;
    result$data['provider'] = toJson$Enum$BackupProvider(l$provider);
    final l$locationId = locationId;
    result$data['locationId'] = l$locationId;
    final l$locationName = locationName;
    result$data['locationName'] = l$locationName;
    final l$login = login;
    result$data['login'] = l$login;
    final l$password = password;
    result$data['password'] = l$password;
    if (_$data.containsKey('localSecret')) {
      final l$localSecret = localSecret;
      result$data['localSecret'] = l$localSecret;
    }
    return result$data;
  }

  CopyWith$Input$InitializeRepositoryInput<Input$InitializeRepositoryInput>
  get copyWith => CopyWith$Input$InitializeRepositoryInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$InitializeRepositoryInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$provider = provider;
    final lOther$provider = other.provider;
    if (l$provider != lOther$provider) {
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
    final l$login = login;
    final lOther$login = other.login;
    if (l$login != lOther$login) {
      return false;
    }
    final l$password = password;
    final lOther$password = other.password;
    if (l$password != lOther$password) {
      return false;
    }
    final l$localSecret = localSecret;
    final lOther$localSecret = other.localSecret;
    if (_$data.containsKey('localSecret') !=
        other._$data.containsKey('localSecret')) {
      return false;
    }
    if (l$localSecret != lOther$localSecret) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$provider = provider;
    final l$locationId = locationId;
    final l$locationName = locationName;
    final l$login = login;
    final l$password = password;
    final l$localSecret = localSecret;
    return Object.hashAll([
      l$provider,
      l$locationId,
      l$locationName,
      l$login,
      l$password,
      _$data.containsKey('localSecret') ? l$localSecret : const {},
    ]);
  }
}

abstract class CopyWith$Input$InitializeRepositoryInput<TRes> {
  factory CopyWith$Input$InitializeRepositoryInput(
    Input$InitializeRepositoryInput instance,
    TRes Function(Input$InitializeRepositoryInput) then,
  ) = _CopyWithImpl$Input$InitializeRepositoryInput;

  factory CopyWith$Input$InitializeRepositoryInput.stub(TRes res) =
      _CopyWithStubImpl$Input$InitializeRepositoryInput;

  TRes call({
    Enum$BackupProvider? provider,
    String? locationId,
    String? locationName,
    String? login,
    String? password,
    String? localSecret,
  });
}

class _CopyWithImpl$Input$InitializeRepositoryInput<TRes>
    implements CopyWith$Input$InitializeRepositoryInput<TRes> {
  _CopyWithImpl$Input$InitializeRepositoryInput(this._instance, this._then);

  final Input$InitializeRepositoryInput _instance;

  final TRes Function(Input$InitializeRepositoryInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? provider = _undefined,
    Object? locationId = _undefined,
    Object? locationName = _undefined,
    Object? login = _undefined,
    Object? password = _undefined,
    Object? localSecret = _undefined,
  }) => _then(
    Input$InitializeRepositoryInput._({
      ..._instance._$data,
      if (provider != _undefined && provider != null)
        'provider': (provider as Enum$BackupProvider),
      if (locationId != _undefined && locationId != null)
        'locationId': (locationId as String),
      if (locationName != _undefined && locationName != null)
        'locationName': (locationName as String),
      if (login != _undefined && login != null) 'login': (login as String),
      if (password != _undefined && password != null)
        'password': (password as String),
      if (localSecret != _undefined) 'localSecret': (localSecret as String?),
    }),
  );
}

class _CopyWithStubImpl$Input$InitializeRepositoryInput<TRes>
    implements CopyWith$Input$InitializeRepositoryInput<TRes> {
  _CopyWithStubImpl$Input$InitializeRepositoryInput(this._res);

  TRes _res;

  call({
    Enum$BackupProvider? provider,
    String? locationId,
    String? locationName,
    String? login,
    String? password,
    String? localSecret,
  }) => _res;
}

class Input$MigrateToBindsInput {
  factory Input$MigrateToBindsInput({
    required String emailBlockDevice,
    required String bitwardenBlockDevice,
    required String giteaBlockDevice,
    required String nextcloudBlockDevice,
    required String pleromaBlockDevice,
  }) => Input$MigrateToBindsInput._({
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
      CopyWith$Input$MigrateToBindsInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$MigrateToBindsInput ||
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
  _CopyWithImpl$Input$MigrateToBindsInput(this._instance, this._then);

  final Input$MigrateToBindsInput _instance;

  final TRes Function(Input$MigrateToBindsInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? emailBlockDevice = _undefined,
    Object? bitwardenBlockDevice = _undefined,
    Object? giteaBlockDevice = _undefined,
    Object? nextcloudBlockDevice = _undefined,
    Object? pleromaBlockDevice = _undefined,
  }) => _then(
    Input$MigrateToBindsInput._({
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
    }),
  );
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
  }) => _res;
}

class Input$MoveServiceInput {
  factory Input$MoveServiceInput({
    required String serviceId,
    required String location,
  }) => Input$MoveServiceInput._({
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
      CopyWith$Input$MoveServiceInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$MoveServiceInput || runtimeType != other.runtimeType) {
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
    return Object.hashAll([l$serviceId, l$location]);
  }
}

abstract class CopyWith$Input$MoveServiceInput<TRes> {
  factory CopyWith$Input$MoveServiceInput(
    Input$MoveServiceInput instance,
    TRes Function(Input$MoveServiceInput) then,
  ) = _CopyWithImpl$Input$MoveServiceInput;

  factory CopyWith$Input$MoveServiceInput.stub(TRes res) =
      _CopyWithStubImpl$Input$MoveServiceInput;

  TRes call({String? serviceId, String? location});
}

class _CopyWithImpl$Input$MoveServiceInput<TRes>
    implements CopyWith$Input$MoveServiceInput<TRes> {
  _CopyWithImpl$Input$MoveServiceInput(this._instance, this._then);

  final Input$MoveServiceInput _instance;

  final TRes Function(Input$MoveServiceInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? serviceId = _undefined, Object? location = _undefined}) =>
      _then(
        Input$MoveServiceInput._({
          ..._instance._$data,
          if (serviceId != _undefined && serviceId != null)
            'serviceId': (serviceId as String),
          if (location != _undefined && location != null)
            'location': (location as String),
        }),
      );
}

class _CopyWithStubImpl$Input$MoveServiceInput<TRes>
    implements CopyWith$Input$MoveServiceInput<TRes> {
  _CopyWithStubImpl$Input$MoveServiceInput(this._res);

  TRes _res;

  call({String? serviceId, String? location}) => _res;
}

class Input$RecoveryKeyLimitsInput {
  factory Input$RecoveryKeyLimitsInput({DateTime? expirationDate, int? uses}) =>
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
  get copyWith => CopyWith$Input$RecoveryKeyLimitsInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$RecoveryKeyLimitsInput ||
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

  TRes call({DateTime? expirationDate, int? uses});
}

class _CopyWithImpl$Input$RecoveryKeyLimitsInput<TRes>
    implements CopyWith$Input$RecoveryKeyLimitsInput<TRes> {
  _CopyWithImpl$Input$RecoveryKeyLimitsInput(this._instance, this._then);

  final Input$RecoveryKeyLimitsInput _instance;

  final TRes Function(Input$RecoveryKeyLimitsInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? expirationDate = _undefined, Object? uses = _undefined}) =>
      _then(
        Input$RecoveryKeyLimitsInput._({
          ..._instance._$data,
          if (expirationDate != _undefined)
            'expirationDate': (expirationDate as DateTime?),
          if (uses != _undefined) 'uses': (uses as int?),
        }),
      );
}

class _CopyWithStubImpl$Input$RecoveryKeyLimitsInput<TRes>
    implements CopyWith$Input$RecoveryKeyLimitsInput<TRes> {
  _CopyWithStubImpl$Input$RecoveryKeyLimitsInput(this._res);

  TRes _res;

  call({DateTime? expirationDate, int? uses}) => _res;
}

class Input$SSHSettingsInput {
  factory Input$SSHSettingsInput({
    required bool enable,
    bool? passwordAuthentication,
  }) => Input$SSHSettingsInput._({
    r'enable': enable,
    if (passwordAuthentication != null)
      r'passwordAuthentication': passwordAuthentication,
  });

  Input$SSHSettingsInput._(this._$data);

  factory Input$SSHSettingsInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$enable = data['enable'];
    result$data['enable'] = (l$enable as bool);
    if (data.containsKey('passwordAuthentication')) {
      final l$passwordAuthentication = data['passwordAuthentication'];
      result$data['passwordAuthentication'] =
          (l$passwordAuthentication as bool?);
    }
    return Input$SSHSettingsInput._(result$data);
  }

  Map<String, dynamic> _$data;

  bool get enable => (_$data['enable'] as bool);

  bool? get passwordAuthentication =>
      (_$data['passwordAuthentication'] as bool?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$enable = enable;
    result$data['enable'] = l$enable;
    if (_$data.containsKey('passwordAuthentication')) {
      final l$passwordAuthentication = passwordAuthentication;
      result$data['passwordAuthentication'] = l$passwordAuthentication;
    }
    return result$data;
  }

  CopyWith$Input$SSHSettingsInput<Input$SSHSettingsInput> get copyWith =>
      CopyWith$Input$SSHSettingsInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$SSHSettingsInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$enable = enable;
    final lOther$enable = other.enable;
    if (l$enable != lOther$enable) {
      return false;
    }
    final l$passwordAuthentication = passwordAuthentication;
    final lOther$passwordAuthentication = other.passwordAuthentication;
    if (_$data.containsKey('passwordAuthentication') !=
        other._$data.containsKey('passwordAuthentication')) {
      return false;
    }
    if (l$passwordAuthentication != lOther$passwordAuthentication) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$enable = enable;
    final l$passwordAuthentication = passwordAuthentication;
    return Object.hashAll([
      l$enable,
      _$data.containsKey('passwordAuthentication')
          ? l$passwordAuthentication
          : const {},
    ]);
  }
}

abstract class CopyWith$Input$SSHSettingsInput<TRes> {
  factory CopyWith$Input$SSHSettingsInput(
    Input$SSHSettingsInput instance,
    TRes Function(Input$SSHSettingsInput) then,
  ) = _CopyWithImpl$Input$SSHSettingsInput;

  factory CopyWith$Input$SSHSettingsInput.stub(TRes res) =
      _CopyWithStubImpl$Input$SSHSettingsInput;

  TRes call({bool? enable, bool? passwordAuthentication});
}

class _CopyWithImpl$Input$SSHSettingsInput<TRes>
    implements CopyWith$Input$SSHSettingsInput<TRes> {
  _CopyWithImpl$Input$SSHSettingsInput(this._instance, this._then);

  final Input$SSHSettingsInput _instance;

  final TRes Function(Input$SSHSettingsInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? enable = _undefined,
    Object? passwordAuthentication = _undefined,
  }) => _then(
    Input$SSHSettingsInput._({
      ..._instance._$data,
      if (enable != _undefined && enable != null) 'enable': (enable as bool),
      if (passwordAuthentication != _undefined)
        'passwordAuthentication': (passwordAuthentication as bool?),
    }),
  );
}

class _CopyWithStubImpl$Input$SSHSettingsInput<TRes>
    implements CopyWith$Input$SSHSettingsInput<TRes> {
  _CopyWithStubImpl$Input$SSHSettingsInput(this._res);

  TRes _res;

  call({bool? enable, bool? passwordAuthentication}) => _res;
}

class Input$SetDnsProviderInput {
  factory Input$SetDnsProviderInput({
    required Enum$DnsProvider provider,
    required String apiToken,
  }) => Input$SetDnsProviderInput._({
    r'provider': provider,
    r'apiToken': apiToken,
  });

  Input$SetDnsProviderInput._(this._$data);

  factory Input$SetDnsProviderInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$provider = data['provider'];
    result$data['provider'] = fromJson$Enum$DnsProvider((l$provider as String));
    final l$apiToken = data['apiToken'];
    result$data['apiToken'] = (l$apiToken as String);
    return Input$SetDnsProviderInput._(result$data);
  }

  Map<String, dynamic> _$data;

  Enum$DnsProvider get provider => (_$data['provider'] as Enum$DnsProvider);

  String get apiToken => (_$data['apiToken'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$provider = provider;
    result$data['provider'] = toJson$Enum$DnsProvider(l$provider);
    final l$apiToken = apiToken;
    result$data['apiToken'] = l$apiToken;
    return result$data;
  }

  CopyWith$Input$SetDnsProviderInput<Input$SetDnsProviderInput> get copyWith =>
      CopyWith$Input$SetDnsProviderInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$SetDnsProviderInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$provider = provider;
    final lOther$provider = other.provider;
    if (l$provider != lOther$provider) {
      return false;
    }
    final l$apiToken = apiToken;
    final lOther$apiToken = other.apiToken;
    if (l$apiToken != lOther$apiToken) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$provider = provider;
    final l$apiToken = apiToken;
    return Object.hashAll([l$provider, l$apiToken]);
  }
}

abstract class CopyWith$Input$SetDnsProviderInput<TRes> {
  factory CopyWith$Input$SetDnsProviderInput(
    Input$SetDnsProviderInput instance,
    TRes Function(Input$SetDnsProviderInput) then,
  ) = _CopyWithImpl$Input$SetDnsProviderInput;

  factory CopyWith$Input$SetDnsProviderInput.stub(TRes res) =
      _CopyWithStubImpl$Input$SetDnsProviderInput;

  TRes call({Enum$DnsProvider? provider, String? apiToken});
}

class _CopyWithImpl$Input$SetDnsProviderInput<TRes>
    implements CopyWith$Input$SetDnsProviderInput<TRes> {
  _CopyWithImpl$Input$SetDnsProviderInput(this._instance, this._then);

  final Input$SetDnsProviderInput _instance;

  final TRes Function(Input$SetDnsProviderInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? provider = _undefined, Object? apiToken = _undefined}) =>
      _then(
        Input$SetDnsProviderInput._({
          ..._instance._$data,
          if (provider != _undefined && provider != null)
            'provider': (provider as Enum$DnsProvider),
          if (apiToken != _undefined && apiToken != null)
            'apiToken': (apiToken as String),
        }),
      );
}

class _CopyWithStubImpl$Input$SetDnsProviderInput<TRes>
    implements CopyWith$Input$SetDnsProviderInput<TRes> {
  _CopyWithStubImpl$Input$SetDnsProviderInput(this._res);

  TRes _res;

  call({Enum$DnsProvider? provider, String? apiToken}) => _res;
}

class Input$SetServiceConfigurationInput {
  factory Input$SetServiceConfigurationInput({
    required String serviceId,
    required Map<String, dynamic> configuration,
  }) => Input$SetServiceConfigurationInput._({
    r'serviceId': serviceId,
    r'configuration': configuration,
  });

  Input$SetServiceConfigurationInput._(this._$data);

  factory Input$SetServiceConfigurationInput.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$serviceId = data['serviceId'];
    result$data['serviceId'] = (l$serviceId as String);
    final l$configuration = data['configuration'];
    result$data['configuration'] = (l$configuration as Map<String, dynamic>);
    return Input$SetServiceConfigurationInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get serviceId => (_$data['serviceId'] as String);

  Map<String, dynamic> get configuration =>
      (_$data['configuration'] as Map<String, dynamic>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$serviceId = serviceId;
    result$data['serviceId'] = l$serviceId;
    final l$configuration = configuration;
    result$data['configuration'] = l$configuration;
    return result$data;
  }

  CopyWith$Input$SetServiceConfigurationInput<
    Input$SetServiceConfigurationInput
  >
  get copyWith => CopyWith$Input$SetServiceConfigurationInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$SetServiceConfigurationInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$serviceId = serviceId;
    final lOther$serviceId = other.serviceId;
    if (l$serviceId != lOther$serviceId) {
      return false;
    }
    final l$configuration = configuration;
    final lOther$configuration = other.configuration;
    if (l$configuration != lOther$configuration) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$serviceId = serviceId;
    final l$configuration = configuration;
    return Object.hashAll([l$serviceId, l$configuration]);
  }
}

abstract class CopyWith$Input$SetServiceConfigurationInput<TRes> {
  factory CopyWith$Input$SetServiceConfigurationInput(
    Input$SetServiceConfigurationInput instance,
    TRes Function(Input$SetServiceConfigurationInput) then,
  ) = _CopyWithImpl$Input$SetServiceConfigurationInput;

  factory CopyWith$Input$SetServiceConfigurationInput.stub(TRes res) =
      _CopyWithStubImpl$Input$SetServiceConfigurationInput;

  TRes call({String? serviceId, Map<String, dynamic>? configuration});
}

class _CopyWithImpl$Input$SetServiceConfigurationInput<TRes>
    implements CopyWith$Input$SetServiceConfigurationInput<TRes> {
  _CopyWithImpl$Input$SetServiceConfigurationInput(this._instance, this._then);

  final Input$SetServiceConfigurationInput _instance;

  final TRes Function(Input$SetServiceConfigurationInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? serviceId = _undefined,
    Object? configuration = _undefined,
  }) => _then(
    Input$SetServiceConfigurationInput._({
      ..._instance._$data,
      if (serviceId != _undefined && serviceId != null)
        'serviceId': (serviceId as String),
      if (configuration != _undefined && configuration != null)
        'configuration': (configuration as Map<String, dynamic>),
    }),
  );
}

class _CopyWithStubImpl$Input$SetServiceConfigurationInput<TRes>
    implements CopyWith$Input$SetServiceConfigurationInput<TRes> {
  _CopyWithStubImpl$Input$SetServiceConfigurationInput(this._res);

  TRes _res;

  call({String? serviceId, Map<String, dynamic>? configuration}) => _res;
}

class Input$SshMutationInput {
  factory Input$SshMutationInput({
    required String username,
    required String sshKey,
  }) => Input$SshMutationInput._({r'username': username, r'sshKey': sshKey});

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
      CopyWith$Input$SshMutationInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$SshMutationInput || runtimeType != other.runtimeType) {
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
    return Object.hashAll([l$username, l$sshKey]);
  }
}

abstract class CopyWith$Input$SshMutationInput<TRes> {
  factory CopyWith$Input$SshMutationInput(
    Input$SshMutationInput instance,
    TRes Function(Input$SshMutationInput) then,
  ) = _CopyWithImpl$Input$SshMutationInput;

  factory CopyWith$Input$SshMutationInput.stub(TRes res) =
      _CopyWithStubImpl$Input$SshMutationInput;

  TRes call({String? username, String? sshKey});
}

class _CopyWithImpl$Input$SshMutationInput<TRes>
    implements CopyWith$Input$SshMutationInput<TRes> {
  _CopyWithImpl$Input$SshMutationInput(this._instance, this._then);

  final Input$SshMutationInput _instance;

  final TRes Function(Input$SshMutationInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? username = _undefined, Object? sshKey = _undefined}) =>
      _then(
        Input$SshMutationInput._({
          ..._instance._$data,
          if (username != _undefined && username != null)
            'username': (username as String),
          if (sshKey != _undefined && sshKey != null)
            'sshKey': (sshKey as String),
        }),
      );
}

class _CopyWithStubImpl$Input$SshMutationInput<TRes>
    implements CopyWith$Input$SshMutationInput<TRes> {
  _CopyWithStubImpl$Input$SshMutationInput(this._res);

  TRes _res;

  call({String? username, String? sshKey}) => _res;
}

class Input$UseNewDeviceKeyInput {
  factory Input$UseNewDeviceKeyInput({
    required String key,
    required String deviceName,
  }) => Input$UseNewDeviceKeyInput._({r'key': key, r'deviceName': deviceName});

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
  get copyWith => CopyWith$Input$UseNewDeviceKeyInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$UseNewDeviceKeyInput ||
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
    return Object.hashAll([l$key, l$deviceName]);
  }
}

abstract class CopyWith$Input$UseNewDeviceKeyInput<TRes> {
  factory CopyWith$Input$UseNewDeviceKeyInput(
    Input$UseNewDeviceKeyInput instance,
    TRes Function(Input$UseNewDeviceKeyInput) then,
  ) = _CopyWithImpl$Input$UseNewDeviceKeyInput;

  factory CopyWith$Input$UseNewDeviceKeyInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UseNewDeviceKeyInput;

  TRes call({String? key, String? deviceName});
}

class _CopyWithImpl$Input$UseNewDeviceKeyInput<TRes>
    implements CopyWith$Input$UseNewDeviceKeyInput<TRes> {
  _CopyWithImpl$Input$UseNewDeviceKeyInput(this._instance, this._then);

  final Input$UseNewDeviceKeyInput _instance;

  final TRes Function(Input$UseNewDeviceKeyInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? key = _undefined, Object? deviceName = _undefined}) =>
      _then(
        Input$UseNewDeviceKeyInput._({
          ..._instance._$data,
          if (key != _undefined && key != null) 'key': (key as String),
          if (deviceName != _undefined && deviceName != null)
            'deviceName': (deviceName as String),
        }),
      );
}

class _CopyWithStubImpl$Input$UseNewDeviceKeyInput<TRes>
    implements CopyWith$Input$UseNewDeviceKeyInput<TRes> {
  _CopyWithStubImpl$Input$UseNewDeviceKeyInput(this._res);

  TRes _res;

  call({String? key, String? deviceName}) => _res;
}

class Input$UseRecoveryKeyInput {
  factory Input$UseRecoveryKeyInput({
    required String key,
    required String deviceName,
  }) => Input$UseRecoveryKeyInput._({r'key': key, r'deviceName': deviceName});

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
      CopyWith$Input$UseRecoveryKeyInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$UseRecoveryKeyInput ||
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
    return Object.hashAll([l$key, l$deviceName]);
  }
}

abstract class CopyWith$Input$UseRecoveryKeyInput<TRes> {
  factory CopyWith$Input$UseRecoveryKeyInput(
    Input$UseRecoveryKeyInput instance,
    TRes Function(Input$UseRecoveryKeyInput) then,
  ) = _CopyWithImpl$Input$UseRecoveryKeyInput;

  factory CopyWith$Input$UseRecoveryKeyInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UseRecoveryKeyInput;

  TRes call({String? key, String? deviceName});
}

class _CopyWithImpl$Input$UseRecoveryKeyInput<TRes>
    implements CopyWith$Input$UseRecoveryKeyInput<TRes> {
  _CopyWithImpl$Input$UseRecoveryKeyInput(this._instance, this._then);

  final Input$UseRecoveryKeyInput _instance;

  final TRes Function(Input$UseRecoveryKeyInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? key = _undefined, Object? deviceName = _undefined}) =>
      _then(
        Input$UseRecoveryKeyInput._({
          ..._instance._$data,
          if (key != _undefined && key != null) 'key': (key as String),
          if (deviceName != _undefined && deviceName != null)
            'deviceName': (deviceName as String),
        }),
      );
}

class _CopyWithStubImpl$Input$UseRecoveryKeyInput<TRes>
    implements CopyWith$Input$UseRecoveryKeyInput<TRes> {
  _CopyWithStubImpl$Input$UseRecoveryKeyInput(this._res);

  TRes _res;

  call({String? key, String? deviceName}) => _res;
}

class Input$UserMutationInput {
  factory Input$UserMutationInput({
    required String username,
    List<String>? directmemberof,
    String? password,
    String? displayName,
  }) => Input$UserMutationInput._({
    r'username': username,
    if (directmemberof != null) r'directmemberof': directmemberof,
    if (password != null) r'password': password,
    if (displayName != null) r'displayName': displayName,
  });

  Input$UserMutationInput._(this._$data);

  factory Input$UserMutationInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$username = data['username'];
    result$data['username'] = (l$username as String);
    if (data.containsKey('directmemberof')) {
      final l$directmemberof = data['directmemberof'];
      result$data['directmemberof'] =
          (l$directmemberof as List<dynamic>?)
              ?.map((e) => (e as String))
              .toList();
    }
    if (data.containsKey('password')) {
      final l$password = data['password'];
      result$data['password'] = (l$password as String?);
    }
    if (data.containsKey('displayName')) {
      final l$displayName = data['displayName'];
      result$data['displayName'] = (l$displayName as String?);
    }
    return Input$UserMutationInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get username => (_$data['username'] as String);

  List<String>? get directmemberof =>
      (_$data['directmemberof'] as List<String>?);

  String? get password => (_$data['password'] as String?);

  String? get displayName => (_$data['displayName'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$username = username;
    result$data['username'] = l$username;
    if (_$data.containsKey('directmemberof')) {
      final l$directmemberof = directmemberof;
      result$data['directmemberof'] = l$directmemberof?.map((e) => e).toList();
    }
    if (_$data.containsKey('password')) {
      final l$password = password;
      result$data['password'] = l$password;
    }
    if (_$data.containsKey('displayName')) {
      final l$displayName = displayName;
      result$data['displayName'] = l$displayName;
    }
    return result$data;
  }

  CopyWith$Input$UserMutationInput<Input$UserMutationInput> get copyWith =>
      CopyWith$Input$UserMutationInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$UserMutationInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) {
      return false;
    }
    final l$directmemberof = directmemberof;
    final lOther$directmemberof = other.directmemberof;
    if (_$data.containsKey('directmemberof') !=
        other._$data.containsKey('directmemberof')) {
      return false;
    }
    if (l$directmemberof != null && lOther$directmemberof != null) {
      if (l$directmemberof.length != lOther$directmemberof.length) {
        return false;
      }
      for (int i = 0; i < l$directmemberof.length; i++) {
        final l$directmemberof$entry = l$directmemberof[i];
        final lOther$directmemberof$entry = lOther$directmemberof[i];
        if (l$directmemberof$entry != lOther$directmemberof$entry) {
          return false;
        }
      }
    } else if (l$directmemberof != lOther$directmemberof) {
      return false;
    }
    final l$password = password;
    final lOther$password = other.password;
    if (_$data.containsKey('password') !=
        other._$data.containsKey('password')) {
      return false;
    }
    if (l$password != lOther$password) {
      return false;
    }
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (_$data.containsKey('displayName') !=
        other._$data.containsKey('displayName')) {
      return false;
    }
    if (l$displayName != lOther$displayName) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$username = username;
    final l$directmemberof = directmemberof;
    final l$password = password;
    final l$displayName = displayName;
    return Object.hashAll([
      l$username,
      _$data.containsKey('directmemberof')
          ? l$directmemberof == null
              ? null
              : Object.hashAll(l$directmemberof.map((v) => v))
          : const {},
      _$data.containsKey('password') ? l$password : const {},
      _$data.containsKey('displayName') ? l$displayName : const {},
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
    List<String>? directmemberof,
    String? password,
    String? displayName,
  });
}

class _CopyWithImpl$Input$UserMutationInput<TRes>
    implements CopyWith$Input$UserMutationInput<TRes> {
  _CopyWithImpl$Input$UserMutationInput(this._instance, this._then);

  final Input$UserMutationInput _instance;

  final TRes Function(Input$UserMutationInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? username = _undefined,
    Object? directmemberof = _undefined,
    Object? password = _undefined,
    Object? displayName = _undefined,
  }) => _then(
    Input$UserMutationInput._({
      ..._instance._$data,
      if (username != _undefined && username != null)
        'username': (username as String),
      if (directmemberof != _undefined)
        'directmemberof': (directmemberof as List<String>?),
      if (password != _undefined) 'password': (password as String?),
      if (displayName != _undefined) 'displayName': (displayName as String?),
    }),
  );
}

class _CopyWithStubImpl$Input$UserMutationInput<TRes>
    implements CopyWith$Input$UserMutationInput<TRes> {
  _CopyWithStubImpl$Input$UserMutationInput(this._res);

  TRes _res;

  call({
    String? username,
    List<String>? directmemberof,
    String? password,
    String? displayName,
  }) => _res;
}

enum Enum$BackupProvider {
  BACKBLAZE,
  NONE,
  MEMORY,
  FILE,
  $unknown;

  factory Enum$BackupProvider.fromJson(String value) =>
      fromJson$Enum$BackupProvider(value);

  String toJson() => toJson$Enum$BackupProvider(this);
}

String toJson$Enum$BackupProvider(Enum$BackupProvider e) {
  switch (e) {
    case Enum$BackupProvider.BACKBLAZE:
      return r'BACKBLAZE';
    case Enum$BackupProvider.NONE:
      return r'NONE';
    case Enum$BackupProvider.MEMORY:
      return r'MEMORY';
    case Enum$BackupProvider.FILE:
      return r'FILE';
    case Enum$BackupProvider.$unknown:
      return r'$unknown';
  }
}

Enum$BackupProvider fromJson$Enum$BackupProvider(String value) {
  switch (value) {
    case r'BACKBLAZE':
      return Enum$BackupProvider.BACKBLAZE;
    case r'NONE':
      return Enum$BackupProvider.NONE;
    case r'MEMORY':
      return Enum$BackupProvider.MEMORY;
    case r'FILE':
      return Enum$BackupProvider.FILE;
    default:
      return Enum$BackupProvider.$unknown;
  }
}

enum Enum$BackupReason {
  EXPLICIT,
  AUTO,
  PRE_RESTORE,
  $unknown;

  factory Enum$BackupReason.fromJson(String value) =>
      fromJson$Enum$BackupReason(value);

  String toJson() => toJson$Enum$BackupReason(this);
}

String toJson$Enum$BackupReason(Enum$BackupReason e) {
  switch (e) {
    case Enum$BackupReason.EXPLICIT:
      return r'EXPLICIT';
    case Enum$BackupReason.AUTO:
      return r'AUTO';
    case Enum$BackupReason.PRE_RESTORE:
      return r'PRE_RESTORE';
    case Enum$BackupReason.$unknown:
      return r'$unknown';
  }
}

Enum$BackupReason fromJson$Enum$BackupReason(String value) {
  switch (value) {
    case r'EXPLICIT':
      return Enum$BackupReason.EXPLICIT;
    case r'AUTO':
      return Enum$BackupReason.AUTO;
    case r'PRE_RESTORE':
      return Enum$BackupReason.PRE_RESTORE;
    default:
      return Enum$BackupReason.$unknown;
  }
}

enum Enum$DnsProvider {
  CLOUDFLARE,
  DIGITALOCEAN,
  DESEC,
  $unknown;

  factory Enum$DnsProvider.fromJson(String value) =>
      fromJson$Enum$DnsProvider(value);

  String toJson() => toJson$Enum$DnsProvider(this);
}

String toJson$Enum$DnsProvider(Enum$DnsProvider e) {
  switch (e) {
    case Enum$DnsProvider.CLOUDFLARE:
      return r'CLOUDFLARE';
    case Enum$DnsProvider.DIGITALOCEAN:
      return r'DIGITALOCEAN';
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
    case r'DIGITALOCEAN':
      return Enum$DnsProvider.DIGITALOCEAN;
    case r'DESEC':
      return Enum$DnsProvider.DESEC;
    default:
      return Enum$DnsProvider.$unknown;
  }
}

enum Enum$RestoreStrategy {
  INPLACE,
  DOWNLOAD_VERIFY_OVERWRITE,
  $unknown;

  factory Enum$RestoreStrategy.fromJson(String value) =>
      fromJson$Enum$RestoreStrategy(value);

  String toJson() => toJson$Enum$RestoreStrategy(this);
}

String toJson$Enum$RestoreStrategy(Enum$RestoreStrategy e) {
  switch (e) {
    case Enum$RestoreStrategy.INPLACE:
      return r'INPLACE';
    case Enum$RestoreStrategy.DOWNLOAD_VERIFY_OVERWRITE:
      return r'DOWNLOAD_VERIFY_OVERWRITE';
    case Enum$RestoreStrategy.$unknown:
      return r'$unknown';
  }
}

Enum$RestoreStrategy fromJson$Enum$RestoreStrategy(String value) {
  switch (value) {
    case r'INPLACE':
      return Enum$RestoreStrategy.INPLACE;
    case r'DOWNLOAD_VERIFY_OVERWRITE':
      return Enum$RestoreStrategy.DOWNLOAD_VERIFY_OVERWRITE;
    default:
      return Enum$RestoreStrategy.$unknown;
  }
}

enum Enum$ServerProvider {
  HETZNER,
  DIGITALOCEAN,
  OTHER,
  $unknown;

  factory Enum$ServerProvider.fromJson(String value) =>
      fromJson$Enum$ServerProvider(value);

  String toJson() => toJson$Enum$ServerProvider(this);
}

String toJson$Enum$ServerProvider(Enum$ServerProvider e) {
  switch (e) {
    case Enum$ServerProvider.HETZNER:
      return r'HETZNER';
    case Enum$ServerProvider.DIGITALOCEAN:
      return r'DIGITALOCEAN';
    case Enum$ServerProvider.OTHER:
      return r'OTHER';
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
    case r'OTHER':
      return Enum$ServerProvider.OTHER;
    default:
      return Enum$ServerProvider.$unknown;
  }
}

enum Enum$ServiceStatusEnum {
  ACTIVE,
  RELOADING,
  INACTIVE,
  FAILED,
  ACTIVATING,
  DEACTIVATING,
  OFF,
  $unknown;

  factory Enum$ServiceStatusEnum.fromJson(String value) =>
      fromJson$Enum$ServiceStatusEnum(value);

  String toJson() => toJson$Enum$ServiceStatusEnum(this);
}

String toJson$Enum$ServiceStatusEnum(Enum$ServiceStatusEnum e) {
  switch (e) {
    case Enum$ServiceStatusEnum.ACTIVE:
      return r'ACTIVE';
    case Enum$ServiceStatusEnum.RELOADING:
      return r'RELOADING';
    case Enum$ServiceStatusEnum.INACTIVE:
      return r'INACTIVE';
    case Enum$ServiceStatusEnum.FAILED:
      return r'FAILED';
    case Enum$ServiceStatusEnum.ACTIVATING:
      return r'ACTIVATING';
    case Enum$ServiceStatusEnum.DEACTIVATING:
      return r'DEACTIVATING';
    case Enum$ServiceStatusEnum.OFF:
      return r'OFF';
    case Enum$ServiceStatusEnum.$unknown:
      return r'$unknown';
  }
}

Enum$ServiceStatusEnum fromJson$Enum$ServiceStatusEnum(String value) {
  switch (value) {
    case r'ACTIVE':
      return Enum$ServiceStatusEnum.ACTIVE;
    case r'RELOADING':
      return Enum$ServiceStatusEnum.RELOADING;
    case r'INACTIVE':
      return Enum$ServiceStatusEnum.INACTIVE;
    case r'FAILED':
      return Enum$ServiceStatusEnum.FAILED;
    case r'ACTIVATING':
      return Enum$ServiceStatusEnum.ACTIVATING;
    case r'DEACTIVATING':
      return Enum$ServiceStatusEnum.DEACTIVATING;
    case r'OFF':
      return Enum$ServiceStatusEnum.OFF;
    default:
      return Enum$ServiceStatusEnum.$unknown;
  }
}

enum Enum$Severity {
  INFO,
  WARNING,
  ERROR,
  CRITICAL,
  SUCCESS,
  $unknown;

  factory Enum$Severity.fromJson(String value) => fromJson$Enum$Severity(value);

  String toJson() => toJson$Enum$Severity(this);
}

String toJson$Enum$Severity(Enum$Severity e) {
  switch (e) {
    case Enum$Severity.INFO:
      return r'INFO';
    case Enum$Severity.WARNING:
      return r'WARNING';
    case Enum$Severity.ERROR:
      return r'ERROR';
    case Enum$Severity.CRITICAL:
      return r'CRITICAL';
    case Enum$Severity.SUCCESS:
      return r'SUCCESS';
    case Enum$Severity.$unknown:
      return r'$unknown';
  }
}

Enum$Severity fromJson$Enum$Severity(String value) {
  switch (value) {
    case r'INFO':
      return Enum$Severity.INFO;
    case r'WARNING':
      return Enum$Severity.WARNING;
    case r'ERROR':
      return Enum$Severity.ERROR;
    case r'CRITICAL':
      return Enum$Severity.CRITICAL;
    case r'SUCCESS':
      return Enum$Severity.SUCCESS;
    default:
      return Enum$Severity.$unknown;
  }
}

enum Enum$SupportLevelEnum {
  NORMAL,
  EXPERIMENTAL,
  DEPRECATED,
  COMMUNITY,
  UNKNOWN,
  $unknown;

  factory Enum$SupportLevelEnum.fromJson(String value) =>
      fromJson$Enum$SupportLevelEnum(value);

  String toJson() => toJson$Enum$SupportLevelEnum(this);
}

String toJson$Enum$SupportLevelEnum(Enum$SupportLevelEnum e) {
  switch (e) {
    case Enum$SupportLevelEnum.NORMAL:
      return r'NORMAL';
    case Enum$SupportLevelEnum.EXPERIMENTAL:
      return r'EXPERIMENTAL';
    case Enum$SupportLevelEnum.DEPRECATED:
      return r'DEPRECATED';
    case Enum$SupportLevelEnum.COMMUNITY:
      return r'COMMUNITY';
    case Enum$SupportLevelEnum.UNKNOWN:
      return r'UNKNOWN';
    case Enum$SupportLevelEnum.$unknown:
      return r'$unknown';
  }
}

Enum$SupportLevelEnum fromJson$Enum$SupportLevelEnum(String value) {
  switch (value) {
    case r'NORMAL':
      return Enum$SupportLevelEnum.NORMAL;
    case r'EXPERIMENTAL':
      return Enum$SupportLevelEnum.EXPERIMENTAL;
    case r'DEPRECATED':
      return Enum$SupportLevelEnum.DEPRECATED;
    case r'COMMUNITY':
      return Enum$SupportLevelEnum.COMMUNITY;
    case r'UNKNOWN':
      return Enum$SupportLevelEnum.UNKNOWN;
    default:
      return Enum$SupportLevelEnum.$unknown;
  }
}

enum Enum$UserType {
  NORMAL,
  PRIMARY,
  ROOT,
  $unknown;

  factory Enum$UserType.fromJson(String value) => fromJson$Enum$UserType(value);

  String toJson() => toJson$Enum$UserType(this);
}

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

enum Enum$__TypeKind {
  SCALAR,
  OBJECT,
  INTERFACE,
  UNION,
  ENUM,
  INPUT_OBJECT,
  LIST,
  NON_NULL,
  $unknown;

  factory Enum$__TypeKind.fromJson(String value) =>
      fromJson$Enum$__TypeKind(value);

  String toJson() => toJson$Enum$__TypeKind(this);
}

String toJson$Enum$__TypeKind(Enum$__TypeKind e) {
  switch (e) {
    case Enum$__TypeKind.SCALAR:
      return r'SCALAR';
    case Enum$__TypeKind.OBJECT:
      return r'OBJECT';
    case Enum$__TypeKind.INTERFACE:
      return r'INTERFACE';
    case Enum$__TypeKind.UNION:
      return r'UNION';
    case Enum$__TypeKind.ENUM:
      return r'ENUM';
    case Enum$__TypeKind.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__TypeKind.LIST:
      return r'LIST';
    case Enum$__TypeKind.NON_NULL:
      return r'NON_NULL';
    case Enum$__TypeKind.$unknown:
      return r'$unknown';
  }
}

Enum$__TypeKind fromJson$Enum$__TypeKind(String value) {
  switch (value) {
    case r'SCALAR':
      return Enum$__TypeKind.SCALAR;
    case r'OBJECT':
      return Enum$__TypeKind.OBJECT;
    case r'INTERFACE':
      return Enum$__TypeKind.INTERFACE;
    case r'UNION':
      return Enum$__TypeKind.UNION;
    case r'ENUM':
      return Enum$__TypeKind.ENUM;
    case r'INPUT_OBJECT':
      return Enum$__TypeKind.INPUT_OBJECT;
    case r'LIST':
      return Enum$__TypeKind.LIST;
    case r'NON_NULL':
      return Enum$__TypeKind.NON_NULL;
    default:
      return Enum$__TypeKind.$unknown;
  }
}

enum Enum$__DirectiveLocation {
  QUERY,
  MUTATION,
  SUBSCRIPTION,
  FIELD,
  FRAGMENT_DEFINITION,
  FRAGMENT_SPREAD,
  INLINE_FRAGMENT,
  VARIABLE_DEFINITION,
  SCHEMA,
  SCALAR,
  OBJECT,
  FIELD_DEFINITION,
  ARGUMENT_DEFINITION,
  INTERFACE,
  UNION,
  ENUM,
  ENUM_VALUE,
  INPUT_OBJECT,
  INPUT_FIELD_DEFINITION,
  $unknown;

  factory Enum$__DirectiveLocation.fromJson(String value) =>
      fromJson$Enum$__DirectiveLocation(value);

  String toJson() => toJson$Enum$__DirectiveLocation(this);
}

String toJson$Enum$__DirectiveLocation(Enum$__DirectiveLocation e) {
  switch (e) {
    case Enum$__DirectiveLocation.QUERY:
      return r'QUERY';
    case Enum$__DirectiveLocation.MUTATION:
      return r'MUTATION';
    case Enum$__DirectiveLocation.SUBSCRIPTION:
      return r'SUBSCRIPTION';
    case Enum$__DirectiveLocation.FIELD:
      return r'FIELD';
    case Enum$__DirectiveLocation.FRAGMENT_DEFINITION:
      return r'FRAGMENT_DEFINITION';
    case Enum$__DirectiveLocation.FRAGMENT_SPREAD:
      return r'FRAGMENT_SPREAD';
    case Enum$__DirectiveLocation.INLINE_FRAGMENT:
      return r'INLINE_FRAGMENT';
    case Enum$__DirectiveLocation.VARIABLE_DEFINITION:
      return r'VARIABLE_DEFINITION';
    case Enum$__DirectiveLocation.SCHEMA:
      return r'SCHEMA';
    case Enum$__DirectiveLocation.SCALAR:
      return r'SCALAR';
    case Enum$__DirectiveLocation.OBJECT:
      return r'OBJECT';
    case Enum$__DirectiveLocation.FIELD_DEFINITION:
      return r'FIELD_DEFINITION';
    case Enum$__DirectiveLocation.ARGUMENT_DEFINITION:
      return r'ARGUMENT_DEFINITION';
    case Enum$__DirectiveLocation.INTERFACE:
      return r'INTERFACE';
    case Enum$__DirectiveLocation.UNION:
      return r'UNION';
    case Enum$__DirectiveLocation.ENUM:
      return r'ENUM';
    case Enum$__DirectiveLocation.ENUM_VALUE:
      return r'ENUM_VALUE';
    case Enum$__DirectiveLocation.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION:
      return r'INPUT_FIELD_DEFINITION';
    case Enum$__DirectiveLocation.$unknown:
      return r'$unknown';
  }
}

Enum$__DirectiveLocation fromJson$Enum$__DirectiveLocation(String value) {
  switch (value) {
    case r'QUERY':
      return Enum$__DirectiveLocation.QUERY;
    case r'MUTATION':
      return Enum$__DirectiveLocation.MUTATION;
    case r'SUBSCRIPTION':
      return Enum$__DirectiveLocation.SUBSCRIPTION;
    case r'FIELD':
      return Enum$__DirectiveLocation.FIELD;
    case r'FRAGMENT_DEFINITION':
      return Enum$__DirectiveLocation.FRAGMENT_DEFINITION;
    case r'FRAGMENT_SPREAD':
      return Enum$__DirectiveLocation.FRAGMENT_SPREAD;
    case r'INLINE_FRAGMENT':
      return Enum$__DirectiveLocation.INLINE_FRAGMENT;
    case r'VARIABLE_DEFINITION':
      return Enum$__DirectiveLocation.VARIABLE_DEFINITION;
    case r'SCHEMA':
      return Enum$__DirectiveLocation.SCHEMA;
    case r'SCALAR':
      return Enum$__DirectiveLocation.SCALAR;
    case r'OBJECT':
      return Enum$__DirectiveLocation.OBJECT;
    case r'FIELD_DEFINITION':
      return Enum$__DirectiveLocation.FIELD_DEFINITION;
    case r'ARGUMENT_DEFINITION':
      return Enum$__DirectiveLocation.ARGUMENT_DEFINITION;
    case r'INTERFACE':
      return Enum$__DirectiveLocation.INTERFACE;
    case r'UNION':
      return Enum$__DirectiveLocation.UNION;
    case r'ENUM':
      return Enum$__DirectiveLocation.ENUM;
    case r'ENUM_VALUE':
      return Enum$__DirectiveLocation.ENUM_VALUE;
    case r'INPUT_OBJECT':
      return Enum$__DirectiveLocation.INPUT_OBJECT;
    case r'INPUT_FIELD_DEFINITION':
      return Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION;
    default:
      return Enum$__DirectiveLocation.$unknown;
  }
}

const possibleTypesMap = <String, Set<String>>{
  'MutationReturnInterface': {
    'ApiKeyMutationReturn',
    'AutoUpgradeSettingsMutationReturn',
    'DeviceApiTokenMutationReturn',
    'GenericBackupConfigReturn',
    'GenericJobMutationReturn',
    'GenericMutationReturn',
    'PasswordResetLinkReturn',
    'SSHSettingsMutationReturn',
    'ServiceJobMutationReturn',
    'ServiceMutationReturn',
    'TimezoneMutationReturn',
    'UserMutationReturn',
  },
  'ConfigItem': {'BoolConfigItem', 'EnumConfigItem', 'StringConfigItem'},
  'MonitoringMetricsResult': {'MonitoringMetrics', 'MonitoringQueryError'},
  'MonitoringValuesResult': {'MonitoringValues', 'MonitoringQueryError'},
  'StorageUsageInterface': {'ServiceStorageUsage'},
};
