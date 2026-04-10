import 'dart:math';

class StoryGenerator {
  static String generate({
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

    String corps = "Sa mission était de $objectif, $obstacle. Soudain, $twist Enfin, $fin";

    if (length == 'Courte') {
      return "$intro $corps";
    } else if (length == 'Longue') {
      String descriptionLieu = "";
      switch (lieu.toLowerCase()) {
        case 'dans l\'espace':
          descriptionLieu = " Le vide infini s'étendait à perte de vue, parsemé d'étoiles scintillantes comme des diamants oubliés.";
          break;
        case 'dans une forêt':
          descriptionLieu = " Les arbres centenaires murmuraient des secrets anciens tandis que la mousse étouffait le bruit de chaque pas.";
          break;
        case 'dans le futur':
          descriptionLieu = " Les néons survitaminés se reflétaient sur le métal poli des gratte-ciel qui touchaient presque les nuages.";
          break;
        default:
          descriptionLieu = " L'atmosphère de cet endroit était unique, chargée d'une énergie qu'on ne trouve nulle part ailleurs.";
      }

      String detailsAction = " Le chemin était parsemé d'embûches, mais la détermination de $personnage était inébranlable. Chaque seconde comptait dans cette quête désespérée.";
      
      return "$intro$descriptionLieu $corps$detailsAction";
    }

    return "$intro $corps";
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
