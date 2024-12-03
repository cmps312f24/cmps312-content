import 'dart:convert';
import 'package:basair/models/tafsir.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TafsirProvider extends Notifier<List<Tafsir>?> {

  List<Tafsir>? allTafsirData;
  bool isInitialized = false;

  @override
  List<Tafsir> build() {
    initializeState();
    return [];
  }

  Future<void> initializeState() async{
    if (isInitialized) return;
    var data = await rootBundle.loadString('assets/data/tafsir.json');
    var tafsirData = jsonDecode(data) as List<dynamic>;

    // Update state with the parsed list
    allTafsirData = tafsirData.map((tafsir) => Tafsir.fromJson(tafsir)).toList();
    state = allTafsirData;
    isInitialized = true;
    print("Initialization complete: Tafsir is loaded.");
  }


  Future<String> getTafsir(int surahNumber, int verseNumber) async {
    while (!isInitialized) {
      print('waiting for data to be loaded');
      await Future.delayed(Duration(milliseconds: 50));
    }

    var foundTafsir = allTafsirData?.firstWhere(
      (tafsir) => tafsir.index == surahNumber,
    );

    if (foundTafsir != null) {
      return foundTafsir.ayat[verseNumber].text;
    } else {
      return "التفسير غير متوفر";
    }
  }
    
}

final tafsirNotifierProvider = NotifierProvider<TafsirProvider, List<Tafsir>?>(
  () => TafsirProvider(),
);
