import 'package:timezone/timezone.dart';

class TimeZoneSettings {
  TimeZoneSettings({this.timezone});

  factory TimeZoneSettings.fromString(final String string) {
    final Location location = timeZoneDatabase.locations[string]!;
    return TimeZoneSettings(timezone: location);
  }
  final Location? timezone;

  Map<String, dynamic> toJson() => {'timezone': timezone?.name ?? 'Unknown'};

  @override
  String toString() => timezone?.name ?? 'Unknown';
}
