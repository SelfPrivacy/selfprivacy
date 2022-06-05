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
      final checkTime = details.checkTime;
      return Column(
        children: [
          Center(child: BrandText.h3('providers.server.bottom_sheet.2'.tr())),
          const SizedBox(height: 10),
          Table(
            columnWidths: const {
              0: FractionColumnWidth(.5),
              1: FractionColumnWidth(.5),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  getRowTitle('Last check:'),
                  getRowValue(formatter.format(checkTime)),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('Server Id:'),
                  getRowValue(data.id.toString()),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('Status:'),
                  getRowValue(
                    data.status.toString().split('.')[1].toUpperCase(),
                    isBold: true,
                  ),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('CPU:'),
                  getRowValue(
                    data.serverType.cores.toString(),
                  ),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('Memory:'),
                  getRowValue(
                    '${data.serverType.memory.toString()} GB',
                  ),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('Disk Local:'),
                  getRowValue(
                    '${data.serverType.disk.toString()} GB',
                  ),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('Price monthly:'),
                  getRowValue(
                    data.serverType.prices[1].monthly.toString(),
                  ),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('Price hourly:'),
                  getRowValue(
                    data.serverType.prices[1].hourly.toString(),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          Center(child: BrandText.h3('providers.server.bottom_sheet.3'.tr())),
          const SizedBox(height: 10),
          Table(
            columnWidths: const {
              0: FractionColumnWidth(.5),
              1: FractionColumnWidth(.5),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  getRowTitle('Country:'),
                  getRowValue(
                    data.location.country,
                  ),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('City:'),
                  getRowValue(data.location.city),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('Description:'),
                  getRowValue(data.location.description),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
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
