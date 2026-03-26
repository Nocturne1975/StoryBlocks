import 'dart:math';

class StoryGenerator {
  static String generate({
    required Map<String, String> selectedBlocks,
    required String tone,
  }) {
    final personnage = selectedBlocks['personnage'] ?? 'Quelqu\'un';
    final lieu = selectedBlocks['lieu'] ?? 'n\'importe où';
    final objectif = selectedBlocks['objectif'] ?? 'faire quelque chose';
    final obstacle = selectedBlocks['obstacle'] ?? 'sans encombre';
    final twist = selectedBlocks['twist'] ?? 'tout était normal';
    final fin = selectedBlocks['fin'] ?? 'l\'histoire se termine.';

    // Variation du texte selon le ton
    String intro = '';
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

    return "$intro Sa mission était de $objectif, $obstacle. Soudain, $twist Enfin, $fin";
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
