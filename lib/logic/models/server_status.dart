class ServerStatus {
  ServerStatus({
    required this.http,
    this.imap = StatusTypes.nodata,
    this.smtp = StatusTypes.nodata,
  });
  final StatusTypes http;
  final StatusTypes imap;
  final StatusTypes smtp;

  ServerStatus fromJson(final Map<String, dynamic> json) => ServerStatus(
    http: statusTypeFromNumber(json['http']),
    imap: statusTypeFromNumber(json['imap']),
    smtp: statusTypeFromNumber(json['smtp']),
  );
}

StatusTypes statusTypeFromNumber(final int? number) {
  if (number == 0) {
    return StatusTypes.ok;
  } else if (number == 1) {
    return StatusTypes.error;
  } else if (number == 2) {
    return StatusTypes.wrongArgument;
  } else if (number == 3) {
    return StatusTypes.wrongFunction;
  } else if (number == 4) {
    return StatusTypes.noRights;
  } else if (number == 5) {
    return StatusTypes.notInstalled;
  } else if (number == 6) {
    return StatusTypes.notConfigured;
  } else if (number == 7) {
    return StatusTypes.off;
  } else {
    throw Exception('wrong status');
  }
}

enum StatusTypes {
  ok,
  error,
  wrongArgument,
  wrongFunction,
  noRights,
  notInstalled,
  notConfigured,
  off,
  nodata,
}
