import 'package:timezone/timezone.dart';

class TimeZoneSettings {
  factory TimeZoneSettings.fromString(final String string) {
    final Location location = timeZoneDatabase.locations[string]!;
    return TimeZoneSettings(timezone: location);
  }

  TimeZoneSettings({this.timezone});
  final Location? timezone;

  Map<String, dynamic> toJson() => {'timezone': timezone?.name ?? 'Unknown'};

  @override
  String toString() => timezone?.name ?? 'Unknown';
}
