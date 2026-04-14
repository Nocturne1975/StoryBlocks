import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/router.dart';
import 'core/models/story.dart';
import 'core/models/idea_block.dart';
import 'app/Theme/storyblocks_theme_oklch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation Hive
  await Hive.initFlutter();

  // Enregistrement des adaptateurs
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(StoryAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(IdeaBlockAdapter());
  }

  // Ouverture des boîtes Hive
  await Hive.openBox<Story>('stories');
  await Hive.openBox<IdeaBlock>('ideas');
  await Hive.openBox('settings');

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
