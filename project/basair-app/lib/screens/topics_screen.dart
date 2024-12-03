import 'package:basair/models/mahwar.dart';
import 'package:basair/providers/topics_provider.dart';
import 'package:basair/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:basair/repositories/page_repository.dart';
import 'package:go_router/go_router.dart';

class TopicsScreen extends ConsumerStatefulWidget {
  const TopicsScreen({super.key});

  @override
  ConsumerState<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends ConsumerState<TopicsScreen> {
  final PageRepository pageRepository = PageRepository();

  @override
  Widget build(BuildContext context) {
    final topicsAsyncValue = ref.watch(topicsProvider);
    final displayMode = ref.watch(displayModeProvider);

    return Directionality(
      textDirection: TextDirection.rtl, // Set the entire screen to RTL
      child: Scaffold(
        body: Column(
          children: [
            searchBar(displayMode),
            Expanded(
              child: topicsAsyncValue.when(
                data: (items) {
                  return _buildListView(displayMode, items);
                },
                error: (e, _) => Center(child: Text('Error: $e')),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(DisplayMode displayMode, List<SurahWithMahawer> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final surah = items[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ListTile(
            title: Text('${surah.surahID}  سورة النساء  '),
            subtitle: _buildSubtitle(displayMode, surah, items),
            onTap: () {
              final pageIndex = pageRepository.getFirstPage(surah.surahID);
              context.go(AppRouter.quranViewer.path, extra: pageIndex);
            },
          ),
        );
      },
    );
  }

  Widget _buildSubtitle(DisplayMode displayMode, SurahWithMahawer surah,
      List<SurahWithMahawer> items) {
    switch (displayMode) {
      case DisplayMode.surahs:
        return _buildSurahView(items);
      case DisplayMode.mahawir:
        return _buildMahwarList(
            surah); // we pass the surah to get the page number
      case DisplayMode.sections:
        return _buildSectionList(surah);
      default:
        return const Text('غير محدد');
    }
  }

  Widget _buildMahwarList(SurahWithMahawer surah) {
    return Consumer(
      builder: (context, watch, child) {
        final searchQuery = ref.watch(searchQueryProvider);
        // Filter mahwars based on the search query
        final filteredMahwars = surah.mahawer.where((mahwar) {
          return mahwar.title.contains(searchQuery);
        }).toList();

        return Column(
          children: filteredMahwars.map((mahwar) {
            return ListTile(
              title: Text(mahwar.title),
              onTap: () {
                final pageIndex = pageRepository.getMihwarPage(surah, mahwar);
                context.go(AppRouter.quranViewer.path, extra: pageIndex);
              },
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildSectionList(SurahWithMahawer surah) {
    return Consumer(
      builder: (context, watch, child) {
        final searchQuery = ref.watch(searchQueryProvider);
        // Filter sections based on the search query
        final filteredSections = surah.mahawer.expand((mahwar) {
          return mahwar.sections.where((section) {
            return section.text.contains(searchQuery);
          }).toList();
        }).toList();

        return Column(
          children: filteredSections.map((section) {
            return ListTile(
              title: Text(section.text),
              onTap: () {
                final pageIndex = pageRepository.getSectionPage(surah, section);
                context.go(AppRouter.quranViewer.path, extra: pageIndex);
              },
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildSurahView(List<SurahWithMahawer> surahs) {
    return Column(
      children: surahs.map((surah) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ExpansionTile(
            title: Text(surah.surahID.toString()),
            subtitle: Text('مقدمة: ${surah.moqadema.title}'),
            children: surah.mahawer.map((mahwar) {
              return ExpansionTile(
                title: Text(mahwar.title),
                children: mahwar.sections.map((section) {
                  return ListTile(
                    title: Text(section.text),
                    onTap: () {
                      final pageIndex =
                          pageRepository.getSectionPage(surah, section);
                      context.go(AppRouter.quranViewer.path, extra: pageIndex);
                    },
                  );
                }).toList(),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget searchBar(DisplayMode displayMode) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
              decoration: const InputDecoration(
                hintText: 'المواضيع',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
        const SizedBox(width: 20),
        DropdownButton<DisplayMode>(
          value: displayMode,
          items: DisplayMode.values.map((mode) {
            return DropdownMenuItem<DisplayMode>(
              value: mode,
              child: Text(mode.toString().split('.').last),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              ref.read(displayModeProvider.notifier).state = value;
            }
          },
        ),
      ],
    );
  }
}
