class Juz {
  final int index;
  final int sura;
  final int aya;
  final int page;

  Juz({
    required this.index,
    required this.sura,
    required this.aya,
    required this.page,
  });

  factory Juz.fromJson(Map<String, dynamic> json) {
    return Juz(
      index: json['index'],
      sura: json['sura'],
      aya: json['aya'],
      page: json['page'],
    );
  }
}

class JuzList {
  final List<Juz> juzs;

  JuzList({required this.juzs});

  factory JuzList.fromJson(List<dynamic> json) {
    List<Juz> juzs = json.map((juz) => Juz.fromJson(juz)).toList();
    return JuzList(juzs: juzs);
  }
}
