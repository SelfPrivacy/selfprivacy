import 'package:selfprivacy/logic/models/hive/backups_credential.dart';

class InitializeRepositoryInput {
  InitializeRepositoryInput({
    required this.provider,
    required this.locationId,
    required this.locationName,
    required this.login,
    required this.password,
  });
  final BackupsProvider provider;
  final String locationId;
  final String locationName;
  final String login;
  final String password;
}
