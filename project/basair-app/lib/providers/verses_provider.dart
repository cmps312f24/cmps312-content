import 'dart:convert';
import 'package:basair/models/page.dart';
import 'package:basair/models/verses.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VersesProvider extends Notifier<Map<int, List<Verse>>> {
  static const int LastSurahNumber = 114;
  List<SurahVerses>? allSurahData;
  List<Page>? allPages;
  bool isInitialized = false;

  @override
  Map<int, List<Verse>> build() {
    initializeState();
    return {};
  }

  Future<void> initializeState() async {
    if (isInitialized) return;
    var dataForPages = await rootBundle.loadString('assets/data/pages.json');
    var pagesData = jsonDecode(dataForPages) as List<dynamic>;

    var dataForVerses = await rootBundle.loadString('assets/data/verses.json');
    var surahsData = jsonDecode(dataForVerses) as List<dynamic>;

    allPages = pagesData.map((page) => Page.fromJson(page)).toList();
    allSurahData =
        surahsData.map((surah) => SurahVerses.fromJson(surah)).toList();

    // Set the flag to indicate initialization is complete
    isInitialized = true;
    print("Initialization complete: Pages and Surahs loaded.");
    state = {};
  }

  Future<void> loadVersesByPage(int pageNumber) async {
    // Wait until initialization is complete
    while (!isInitialized) {
      await Future.delayed(const Duration(milliseconds: 50));
    }

    final pageData = getPageData(pageNumber);
    if (pageData == null) {
      print("No page data found for page number $pageNumber");
      return;
    }

    int currentSurahNumber = pageData.sura;
    int currentAya = pageData.aya;

    final nextPageData = getPageData(pageNumber + 1);
    int nextPageSurahNumber = nextPageData?.sura ?? LastSurahNumber;
    int nextPageAya = nextPageData?.aya ?? 1;
    Map<int, List<Verse>> surahsOnPage = {};

    bool isLastPage = nextPageData == null;
    bool lastSurahReached = false;

    while (!lastSurahReached) {
      final surahData = getSurahData(currentSurahNumber);
      if (surahData == null) break;

      List<Verse> allAyas = surahData.verses;
      int startIndex = currentAya - 1;
      int endIndex = allAyas.length;

      if (!isLastPage && currentSurahNumber == nextPageSurahNumber) {
        endIndex = nextPageAya - 1;
        lastSurahReached = true;
      }

      final versesOnPage = allAyas.sublist(startIndex, endIndex);
      surahsOnPage[currentSurahNumber] = versesOnPage;

      if (!lastSurahReached) {
        if (isLastPage && currentSurahNumber >= LastSurahNumber) {
          lastSurahReached = true;
        } else {
          currentSurahNumber += 1;
          currentAya = 1;
        }
      }
    }
    state = surahsOnPage;
  }

  Page? getPageData(int pageNumber) {
    return allPages?.firstWhere(
      (page) => page.index == pageNumber,
    );
  }

  SurahVerses? getSurahData(int surahNumber) {
    return allSurahData?.firstWhere(
      (surah) => surah.id == surahNumber,
    );
  }

  String? getSurahNameById(int surahId) {
    return allSurahData
        ?.firstWhere(
          (surah) => surah.id == surahId,
        )
        .name;
  }

  String? getSurahTypeByPage(int pageNumber) {
    int? surahNumber = getSurahIdByPage(pageNumber);

    var foundSurah =
        allSurahData?.firstWhere((surah) => surah.id == surahNumber);
    if (foundSurah?.type == 'madinan') {
      return 'مدنية';
    } else {
      return 'مكية';
    }
  }

  String? getSurahNameByPage(int pageNumber) {
    int? surahNumber = getSurahIdByPage(pageNumber);

    var foundSurah =
        allSurahData?.firstWhere((surah) => surah.id == surahNumber);
    return foundSurah?.name;
  }

  int? getSurahIdByPage(int pageNumber) {
    var foundPage = allPages?.firstWhere((page) => page.index == pageNumber);

    return foundPage?.sura;
  }

  // Get Surah name by verse ID
  String? getSurahNameByVerseId(int verseId) {
    for (var surah in allSurahData!) {
      for (var verse in surah.verses) {
        if (verse.id == verseId) {
          return surah.name;
        }
      }
    }
    return null;
  }

  // Get Page Number by verse ID
  int? getPageNumberByVerseId(int verseId) {
    for (var page in allPages!) {
      if (page.aya == verseId) {
        return page.index;
      }
    }
    return null;
  }

  // Search for verses that contain a specific text or part of the text
  Map<int, Verse> searchVersesByText(String searchText) {
    Map<int, Verse> matchingVerses = {};

    for (var surah in allSurahData!) {
      for (var verse in surah.verses) {
        if (verse.text.contains(searchText)) {
          matchingVerses[verse.id] = verse;
        }
      }
    }

    return matchingVerses;
  }
}

final versesNotifierProvider =
    NotifierProvider<VersesProvider, Map<int, List<Verse>>>(
  () => VersesProvider(),
);
