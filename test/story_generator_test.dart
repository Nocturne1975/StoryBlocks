import 'package:flutter_test/flutter_test.dart';
import 'package:storyblocks/core/story_engine/story_generator.dart';

void main() {
  test('La génération d\'histoire doit produire un texte non vide', () {
    final selectedBlocks = {
      'personnage': 'Un détective',
      'lieu': 'dans la brume',
      'objectif': 'trouver la clé',
      'obstacle': 'mais il pleut',
      'twist': 'il réalise qu\'il est un robot',
      'fin': 'fin de l\'enquête.',
    };

    final story = StoryGenerator.generate(
      selectedBlocks: selectedBlocks,
      tone: 'Sombre',
    );

    expect(story, isNotEmpty);
    expect(story, contains('Un détective'));
    expect(story, contains('dans la brume'));
  });

  test('La génération de titre doit produire un titre cohérent', () {
    final selectedBlocks = {'personnage': 'Un chat', 'lieu': 'sur la lune'};

    final title = StoryGenerator.generateTitle(selectedBlocks);
    expect(title, isNotEmpty);
  });
}
