import 'dart:convert';
import 'dart:io';
import 'Country.dart';

class CountryRepository {
  late final List<Country> countries;

  CountryRepository() {
    final filePath = 'data/countries.json';
    final jsonData = _getFileContent(filePath);

    final List<dynamic> jsonList = jsonDecode(jsonData);
    countries = jsonList.map((json) => Country.fromJson(json)).toList();
  }

  List<Country> getCountriesByContinent(String continent) {
    return countries
        .where((country) => country.continent.toLowerCase() == continent.toLowerCase())
        .toList()
          ..sort((a, b) => b.population.compareTo(a.population));
  }

  List<Country> getCountriesByRegion(String region) {
    return countries
        .where((country) => country.region.toLowerCase() == region.toLowerCase())
        .toList()
          ..sort((a, b) => a.population.compareTo(b.population));
  }

  Map<String, int> get countryCountByContinent {
    return countries.fold<Map<String, int>>({}, (map, country) {
      map[country.continent] = (map[country.continent] ?? 0) + 1;
      return map;
    });
  }

  Map<String, int> get populationByContinent {
    return countries.fold<Map<String, int>>({}, (map, country) {
      map[country.continent] = (map[country.continent] ?? 0) + country.population;
      return map;
    });
  }

  Country? getPopulousCountry() {
    return countries.reduce((a, b) => a.population > b.population ? a : b);
  }

  Country? getLeastPopulatedCountry() {
    return countries
        .where((country) => country.population > 0)
        .reduce((a, b) => a.population < b.population ? a : b);
  }

  Country? getLargestCountry() {
    return countries.reduce((a, b) => a.area > b.area ? a : b);
  }

  Country? getSmallestCountry() {
    return countries
        .where((country) => country.area > 0)
        .reduce((a, b) => a.area < b.area ? a : b);
  }

  String _getFileContent(String filePath) {
    final file = File(filePath);
    return file.readAsStringSync();
  }
}