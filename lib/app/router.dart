import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/builder/builder_screen.dart';
import '../features/reader/reader_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const BuilderScreen(),
      ),
      GoRoute(
        path: '/reader',
        builder: (context, state) => const ReaderScreen(),
      ),
    ],
  );
});
