import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/story.dart';
import '../stories/stories_provider.dart';
import '../../app/Theme/storyblocks_tokens.dart';

class EditorScreen extends ConsumerStatefulWidget {
  final String? storyId;
  const EditorScreen({super.key, this.storyId});

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _isNew = true;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();

    if (widget.storyId != null) {
      _isNew = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final story = ref.read(storiesProvider).firstWhere((s) => s.id == widget.storyId);
        _titleController.text = story.title;
        _contentController.text = story.content;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveStory() async {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Donnez un titre à votre éclat !')),
      );
      return;
    }

    final story = Story(
      id: widget.storyId, // Très important : si null, un nouvel UUID sera généré par le modèle Story
      title: _titleController.text,
      content: _contentController.text,
      createdAt: DateTime.now(),
      blocks: {}, 
      tone: 'Libre',
    );

    await ref.read(storiesProvider.notifier).saveStory(story);
    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.sbTokens;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          _isNew ? 'Nouvel Éclat' : 'Modifier l\'histoire',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: _saveStory,
            child: Text(
              'ENREGISTRER',
              style: TextStyle(color: tokens.blockIdea, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: _titleController,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: 'Titre de l\'histoire...',
                border: InputBorder.none,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top, // Aligne le texte en haut
                style: const TextStyle(fontSize: 18, height: 1.6),
                decoration: const InputDecoration(
                  hintText: 'Laissez couler votre imagination ici...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
