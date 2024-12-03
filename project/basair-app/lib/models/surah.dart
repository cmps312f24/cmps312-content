class Surah {
  int id;
  String name;
  int ayaCount;
  String type;
  int page;

  Surah(
      {required this.id,
      required this.name,
      required this.ayaCount,
      required this.type,
      required this.page});

  // create an Surah object from a map
  factory Surah.fromJson(Map<String, dynamic> map) {
    return Surah(
      id: map['id'],
      name: map['name'],
      ayaCount: map['ayaCount'],
      type: map['typeArabic'],
      page: map['page'],
    );
  }
}
