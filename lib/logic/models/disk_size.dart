class DiskSize {
  DiskSize({final this.byte = 0});

  double asKb() => byte / 1024.0;
  double asMb() => byte / 1024.0 / 1024.0;
  double asGb() => byte / 1024.0 / 1024.0 / 1024.0;

  int byte;
}
