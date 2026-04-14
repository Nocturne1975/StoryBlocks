import 'dart:math';

class StoryGenerator {
  // Ancienne méthode restaurée pour la compatibilité
  static String generate({
    required Map<String, String> selectedBlocks,
    required String tone,
    String length = 'Moyenne',
  }) {
    final result = generateDetailed(
      selectedBlocks: selectedBlocks,
      tone: tone,
      length: length,
    );
    return (result['content'] as List<String>).join(' ');
  }

  static Map<String, List<String>> generateDetailed({
    required Map<String, String> selectedBlocks,
    required String tone,
    String length = 'Moyenne',
  }) {
    final personnage = selectedBlocks['personnage'] ?? 'Quelqu\'un';
    final lieu = selectedBlocks['lieu'] ?? 'n\'importe où';
    final objectif = selectedBlocks['objectif'] ?? 'faire quelque chose';
    final obstacle = selectedBlocks['obstacle'] ?? 'sans encombre';
    final twist = selectedBlocks['twist'] ?? 'tout était normal';
    final fin = selectedBlocks['fin'] ?? 'l\'histoire se termine.';

    String intro = "";
    switch (tone.toLowerCase()) {
      case 'drôle':
        intro = "Contre toute attente, $personnage se trouvait $lieu.";
        break;
      case 'sombre':
        intro = "Dans les ténèbres, $personnage errait $lieu.";
        break;
      case 'poétique':
        intro = "Telle une brise légère, $personnage se mouvait $lieu.";
        break;
      default:
        intro = "$personnage se trouvait $lieu.";
    }

    String action = "Sa mission était de $objectif, mais cela devait se faire $obstacle.";
    String rebondissement = "Soudain, $twist et tout a changé d'un coup !";
    String conclusion = "Enfin, $fin";

    List<String> blocks = [intro, action, rebondissement, conclusion];

    if (length == 'Longue') {
      String descriptionLieu = "L'atmosphère de cet endroit était unique, chargée d'une énergie particulière.";
      if (lieu.contains('espace')) {
        descriptionLieu = "Le vide infini s'étendait à perte de vue, parsemé d'étoiles scintillantes comme des diamants.";
      }
      blocks.insert(1, descriptionLieu);
    }

    return {
      'title': [generateTitle(selectedBlocks)],
      'content': blocks,
    };
  }

  static String generateTitle(Map<String, String> selectedBlocks) {
    final rand = Random();
    final titles = [
      "L'aventure de ${selectedBlocks['personnage']}",
      "Mystère ${selectedBlocks['lieu']}",
      "L'objectif : ${selectedBlocks['objectif']}",
    ];
    return titles[rand.nextInt(titles.length)];
  }
}
