import 'package:flutter/cupertino.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

part 'server_installation_wizard_data.g.dart';

@HiveType(typeId: 60)
class ServerInstallationWizardData {
  const ServerInstallationWizardData({
    required this.hasFinalChecked,
    required this.isServerStarted,
    required this.isServerResetedFirstTime,
    required this.isServerResetedSecondTime,
    required this.isLoading,
    required this.isRecoveringServer,
    required this.rootUser,
    required this.serverProviderType,
    required this.serverProviderKey,
    required this.dnsProviderType,
    required this.dnsProviderKey,
    required this.backupsCredential,
    required this.serverTypeIdentifier,
    required this.serverLocation,
    required this.serverDetails,
    required this.serverDomain,
  });

  ServerInstallationWizardData.empty()
    : this(
        hasFinalChecked: false,
        isServerStarted: false,
        isServerResetedFirstTime: false,
        isServerResetedSecondTime: false,
        isLoading: false,
        isRecoveringServer: false,
        rootUser: null,
        serverProviderType: null,
        serverProviderKey: null,
        dnsProviderType: null,
        dnsProviderKey: null,
        backupsCredential: null,
        serverTypeIdentifier: null,
        serverLocation: null,
        serverDetails: null,
        serverDomain: null,
      );

  // Bool flags used by installer
  @HiveField(0)
  final bool hasFinalChecked;
  @HiveField(1)
  final bool isServerStarted;
  @HiveField(2)
  final bool isServerResetedFirstTime;
  @HiveField(3)
  final bool isServerResetedSecondTime;
  @HiveField(4)
  final bool isLoading;

  @HiveField(5)
  final bool isRecoveringServer;

  @HiveField(6)
  final User? rootUser;

  @HiveField(7)
  final ServerProviderType? serverProviderType;
  @HiveField(8)
  final String? serverProviderKey;

  @HiveField(9)
  final DnsProviderType? dnsProviderType;
  @HiveField(10)
  final String? dnsProviderKey;

  @HiveField(11)
  final BackupsCredential? backupsCredential;

  @HiveField(12)
  final String? serverTypeIdentifier;
  @HiveField(13)
  final String? serverLocation;
  @HiveField(14)
  final ServerHostingDetails? serverDetails;
  @HiveField(15)
  final ServerDomain? serverDomain;

  ServerInstallationWizardData copyWith({
    final bool? hasFinalChecked,
    final bool? isServerStarted,
    final bool? isServerResetedFirstTime,
    final bool? isServerResetedSecondTime,
    final bool? isLoading,
    final bool? isRecoveringServer,
    final User? rootUser,
    final ServerProviderType? serverProviderType,
    final String? serverProviderKey,
    final DnsProviderType? dnsProviderType,
    final String? dnsProviderKey,
    final BackupsCredential? backupsCredential,
    final String? serverTypeIdentifier,
    final String? serverLocation,
    final ValueGetter<ServerHostingDetails?>? serverDetails,
    final ValueGetter<ServerDomain?>? serverDomain,
  }) => ServerInstallationWizardData(
    hasFinalChecked: hasFinalChecked ?? this.hasFinalChecked,
    isServerStarted: isServerStarted ?? this.isServerStarted,
    isServerResetedFirstTime:
        isServerResetedFirstTime ?? this.isServerResetedFirstTime,
    isServerResetedSecondTime:
        isServerResetedSecondTime ?? this.isServerResetedSecondTime,
    isLoading: isLoading ?? this.isLoading,
    isRecoveringServer: isRecoveringServer ?? this.isRecoveringServer,
    rootUser: rootUser ?? this.rootUser,
    serverProviderType: serverProviderType ?? this.serverProviderType,
    serverProviderKey: serverProviderKey ?? this.serverProviderKey,
    dnsProviderType: dnsProviderType ?? this.dnsProviderType,
    dnsProviderKey: dnsProviderKey ?? this.dnsProviderKey,
    backupsCredential: backupsCredential ?? this.backupsCredential,
    serverTypeIdentifier: serverTypeIdentifier ?? this.serverTypeIdentifier,
    serverLocation: serverLocation ?? this.serverLocation,
    serverDetails: serverDetails != null ? serverDetails() : this.serverDetails,
    serverDomain: serverDomain != null ? serverDomain() : this.serverDomain,
  );
}
