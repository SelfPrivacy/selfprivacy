import 'package:equatable/equatable.dart';
import 'package:timezone/timezone.dart';

class ServerTimezone extends Equatable {
  final Location timezone;

  const ServerTimezone({required this.timezone});

  factory ServerTimezone.fromJson(Map<String, dynamic> json) {
    var timezone = getLocation(json['timezone']);
    return ServerTimezone(timezone: timezone);
  }

  Map<String, dynamic> toJson() => {'timezone': timezone.name};

  @override
  List<Object?> get props => [timezone.name];
}
