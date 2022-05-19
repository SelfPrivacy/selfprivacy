part of 'server_details_screen.dart';

class _Chart extends StatelessWidget {
  const _Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<HetznerMetricsCubit>();
    var period = cubit.state.period;
    var state = cubit.state;
    List<Widget> charts;
    if (state is HetznerMetricsLoading) {
      charts = [
        Container(
          height: 200,
          alignment: Alignment.center,
          child: Text('basis.loading'.tr()),
        )
      ];
    } else if (state is HetznerMetricsLoaded) {
      charts = [
        Legend(color: Colors.red, text: 'CPU %'),
        SizedBox(height: 20),
        getCpuChart(state),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BrandText.small('Public Network interface packets per sec'),
            SizedBox(width: 10),
            Legend(color: Colors.red, text: 'IN'),
            SizedBox(width: 5),
            Legend(color: Colors.green, text: 'OUT'),
          ],
        ),
        SizedBox(height: 20),
        getPpsChart(state),
        SizedBox(height: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BrandText.small('Public Network interface bytes per sec'),
            SizedBox(width: 10),
            Legend(color: Colors.red, text: 'IN'),
            SizedBox(width: 5),
            Legend(color: Colors.green, text: 'OUT'),
          ],
        ),
        SizedBox(height: 20),
        getBandwidthChart(state),
      ];
    } else {
      throw 'wrong state';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BrandRadioTile(
                  isChecked: period == Period.month,
                  text: 'providers.server.chart.month'.tr(),
                  onPress: () => cubit.changePeriod(Period.month),
                ),
                BrandRadioTile(
                  isChecked: period == Period.day,
                  text: 'providers.server.chart.day'.tr(),
                  onPress: () => cubit.changePeriod(Period.day),
                ),
                BrandRadioTile(
                  isChecked: period == Period.hour,
                  text: 'providers.server.chart.hour'.tr(),
                  onPress: () => cubit.changePeriod(Period.hour),
                ),
              ],
            ),
          ),
          ...charts,
        ],
      ),
    );
  }

  Widget getCpuChart(HetznerMetricsLoaded state) {
    var data = state.cpu;

    return Container(
      height: 200,
      child: CpuChart(data, state.period, state.start),
    );
  }

  Widget getPpsChart(HetznerMetricsLoaded state) {
    var ppsIn = state.ppsIn;
    var ppsOut = state.ppsOut;

    return Container(
      height: 200,
      child: NetworkChart(
        [ppsIn, ppsOut],
        state.period,
        state.start,
      ),
    );
  }

  Widget getBandwidthChart(HetznerMetricsLoaded state) {
    var ppsIn = state.bandwidthIn;
    var ppsOut = state.bandwidthOut;

    return Container(
      height: 200,
      child: NetworkChart(
        [ppsIn, ppsOut],
        state.period,
        state.start,
      ),
    );
  }
}

class Legend extends StatelessWidget {
  const Legend({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _ColoredBox(color: color),
        SizedBox(width: 5),
        BrandText.small(text),
      ],
    );
  }
}

class _ColoredBox extends StatelessWidget {
  const _ColoredBox({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          border: Border.all(
            color: color,
          )),
    );
  }
}
