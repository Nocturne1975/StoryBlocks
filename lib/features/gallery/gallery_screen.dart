import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/Theme/storyblocks_tokens.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

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
              Icons.collections_bookmark,
              color: tokens.blockScene,
              size: 24,
            ),
            const SizedBox(width: 8),
            const Text(
              'Galerie',
              style: TextStyle(
                color: Color(0xFF1F2937),
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black87),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher dans la galerie...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
                filled: true,
                fillColor: const Color(0xFFF9FAFB),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    count: '6',
                    label: 'Images',
                    color: tokens.blockScene,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    count: '3',
                    label: 'Favoris',
                    color: tokens.blockCharacter,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 20),
                label: const Text('Ajouter une image d\'inspiration'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: tokens.blockScene,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.85,
              children: const [
                _GalleryItem(
                  imageUrl: 'https://picsum.photos/id/10/400/500',
                  isFavorite: true,
                ),
                _GalleryItem(
                  imageUrl: 'https://picsum.photos/id/20/400/500',
                  title: 'Paysage naturel',
                  tags: ['nature', 'paysage'],
                  showActions: true,
                ),
                _GalleryItem(
                  imageUrl: 'https://picsum.photos/id/30/400/500',
                  isFavorite: true,
                ),
                _GalleryItem(imageUrl: 'https://picsum.photos/id/40/400/500'),
                _GalleryItem(
                  imageUrl: 'https://picsum.photos/id/50/400/500',
                  isFavorite: true,
                ),
                _GalleryItem(imageUrl: 'https://picsum.photos/id/60/400/500'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String count;
  final String label;
  final Color color;

  const _StatCard({
    required this.count,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _GalleryItem extends StatelessWidget {
  final String imageUrl;
  final String? title;
  final List<String>? tags;
  final bool isFavorite;
  final bool showActions;

  const _GalleryItem({
    required this.imageUrl,
    this.title,
    this.tags,
    this.isFavorite = false,
    this.showActions = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(imageUrl, fit: BoxFit.cover),
          if (title != null)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withAlpha(179), // 0.7 * 255
                    ],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),
            ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isFavorite
                    ? Colors.red
                    : Colors.white.withAlpha(77), // 0.3 * 255
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          if (showActions)
            Positioned(
              top: 10,
              right: 45,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(77),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.download,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          if (title != null)
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (tags != null)
                    Row(
                      children: tags!
                          .map(
                            (tag) => Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Text(
                                '#$tag',
                                style: TextStyle(
                                  color: Colors.white.withAlpha(
                                    204,
                                  ), // 0.8 * 255
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
