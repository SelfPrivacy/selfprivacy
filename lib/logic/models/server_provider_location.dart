class ServerProviderLocation {
  ServerProviderLocation({
    required this.title,
    required this.identifier,
    this.description,
    this.flag = '',
  });

  final String title;
  final String identifier;
  final String? description;
  final String flag;
}
