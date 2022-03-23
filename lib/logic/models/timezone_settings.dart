import 'package:timezone/timezone.dart';

class TimeZoneSettings {
  final Location timezone;

  TimeZoneSettings(this.timezone);

  Map<String, dynamic> toJson() {
    return {
      'timezone': timezone.name,
    };
  }

  factory TimeZoneSettings.fromString(String string) {
    var location = timeZoneDatabase.locations[string]!;
    return TimeZoneSettings(location);
  }
}
