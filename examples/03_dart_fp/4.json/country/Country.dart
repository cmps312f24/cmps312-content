class Country {
  final String code;
  final String name;
  final String capital;
  final String continent;
  final String region;
  final int population;
  final int area;

  Country({
    required this.code,
    required this.name,
    required this.capital,
    required this.continent,
    required this.region,
    required this.population,
    this.area = 0,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        code: json['code'],
        name: json['name'],
        capital: json['capital'],
        continent: json['continent'],
        region: json['region'],
        population: json['population'],
        area: json['area'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'capital': capital,
        'continent': continent,
        'region': region,
        'population': population,
        'area': area,
      };

  @override
  String toString() =>
      'name: $name, capital: $capital, population: $population, continent: $continent, region: $region, area: $area';
}
