// ignore_for_file: prefer_final_parameters, prefer_expression_function_bodies, avoid_annotating_with_dynamic

String dateTimeToJson(DateTime data) {
  return data.toIso8601String();
}

DateTime dateTimeFromJson(dynamic data) {
  return DateTime.parse(data as String);
}
