part of 'server_details_screen.dart';

class _Chart extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    final HetznerMetricsCubit cubit = context.watch<HetznerMetricsCubit>();
    final Period period = cubit.state.period;
    final HetznerMetricsState state = cubit.state;
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
        const Legend(color: Colors.red, text: 'CPU %'),
        const SizedBox(height: 20),
        getCpuChart(state),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BrandText.small('Public Network interface packets per sec'),
            const SizedBox(width: 10),
            const Legend(color: Colors.red, text: 'IN'),
            const SizedBox(width: 5),
            const Legend(color: Colors.green, text: 'OUT'),
          ],
        ),
        const SizedBox(height: 20),
        getPpsChart(state),
        const SizedBox(height: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BrandText.small('Public Network interface bytes per sec'),
            const SizedBox(width: 10),
            const Legend(color: Colors.red, text: 'IN'),
            const SizedBox(width: 5),
            const Legend(color: Colors.green, text: 'OUT'),
          ],
        ),
        const SizedBox(height: 20),
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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

  Widget getCpuChart(final HetznerMetricsLoaded state) {
    final data = state.cpu;

    return SizedBox(
      height: 200,
      child: CpuChart(
        data: data,
        period: state.period,
        start: state.start,
      ),
    );
  }

  Widget getPpsChart(final HetznerMetricsLoaded state) {
    final ppsIn = state.ppsIn;
    final ppsOut = state.ppsOut;

    return SizedBox(
      height: 200,
      child: NetworkChart(
        listData: [ppsIn, ppsOut],
        period: state.period,
        start: state.start,
      ),
    );
  }

  Widget getBandwidthChart(final HetznerMetricsLoaded state) {
    final ppsIn = state.bandwidthIn;
    final ppsOut = state.bandwidthOut;

    return SizedBox(
      height: 200,
      child: NetworkChart(
        listData: [ppsIn, ppsOut],
        period: state.period,
        start: state.start,
      ),
    );
  }
}

class Legend extends StatelessWidget {
  const Legend({
    required this.color,
    required this.text,
    final super.key,
  });

  final String text;
  final Color color;
  @override
  Widget build(final BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _ColoredBox(color: color),
          const SizedBox(width: 5),
          BrandText.small(text),
        ],
      );
}

class _ColoredBox extends StatelessWidget {
  const _ColoredBox({
    required this.color,
  });

  final Color color;

  @override
  Widget build(final BuildContext context) => Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          border: Border.all(
            color: color,
          ),
        ),
      );
}
