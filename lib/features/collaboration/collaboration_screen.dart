import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/Theme/storyblocks_tokens.dart';

class CollaborationScreen extends StatelessWidget {
  const CollaborationScreen({super.key});

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
            Icon(Icons.groups_outlined, color: tokens.blockCharacter, size: 24),
            const SizedBox(width: 8),
            const Text(
              'Collaboration',
              style: TextStyle(
                color: Color(0xFF1F2937),
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.person_add_alt_1_outlined, size: 20),
                label: const Text(
                  'Inviter un collaborateur',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            _buildSectionTitle(
              'Collaborateurs (4)',
              Icons.groups_outlined,
              tokens.blockCharacter,
            ),
            const SizedBox(height: 16),
            const _CollaboratorCard(
              name: 'Sophie Martin',
              email: 'sophie.martin@email.com',
              role: 'Propriétaire',
              roleColor: Color(0xFFEA580C),
              imageUrl: 'https://i.pravatar.cc/150?u=sophie',
            ),
            const _CollaboratorCard(
              name: 'Thomas Dubois',
              email: 'thomas.dubois@email.com',
              role: 'Éditeur',
              roleColor: Color(0xFFF59E0B),
              imageUrl: 'https://i.pravatar.cc/150?u=thomas',
            ),
            const _CollaboratorCard(
              name: 'Marie Laurent',
              email: 'marie.laurent@email.com',
              role: 'Lecteur',
              roleColor: Color(0xFFD4A340),
              imageUrl: 'https://i.pravatar.cc/150?u=marie',
            ),
            const _CollaboratorCard(
              name: 'Lucas Bernard',
              email: 'lucas.bernard@email.com',
              role: 'Éditeur',
              roleColor: Color(0xFFF59E0B),
              imageUrl: 'https://i.pravatar.cc/150?u=lucas',
              status: 'En attente',
              showActions: true,
            ),
            const SizedBox(height: 32),

            _buildSectionTitle(
              'Projets partagés',
              Icons.chat_bubble_outline,
              Colors.orange[800]!,
            ),
            const SizedBox(height: 16),
            const _SharedProjectCard(
              title: 'Le Royaume Oublié',
              owner: 'Vous',
              members: 3,
              lastActivity: 'Il y a 2h',
              isActive: true,
            ),
            const _SharedProjectCard(
              title: 'Chroniques Urbaines',
              owner: 'Marie Laurent',
              members: 5,
              lastActivity: 'Hier',
              isActive: true,
            ),
          ],
        ),
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
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
      ],
    );
  }
}

class _CollaboratorCard extends StatelessWidget {
  final String name;
  final String email;
  final String role;
  final Color roleColor;
  final String imageUrl;
  final String? status;
  final bool showActions;

  const _CollaboratorCard({
    required this.name,
    required this.email,
    required this.role,
    required this.roleColor,
    required this.imageUrl,
    this.status,
    this.showActions = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 24, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    if (status != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          status!,
                          style: const TextStyle(
                            color: Color(0xFFD97706),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  email,
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: roleColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (role == 'Propriétaire')
                        const Icon(
                          Icons.workspace_premium,
                          size: 12,
                          color: Colors.white,
                        ),
                      if (role == 'Éditeur')
                        const Icon(Icons.edit, size: 12, color: Colors.white),
                      if (role == 'Lecteur')
                        const Icon(
                          Icons.visibility,
                          size: 12,
                          color: Colors.white,
                        ),
                      const SizedBox(width: 4),
                      Text(
                        role,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showActions)
            Row(
              children: [
                Icon(Icons.check, color: Colors.green[600], size: 20),
                const SizedBox(width: 12),
                Icon(Icons.close, color: Colors.red[600], size: 20),
              ],
            ),
        ],
      ),
    );
  }
}

class _SharedProjectCard extends StatelessWidget {
  final String title;
  final String owner;
  final int members;
  final String lastActivity;
  final bool isActive;

  const _SharedProjectCard({
    required this.title,
    required this.owner,
    required this.members,
    required this.lastActivity,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              if (isActive)
                const Icon(Icons.circle, color: Colors.green, size: 8),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.workspace_premium_outlined,
                size: 16,
                color: Colors.orange[600],
              ),
              const SizedBox(width: 4),
              Text(
                owner,
                style: const TextStyle(color: Color(0xFF4B5563), fontSize: 14),
              ),
              const Spacer(),
              Icon(Icons.groups_outlined, size: 16, color: Colors.grey[400]),
              const SizedBox(width: 4),
              Text(
                '$members membres',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Dernière activité : $lastActivity',
            style: TextStyle(color: Colors.grey[400], fontSize: 11),
          ),
        ],
      ),
    );
  }
}
