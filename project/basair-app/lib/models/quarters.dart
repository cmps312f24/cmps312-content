class Quarter {
  int index;
  int sura;
  int aya;

  Quarter({
    this.index = 0,
    this.sura = 0,
    this.aya = 0,
  });

  // Factory method to create a Juz object from a map
  factory Quarter.fromJson(Map<String, dynamic> map) {
    return Quarter(
      index: map['index'] ?? 0,
      sura: map['sura'] ?? 0,
      aya: map['aya'] ?? 0,
    );
  }

  // Method to convert a Juz object to a map (optional)
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'sura': sura,
      'aya': aya,
    };
  }
}
