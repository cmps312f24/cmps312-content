import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/surah.dart';

class SurahNotifier extends Notifier<List<Surah>> {
  @override
  List<Surah> build() {
    initializeState();
    return [];
  }

  Future<void> initializeState() async {
    try {
      final data = await rootBundle.loadString('assets/data/surahs.json');
      final surahsMap = jsonDecode(data) as List<dynamic>;

      final surahs = surahsMap.map((map) => Surah.fromJson(map)).toList();
      state = surahs;
    } catch (error) {
      print('Error loading surahs: $error');
    }
  }

  // Optional filter method for Surahs
  List<Surah> filterSurahs({String name = ''}) {
    return state.where((surah) {
      return surah.name.toLowerCase().contains(name.toLowerCase());
    }).toList();
  }
}

// Provider for accessing the SurahNotifier
final surahProvider = NotifierProvider<SurahNotifier, List<Surah>>(
  () => SurahNotifier(),
);
