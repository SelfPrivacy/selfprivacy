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
      return FilledCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'server.general_information'.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
            ...details.metadata
                .map(
                  (final metadata) => ListTileOnSurfaceVariant(
                    leadingIcon: metadata.type.icon,
                    title: metadata.name,
                    subtitle: metadata.value,
                  ),
                )
                .toList(),
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
