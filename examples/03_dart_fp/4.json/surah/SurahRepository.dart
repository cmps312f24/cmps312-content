import 'dart:convert';
import 'dart:io';
import 'Surah.dart';

class SurahRepository {
  late final List<Surah> surahs;

  SurahRepository() {
    final filePath = 'data/surahs.json';
    final jsonData = File(filePath).readAsStringSync();
    final List<dynamic> jsonList = jsonDecode(jsonData);
    surahs = jsonList.map((json) => Surah.fromJson(json)).toList();
  }

  int get totalAyat => surahs.fold(0, (sum, surah) => sum + surah.ayaCount);

  /*
  - Fold starts with an empty map <String, int>{} that will hold the surah types as keys 
    and the count of surahs for each type as values.
  - For each surah, it checks if the surah type already exists in the map: 
     If so, it it increments the count. 
     If not, it initializes the count for that type as 1.
  */
  Map<String, int> get surahCountByType {
    return surahs.fold(<String, int>{}, (acc, surah) {
      acc[surah.type] = (acc[surah.type] ?? 0) + 1;
      return acc;
    });
  }

  /*
  Map<String, int> get surahCountByType {
    //  creates a map to store the count of each type
    final countByType = <String, int>{};
    //  iterates through surahs and counts occurrences of each type
    for (final surah in surahs) {
      countByType[surah.type] = (countByType[surah.type] ?? 0) + 1;
    }
    return countByType;
  }*/

/*
Fold:
 - We start with an empty map <String, int>{} that will hold the surah types as keys 
  and the cumulative ayaCount for each type as values.
- For each surah, it checks if the surah type already exists in the map:
   If so, it adds the current surah.ayaCount to the existing value.
   If not, it initializes the count with surah.ayaCount.
*/
  Map<String, int> get ayaCountByType {
    return surahs.fold(<String, int>{}, (acc, surah) {
      acc[surah.type] = (acc[surah.type] ?? 0) + surah.ayaCount;
      return acc;
    });
  }

  List<Surah> getSurahsByAyaCount(int ayaCount) {
    return surahs.where((surah) => surah.ayaCount >= ayaCount).toList()
      ..sort((a, b) => b.ayaCount.compareTo(a.ayaCount));
  }

  List<Surah> getSurahsByType(String surahType) {
    return surahs
        .where((surah) => surah.type.toLowerCase() == surahType.toLowerCase())
        .toList();
  }

  Surah getLongestSurah() {
    return surahs.reduce((a, b) => a.ayaCount > b.ayaCount ? a : b);
  }
}
