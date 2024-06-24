import 'dart:convert';

String? mapToEscapedJson(Map<String, dynamic> map) {
  // Encode the map to JSON and escape the special characters
  String? jsonString = json.encode(map);

  // Replace characters that need to be escaped in AWS JSON
  jsonString = jsonString
      .replaceAll(r'\', r'\\') // Escape backslashes
      .replaceAll(r'/', r'\/') // Escape forwardslashes
      .replaceAll('"', r'\"'); // Escape double quotes

  return jsonString;
}