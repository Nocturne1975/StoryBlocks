import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/story_engine/story_generator.dart';
import '../builder/builder_provider.dart';

class ReaderScreen extends ConsumerWidget {
  const ReaderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final builderState = ref.watch(builderProvider);
    
    // Génération du contenu (titre et texte) à partir de l'état actuel
    final title = StoryGenerator.generateTitle(builderState.selectedBlocks);
    final content = StoryGenerator.generate(
      selectedBlocks: builderState.selectedBlocks,
      tone: builderState.tone,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Votre Histoire'),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: 'Copier l\'histoire',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: "$title\n\n$content"));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Histoire copiée dans le presse-papier !')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 24),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                    fontSize: 18,
                  ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.edit),
                  label: const Text('Modifier les blocs'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // La régénération se fait en provoquant un rebuild
                    // (L'état ne change pas, mais le générateur choisit un titre différent aléatoirement)
                    (context as Element).markNeedsBuild();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Régénérer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
