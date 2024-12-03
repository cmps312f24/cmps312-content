import 'package:basair/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/surah_provider.dart';
import '../providers/juz_provider.dart';
import '../widgets/surah_card.dart';
import '../widgets/juz_card.dart';
import '../providers/verses_provider.dart';

class NavigationScreen extends ConsumerStatefulWidget {
  const NavigationScreen({super.key});

  @override
  ConsumerState<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends ConsumerState<NavigationScreen> {
  String selectedFilter = 'Surah';
  String searchQuery = '';

  void _searchPage(BuildContext context) {
    if (selectedFilter == 'Page') {
      final pageNumber = int.tryParse(searchQuery);
      if (pageNumber != null) {
        context.go(AppRouter.quranViewer.path, extra: pageNumber);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a valid page number.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final surahs = ref.watch(surahProvider);
    final juzs = ref.watch(juzProvider);
    final versesProvider = ref.read(versesNotifierProvider.notifier);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  hintText:
                      "ابحث باسم السورة ،أو الجزء، رقم الصفحة ، الايه....",
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => _searchPage(context),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                onSubmitted: (_) => _searchPage(context),
              ),
            ),
            // Radio buttons for selection
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 'Surah',
                  groupValue: selectedFilter,
                  onChanged: (value) {
                    setState(() {
                      selectedFilter = value.toString();
                    });
                  },
                ),
                const Text('سورة'),
                Radio(
                  value: 'Juz',
                  groupValue: selectedFilter,
                  onChanged: (value) {
                    setState(() {
                      selectedFilter = value.toString();
                    });
                  },
                ),
                const Text('جزء'),
                Radio(
                  value: 'Page',
                  groupValue: selectedFilter,
                  onChanged: (value) {
                    setState(() {
                      selectedFilter = value.toString();
                    });
                  },
                ),
                const Text('صفحة'),
                Radio(
                  value: 'Ayah',
                  groupValue: selectedFilter,
                  onChanged: (value) {
                    setState(() {
                      selectedFilter = value.toString();
                    });
                  },
                ),
                const Text('آيه'),
              ],
            ),
            // Display content based on selected filter
            Expanded(
              child: Builder(
                builder: (context) {
                  if (selectedFilter == 'Surah') {
                    final filteredSurahs = searchQuery.isEmpty
                        ? surahs
                        : surahs
                            .where((surah) => surah.name
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()))
                            .toList();
                    return ListView(
                      children: filteredSurahs
                          .map((surah) => SurahCard(surah: surah))
                          .toList(),
                    );
                  } else if (selectedFilter == 'Juz') {
                    final filteredJuzs = searchQuery.isEmpty
                        ? juzs
                        : juzs
                            .where((juz) =>
                                juz.index.toString().contains(searchQuery))
                            .toList();
                    return ListView(
                      children: filteredJuzs.map((juz) {
                        int pageNumber = juz.page;
                        return JuzCard(
                            juzNumber: juz.index, pageNumber: pageNumber);
                      }).toList(),
                    );
                  } else if (selectedFilter == 'Page') {
                    return const Center(
                        child: Text("أدخل رقم الصفحة المراد البحث عنها"));
                  } else if (selectedFilter == 'Ayah') {
                    final filteredVerses =
                        versesProvider.searchVersesByText(searchQuery);

                    return ListView(
                      children: filteredVerses.values.map((verse) {
                        final surahName =
                            versesProvider.getSurahNameByVerseId(verse.id);
                        final pageNumber =
                            versesProvider.getPageNumberByVerseId(verse.id);

                        return ListTile(
                          title: Text(verse.text),
                          subtitle:
                              Text('Surah: $surahName, Ayah: ${verse.id}'),
                          onTap: () {
                            context.go(AppRouter.quranViewer.path,
                                extra: pageNumber);
                          },
                        );
                      }).toList(),
                    );
                  } else {
                    return ListView(
                      children: surahs
                          .map((surah) => SurahCard(surah: surah))
                          .toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
