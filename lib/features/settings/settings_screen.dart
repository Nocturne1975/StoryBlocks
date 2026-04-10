import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app/Theme/storyblocks_tokens.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool notificationsPush = true;
  bool dailyReminders = true;
  bool soundEffects = true;
  bool autoSave = true;

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
          'Paramètres',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- APPARENCE ---
            _buildSectionTitle(Icons.palette_outlined, 'Apparence'),
            const SizedBox(height: 12),
            _buildSettingsCard(
              child: _buildSwitchTile(
                icon: Icons.wb_sunny_outlined,
                iconColor: Colors.orange[700]!,
                title: 'Mode sombre',
                subtitle: 'Activer le thème sombre',
                value: darkMode,
                onChanged: (val) => setState(() => darkMode = val),
              ),
            ),
            const SizedBox(height: 24),

            // --- LANGUE ---
            _buildSectionTitle(Icons.language_outlined, 'Langue & Région'),
            const SizedBox(height: 12),
            _buildSettingsCard(
              child: _buildActionTile(
                icon: Icons.language,
                iconColor: Colors.orange[600]!,
                title: 'Langue',
                subtitle: 'Français',
                trailing: Text(
                  'Modifier',
                  style: TextStyle(
                    color: tokens.blockScene,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 24),

            // --- NOTIFICATIONS ---
            _buildSectionTitle(
              Icons.notifications_none_outlined,
              'Notifications',
            ),
            const SizedBox(height: 12),
            _buildSettingsCard(
              child: Column(
                children: [
                  _buildSwitchTile(
                    icon: Icons.notifications_active_outlined,
                    iconColor: Colors.orange[600]!,
                    title: 'Notifications push',
                    subtitle: 'Recevoir des notifications',
                    value: notificationsPush,
                    onChanged: (val) => setState(() => notificationsPush = val),
                  ),
                  const Divider(height: 1, indent: 70),
                  _buildSwitchTile(
                    icon: Icons.notifications_none_outlined,
                    iconColor: Colors.orange[600]!,
                    title: 'Rappels quotidiens',
                    subtitle: 'Rappel pour écrire chaque jour',
                    value: dailyReminders,
                    onChanged: (val) => setState(() => dailyReminders = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- PRÉFÉRENCES ---
            _buildSectionTitle(Icons.volume_up_outlined, 'Préférences'),
            const SizedBox(height: 12),
            _buildSettingsCard(
              child: Column(
                children: [
                  _buildSwitchTile(
                    icon: Icons.volume_up_outlined,
                    iconColor: Colors.orange[700]!,
                    title: 'Effets sonores',
                    subtitle: 'Sons des interactions',
                    value: soundEffects,
                    onChanged: (val) => setState(() => soundEffects = val),
                  ),
                  const Divider(height: 1, indent: 70),
                  _buildSwitchTile(
                    icon: Icons.shield_outlined,
                    iconColor: Colors.orange[800]!,
                    title: 'Sauvegarde automatique',
                    subtitle: 'Enregistrer automatiquement',
                    value: autoSave,
                    onChanged: (val) => setState(() => autoSave = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- AIDE & LÉGAL ---
            _buildSectionTitle(Icons.info_outline, 'Aide & Légal'),
            const SizedBox(height: 12),
            _buildSettingsCard(
              child: Column(
                children: [
                  _buildActionTile(
                    icon: Icons.help_outline,
                    iconColor: Colors.amber[600]!,
                    title: 'Centre d\'aide',
                    subtitle: 'Tutoriels et support',
                    trailing: const Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 70),
                  _buildActionTile(
                    icon: Icons.privacy_tip_outlined,
                    iconColor: Colors.blue[600]!,
                    title: 'Confidentialité',
                    subtitle: 'Politique de gestion des données',
                    trailing: const Icon(
                      Icons.open_in_new,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onTap: () async {
                      final Uri url = Uri.parse(
                        'https://github.com/Nocturne1975/StoryBlocks/blob/main/docs/privacy.md',
                      );
                      if (!await launchUrl(url)) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Impossible d\'ouvrir le lien'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange[800], size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF374151),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
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
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
