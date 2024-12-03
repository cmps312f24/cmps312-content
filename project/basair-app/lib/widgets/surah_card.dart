import 'package:basair/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/surah.dart';

class SurahCard extends StatelessWidget {
  final Surah surah;

  const SurahCard({required this.surah, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(surah.id.toString()), // Surah number
        title: Text(surah.name),
        subtitle: Text('${surah.type} • ${surah.ayaCount} آيات'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon:
                  const Icon(Icons.account_tree_sharp), // Use the desired icon
              onPressed: () {
                if (surah.id == 4) {
                  context.go(AppRouter.topicScreen.path);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: AlertDialog(
                          title: const Text('تنبيه'),
                          content: const Text('لا يوجد محاور لهذه السورة بعد'),
                          actions: [
                            TextButton(
                              child: const Text('حسناً'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            // Define what this icon button should do if needed
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                context.go(AppRouter.quranViewer.path, extra: surah.page);
              },
            ),
          ],
        ),
      ),
    );
  }
}
