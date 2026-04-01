import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/models/story.dart';
import '../../core/story_engine/story_generator.dart';
import '../builder/builder_provider.dart';
import '../stories/stories_provider.dart';

class ReaderScreen extends ConsumerStatefulWidget {
  const ReaderScreen({super.key});

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  String? _currentTitle;
  String? _currentContent;

  void _generateStory() {
    final builderState = ref.read(builderProvider);
    setState(() {
      _currentTitle = StoryGenerator.generateTitle(builderState.selectedBlocks);
      _currentContent = StoryGenerator.generate(
        selectedBlocks: builderState.selectedBlocks,
        tone: builderState.tone,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _generateStory());
  }

  @override
  Widget build(BuildContext context) {
    if (_currentTitle == null || _currentContent == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final builderState = ref.watch(builderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Votre Histoire'),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: 'Copier',
            onPressed: () {
              Clipboard.setData(
                ClipboardData(text: "$_currentTitle\n\n$_currentContent"),
              );
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Copié !')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Partager',
            onPressed: () {
              Share.share("$_currentTitle\n\n$_currentContent");
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Sauvegarder',
            onPressed: () async {
              final story = Story(
                title: _currentTitle!,
                content: _currentContent!,
                createdAt: DateTime.now(),
                blocks: builderState.selectedBlocks,
                tone: builderState.tone,
              );
              await ref.read(storiesProvider.notifier).saveStory(story);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Histoire sauvegardée !')),
                );
              }
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
              _currentTitle!,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _currentContent!,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: 1.6, fontSize: 18),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.edit),
                  label: const Text('Modifier'),
                ),
                ElevatedButton.icon(
                  onPressed: _generateStory,
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
