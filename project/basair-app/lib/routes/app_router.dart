import 'package:basair/screens/navigation_screen.dart';
import 'package:basair/screens/quran_viewer_screen.dart';
import 'package:basair/screens/shell_screen.dart';
import 'package:basair/screens/topics_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const navigation = (name: 'home', path: '/');
  static const quranViewer = (name: 'quranViewer', path: '/quranViewer');
  static const topicScreen = (name: 'topicScreen', path: '/topics');
  static const juzScreen =
      (name: 'juzScreen', path: '/juz'); // New route for Juz

  static final router = GoRouter(
    initialLocation: navigation.path,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ShellScreen(
            child: child,
          ); // ShellScreen with Top navigation
        },
        routes: [
          GoRoute(
            name: navigation.name,
            path: navigation.path,
            builder: (context, state) => const NavigationScreen(),
          ),
          GoRoute(
            name: topicScreen.name,
            path: topicScreen.path,
            builder: (context, state) => TopicsScreen(),
          ),
        ],
      ),
      GoRoute(
          name: quranViewer.name,
          path: quranViewer.path,
          builder: (context, state) {
            final pageNumber = state.extra as int? ?? 1;
            return QuranViewerScreen(pageNumber: pageNumber);
          }),
    ],
  );
}
