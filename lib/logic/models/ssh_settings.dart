import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_settings.graphql.dart';

class SshSettings {
  SshSettings({
    required this.enable,
    required this.passwordAuthentication,
  });

  SshSettings.fromGraphQL(final Query$SystemSettings$system$settings$ssh ssh)
      : this(
          enable: ssh.enable,
          passwordAuthentication: ssh.passwordAuthentication,
        );

  final bool enable;
  final bool passwordAuthentication;
}
