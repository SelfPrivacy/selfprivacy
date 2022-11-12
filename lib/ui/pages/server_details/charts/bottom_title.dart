import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:intl/intl.dart';

String bottomTitle(
  final int value,
  final List<TimeSeriesData> data,
  final Period period,
) {
  final hhmm = DateFormat('HH:mm');
  final day = DateFormat('MMMd');
  String res;

  if (value <= 0) {
    return '';
  }

  final time = data[value].time;
  switch (period) {
    case Period.hour:
    case Period.day:
      res = hhmm.format(time);
      break;
    case Period.month:
      res = day.format(time);
  }

  return res;
}
