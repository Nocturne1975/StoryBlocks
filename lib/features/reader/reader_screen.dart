import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/models/story.dart';
import '../../core/story_engine/story_generator.dart';
import '../../core/utils/date_formatter.dart';
import '../builder/builder_provider.dart';
import '../stories/stories_provider.dart';

class ReaderScreen extends ConsumerStatefulWidget {
  final String? storyId;
  const ReaderScreen({super.key, this.storyId});

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  String? _currentTitle;
  String? _currentContent;
  DateTime? _createdAt;

  void _generateStory() {
    final builderState = ref.read(builderProvider);
    setState(() {
      _currentTitle = StoryGenerator.generateTitle(builderState.selectedBlocks);
      _currentContent = StoryGenerator.generate(
        selectedBlocks: builderState.selectedBlocks,
        tone: builderState.tone,
        length: builderState.storyLength,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.storyId != null) {
        final stories = ref.read(storiesProvider);
        final story = stories.firstWhere((s) => s.id == widget.storyId);
        setState(() {
          _currentTitle = story.title;
          _currentContent = story.content;
          _createdAt = story.createdAt;
        });
      } else {
        _generateStory();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentTitle == null || _currentContent == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final builderState = ref.watch(builderProvider);

    Future<void> confirmDelete() async {
      final bool? confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Supprimer l\'histoire'),
          content: Text('Êtes-vous sûr de vouloir supprimer "$_currentTitle" ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Supprimer'),
            ),
          ],
        ),
      );

      if (confirmed == true && widget.storyId != null) {
        await ref.read(storiesProvider.notifier).deleteStory(widget.storyId!);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Histoire supprimée')),
          );
          context.pop();
        }
      }
    }
    Future<void> shareStory() async {
      try {
        await Share.share(
          "$_currentTitle\n\n$_currentContent",
          subject: _currentTitle,
        );    
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erreur lors du partage'),
              backgroundColor: Colors.red,
            ),
          );    
        }
      }
    }
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
            onPressed: shareStory,
          ),
          if (widget.storyId != null)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Supprimer',
              onPressed: confirmDelete,
            ),
          if (widget.storyId == null)
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
            if (_createdAt != null) ...[
              Text(
                formatStoryDate(_createdAt!),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
              const SizedBox(height: 8),
            ],
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
                if (widget.storyId == null)
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
