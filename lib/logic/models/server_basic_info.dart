class ServerBasicInfo {
  ServerBasicInfo({
    required this.id,
    required this.name,
    required this.reverseDns,
    required this.ip,
    required this.created,
    required this.volumeId,
  });
  final int id;
  final String name;
  final String reverseDns;
  final String ip;
  final DateTime created;
  final int volumeId;
}

class ServerBasicInfoWithValidators extends ServerBasicInfo {
  ServerBasicInfoWithValidators.fromServerBasicInfo({
    required final ServerBasicInfo serverBasicInfo,
    required final isIpValid,
    required final isReverseDnsValid,
  }) : this(
          id: serverBasicInfo.id,
          name: serverBasicInfo.name,
          reverseDns: serverBasicInfo.reverseDns,
          ip: serverBasicInfo.ip,
          created: serverBasicInfo.created,
          volumeId: serverBasicInfo.volumeId,
          isIpValid: isIpValid,
          isReverseDnsValid: isReverseDnsValid,
        );

  ServerBasicInfoWithValidators({
    required super.id,
    required super.name,
    required super.reverseDns,
    required super.ip,
    required super.created,
    required super.volumeId,
    required this.isIpValid,
    required this.isReverseDnsValid,
  });
  final bool isIpValid;
  final bool isReverseDnsValid;
}
