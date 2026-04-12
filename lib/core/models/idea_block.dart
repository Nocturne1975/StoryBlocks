import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'idea_block.g.dart';

@HiveType(typeId: 1) // On utilise un nouvel ID pour Hive
class IdeaBlock extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final String category; // 'Personnage', 'Lieu', 'Phrase', 'Idée', 'Général'

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final List<String> tags;

  IdeaBlock({
    String? id,
    required this.content,
    this.category = 'Général',
    required this.createdAt,
    this.tags = const [],
  }) : id = id ?? const Uuid().v4();
}
