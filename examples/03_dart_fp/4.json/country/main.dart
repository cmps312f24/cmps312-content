import 'CountryRepository.dart';

void main() {
  var countryRepository = CountryRepository();
  print("> Top 5 populated countries by continent");
  countryRepository.getCountriesByContinent("Asia").take(5).forEach(print);

  print("\n> Top 5 least populated countries by region");
  countryRepository.getCountriesByRegion("Western Asia").take(5).forEach(print);

  print("\n> Country count by continent");
  var countryCountByContinent = countryRepository.countryCountByContinent;
  print(countryCountByContinent);

  print("\n> Population by continent");
  var populationByContinent = countryRepository.populationByContinent;
  populationByContinent.forEach((key, value) {
    print("$key - $value");
  });

  print("\n> Population by continent sorted");
  var continentList = populationByContinent.entries.toList();
  continentList.sort((a, b) => b.value.compareTo(a.value));
  continentList.forEach((entry) {
    print("${entry.key} - ${entry.value}");
    //print("%-8s: %,15d".format([entry.key, entry.value]));
  });

  print("\n> Country with the highest population");
  var populousCountry = countryRepository.getPopulousCountry();
  print(populousCountry);

  print("\n> Country with least Population");
  var lowestPopulation = countryRepository.getLeastPopulatedCountry();
  print(lowestPopulation);

  print("\n> Largest country (with biggest area)");
  var largestCountry = countryRepository.getLargestCountry();
  print(largestCountry);

  print("\n> Smallest country (with smallest area)");
  var smallestCountry = countryRepository.getSmallestCountry();
  print(smallestCountry);
}
