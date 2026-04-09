import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/welcome/welcome_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/builder/builder_screen.dart';
import '../features/reader/reader_screen.dart';
import '../features/stories/stories_screen.dart';
import '../features/gallery/gallery_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/notifications/notifications_screen.dart';
import '../features/stats/stats_screen.dart';
import '../features/ideas/ideas_screen.dart';
import '../features/collaboration/collaboration_screen.dart';
import '../features/settings/settings_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/builder',
        builder: (context, state) => const BuilderScreen(),
      ),
      GoRoute(
        path: '/reader/:storyId?',
        builder: (context, state) {
          final storyId = state.pathParameters['storyId'];
          return ReaderScreen(storyId: storyId);
        },
      ),
      GoRoute(
        path: '/stories',
        builder: (context, state) => const StoriesScreen(),
      ),
      GoRoute(
        path: '/gallery',
        builder: (context, state) => const GalleryScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(path: '/stats', builder: (context, state) => const StatsScreen()),
      GoRoute(path: '/ideas', builder: (context, state) => const IdeasScreen()),
      GoRoute(
        path: '/collaboration',
        builder: (context, state) => const CollaborationScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});
