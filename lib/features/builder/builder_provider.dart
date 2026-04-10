import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/story.dart';
import '../../core/story_engine/story_generator.dart';

class BuilderState {
  final Map<String, String> selectedBlocks;
  final String tone;
  final String storyLength;
  final Story? generatedStory; // Nouveau champ

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
  BuilderNotifier()
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

  // Nouvelle méthode pour générer l'histoire
  void generateStory() {
    final result = StoryGenerator.generateDetailed(
      selectedBlocks: state.selectedBlocks,
      tone: state.tone,
      length: state.storyLength,
    );

    final newStory = Story(
      title: result['title']!.first,
      content: result['content']!.join(' '),
      createdAt: DateTime.now(),
      blocks: state.selectedBlocks,
      tone: state.tone,
    );

    state = state.copyWith(generatedStory: newStory);
  }

  bool get isComplete {
    return state.selectedBlocks.length >= 6;
  }
}

final builderProvider = StateNotifierProvider<BuilderNotifier, BuilderState>((
  ref,
) {
  return BuilderNotifier();
});
