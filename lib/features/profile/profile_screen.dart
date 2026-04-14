import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/Theme/storyblocks_tokens.dart';
import '../stories/stories_provider.dart';
import 'profile_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isEditing = false;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider);
    _nameController = TextEditingController(text: profile.name);
    _emailController = TextEditingController(text: profile.email);
    _bioController = TextEditingController(text: profile.bio);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    ref.read(profileProvider.notifier).updateProfile(
      name: _nameController.text,
      email: _emailController.text,
      bio: _bioController.text,
    );
    setState(() => _isEditing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil mis à jour !')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.sbTokens;
    final profile = ref.watch(profileProvider);
    final stories = ref.watch(storiesProvider);

    int totalBlocks = 0;
    for (var s in stories) {
      totalBlocks += s.blocks.length;
    }

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
            icon: Icon(
              _isEditing ? Icons.check : Icons.edit_outlined,
              color: _isEditing ? Colors.green : Colors.black87,
            ),
            onPressed: () {
              if (_isEditing) {
                _saveProfile();
              } else {
                setState(() => _isEditing = true);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(tokens, profile),
            const SizedBox(height: 32),
            _buildSectionTitle('Mes Statistiques', Icons.trending_up, Colors.orange),
            const SizedBox(height: 16),
            _StatCard(
              count: stories.length.toString(),
              label: 'Projets créés',
              icon: Icons.menu_book_rounded,
              gradient: const [Color(0xFFF97316), Color(0xFFEA580C)],
            ),
            const SizedBox(height: 12),
            _StatCard(
              count: totalBlocks.toString(),
              label: 'Blocs écrits',
              icon: Icons.auto_graph_rounded,
              gradient: const [Color(0xFFF59E0B), Color(0xFFD97706)],
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('Réalisations', Icons.emoji_events_outlined, Colors.orange[800]!),
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
                  title: 'Architecte',
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
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(StoryBlocksTokens tokens, UserProfile profile) {
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 42,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=user'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_isEditing)
                    TextField(
                      controller: _nameController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(hintText: 'Votre nom'),
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  else
                    Text(
                      profile.name,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
                    ),
                  const SizedBox(height: 12),
                  if (_isEditing)
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'Email',
                      ),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email_outlined, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(profile.email, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                      ],
                    ),
                  const SizedBox(height: 12),
                  if (_isEditing)
                    TextField(
                      controller: _bioController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Votre bio...',
                        border: OutlineInputBorder(),
                      ),
                    )
                  else
                    Text(
                      profile.bio,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Color(0xFF4B5563), height: 1.5),
                    ),
                  const SizedBox(height: 24),
                  if (_isEditing)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _saveProfile,
                        icon: const Icon(Icons.save),
                        label: const Text('ENREGISTRER LE PROFIL'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tokens.blockIdea,
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
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Text(icon, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
