class Surah {
  final int id;
  final String name;
  final String englishName;
  final int ayaCount;
  final String type;

  const Surah({
    required this.id,
    required this.name,
    required this.englishName,
    required this.ayaCount,
    required this.type,
  });

  @override
  String toString() =>
      '${this.id}) ${this.name} ${this.englishName}, ${this.type} ${this.ayaCount} ayat';

  // Convert a Surah object to a JSON map
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'englishName': englishName,
        'ayaCount': ayaCount,
        'type': type,
      };

  // Convert a JSON map to a Surah object
  Surah.fromJson(Map<String, dynamic> json):
    id = json['id'] as int,
    name = json['name'] as String,
    englishName = json['englishName'] as String,
    ayaCount = json['ayaCount'] as int,
    type = json['type'] as String;
}
