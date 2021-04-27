part of 'server_details.dart';

class _TextDetails extends StatelessWidget {
  const _TextDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var details = context.watch<ServerDetailsCubit>().state;

    if (details is ServerDetailsLoading || details is ServerDetailsInitial) {
      return _TempMessage(message: 'basis.loading'.tr());
    } else if (details is ServerDetailsNotReady) {
      return _TempMessage(message: 'basis.no_data'.tr());
    } else if (details is Loaded) {
      var data = details.serverInfo;
      var checkTime = details.checkTime;
      return Column(
        children: [
          Center(child: BrandText.h3('providers.server.bottom_sheet.2'.tr())),
          SizedBox(height: 10),
          Table(
            columnWidths: {
              0: FractionColumnWidth(.5),
              1: FractionColumnWidth(.5),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  getRowTitle('Last check'),
                  getRowValue(formater.format(checkTime)),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('Server Id'),
                  getRowValue(data.id.toString()),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('Status:'),
                  getRowValue(
                    '${data.status.toString().split('.')[1].toUpperCase()}',
                    isBold: true,
                  ),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('CPU'),
                  getRowValue(
                    data.serverType.cores.toString(),
                  ),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('Memory'),
                  getRowValue(
                    '${data.serverType.memory.toString()} GB',
                  ),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('Disk Local'),
                  getRowValue(
                    '${data.serverType.disk.toString()} GB',
                  ),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('Price monthly:'),
                  getRowValue(
                    '${data.serverType.prices[1].monthly.toString()}',
                  ),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('Price hourly:'),
                  getRowValue(
                    '${data.serverType.prices[1].hourly.toString()}',
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Center(child: BrandText.h3('providers.server.bottom_sheet.3'.tr())),
          SizedBox(height: 10),
          Table(
            columnWidths: {
              0: FractionColumnWidth(.5),
              1: FractionColumnWidth(.5),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  getRowTitle('Country'),
                  getRowValue(
                    '${data.location.country}',
                  ),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('City'),
                  getRowValue(data.location.city),
                ],
              ),
              TableRow(
                children: [
                  getRowTitle('Description'),
                  getRowValue(data.location.description),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      );
    } else {
      throw Exception('wrong state');
    }
  }

  Widget getRowTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: BrandText.h5(
        title,
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget getRowValue(String title, {bool isBold = false}) {
    return BrandText.body1(
      title,
      style: isBold
          ? TextStyle(
              fontWeight: NamedFontWeight.demiBold,
            )
          : null,
    );
  }
}

class _TempMessage extends StatelessWidget {
  const _TempMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: Center(
        child: BrandText.body2(message),
      ),
    );
  }
}

final DateFormat formater = DateFormat('HH:mm:ss');
