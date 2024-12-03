import 'dart:convert';

import 'package:basair/models/mahwar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SurahWithMahawerProvider extends Notifier<List<SurahWithMahawer>> {

  bool isInitialized = false;
  List<SurahWithMahawer>? surahsWithMahawer;
  Map<double, Color> sectionsWithColorsPortriat = {};
  Map<double, Color> sectionsWithColorsLandscape = {};


  final List<Color> colorsPortriat = [Color.fromARGB(255, 10, 71, 224),Color.fromARGB(255, 9, 140, 107), Color.fromARGB(255, 104, 3, 8), Color.fromARGB(255, 131, 13, 113)];
  final List<Color> colorsLandscape = [Color.fromARGB(255, 193, 207, 243),Color.fromARGB(255, 182, 236, 223), Color.fromARGB(255, 236, 187, 190), Color.fromARGB(255, 233, 190, 226)];

  @override
  List<SurahWithMahawer> build() {
    initializeState();
    return [];
  }
  
  Future<void> initializeState() async {
    if (isInitialized) return;
    var data = await rootBundle.loadString('assets/data/mahawer.json');
    var mahawerData = jsonDecode(data) as List<dynamic>;
    var surahWithMahawerData = mahawerData.map((mahwer) => SurahWithMahawer.fromJson(mahwer)).toList();

    isInitialized = true;
    surahsWithMahawer = surahWithMahawerData;
    state = surahWithMahawerData;

  }

  Map<String, dynamic> findSections(int verseIndex, int surahIndex) {

    Map<String, dynamic> result = {};

    SurahWithMahawer? surah;

    for (SurahWithMahawer s in surahsWithMahawer!) {
      if (s.surahID == surahIndex) {
        surah = s;
        break;
      }
    };


    print('${surah?.surahID} found ');

    if (surah == null) {
      return result;
    }

    for (var section in surah.moqadema.sections) {
      if (verseIndex >= section.startAya && verseIndex <= section.endAya) {
        result = {
         'id': section.id,
         'text': section.text,
         'range': '[${section.startAya}-${section.endAya}]'
        };
      }
    }

    for (var mahwar in surah.mahawer) {
      for (var section in mahwar.sections) {
        if (verseIndex >= section.startAya && verseIndex <= section.endAya) {
          result = {
            'id': section.id,
            'text': section.text,
            'range': '[${section.startAya}-${section.endAya}]'
          };
        }
      }
    }

    return result;
  }

  void assignColorsToSections() {
    // sectionsWithColors = {};

    int colorIndex = 0;

    for (var surah in surahsWithMahawer ?? []) {
      for (var section in surah.moqadema.sections) {
        sectionsWithColorsPortriat[section.id] = colorsPortriat[colorIndex % colorsPortriat.length];
        sectionsWithColorsLandscape[section.id] = colorsLandscape[colorIndex % colorsLandscape.length];
        colorIndex++;
      }

      for (var mahwar in surah.mahawer) {
        for (var section in mahwar.sections) {
          sectionsWithColorsPortriat[section.id] = colorsPortriat[colorIndex % colorsPortriat.length];
          sectionsWithColorsLandscape[section.id] = colorsLandscape[colorIndex % colorsLandscape.length];
          colorIndex++;
        }
      }
    }
  }

  Color? getSectionColorPortriat (double sectionId) {
    assignColorsToSections();
    return sectionsWithColorsPortriat[sectionId];
  }

  Color? getSectionColorLandscape (double sectionId) {
    assignColorsToSections();
    return sectionsWithColorsLandscape[sectionId];
  }

}

final mahawerNotifierProvider =
    NotifierProvider<SurahWithMahawerProvider, List<SurahWithMahawer>>(
  () => SurahWithMahawerProvider(),
);
