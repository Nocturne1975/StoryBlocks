import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../ideas/idea_provider.dart';
import '../builder/builder_provider.dart';
import '../../app/Theme/storyblocks_tokens.dart';
import '../../core/story_engine/story_data.dart';
import 'dart:math';

class WorkshopScreen extends ConsumerStatefulWidget {
  const WorkshopScreen({super.key});

  @override
  ConsumerState<WorkshopScreen> createState() => _WorkshopScreenState();
}

class _WorkshopScreenState extends ConsumerState<WorkshopScreen> {
  final Map<String, TextEditingController> _controllers = {
    'Ton': TextEditingController(),
    'Personnage': TextEditingController(),
    'Lieu': TextEditingController(),
    'Objectif': TextEditingController(),
    'Obstacle': TextEditingController(),
    'Twist': TextEditingController(),
    'Fin': TextEditingController(),
  };

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _randomizeFields() {
    final myIdeas = ref.read(ideaProvider);
    final random = Random();
    
    _controllers.forEach((category, controller) {
      // On cherche dans tes idées
      final myFiltered = myIdeas.where((i) => i.category.toLowerCase() == category.toLowerCase()).toList();
      
      if (myFiltered.isNotEmpty && random.nextBool()) {
        controller.text = myFiltered[random.nextInt(myFiltered.length)].content;
      } else {
        // Sinon dans les données par défaut (si elles existent pour cette catégorie)
        final defaultData = StoryData.blocks[category.toLowerCase()];
        if (defaultData != null && defaultData.isNotEmpty) {
          controller.text = defaultData[random.nextInt(defaultData.length)];
        } else if (category == 'Ton') {
          controller.text = StoryData.tones[random.nextInt(StoryData.tones.length)];
        }
      }
    });
    setState(() {});
  }

  void _sendToWorkshop() async {
    for (var entry in _controllers.entries) {
      if (entry.value.text.isNotEmpty) {
        // On sauvegarde dans le coffre (sans doublon si possible)
        await ref.read(ideaProvider.notifier).addIdea(
          entry.value.text,
          entry.key,
          [],
        );
        
        // On injecte dans le constructeur
        ref.read(builderProvider.notifier).updateBlock(entry.key.toLowerCase(), entry.value.text);
        if (entry.key == 'Ton') {
          ref.read(builderProvider.notifier).updateTone(entry.value.text);
        }
      }
    }

    if (mounted) {
      context.push('/builder');
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.sbTokens;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F2),
      appBar: AppBar(
        title: const Text('L\'Atelier de Création', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: _randomizeFields,
            icon: const Icon(Icons.casino_outlined, size: 20),
            label: const Text('GÉNÉRER SEUL'),
            style: TextButton.styleFrom(foregroundColor: tokens.blockIdea),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ..._controllers.entries.map((entry) => _buildWorkshopField(entry.key, entry.value, tokens)),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: _sendToWorkshop,
                icon: const Icon(Icons.auto_awesome),
                label: const Text('FAIRE DANSER DANS L\'ATELIER', style: TextStyle(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: tokens.blockIdea,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkshopField(String label, TextEditingController controller, StoryBlocksTokens tokens) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Votre idée...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
