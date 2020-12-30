import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/models/user.dart';

class AppConfig extends Equatable {
  const AppConfig({
    this.hatzner,
    this.cloudFlare,
    this.domain,
    this.rootUser,
  });

  final String hatzner;
  final String cloudFlare;
  final String domain;
  final User rootUser;

  factory AppConfig.empty() {
    return AppConfig();
  }

  AppConfig copyWith({
    hatzner,
    cloudFlare,
    domain,
    rootUser,
  }) =>
      AppConfig(
        hatzner: hatzner ?? this.hatzner,
        cloudFlare: cloudFlare ?? this.cloudFlare,
        domain: domain ?? this.domain,
        rootUser: rootUser ?? this.rootUser,
      );

  @override
  List<Object> get props => [hatzner, cloudFlare, domain, rootUser];
}
