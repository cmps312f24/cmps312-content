import 'dart:async';

import 'package:basair/models/verses.dart';
import 'package:basair/providers/surahWithMahawer_provider.dart';
import 'package:basair/providers/tafsir_provider.dart';
import 'package:basair/providers/verses_provider.dart';
import 'package:basair/routes/app_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quran/quran.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/src/source.dart';
import 'package:to_arabic_number/to_arabic_number.dart';

class QuranViewerScreen extends ConsumerStatefulWidget {
  final int pageNumber;
  const QuranViewerScreen({super.key, required this.pageNumber});

  @override
  ConsumerState<QuranViewerScreen> createState() => _QuranViewerScreenState();
}

class _QuranViewerScreenState extends ConsumerState<QuranViewerScreen> {
  late int pageNumber;
  int? selectedVerse;
  OverlayEntry? _overlayEntry;
  Offset _tapPosition = Offset.zero;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    pageNumber = widget.pageNumber;
    _loadVersesForPage();
  }

  void _loadVersesForPage() {
    final verseNotifier = ref.read(versesNotifierProvider.notifier);
    verseNotifier.loadVersesByPage(pageNumber);
  }

  void _removeMenu() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      setState(() {
        selectedVerse = null;
      });
    }
  }

  Future<void> playAudio(int surahIndex, int verse) async {
    final surahNumber = surahIndex.toString().padLeft(3, '0');
    final ayahNumber = verse.toString().padLeft(3, '0');
    await player.play(UrlSource(
        'https://everyayah.com/data/Abdul_Basit_Murattal_192kbps/$surahNumber$ayahNumber.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    final surahsOnPage = ref.watch(versesNotifierProvider);
    // final tafsirState = ref.watch(tafsirNotifierProvider);
    final mahawerNotifier = ref.read(mahawerNotifierProvider.notifier);
    final tafsirNotifier = ref.read(tafsirNotifierProvider.notifier);

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      // Horizontal View Code
      return Scaffold(
        backgroundColor: Color(0xffFFFBE6),
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Color(0xffFFFBE6),
          title: Padding(
            padding: const EdgeInsets.only(right: 12, left: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          context.go(AppRouter.navigation.path);
                        },
                        icon: Icon(Icons.home_rounded))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${ref.read(versesNotifierProvider.notifier).getSurahTypeByPage(pageNumber)}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff347928)),
                    ),
                    Text(
                      ' سورة ${ref.read(versesNotifierProvider.notifier).getSurahNameByPage(pageNumber)}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff347928)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: surahsOnPage.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding:
                    EdgeInsets.only(right: 30, left: 30, top: 10, bottom: 10),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    // Loop through each surah entry and create a separate Table
                    ...surahsOnPage.entries.map((entry) {
                      final surahIndex = entry.key;
                      final verses = entry.value;

                      final List<List<Verse>> groupedVerses = [];
                      List<Verse>? currentGroup;
                      String? lastSectionId;

                      for (var verse in verses) {
                        final sectionData =
                            mahawerNotifier.findSections(verse.id, surahIndex);
                        final sectionId = sectionData['id']?.toString();

                        if (sectionId == null || sectionId != lastSectionId) {
                          if (currentGroup != null) {
                            groupedVerses.add(currentGroup);
                          }
                          currentGroup = [verse];
                        } else {
                          currentGroup!.add(verse);
                        }
                        lastSectionId = sectionId;
                      }

                      if (currentGroup != null) {
                        groupedVerses.add(currentGroup);
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            // Display Surah Name
                            if (verses.isNotEmpty && verses[0].id == 1)
                              Text(
                                '${ref.read(versesNotifierProvider.notifier).getSurahNameById(surahIndex)}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 7, 89, 10),
                                ),
                              ),
                            // Display Basmala
                            if (verses.isNotEmpty &&
                                surahIndex != 9 &&
                                surahIndex != 1 &&
                                verses[0].id == 1)
                              const Text(
                                'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 205, 10, 10),
                                ),
                              ),
                            Table(
                              border: TableBorder.all(
                                  color: Color(0xff347928), width: 2),
                              children: groupedVerses.map((groupEntry) {
                                final sectionData = mahawerNotifier
                                    .findSections(groupEntry[0].id, surahIndex);
                                final sectionId = sectionData['id']?.toString();
                                final sectionText =
                                    sectionData['text']?.toString() ?? '';
                                final sectionRange =
                                    sectionData['range']?.toString() ?? '';

                                return TableRow(
                                  decoration: BoxDecoration(
                                    color: sectionId != null
                                        ? mahawerNotifier
                                            .getSectionColorLandscape(
                                                double.parse(sectionId))
                                        : Colors.transparent,
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        sectionId != null
                                            ? "المحور رقم $sectionId \n $sectionText \n الآيات $sectionRange"
                                            : 'المحور غير متوفر حالياً',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        alignment: WrapAlignment.end,
                                        direction: Axis.horizontal,
                                        spacing: 2.0,
                                        runSpacing: 2.0,
                                        children: groupEntry.map((verse) {
                                          return GestureDetector(
                                            onTap: () {
                                              playAudio(surahIndex, verse.id);
                                            },
                                            onLongPress: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      'تفسير الآية ${verse.id}',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    content:
                                                        FutureBuilder<String>(
                                                      future: tafsirNotifier
                                                          .getTafsir(surahIndex,
                                                              verse.id),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return const Text(
                                                              "يتم التحميل .. يرجى الانتظار");
                                                        } else if (snapshot
                                                            .hasError) {
                                                          return const Text(
                                                              "حدث خطأ أثناء تحميل التفسير");
                                                        } else {
                                                          return Text(snapshot
                                                                  .data ??
                                                              "No Tafsir available");
                                                        }
                                                      },
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text(
                                                          "اغلاق",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Text(
                                              '${verse.text}  ${getVerseEndSymbol(verse.id)} ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: (pageNumber == 1 ||
                                                        pageNumber == 2)
                                                    ? 23
                                                    : 20,
                                                color: verse.id == selectedVerse
                                                    ? const Color.fromARGB(
                                                        255, 29, 188, 61)
                                                    : Colors.black,
                                              ),
                                              textAlign: TextAlign.right,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (pageNumber < 604) {
                      pageNumber++;
                      _removeMenu();
                      _loadVersesForPage();
                    }
                  });
                },
                icon: const Icon(Icons.arrow_back, color: Color(0xff347928))),
            Container(
              padding: EdgeInsets.all(4.0),
              margin: EdgeInsets.only(bottom: 4.0, top: 4.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const []),
              height: 35,
              width: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    Arabic.number(pageNumber.toString()),
                    style: const TextStyle(color: Colors.red, fontSize: 26),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    if (pageNumber > 1) {
                      pageNumber--;
                      _removeMenu();
                      _loadVersesForPage();
                    }
                  });
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: Color(0xff347928),
                )),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffFFFBE6),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xffFFFBE6),
        title: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        context.go(AppRouter.navigation.path);
                      },
                      icon: const Icon(Icons.home_rounded))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${ref.read(versesNotifierProvider.notifier).getSurahTypeByPage(pageNumber)}',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff347928)),
                  ),
                  Text(
                    ' سورة ${ref.read(versesNotifierProvider.notifier).getSurahNameByPage(pageNumber)}',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff347928)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: surahsOnPage.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(
                  right: 30, left: 30, top: 10, bottom: 10),
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: surahsOnPage.entries.map((entry) {
                    final surahIndex = entry.key;
                    final verses = entry.value;

                    return Center(
                      child: Column(
                        crossAxisAlignment: (pageNumber == 1 || pageNumber == 2)
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: RichText(
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                softWrap: true,
                                locale: const Locale("ar"),
                                text: TextSpan(
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    children: [
                                      if (verses.isNotEmpty &&
                                          verses[0].id == 1)
                                        TextSpan(
                                          text:
                                              '\n ${ref.read(versesNotifierProvider.notifier).getSurahNameById(surahIndex)} \n',
                                          style: const TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 7, 89, 10)),
                                        ),
                                      if (verses.isNotEmpty &&
                                          (surahIndex != 9 &&
                                              surahIndex != 1) &&
                                          (verses[0].id == 1))
                                        const TextSpan(
                                          text:
                                              'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ\n',
                                          style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 205, 10, 10)),
                                        ),
                                      ...verses.map(
                                        (verse) => TextSpan(
                                            text:
                                                '${verse.text}  ${getVerseEndSymbol(verse.id)} ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: (pageNumber == 1 ||
                                                      pageNumber == 2)
                                                  ? 23
                                                  : 20,
                                              color: verse.id == selectedVerse
                                                  ? const Color.fromARGB(
                                                      255, 29, 188, 61)
                                                  : (surahIndex != 4
                                                      ? Colors.black
                                                      : mahawerNotifier.getSectionColorPortriat(
                                                          double.tryParse(mahawerNotifier
                                                                      .findSections(
                                                                          verse
                                                                              .id,
                                                                          surahIndex)['id']
                                                                      ?.toString() ??
                                                                  '') ??
                                                              0.0)),
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTapDown =
                                                  (TapDownDetails details) {
                                                setState(() {
                                                  _removeMenu();
                                                  _tapPosition =
                                                      details.globalPosition;
                                                  selectedVerse = verse.id;
                                                });
                                                // _removeMenu();
                                                _overlayEntry = OverlayEntry(
                                                  builder: (context) =>
                                                      Positioned(
                                                    top: _tapPosition.dy - 50,
                                                    left: _tapPosition.dx,
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        decoration: BoxDecoration(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                252, 245, 211),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black26,
                                                                blurRadius: 8.0,
                                                                offset: Offset(
                                                                    0, 4),
                                                              )
                                                            ]),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                IconButton(
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .play_arrow_rounded,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            30,
                                                                            107,
                                                                            32),
                                                                    size: 20,
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    _removeMenu();
                                                                    playAudio(
                                                                        surahIndex,
                                                                        verse
                                                                            .id);
                                                                  },
                                                                ),
                                                                const Text(
                                                                  'تشغيل',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              ],
                                                            ),
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                IconButton(
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .assignment,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            81,
                                                                            76,
                                                                            175),
                                                                    size: 20,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    _removeMenu();
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              Text(
                                                                            'تفسير الآية ${verse.id}',
                                                                            style:
                                                                                const TextStyle(fontWeight: FontWeight.bold),
                                                                          ),
                                                                          content:
                                                                              FutureBuilder<String>(
                                                                            future:
                                                                                tafsirNotifier.getTafsir(surahIndex, verse.id),
                                                                            builder:
                                                                                (context, snapshot) {
                                                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                return const Text("يتم التحميل .. يرجى الانتظار");
                                                                              } else if (snapshot.hasError) {
                                                                                return const Text("حدث خطأ أثناء تحميل التفسير");
                                                                              } else {
                                                                                return Text(snapshot.data ?? "No Tafsir available");
                                                                              }
                                                                            },
                                                                          ),
                                                                          actions: <Widget>[
                                                                            TextButton(
                                                                              child: const Text(
                                                                                "اغلاق",
                                                                                style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                                const Text(
                                                                  'تفسير',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              ],
                                                            ),
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                IconButton(
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .auto_stories_outlined,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            165,
                                                                            52,
                                                                            54),
                                                                    size: 20,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    _removeMenu();
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              Text(
                                                                            ' شرح المحور الآية ${verse.id}',
                                                                            style:
                                                                                const TextStyle(fontWeight: FontWeight.bold),
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                          ),
                                                                          content:
                                                                              Text(
                                                                            surahIndex != 4
                                                                                ? "محور هذه السورة غير متوفر"
                                                                                : "المحور رقم ${mahawerNotifier.findSections(verse.id, surahIndex)['id']} \n ${mahawerNotifier.findSections(verse.id, surahIndex)['text']} \n الآيات${mahawerNotifier.findSections(verse.id, surahIndex)['range']}",
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            style:
                                                                                const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                                                                          ),
                                                                          actions: <Widget>[
                                                                            TextButton(
                                                                              child: const Text(
                                                                                "اغلاق",
                                                                                style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                                const Text(
                                                                  'شرح المحور',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                                Overlay.of(context)
                                                    .insert(_overlayEntry!);
                                              }),
                                      ),
                                    ])),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (pageNumber < 604) {
                    pageNumber++;
                    _removeMenu();
                    _loadVersesForPage();
                  }
                });
              },
              icon: const Icon(Icons.arrow_back, color: Color(0xff347928))),
          Container(
            padding: const EdgeInsets.all(4.0),
            margin: const EdgeInsets.only(bottom: 4.0, top: 4.0),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const []),
            height: 35,
            width: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  Arabic.number(pageNumber.toString()),
                  style: const TextStyle(color: Colors.red, fontSize: 26),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  if (pageNumber > 1) {
                    pageNumber--;
                    _removeMenu();
                    _loadVersesForPage();
                  }
                });
              },
              icon: const Icon(
                Icons.arrow_forward,
                color: Color(0xff347928),
              )),
        ],
      ),
    );
  }
}
