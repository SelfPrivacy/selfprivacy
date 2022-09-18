part of 'server_details_screen.dart';

class _TextDetails extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    final details = context.watch<ServerDetailsCubit>().state;

    if (details is ServerDetailsLoading || details is ServerDetailsInitial) {
      return _TempMessage(message: 'basis.loading'.tr());
    } else if (details is ServerDetailsNotReady) {
      return _TempMessage(message: 'basis.no_data'.tr());
    } else if (details is Loaded) {
      final data = details.serverInfo;
      return FilledCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'providers.server.bottom_sheet.2'.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
            ListTileOnSurfaceVariant(
              leadingIcon: Icons.numbers_outlined,
              title: data.id.toString(),
              subtitle: 'providers.server.info.server_id'.tr(),
            ),
            ListTileOnSurfaceVariant(
              leadingIcon: Icons.mode_standby_outlined,
              title: data.status.toString().split('.')[1].capitalize(),
              subtitle: 'providers.server.info.status'.tr(),
            ),
            ListTileOnSurfaceVariant(
              leadingIcon: Icons.memory_outlined,
              title: 'providers.server.info.core_count'
                  .plural(data.serverType.cores),
              subtitle: 'providers.server.info.cpu'.tr(),
            ),
            ListTileOnSurfaceVariant(
              leadingIcon: Icons.memory_outlined,
              title: '${data.serverType.memory.toString()} GB',
              subtitle: 'providers.server.info.ram'.tr(),
            ),
            ListTileOnSurfaceVariant(
              leadingIcon: Icons.euro_outlined,
              title: data.serverType.prices[1].monthly.toStringAsFixed(2),
              subtitle: 'providers.server.info.monthly_cost'.tr(),
            ),
            // Server location
            ListTileOnSurfaceVariant(
              leadingIcon: Icons.location_on_outlined,
              title: '${data.location.city}, ${data.location.country}',
              subtitle: 'providers.server.info.location'.tr(),
            ),
          ],
        ),
      );
    } else {
      throw Exception('wrong state');
    }
  }

  Widget getRowTitle(final String title) => Padding(
        padding: const EdgeInsets.only(right: 10),
        child: BrandText.h5(
          title,
          textAlign: TextAlign.right,
        ),
      );

  Widget getRowValue(final String title, {final bool isBold = false}) =>
      BrandText.body1(
        title,
        style: isBold
            ? const TextStyle(
                fontWeight: NamedFontWeight.demiBold,
              )
            : null,
      );
}

class _TempMessage extends StatelessWidget {
  const _TempMessage({
    required this.message,
  });

  final String message;
  @override
  Widget build(final BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height - 100,
        child: Center(
          child: BrandText.body2(message),
        ),
      );
}

final DateFormat formatter = DateFormat('HH:mm:ss');
