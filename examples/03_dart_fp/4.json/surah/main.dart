import 'SurahRepository.dart';

void main() {
  final surahRepository = SurahRepository();
  print('\n> Total number of Ayat: ${surahRepository.totalAyat}');
  print('> Number of surahs by type: ${surahRepository.surahCountByType}');
  print('> Aya count by surah type: ${surahRepository.ayaCountByType}');

  print('\n> Surahs having more than 200 Ayat:');
  surahRepository
      .getSurahsByAyaCount(200)
      .asMap()
      .forEach((i, surah) => print('${i + 1}: $surah'));

  print('\n> First 5 Medinan Surahs:');
  surahRepository.getSurahsByType('Medinan').take(5).forEach(print);

  print('\n> Longest Surah: ${surahRepository.getLongestSurah()}');
}
