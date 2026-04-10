import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'story.g.dart';

@HiveType(typeId: 0)
class Story extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final DateTime createdAt;

  // Blocs narratifs utilisés
  @HiveField(4)
  final Map<String, String> blocks;

  @HiveField(5)
  final String tone;

  Story({
    String? id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.blocks,
    required this.tone,
  }) : id = id ?? const Uuid().v4();
}
