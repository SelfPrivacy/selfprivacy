// ignore_for_file: unnecessary_this

extension DurationFormatter on Duration {
  String toDayHourMinuteSecondFormat() {
    return [
      this.inHours.remainder(24),
      this.inMinutes.remainder(60),
      this.inSeconds.remainder(60)
    ].map((seg) {
      return seg.toString().padLeft(2, '0');
    }).join(':');
  }

  String toDayHourMinuteFormat() {
    var designator = this >= Duration.zero ? '+' : '-';

    var segments = [
      this.inHours.remainder(24).abs(),
      this.inMinutes.remainder(60).abs(),
    ].map((seg) {
      return seg.toString().padLeft(2, '0');
    });

    return '$designator${segments.first}:${segments.last}';
  }

  String toHoursMinutesSecondsFormat() {
    // WAT: https://flutterigniter.com/how-to-format-duration/
    return this.toString().split('.').first.padLeft(8, '0');
  }

  String toDayHourMinuteFormat2() {
    var segments = [
      this.inHours.remainder(24),
      this.inMinutes.remainder(60),
    ].map((seg) {
      return seg.toString().padLeft(2, '0');
    });
    return '${segments.first} h ${segments.last} min';
  }
}
