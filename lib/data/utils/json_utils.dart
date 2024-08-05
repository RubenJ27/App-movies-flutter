import 'dart:convert';

String convertToJsonString(dynamic data) {
  if (data is Map) {
    return jsonEncode(data);
  } else if (data is String) {
    return data;
  } else {
    throw ArgumentError('Invalid data type');
  }
}
