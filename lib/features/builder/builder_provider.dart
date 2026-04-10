import 'package:flutter_riverpod/flutter_riverpod.dart';

// État du builder : une map des blocs sélectionnés et le ton choisi
class BuilderState {
  final Map<String, String> selectedBlocks;
  final String tone;
  final String storyLength;

  BuilderState({
    required this.selectedBlocks,
    required this.tone,
    required this.storyLength,
  });

  BuilderState copyWith({
    Map<String, String>? selectedBlocks,
    String? tone,
    String? storyLength,
  }) {
    return BuilderState(
      selectedBlocks: selectedBlocks ?? this.selectedBlocks,
      tone: tone ?? this.tone,
      storyLength: storyLength ?? this.storyLength,
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

  bool get isComplete {
    // On vérifie si toutes les catégories obligatoires sont remplies
    return state.selectedBlocks.length >=
        6; // personnage, lieu, objectif, obstacle, twist, fin
  }
}

final builderProvider = StateNotifierProvider<BuilderNotifier, BuilderState>((
  ref,
) {
  return BuilderNotifier();
});
