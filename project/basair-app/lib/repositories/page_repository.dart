import 'dart:convert';
import 'package:basair/models/mahwar.dart';
import 'package:basair/models/page.dart';
import 'package:flutter/services.dart';

class PageRepository {
  List<Page> _pages = [];

  PageRepository() {
    _loadData();
  }

  Future<void> _loadData() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/pages.json');
    final List<dynamic> jsonData = jsonDecode(jsonString);
    _pages = _pages = jsonData.map((data) => Page.fromJson(data)).toList();
  }

  int getFirstPage(int surahId) {
    return _pages.firstWhere((page) => page.sura == surahId).index;
  }

  int getMihwarPage(SurahWithMahawer surah, Mahwar mihwar) {
    int page = 1;
    Section fistSection = mihwar.sections[0];
    // a list of the pages of the surah and more because we don't want and index out of bounds error
    List<Page> surahPages =
        _pages.where((page) => page.sura >= surah.surahID).toList();
    for (int i = 0; i < (surahPages.length - 1); i++) {
      if (fistSection.startAya >= surahPages[i].aya &&
          fistSection.startAya < surahPages[i + 1].aya) {
        page = surahPages[i].index;
        break;
      }
    }
    return page;
  }

  int getSectionPage(SurahWithMahawer surah, Section section) {
    int page = 1;
    List<Page> surahPages =
        _pages.where((page) => page.sura >= surah.surahID).toList();
    for (int i = 0; i < (surahPages.length - 1); i++) {
      if (surahPages[i + 1].sura != surah.surahID) {
        page = surahPages[i].index;
        break;
      }
      if (section.startAya >= surahPages[i].aya &&
          section.startAya < surahPages[i + 1].aya) {
        page = surahPages[i].index;
        break;
      }
    }
    return page;
  }

  int getPageFromAya(int surahID, int aya) {
    int page = 1;
    List<Page> surahPages =
        _pages.where((page) => page.sura >= surahID).toList();
    for (int i = 0; i < (surahPages.length - 1); i++) {
      if (surahPages[i + 1].sura != surahID) {
        page = surahPages[i].index;
        break;
      }
      if (aya >= surahPages[i].aya && aya < surahPages[i + 1].aya) {
        page = surahPages[i].index;
        break;
      }
    }
    return page;
  }
}
