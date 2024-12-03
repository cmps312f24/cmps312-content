class Page {
  int index;
  int sura;
  int aya;

  Page({
    required this.index,
    required this.sura,
    required this.aya
  });

// To create page object from json data
  factory Page.fromJson(Map<String, dynamic> map) {
    return Page(
      index: map['index'],
      sura: map['sura'],
      aya: map['aya'],
    );
  }
}