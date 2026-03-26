import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialisation Hive
  await Hive.initFlutter();
  // On enregistrera l'adaptateur de Story plus tard quand il sera généré
  // Hive.registerAdapter(StoryAdapter());
  
  runApp(
    const ProviderScope(
      child: StoryBlocksApp(),
    ),
  );
}

class StoryBlocksApp extends ConsumerWidget {
  const StoryBlocksApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'StoryBlocks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
