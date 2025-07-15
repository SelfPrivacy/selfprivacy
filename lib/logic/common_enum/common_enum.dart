enum LoadingStatus { uninitialized, refreshing, success, error }

enum Period {
  hour,
  day,
  month;

  int get stepPeriodInSeconds {
    switch (this) {
      case Period.hour:
        return 18;
      case Period.day:
        return 432;
      case Period.month:
        return 6480;
    }
  }
}
