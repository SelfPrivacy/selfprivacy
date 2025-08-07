class ServerBasicInfo {
  ServerBasicInfo({
    required this.id,
    required this.name,
    required this.reverseDns,
    required this.ip,
    required this.created,
    required this.location,
  });
  final int id;
  final String name;
  final String reverseDns;
  final String ip;
  final DateTime created;
  final String location;
}

class ServerBasicInfoWithValidators extends ServerBasicInfo {
  ServerBasicInfoWithValidators({
    required super.id,
    required super.name,
    required super.reverseDns,
    required super.ip,
    required super.created,
    required super.location,
    required this.isIpValid,
    required this.isReverseDnsValid,
  });

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
         location: serverBasicInfo.location,
         isIpValid: isIpValid,
         isReverseDnsValid: isReverseDnsValid,
       );
  final bool isIpValid;
  final bool isReverseDnsValid;
}
