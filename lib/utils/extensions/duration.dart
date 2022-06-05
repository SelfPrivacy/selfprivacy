// ignore_for_file: unnecessary_this

extension DurationFormatter on Duration {
  String toDayHourMinuteSecondFormat() => [
        this.inHours.remainder(24),
        this.inMinutes.remainder(60),
        this.inSeconds.remainder(60)
      ].map((final int seg) => seg.toString().padLeft(2, '0')).join(':');

  String toDayHourMinuteFormat() {
    final designator = this >= Duration.zero ? '+' : '-';

    final Iterable<String> segments = [
      this.inHours.remainder(24).abs(),
      this.inMinutes.remainder(60).abs(),
    ].map((final int seg) => seg.toString().padLeft(2, '0'));

    return '$designator${segments.first}:${segments.last}';
  }

// WAT: https://flutterigniter.com/how-to-format-duration/
  String toHoursMinutesSecondsFormat() =>
      this.toString().split('.').first.padLeft(8, '0');

  String toDayHourMinuteFormat2() {
    final Iterable<String> segments = [
      this.inHours.remainder(24),
      this.inMinutes.remainder(60),
    ].map((final int seg) => seg.toString().padLeft(2, '0'));
    return '${segments.first} h ${segments.last} min';
  }
}
