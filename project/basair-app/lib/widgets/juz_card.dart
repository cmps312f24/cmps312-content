import 'package:basair/repositories/page_repository.dart';
import 'package:basair/repositories/quarter_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:basair/routes/app_router.dart';

class JuzCard extends StatelessWidget {
  final int juzNumber;
  final int pageNumber; // Page number where the Juz starts

  const JuzCard({
    Key? key,
    required this.juzNumber,
    required this.pageNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate حزب numbers
    int hizbNumber1 = (juzNumber - 1) * 2 + 1;
    int hizbNumber2 = hizbNumber1 + 1;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      child: ListTile(
        onTap: () {
          // Navigate to QuranViewerScreen with the specific page number
          context.go(AppRouter.quranViewer.path, extra: pageNumber);
        },
        title: Text(
          'الجزء $juzNumber',
          style:
              Theme.of(context).textTheme.titleLarge, // Consistent text style
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Starts at Page $pageNumber',
            //   style: Theme.of(context).textTheme.bodyMedium,
            // ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 20.0,
              runSpacing: 16.0,
              children: [
                _buildHizbSection(context, hizbNumber1),
                _buildHizbSection(context, hizbNumber2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a Hizb section with a label and numbered buttons
  Widget _buildHizbSection(BuildContext context, int hizbNumber) {
    final quarterRepo = QuarterRepository();
    final pageRepo = PageRepository();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'الحزب $hizbNumber',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          children: [
            for (int i = 0; i < 4; i++)
              ElevatedButton(
                onPressed: () {
                  final quarter =
                      quarterRepo.getquarterFromIndex((hizbNumber - 1) * 4 + i);
                  context.go(AppRouter.quranViewer.path,
                      extra:
                          pageRepo.getPageFromAya(quarter.sura, quarter.aya));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12.0),
                  backgroundColor: const Color.fromARGB(
                      199, 13, 125, 1), // Use the secondary color
                ),
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
