import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_settings.graphql.dart';

class SshSettings {
  SshSettings({required this.enable});

  SshSettings.fromGraphQL(final Query$SystemSettings$system$settings$ssh ssh)
    : this(enable: ssh.enable);

  final bool enable;
}
