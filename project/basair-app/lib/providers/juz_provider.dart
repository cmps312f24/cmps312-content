import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/juz.dart';
import '../models/page.dart';

class JuzNotifier extends StateNotifier<List<Juz>> {
  JuzNotifier() : super([]) {
    _initializeState();
  }

  List<List<Juz>> quartersByJuz = [];
  List<Page>? allPages;

  Future<void> _initializeState() async {
    try {
      final data = await rootBundle.loadString('assets/data/juzs.json');
      final juzMap = jsonDecode(data) as List<dynamic>;

      final juzs = juzMap.map((map) => Juz.fromJson(map)).toList();
      state = juzs;
      quartersByJuz = _groupQuartersByJuz(juzs);
      // Load allPages data here if needed
    } catch (error) {
      print('Error loading Juz data: $error');
    }
  }

  List<List<Juz>> _groupQuartersByJuz(List<Juz> juzs) {
    List<List<Juz>> groupedQuarters = [];
    for (var i = 0; i < juzs.length; i += 8) {
      groupedQuarters.add(juzs.sublist(i, i + 8));
    }
    return groupedQuarters;
  }

  List<Juz> getQuartersForJuz(int juzIndex) {
    if (juzIndex < quartersByJuz.length) {
      return quartersByJuz[juzIndex];
    }
    return [];
  }
}

final juzProvider = StateNotifierProvider<JuzNotifier, List<Juz>>(
  (ref) => JuzNotifier(),
);
