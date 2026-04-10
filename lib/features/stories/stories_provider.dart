import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/models/story.dart';

// Le Notifier contient la logique metier
class StoriesNotifier extends StateNotifier<List<Story>> {
  final Box<Story> _box;
  bool _sortByDate = true;

  StoriesNotifier(this._box) : super([]) {
    _loadStories();
  }

  // Au demarrage, on recupere la boite Hive et on charge les stories
  void _loadStories() {
    final stories = _box.values.toList();
    if (_sortByDate) {
      stories.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else {
      stories.sort(
        (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
      );
    }
    state = stories;
  }

  // Basculer entre le tri par date et par titre
  void toggleSort() {
    _sortByDate = !_sortByDate;
    _loadStories();
  }

  Future<void> saveStory(Story story) async {
    await _box.put(story.id, story);
    _loadStories();
  }

  Future<void> deleteStory(String id) async {
    await _box.delete(id);
    _loadStories();
  }

  // Supprimer toutes les histoires
  Future<void> clearAll() async {
    await _box.clear();
    _loadStories();
  }

  // Partager une histoire directement depuis la liste
  Future<void> shareStory(Story story) async {
    await Share.share("${story.title}\n\n${story.content}", subject: story.title);
  }
}

final storiesBoxProvider = Provider<Box<Story>>((ref) {
  return Hive.box<Story>('stories');
});

// Le Provider permet a l'UI d'acceder aux donnees
final storiesProvider = StateNotifierProvider<StoriesNotifier, List<Story>>((
  ref,
) {
  return StoriesNotifier(ref.watch(storiesBoxProvider));
});
