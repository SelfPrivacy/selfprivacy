class DiskSize {
  DiskSize({final this.byte = 0});

  double asKb() => byte / 1000.0;
  double asMb() => byte / 1000000.0;
  double asGb() => byte / 1000000000.0;

  int byte;
}
