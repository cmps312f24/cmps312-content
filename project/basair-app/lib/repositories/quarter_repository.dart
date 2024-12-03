import 'dart:convert';
import 'package:basair/models/quarters.dart';
import 'package:flutter/services.dart';

class QuarterRepository {
  List<Quarter> _quarters = [];

  QuarterRepository() {
    loadJuzList();
  }

  Future<void> loadJuzList() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/quarters.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    _quarters = jsonList.map((jsonItem) => Quarter.fromJson(jsonItem)).toList();
  }

  Quarter getquarterFromIndex(int index) {
    return _quarters[index];
  }
}
