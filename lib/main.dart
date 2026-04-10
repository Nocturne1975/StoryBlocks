import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/router.dart';
import 'core/models/story.dart';
import 'app/Theme/storyblocks_theme_oklch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation Hive
  await Hive.initFlutter();

  // Enregistrement de l'adaptateur généré
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(StoryAdapter());
  }

  // Ouverture de la boîte pour stocker les histoires
  await Hive.openBox<Story>('stories');

  runApp(const ProviderScope(child: StoryBlocksApp()));
}

class StoryBlocksApp extends ConsumerWidget {
  const StoryBlocksApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'StoryBlocks',
      debugShowCheckedModeBanner: false,
      theme: StoryBlocksThemeOKLCH.light(),
      darkTheme: StoryBlocksThemeOKLCH.dark(),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
