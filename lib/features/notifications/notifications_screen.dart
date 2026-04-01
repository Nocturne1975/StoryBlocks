import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/Theme/storyblocks_tokens.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

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
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.notifications_none_outlined,
              color: tokens.blockScene,
              size: 24,
            ),
            const SizedBox(width: 8),
            const Text(
              'Notifications',
              style: TextStyle(
                color: Color(0xFF1F2937),
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.check, size: 18, color: Colors.orange),
              label: const Text(
                'Tout marquer comme lu',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                side: const BorderSide(color: Color(0xFFFFEDD5)),
                backgroundColor: const Color(0xFFFFF7ED),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 24),

            _NotificationCard(
              title: 'Rappel d\'écriture',
              description:
                  "N'oubliez pas d'écrire aujourd'hui pour maintenir votre série de 7 jours !",
              time: 'Il y a 2h',
              icon: Icons.calendar_today,
              iconColor: Colors.orange[600]!,
              isUnread: true,
            ),
            _NotificationCard(
              title: 'Nouveau badge débloqué !',
              description:
                  'Vous avez débloqué "Architecte Narratif" - 10 projets créés',
              time: 'Il y a 5h',
              icon: Icons.emoji_events,
              iconColor: Colors.amber[600]!,
              isUnread: true,
            ),
            const _NotificationCard(
              title: 'Nouvelle idée ajoutée',
              description:
                  'Votre idée "Monde sous-marin dystopique" a été sauvegardée',
              time: 'Hier',
              icon: Icons.lightbulb,
              iconColor: Colors.orange,
              isUnread: false,
            ),
            const _NotificationCard(
              title: 'Invitation à collaborer',
              description:
                  'Marie vous a invité à collaborer sur "Le Royaume Oublié"',
              time: 'Il y a 2 jours',
              icon: Icons.person_add,
              iconColor: Colors.orange,
              isUnread: false,
            ),
            const _NotificationCard(
              title: 'Objectif mensuel',
              description:
                  'Plus que 5 jours pour atteindre votre objectif de 100 blocs ce mois-ci !',
              time: 'Il y a 3 jours',
              icon: Icons.calendar_month,
              iconColor: Colors.orange,
              isUnread: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color iconColor;
  final bool isUnread;

  const _NotificationCard({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.iconColor,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isUnread
              ? Colors.orange.withValues(alpha: 0.3)
              : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      time,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Icon(
                      Icons.delete_outline,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
