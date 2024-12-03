import 'dart:convert';

import 'package:basair/models/mahwar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// State provider to keep track of the search query
final searchQueryProvider = StateProvider<String>((ref) => '');

//for the mahawir menu
enum DisplayMode {
  surahs,
  mahawir,
  sections;

  @override
  String toString() {
    switch (this) {
      case DisplayMode.surahs:
        return 'السور';
      case DisplayMode.mahawir:
        return 'المحاور';
      case DisplayMode.sections:
        return 'الأقسام';
    }
  }
}

final displayModeProvider =
    StateProvider<DisplayMode>((ref) => DisplayMode.surahs);

final topicsProvider = FutureProvider<List<SurahWithMahawer>>((ref) async {
  // Fetch the list of SurahWithMahawer from your data source
  final surahs = await getSurahWithMahawer();

  // Return the fetched list, or an empty list if null
  return surahs ?? [];
});

Future<List<SurahWithMahawer>?> getSurahWithMahawer() async {
  try {
    var data = await rootBundle.loadString('assets/data/mahawer.json');
    var surahDataList = jsonDecode(data) as List<dynamic>;

    return surahDataList
        .map((surahMap) => SurahWithMahawer.fromJson(surahMap))
        .toList();
  } catch (e) {
    print("Error loading surah data: $e");
    return null;
  }
}
