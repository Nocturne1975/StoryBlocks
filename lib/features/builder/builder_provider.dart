import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/story.dart';
import '../../core/story_engine/story_generator.dart';
import '../../core/story_engine/story_data.dart';
import '../ideas/idea_provider.dart';
import 'dart:math';

class BuilderState {
  final Map<String, String> selectedBlocks;
  final String tone;
  final String storyLength;
  final Story? generatedStory;

  BuilderState({
    required this.selectedBlocks,
    required this.tone,
    required this.storyLength,
    this.generatedStory,
  });

  BuilderState copyWith({
    Map<String, String>? selectedBlocks,
    String? tone,
    String? storyLength,
    Story? generatedStory,
  }) {
    return BuilderState(
      selectedBlocks: selectedBlocks ?? this.selectedBlocks,
      tone: tone ?? this.tone,
      storyLength: storyLength ?? this.storyLength,
      generatedStory: generatedStory ?? this.generatedStory,
    );
  }
}

class BuilderNotifier extends StateNotifier<BuilderState> {
  final Ref _ref;

  BuilderNotifier(this._ref)
    : super(
        BuilderState(selectedBlocks: {}, tone: 'Neutre', storyLength: 'Moyenne'),
      );

  void updateBlock(String category, String value) {
    final newBlocks = Map<String, String>.from(state.selectedBlocks);
    newBlocks[category] = value;
    state = state.copyWith(selectedBlocks: newBlocks);
  }

  void updateTone(String newTone) {
    state = state.copyWith(tone: newTone);
  }

  void updateLength(String newLength) {
    state = state.copyWith(storyLength: newLength);
  }

  // Piger tout aléatoirement (Le bouton "Générer seul")
  void randomizeAll() {
    final myIdeas = _ref.read(ideaProvider);
    final random = Random();
    final Map<String, String> newBlocks = {};

    // Pour chaque catégorie (personnage, lieu, etc.)
    for (var category in StoryData.blocks.keys) {
      // On cherche dans tes idées d'abord
      final myFilteredIdeas = myIdeas
          .where((i) => i.category.toLowerCase().contains(category.toLowerCase()))
          .toList();

      if (myFilteredIdeas.isNotEmpty && random.nextBool()) {
        // 50% de chance de prendre une de tes idées si tu en as
        newBlocks[category] = myFilteredIdeas[random.nextInt(myFilteredIdeas.length)].content;
      } else {
        // Sinon on prend dans les idées par défaut
        final defaultOptions = StoryData.blocks[category]!;
        newBlocks[category] = defaultOptions[random.nextInt(defaultOptions.length)];
      }
    }

    // Choisir un ton au hasard aussi (parmi les défauts + les tiens)
    final myTones = myIdeas.where((i) => i.category.toLowerCase() == 'ton').map((i) => i.content).toList();
    final allTones = {...StoryData.tones, ...myTones}.toList();
    final randomTone = allTones[random.nextInt(allTones.length)];

    state = state.copyWith(
      selectedBlocks: newBlocks,
      tone: randomTone,
    );
  }

  Future<void> generateStory() async {
    final result = StoryGenerator.generateDetailed(
      selectedBlocks: state.selectedBlocks,
      tone: state.tone,
      length: state.storyLength,
    );

    final newStory = Story(
      title: result['title']!.first,
      content: result['content']!.join('\n\n'),
      createdAt: DateTime.now(),
      blocks: state.selectedBlocks,
      tone: state.tone,
    );

    // On ne sauvegarde plus automatiquement dans "Mes Projets"
    // await _storiesNotifier.saveStory(newStory);
    state = state.copyWith(generatedStory: newStory);
  }

  bool get isComplete {
    return state.selectedBlocks.length >= 6;
  }
}

final builderProvider = StateNotifierProvider<BuilderNotifier, BuilderState>((ref) {
  return BuilderNotifier(ref);
});
