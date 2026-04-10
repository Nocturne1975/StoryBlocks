import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/Theme/storyblocks_tokens.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.sbTokens;

    return Drawer(
      backgroundColor: const Color(0xFFFFFBF5),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'StoryBlocks',
                        style: TextStyle(
                          color: tokens.blockScene,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Menu de navigation',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFF3F4F6)),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [
                  _DrawerItem(
                    icon: Icons.home_filled,
                    label: 'Dashboard',
                    color: tokens.blockScene,
                    onTap: () => context.go('/dashboard'),
                  ),
                  _DrawerItem(
                    icon: Icons.person,
                    label: 'Mon Profil',
                    color: tokens.blockCharacter,
                    onTap: () => context.push('/profile'),
                  ),
                  _DrawerItem(
                    icon: Icons.notifications,
                    label: 'Notifications',
                    color: tokens.blockTheme,
                    onTap: () => context.push('/notifications'),
                  ),
                  _DrawerItem(
                    icon: Icons.menu_book,
                    label: 'Mes histoires',
                    color: tokens.blockPlace,
                    onTap: () => context.push('/stories'),
                  ),
                  _DrawerItem(
                    icon: Icons.show_chart,
                    label: 'Statistiques',
                    color: tokens.blockScene,
                    onTap: () => context.push('/stats'),
                  ),
                  _DrawerItem(
                    icon: Icons.lightbulb,
                    label: 'Mes Idées',
                    color: tokens.blockIdea,
                    onTap: () => context.push('/ideas'),
                  ),
                  _DrawerItem(
                    icon: Icons.group,
                    label: 'Collaboration',
                    color: tokens.blockCharacter,
                    onTap: () => context.push('/collaboration'),
                  ),
                  _DrawerItem(
                    icon: Icons.image,
                    label: 'Galerie',
                    color: tokens.blockScene,
                    onTap: () => context.push('/gallery'),
                  ),
                  _DrawerItem(
                    icon: Icons.settings,
                    label: 'Paramètres',
                    color: const Color(0xFF4B5563),
                    onTap: () => context.push('/settings'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF374151),
          fontSize: 16,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}
