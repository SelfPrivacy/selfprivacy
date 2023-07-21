class ServerBasicInfo {
  ServerBasicInfo({
    required this.id,
    required this.name,
    required this.reverseDns,
    required this.serverTypeId,
    required this.ip,
    required this.created,
  });
  final int id;
  final String name;
  final String reverseDns;
  final String serverTypeId;
  final String ip;
  final DateTime created;
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
          serverTypeId: serverBasicInfo.serverTypeId,
          ip: serverBasicInfo.ip,
          created: serverBasicInfo.created,
          isIpValid: isIpValid,
          isReverseDnsValid: isReverseDnsValid,
        );

  ServerBasicInfoWithValidators({
    required super.id,
    required super.name,
    required super.reverseDns,
    required super.serverTypeId,
    required super.ip,
    required super.created,
    required this.isIpValid,
    required this.isReverseDnsValid,
  });
  final bool isIpValid;
  final bool isReverseDnsValid;
}
