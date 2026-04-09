import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'stories_provider.dart';

class StoriesScreen extends ConsumerWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stories = ref.watch(storiesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFBF5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Mes histoires',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: stories.isEmpty
          ? const Center(
              child: Text(
                'Aucune histoire',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: stories.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final story = stories[index];

                return _StoryListItem(
                  id: story.id,
                  title: story.title,
                  date: formatStoryDate(story.createdAt),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/builder'),
        icon: const Icon(Icons.add),
        label: const Text('Nouvelle histoire'),
      ),
    );
  }
}

String formatStoryDate(DateTime createdAt) {
  return DateFormat('dd/MM/yyyy').format(createdAt);
}

class _StoryListItem extends StatelessWidget {
  const _StoryListItem({
    required this.id,
    required this.title,
    required this.date,
  });

  final String id;
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/reader/$id'),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF97316).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.auto_stories, color: Color(0xFFF97316)),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              date,
              style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
        ),
      ),
    );
  }
}
