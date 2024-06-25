class ServerProviderLocation {
  ServerProviderLocation({
    required this.title,
    required this.identifier,
    required this.countryDisplayKey,
    this.description,
    this.flag = '',
  });

  final String title;
  final String identifier;
  final String countryDisplayKey;
  final String? description;
  final String flag;
}
