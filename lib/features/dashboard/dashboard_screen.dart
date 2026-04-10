import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import '../stories/stories_provider.dart';
import '../../core/models/story.dart';
import '../../core/widgets/app_drawer.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const _DashboardContent();
  }
}

class _DashboardContent extends ConsumerWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stories = ref.watch(storiesProvider);

    int totalBlocks = 0;
    for (var s in stories) {
      totalBlocks += s.blocks.length;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const AppDrawer(),
      body: Builder(
        builder: (context) => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFF7ED), Color(0xFFFFFBEB), Color(0xFFFEFCE8)],
            ),
          ),
          child: SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.7),
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.orange[100]!.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _HeaderButton(
                                  icon: Icons.menu,
                                  onTap: () =>
                                      Scaffold.of(context).openDrawer(),
                                ),
                                const _LogoSimple(),
                                _HeaderButton(
                                  icon: Icons.person_outline,
                                  onTap: () {},
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Rechercher un projet...',
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                filled: true,
                                fillColor: Colors.white.withValues(alpha: 0.7),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: _StatCard(
                            count: stories.length.toString(),
                            label: 'Projets',
                            gradient: const [
                              Color(0xFFF97316),
                              Color(0xFFEA580C),
                            ],
                            icon: Icons.layers,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _StatCard(
                            count: totalBlocks.toString(),
                            label: 'Blocs récents',
                            gradient: const [
                              Color(0xFFF59E0B),
                              Color(0xFFEAB308),
                            ],
                            icon: Icons.access_time,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Mes Projets',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF3A2F28),
                          ),
                        ),
                        _NewProjectButton(
                          onTap: () => context.push('/builder'),
                        ),
                      ],
                    ),
                  ),
                ),
                stories.isEmpty
                    ? const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text('Aucune histoire sauvegardée.'),
                        ),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.all(24),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            return _ProjectCard(
                              story: stories[index],
                              onTap: () =>
                                  _showStoryContent(context, stories[index]),
                            );
                          }, childCount: stories.length),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showStoryContent(BuildContext context, Story story) {
    showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            story.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Text(
              story.content,
              style: const TextStyle(height: 1.6, fontSize: 16),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fermer'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoSimple extends StatelessWidget {
  const _LogoSimple();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/logosb.png',
          height: 32,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.auto_stories, color: Colors.orange, size: 32),
        ),
        const SizedBox(width: 8),
        Text(
          'StoryBlocks',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.orange[800],
            letterSpacing: -1,
          ),
        ),
      ],
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _HeaderButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }
}

class _NewProjectButton extends StatelessWidget {
  final VoidCallback onTap;
  const _NewProjectButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: const Icon(Icons.add, size: 18),
      label: const Text('Nouveau'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange[600],
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.orange.withValues(alpha: 0.5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String count;
  final String label;
  final List<Color> gradient;
  final IconData icon;

  const _StatCard({
    required this.count,
    required this.label,
    required this.gradient,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withValues(alpha: 0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.white.withValues(alpha: 0.8), size: 28),
              Text(
                count,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Story story;
  final VoidCallback onTap;

  const _ProjectCard({required this.story, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          story.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          story.content,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const _StatusIndicator(),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _BlockBadge(count: story.blocks.length),
                      const SizedBox(width: 12),
                      const Text(
                        "Aujourd'hui",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9CA3AF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.orange,
                    size: 14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  const _StatusIndicator();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green[400],
        boxShadow: [
          BoxShadow(
            color: Colors.green[400]!.withValues(alpha: 0.5),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}

class _BlockBadge extends StatelessWidget {
  final int count;
  const _BlockBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange[400]!, Colors.orange[600]!],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.grid_view_rounded, size: 12, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            count.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
