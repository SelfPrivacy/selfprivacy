// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_installation_wizard_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServerInstallationWizardDataAdapter
    extends TypeAdapter<ServerInstallationWizardData> {
  @override
  final typeId = 60;

  @override
  ServerInstallationWizardData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServerInstallationWizardData(
      hasFinalChecked: fields[0] as bool,
      isServerStarted: fields[1] as bool,
      isServerResetedFirstTime: fields[2] as bool,
      isServerResetedSecondTime: fields[3] as bool,
      isLoading: fields[4] as bool,
      isRecoveringServer: fields[5] as bool,
      rootUser: fields[6] as User?,
      serverProviderType: fields[7] as ServerProviderType?,
      serverProviderKey: fields[8] as String?,
      dnsProviderType: fields[9] as DnsProviderType?,
      dnsProviderKey: fields[10] as String?,
      backupsCredential: fields[11] as BackupsCredential?,
      serverTypeIdentifier: fields[12] as String?,
      serverLocation: fields[13] as String?,
      serverDetails: fields[14] as ServerHostingDetails?,
      serverDomain: fields[15] as ServerDomain?,
    );
  }

  @override
  void write(BinaryWriter writer, ServerInstallationWizardData obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.hasFinalChecked)
      ..writeByte(1)
      ..write(obj.isServerStarted)
      ..writeByte(2)
      ..write(obj.isServerResetedFirstTime)
      ..writeByte(3)
      ..write(obj.isServerResetedSecondTime)
      ..writeByte(4)
      ..write(obj.isLoading)
      ..writeByte(5)
      ..write(obj.isRecoveringServer)
      ..writeByte(6)
      ..write(obj.rootUser)
      ..writeByte(7)
      ..write(obj.serverProviderType)
      ..writeByte(8)
      ..write(obj.serverProviderKey)
      ..writeByte(9)
      ..write(obj.dnsProviderType)
      ..writeByte(10)
      ..write(obj.dnsProviderKey)
      ..writeByte(11)
      ..write(obj.backupsCredential)
      ..writeByte(12)
      ..write(obj.serverTypeIdentifier)
      ..writeByte(13)
      ..write(obj.serverLocation)
      ..writeByte(14)
      ..write(obj.serverDetails)
      ..writeByte(15)
      ..write(obj.serverDomain);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerInstallationWizardDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
