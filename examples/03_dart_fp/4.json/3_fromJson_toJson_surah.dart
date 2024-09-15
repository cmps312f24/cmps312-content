import 'dart:convert';

class Surah {
  final int number;
  final String arabicName;
  final String englishName;
  final int verseCount;
  final String type;

  Surah({
    required this.number,
    required this.arabicName,
    required this.englishName,
    required this.verseCount,
    required this.type,
  });

  // Convert a Surah object to a JSON map
  Map<String, dynamic> toJson() => {
    'number': number,
    'arabicName': arabicName,
    'englishName': englishName,
    'verseCount': verseCount,
    'type': type,
  };

  // Convert a JSON map to a Surah object
  Surah.fromJson(Map<String, dynamic> json) : 
    number = json['number'],
    arabicName = json['arabicName'],
    englishName = json['englishName'],
    verseCount = json['verseCount'],
    type = json['type'];
}

void main() {
  // Create a Surah object
  var fatiha = Surah(
    number: 1,
    arabicName: "الفاتحة",
    englishName: "Al-Fatiha",
    verseCount: 7,
    type: "Meccan",
  );

  // Convert the Surah object to a JSON string
  String surahJson = jsonEncode(fatiha.toJson());
  print("Serialized Surah to JSON string: $surahJson");

  // Convert the JSON string back to a Surah object
  var surah = Surah.fromJson(jsonDecode(surahJson));
  print("Deserialized Surah: ${surah.englishName}, ${surah.verseCount} verses");
}
