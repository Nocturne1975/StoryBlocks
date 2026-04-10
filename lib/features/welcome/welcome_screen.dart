import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/Theme/storyblocks_tokens.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.sbTokens;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFFFF), Color(0xFFFFFBEB)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),
              // Image centrale (les blocs)
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    'assets/images/logosb.png', // On utilise le logo comme illustration centrale
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.auto_stories,
                      size: 100,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Titre StoryBlocks
              Text(
                'StoryBlocks',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  color: tokens.blockScene,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 16),
              // Sous-titre
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Organisez vos histoires avec des blocs narratifs modulaires',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF4B5563),
                    height: 1.4,
                  ),
                ),
              ),
              const Spacer(),
              // Grille de catégories (Image 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    _CategoryMiniCard(
                      label: 'Scènes',
                      icon: Icons.book,
                      color: tokens.blockScene,
                    ),
                    _CategoryMiniCard(
                      label: 'Personnages',
                      icon: Icons.groups,
                      color: tokens.blockCharacter,
                    ),
                    _CategoryMiniCard(
                      label: 'Lieux',
                      icon: Icons.place,
                      color: tokens.blockPlace,
                    ),
                    _CategoryMiniCard(
                      label: 'Idées',
                      icon: Icons.lightbulb,
                      color: tokens.blockIdea,
                    ),
                    _CategoryMiniCard(
                      label: 'Thèmes',
                      icon: Icons.sell,
                      color: tokens.blockTheme,
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              // Bouton Commencer
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                  onPressed: () => context.go('/dashboard'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[600],
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(64),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Commencer',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryMiniCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _CategoryMiniCard({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }
}
