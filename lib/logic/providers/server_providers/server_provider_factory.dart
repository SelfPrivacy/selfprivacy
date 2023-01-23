class ServerProviderFactory {
  static ServerProvider createServerProviderApiFactory(
    final ServerProviderApiFactorySettings settings,
  ) {
    switch (settings.provider) {
      case ServerProvider.hetzner:
        return HetznerApiFactory(region: settings.location);
      case ServerProvider.digitalOcean:
        return DigitalOceanApiFactory(region: settings.location);
      case ServerProvider.unknown:
        throw UnknownApiProviderException('Unknown server provider');
    }
  }
}
