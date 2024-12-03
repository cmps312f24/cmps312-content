class SurahWithMahawer {
  int surahID;
  Moqadema moqadema;
  List<Mahwar> mahawer;

  SurahWithMahawer({
    required this.surahID,
    required this.moqadema,
    required this.mahawer
  });

  factory SurahWithMahawer.fromJson(Map<String, dynamic> json){
    return SurahWithMahawer(
      surahID: json['surahID'],
      moqadema: Moqadema.fromJson(json['moqadema']),
      mahawer: (json['mahawer'] as List)
          .map((mahwar) => Mahwar.fromJson(mahwar))
          .toList(),
    );
  }
}

class Moqadema {
  String title;
  String range;
  List<Section> sections;

  Moqadema({
    required this.title,
    required this.range,
    required this.sections,
  });

  factory Moqadema.fromJson(Map<String, dynamic> json) {
    return Moqadema(
      title: json['title'],
      range: json['range'],
      sections: (json['sections'] as List)
          .map((section) => Section.fromJson(section))
          .toList(),
    );
  }
}


class Mahwar {
  int id;
  String counter;
  String title;
  String text;
  String range;
  List<Section> sections;

  Mahwar({
    required this.id,
    required this.counter,
    required this.title,
    required this.text,
    required this.range,
    required this.sections,
  });

  factory Mahwar.fromJson(Map<String, dynamic> json) {
    return Mahwar(
      id: json['id'],
      counter: json['counter'],
      title: json['title'],
      text: json['text'],
      range: json['range'],
      sections: (json['sections'] as List)
          .map((section) => Section.fromJson(section))
          .toList(),
    );
  }
}

class Section {
  double id;
  String text;
  int startAya;
  int endAya;

  Section({
    required this.id,
    required this.text,
    required this.startAya,
    required this.endAya,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      text: json['text'],
      startAya: json['startAya'],
      endAya: json['endAya'],
    );
  }
}