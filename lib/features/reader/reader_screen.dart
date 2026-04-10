import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../core/models/story.dart';
import '../stories/stories_provider.dart';
import '../builder/builder_provider.dart';
import '../../app/Theme/storyblocks_tokens.dart';

class ReaderScreen extends ConsumerWidget {
  final String? storyId;

  const ReaderScreen({super.key, this.storyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = context.sbTokens;

    // Récupérer l'histoire (soit depuis Hive via l'ID, soit l'histoire en cours de génération)
    final Story? story = storyId != null
        ? ref.watch(storiesProvider).firstWhere((s) => s.id == storyId)
        : ref.watch(builderProvider).generatedStory;

    if (story == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text("Histoire non trouvée")),
      );
    }

    // Découper le contenu en blocs pour l'effet de cascade
    // Si l'histoire a été générée avec le nouveau générateur, elle aura peut-être déjà des délimiteurs
    // Sinon on découpe par phrases ou par points pour simuler des blocs.
    final List<String> storyBlocks = story.content
        .split(RegExp(r'(?<=[.!?])\s+'))
        .where((s) => s.isNotEmpty)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: Text(
          story.title,
          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black87),
            onPressed: () => ref.read(storiesProvider.notifier).shareStory(story),
          ),
          if (storyId == null) // Bouton de sauvegarde seulement si c'est une nouvelle histoire
            IconButton(
              icon: const Icon(Icons.save_outlined, color: Colors.black87),
              onPressed: () async {
                await ref.read(storiesProvider.notifier).saveStory(story);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Histoire enregistrée dans ta bibliothèque !')),
                  );
                }
              },
            ),
        ],
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: storyBlocks.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 600),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: _StoryBlockCard(
                    text: storyBlocks[index],
                    index: index,
                    tokens: tokens,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StoryBlockCard extends StatelessWidget {
  final String text;
  final int index;
  final StoryBlocksTokens tokens;

  const _StoryBlockCard({
    required this.text,
    required this.index,
    required this.tokens,
  });

  @override
  Widget build(BuildContext context) {
    // Alternance de couleurs pour l'effet "blocs Lego"
    final List<Color> colors = [
      tokens.blockScene.withValues(alpha: 0.1),
      tokens.blockCharacter.withValues(alpha: 0.1),
      tokens.blockIdea.withValues(alpha: 0.1),
    ];
    final Color blockColor = colors[index % colors.length];
    final Color borderColor = colors[index % colors.length].withValues(alpha: 0.5);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: blockColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "${index + 1}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: borderColor.withValues(alpha: 1.0),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 17,
                height: 1.6,
                color: Color(0xFF374151),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
