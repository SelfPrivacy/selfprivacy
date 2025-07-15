part of '../server_installation/server_installation_cubit.dart';

abstract class ServerInstallationState extends Equatable {
  const ServerInstallationState({
    required this.providerApiToken,
    required this.serverTypeIdentificator,
    required this.dnsApiToken,
    required this.backblazeCredential,
    required this.serverDomain,
    required this.rootUser,
    required this.serverDetails,
    required this.isServerStarted,
    required this.isServerResetedFirstTime,
    required this.isServerResetedSecondTime,
    required this.installationDialoguePopUp,
    required this.serverLocation,
  });

  @override
  List<Object?> get props => [
    providerApiToken,
    serverTypeIdentificator,
    dnsApiToken,
    backblazeCredential,
    serverDomain,
    rootUser,
    serverDetails,
    isServerStarted,
    isServerResetedFirstTime,
    installationDialoguePopUp,
    serverLocation,
  ];

  final String? providerApiToken;
  final String? dnsApiToken;
  final String? serverTypeIdentificator;
  final String? serverLocation;
  final BackupsCredential? backblazeCredential;
  final ServerDomain? serverDomain;
  final User? rootUser;
  final ServerHostingDetails? serverDetails;
  final bool isServerStarted;
  final bool isServerResetedFirstTime;
  final bool isServerResetedSecondTime;
  final CallbackDialogueBranching? installationDialoguePopUp;

  bool get isServerProviderApiKeyFilled => providerApiToken != null;
  bool get isServerTypeFilled => serverTypeIdentificator != null;
  bool get isDnsProviderFilled => dnsApiToken != null;
  bool get isBackupsProviderFilled => backblazeCredential != null;
  bool get isDomainSelected => serverDomain != null;
  bool get isPrimaryUserFilled => rootUser != null;
  bool get isServerCreated => serverDetails != null;

  bool get isFullyInitialized =>
      _fulfillmentList.every((final el) => el ?? false);
  ServerSetupProgress get progress =>
      ServerSetupProgress.values[_fulfillmentList
          .where((final el) => el!)
          .length];

  int get progressBar {
    if (progress.index < 6) {
      return progress.index;
    } else if (progress.index < 10) {
      return 6;
    } else {
      return 7;
    }
  }

  List<bool?> get _fulfillmentList {
    final List<bool> res = [
      isServerProviderApiKeyFilled,
      isServerTypeFilled,
      isDnsProviderFilled,
      isBackupsProviderFilled,
      isDomainSelected,
      isPrimaryUserFilled,
      isServerCreated,
      isServerStarted,
      isServerResetedFirstTime,
      isServerResetedSecondTime,
    ];

    return res;
  }
}

class TimerState extends ServerInstallationNotFinished {
  TimerState({
    required this.dataState,
    required super.isLoading,
    this.timerStart,
    this.duration,
  }) : super(
         providerApiToken: dataState.providerApiToken,
         serverTypeIdentificator: dataState.serverTypeIdentificator,
         serverLocation: dataState.serverLocation,
         dnsApiToken: dataState.dnsApiToken,
         backblazeCredential: dataState.backblazeCredential,
         serverDomain: dataState.serverDomain,
         rootUser: dataState.rootUser,
         serverDetails: dataState.serverDetails,
         isServerStarted: dataState.isServerStarted,
         isServerResetedFirstTime: dataState.isServerResetedFirstTime,
         isServerResetedSecondTime: dataState.isServerResetedSecondTime,
         dnsMatches: dataState.dnsMatches,
         installationDialoguePopUp: dataState.installationDialoguePopUp,
         customSshKey: dataState.customSshKey,
       );

  final ServerInstallationNotFinished dataState;
  final DateTime? timerStart;
  final Duration? duration;

  @override
  List<Object?> get props => [dataState, timerStart, duration];
}

enum ServerSetupProgress {
  nothingYet,
  serverProviderFilled,
  serverTypeFilled,
  dnsProviderFilled,
  backblazeFilled,
  domainFilled,
  userFilled,
  serverCreated,
  serverStarted,
  serverResetedFirstTime,
  serverResetedSecondTime,
}

class ServerInstallationNotFinished extends ServerInstallationState {
  const ServerInstallationNotFinished({
    required super.isServerStarted,
    required super.isServerResetedFirstTime,
    required super.isServerResetedSecondTime,
    required this.isLoading,
    required this.dnsMatches,
    required this.customSshKey,
    super.providerApiToken,
    super.serverLocation,
    super.serverTypeIdentificator,
    super.dnsApiToken,
    super.backblazeCredential,
    super.serverDomain,
    super.rootUser,
    super.serverDetails,
    super.installationDialoguePopUp,
  });

  ServerInstallationNotFinished.fromWizardData(
    final ServerInstallationWizardData data,
  ) : this(
        providerApiToken: data.serverProviderKey,
        dnsApiToken: data.dnsProviderKey,
        serverDomain: data.serverDomain,
        serverTypeIdentificator: data.serverTypeIdentifier,
        serverLocation: data.serverLocation,
        backblazeCredential: data.backupsCredential,
        serverDetails: data.serverDetails,
        rootUser: data.rootUser,
        isServerStarted: data.isServerStarted,
        isServerResetedFirstTime: data.isServerResetedFirstTime,
        isServerResetedSecondTime: data.isServerResetedSecondTime,
        isLoading: data.isLoading,
        dnsMatches: null,
        customSshKey: null,
        installationDialoguePopUp: null,
      );

  final bool isLoading;
  final Map<String, DnsRecordStatus>? dnsMatches;
  final String? customSshKey;

  @override
  List<Object?> get props => [
    providerApiToken,
    serverTypeIdentificator,
    serverLocation,
    dnsApiToken,
    backblazeCredential,
    serverDomain,
    rootUser,
    serverDetails,
    isServerStarted,
    isServerResetedFirstTime,
    isLoading,
    dnsMatches,
    customSshKey,
    installationDialoguePopUp,
  ];

  ServerInstallationNotFinished copyWith({
    final String? providerApiToken,
    final String? serverLocation,
    final String? serverTypeIdentificator,
    final String? dnsApiToken,
    final BackupsCredential? backblazeCredential,
    final ServerDomain? serverDomain,
    final User? rootUser,
    final ServerHostingDetails? serverDetails,
    final bool? isServerStarted,
    final bool? isServerResetedFirstTime,
    final bool? isServerResetedSecondTime,
    final bool? isLoading,
    final Map<String, DnsRecordStatus>? dnsMatches,
    final CallbackDialogueBranching? installationDialoguePopUp,
    final String? customSshKey,
  }) => ServerInstallationNotFinished(
    providerApiToken: providerApiToken ?? this.providerApiToken,
    serverLocation: serverLocation ?? this.serverLocation,
    serverTypeIdentificator:
        serverTypeIdentificator ?? this.serverTypeIdentificator,
    dnsApiToken: dnsApiToken ?? this.dnsApiToken,
    backblazeCredential: backblazeCredential ?? this.backblazeCredential,
    serverDomain: serverDomain ?? this.serverDomain,
    rootUser: rootUser ?? this.rootUser,
    serverDetails: serverDetails ?? this.serverDetails,
    isServerStarted: isServerStarted ?? this.isServerStarted,
    isServerResetedFirstTime:
        isServerResetedFirstTime ?? this.isServerResetedFirstTime,
    isServerResetedSecondTime:
        isServerResetedSecondTime ?? this.isServerResetedSecondTime,
    isLoading: isLoading ?? this.isLoading,
    dnsMatches: dnsMatches ?? this.dnsMatches,
    installationDialoguePopUp:
        installationDialoguePopUp ?? this.installationDialoguePopUp,
    customSshKey: customSshKey ?? this.customSshKey,
  );

  ServerInstallationFinished finish() => ServerInstallationFinished(
    providerApiToken: providerApiToken,
    serverLocation: serverLocation,
    serverTypeIdentificator: serverTypeIdentificator,
    dnsApiToken: dnsApiToken!,
    backblazeCredential: backblazeCredential!,
    serverDomain: serverDomain!,
    serverDetails: serverDetails!,
  );
}

class ServerInstallationEmpty extends ServerInstallationNotFinished {
  const ServerInstallationEmpty()
    : super(
        providerApiToken: null,
        serverLocation: null,
        serverTypeIdentificator: null,
        dnsApiToken: null,
        backblazeCredential: null,
        serverDomain: null,
        rootUser: null,
        serverDetails: null,
        isServerStarted: false,
        isServerResetedFirstTime: false,
        isServerResetedSecondTime: false,
        isLoading: false,
        dnsMatches: null,
        installationDialoguePopUp: null,
        customSshKey: null,
      );
}

class ServerInstallationFinished extends ServerInstallationState {
  const ServerInstallationFinished({
    required String super.dnsApiToken,
    required BackupsCredential super.backblazeCredential,
    required ServerDomain super.serverDomain,
    required ServerHostingDetails super.serverDetails,
    super.providerApiToken,
    super.serverTypeIdentificator,
    super.serverLocation,
  }) : super(
         rootUser: null,
         isServerStarted: true,
         isServerResetedFirstTime: true,
         isServerResetedSecondTime: true,
         installationDialoguePopUp: null,
       );

  @override
  List<Object?> get props => [
    providerApiToken,
    serverTypeIdentificator,
    serverLocation,
    dnsApiToken,
    backblazeCredential,
    serverDomain,
    rootUser,
    serverDetails,
    isServerStarted,
    isServerResetedFirstTime,
    installationDialoguePopUp,
  ];
}

enum RecoveryStep {
  selecting,
  recoveryKey,
  newDeviceKey,
  oldToken,
  serverProviderToken,
  serverSelection,
  dnsProviderToken,
  backblazeToken,
}

enum ServerRecoveryCapabilities { none, legacy, loginTokens }

enum ServerRecoveryMethods { newDeviceKey, recoveryKey, oldToken }

class ServerInstallationRecovery extends ServerInstallationState {
  const ServerInstallationRecovery({
    required this.currentStep,
    required this.recoveryCapabilities,
    super.providerApiToken,
    super.serverTypeIdentificator,
    super.serverLocation,
    super.dnsApiToken,
    super.backblazeCredential,
    super.serverDomain,
    super.serverDetails,
  }) : super(
         rootUser: null,
         isServerStarted: true,
         isServerResetedFirstTime: true,
         isServerResetedSecondTime: true,
         installationDialoguePopUp: null,
       );
  final RecoveryStep currentStep;
  final ServerRecoveryCapabilities recoveryCapabilities;

  @override
  List<Object?> get props => [
    providerApiToken,
    serverTypeIdentificator,
    serverLocation,
    dnsApiToken,
    backblazeCredential,
    serverDomain,
    rootUser,
    serverDetails,
    isServerStarted,
    isServerResetedFirstTime,
    currentStep,
    installationDialoguePopUp,
  ];

  ServerInstallationRecovery copyWith({
    final String? providerApiToken,
    final String? serverLocation,
    final String? serverTypeIdentificator,
    final String? dnsApiToken,
    final BackupsCredential? backblazeCredential,
    final ServerDomain? serverDomain,
    final ServerHostingDetails? serverDetails,
    final RecoveryStep? currentStep,
    final ServerRecoveryCapabilities? recoveryCapabilities,
  }) => ServerInstallationRecovery(
    providerApiToken: providerApiToken ?? this.providerApiToken,
    serverLocation: serverLocation ?? this.serverLocation,
    serverTypeIdentificator:
        serverTypeIdentificator ?? this.serverTypeIdentificator,
    dnsApiToken: dnsApiToken ?? this.dnsApiToken,
    backblazeCredential: backblazeCredential ?? this.backblazeCredential,
    serverDomain: serverDomain ?? this.serverDomain,
    serverDetails: serverDetails ?? this.serverDetails,
    currentStep: currentStep ?? this.currentStep,
    recoveryCapabilities: recoveryCapabilities ?? this.recoveryCapabilities,
  );

  ServerInstallationFinished finish() => ServerInstallationFinished(
    providerApiToken: providerApiToken,
    serverLocation: serverLocation,
    serverTypeIdentificator: serverTypeIdentificator,
    dnsApiToken: dnsApiToken!,
    backblazeCredential: backblazeCredential!,
    serverDomain: serverDomain!,
    serverDetails: serverDetails!,
  );
}
