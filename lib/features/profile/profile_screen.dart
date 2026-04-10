import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/Theme/storyblocks_tokens.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.sbTokens;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Mon Profil',
          style: TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- PROFILE HEADER CARD ---
            _buildProfileHeader(tokens),
            const SizedBox(height: 32),

            // --- STATS SECTION ---
            _buildSectionTitle('Mes Statistiques', Icons.trending_up, Colors.orange),
            const SizedBox(height: 16),
            _StatCard(
              count: '12',
              label: 'Projets créés',
              icon: Icons.menu_book_rounded,
              gradient: [const Color(0xFFF97316), const Color(0xFFEA580C)],
            ),
            const SizedBox(height: 12),
            _StatCard(
              count: '847',
              label: 'Blocs écrits',
              icon: Icons.auto_graph_rounded,
              gradient: [const Color(0xFFF59E0B), const Color(0xFFD97706)],
            ),
            const SizedBox(height: 12),
            _StatCard(
              count: '75%',
              label: 'Objectif mensuel',
              icon: Icons.track_changes_rounded,
              gradient: [const Color(0xFFD4A340), const Color(0xFFB38A2D)],
            ),
            const SizedBox(height: 32),

            // --- ACHIEVEMENTS SECTION ---
            _buildSectionTitle('Mes Réalisations', Icons.emoji_events_outlined, Colors.orange[800]!),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.85,
              children: const [
                _AchievementCard(
                  title: 'Premier Projet',
                  description: 'Créer votre premier projet',
                  date: '15 Jan 2024',
                  icon: '🎯',
                  color: Color(0xFFFCE7F3),
                ),
                _AchievementCard(
                  title: 'Écrivain Prolifique',
                  description: 'Écrire 500 blocs',
                  date: '28 Fév 2024',
                  icon: '✍️',
                  color: Color(0xFFFEF3C7),
                ),
                _AchievementCard(
                  title: 'Marathonien',
                  description: 'Écrire 7 jours consécutifs',
                  date: '10 Mar 2024',
                  icon: '🏃',
                  color: Color(0xFFE0F2FE),
                ),
                _AchievementCard(
                  title: 'Architecte Narratif',
                  description: 'Créer 10 projets',
                  date: '20 Mar 2024',
                  icon: '🏗️',
                  color: Color(0xFFDCFCE7),
                ),
                _AchievementCard(
                  title: 'Maître des Blocs',
                  description: 'Écrire 1000 blocs',
                  date: '',
                  icon: '👑',
                  color: Color(0xFFF3F4F6),
                  isLocked: true,
                ),
                _AchievementCard(
                  title: 'Explorateur',
                  description: 'Utiliser tous les types de blocs',
                  date: '',
                  icon: '🗺️',
                  color: Color(0xFFF3F4F6),
                  isLocked: true,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // --- LOGOUT BUTTON ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout),
                label: const Text('Se déconnecter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(StoryBlocksTokens tokens) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [tokens.blockScene, tokens.blockIdea],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -40),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 42,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=sophie'),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sophie Martin',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email_outlined, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text('sophie.martin@email.com', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text('Membre depuis Janvier 2024', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
                  child: Text(
                    'Écrivaine passionnée de fantasy et science-fiction. J\'aime créer des mondes riches et des personnages complexes.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF4B5563), height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String count;
  final String label;
  final IconData icon;
  final List<Color> gradient;

  const _StatCard({required this.count, required this.label, required this.icon, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradient),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(count, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              Text(label, style: const TextStyle(color: Color(0xB3FFFFFF), fontSize: 14)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(16)),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String icon;
  final Color color;
  final bool isLocked;

  const _AchievementCard({
    required this.title,
    required this.description,
    required this.date,
    required this.icon,
    required this.color,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Opacity(
              opacity: isLocked ? 0.3 : 1.0,
              child: Text(icon, style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isLocked ? Colors.grey : const Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            description,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
          if (date.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              date,
              style: const TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.bold),
            ),
          ],
        ],
      ),
    );
  }
}
