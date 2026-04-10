import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/models/story.dart';

// Le Notifier contient la logique metier
class StoriesNotifier extends StateNotifier<List<Story>> {
  final Box<Story> _box;

  StoriesNotifier(this._box) : super([]) {
    _loadStories();
  }
  // Au demarrage, on recupere la boite Hive et on charge les stories
  void _loadStories() {
    state = _box.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> saveStory(Story story) async {
    await _box.put(story.id, story);
    _loadStories();
  }

  Future<void> deleteStory(String id) async {
    await _box.delete(id);
    _loadStories();
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
