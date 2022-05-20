class ServerBasicInfo {
  final int id;
  final String name;
  final String reverseDns;
  final String ip;
  final DateTime created;
  final int volumeId;

  ServerBasicInfo({
    required this.id,
    required this.name,
    required this.reverseDns,
    required this.ip,
    required this.created,
    required this.volumeId,
  });
}

class ServerBasicInfoWithValidators extends ServerBasicInfo {
  final bool isIpValid;
  final bool isReverseDnsValid;

  ServerBasicInfoWithValidators({
    required int id,
    required String name,
    required String reverseDns,
    required String ip,
    required DateTime created,
    required int volumeId,
    required this.isIpValid,
    required this.isReverseDnsValid,
  }) : super(
          id: id,
          name: name,
          reverseDns: reverseDns,
          ip: ip,
          created: created,
          volumeId: volumeId,
        );

  ServerBasicInfoWithValidators.fromServerBasicInfo({
    required ServerBasicInfo serverBasicInfo,
    required isIpValid,
    required isReverseDnsValid,
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
}
