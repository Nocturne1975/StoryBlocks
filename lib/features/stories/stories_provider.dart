import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/models/story.dart';

class StoriesNotifier extends StateNotifier<List<Story>> {
  final Box<Story> _box;

  StoriesNotifier(this._box) : super([]) {
    _loadStories();
  }

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

final storiesProvider = StateNotifierProvider<StoriesNotifier, List<Story>>((ref) {
  final box = Hive.box<Story>('stories');
  return StoriesNotifier(box);
});
