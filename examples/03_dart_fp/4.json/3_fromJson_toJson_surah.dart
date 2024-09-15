import 'dart:convert';
import 'surah/Surah.dart';

void main() {
  // Create a Surah object
  const fatiha = Surah(
    id: 1,
    name: "الفاتحة",
    englishName: "Al-Fatiha",
    ayaCount: 7,
    type: "Meccan",
  );

  // Convert the Surah object to a JSON string
  String surahJson = jsonEncode(fatiha.toJson());
  print("Serialized Surah to JSON string: $surahJson");

  // Convert the JSON string back to a Surah object
  var surah = Surah.fromJson(jsonDecode(surahJson));
  print("Deserialized Surah: ${surah.id} -  $surah");
}
