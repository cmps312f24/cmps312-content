import 'dart:convert';
import 'dart:io';
import 'surah/Surah.dart';

List<Surah> getSurahs(String filePath) {
  // Read the content of the file at the given path as a string
  final fileContent = File(filePath).readAsStringSync();

  // Parse the JSON content into a list of dynamic objects
  final List<dynamic> jsonList = jsonDecode(fileContent);

  // Convert each dynamic object into a Surah instance using fromJson
  final surahs = jsonList.map((json) => Surah.fromJson(json)).toList();

  // Return the list of Surah objects
  return surahs;
}


void main() {
  // Specify the file path
  String filePath = 'data/surahs.json';

  // Read and decode the list of Surah objects
  var surahs = getSurahs(filePath);

  // Print out the details of each Surah
  surahs.forEach(print);
}
