import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:storyblocks/core/models/story.dart';
import 'package:storyblocks/features/stories/stories_provider.dart';
import 'package:storyblocks/features/stories/stories_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late Box<Story> box;
  late String boxName;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('storyblocks_test_');
    Hive.init(tempDir.path);

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(StoryAdapter());
    }

    boxName = 'stories_${DateTime.now().microsecondsSinceEpoch}';
    box = await Hive.openBox<Story>(boxName);
  });

  tearDown(() async {
    if (box.isOpen) {
      await box.deleteFromDisk();
    }

    await Hive.close();

    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  testWidgets('affiche "Aucune histoire" quand la liste est vide', (
    tester,
  ) async {
    await _pumpStoriesScreen(tester, box);

    expect(find.text('Mes histoires'), findsOneWidget);
    expect(find.text('Aucune histoire'), findsOneWidget);
  });

  testWidgets('affiche toutes les histoires sauvegardees avec titre et date', (
    tester,
  ) async {
    final olderStory = Story(
      title: 'Le phare abandonne',
      content: 'Une vieille histoire de tempete.',
      createdAt: DateTime(2026, 4, 2),
      blocks: const {'personnage': 'Mila', 'lieu': 'le phare'},
      tone: 'Mystere',
    );
    final recentStory = Story(
      title: 'Le jardin secret',
      content: 'Une histoire plus recente.',
      createdAt: DateTime(2026, 4, 8),
      blocks: const {'personnage': 'Noe', 'lieu': 'le jardin'},
      tone: 'Poetique',
    );

    await box.putAll({olderStory.id: olderStory, recentStory.id: recentStory});

    await _pumpStoriesScreen(tester, box);

    expect(find.text('Aucune histoire'), findsNothing);
    expect(find.text('Le phare abandonne'), findsOneWidget);
    expect(find.text('Le jardin secret'), findsOneWidget);
    expect(find.text('02/04/2026'), findsOneWidget);
    expect(find.text('08/04/2026'), findsOneWidget);

    final recentStoryPosition = tester.getTopLeft(
      find.text('Le jardin secret'),
    );
    final olderStoryPosition = tester.getTopLeft(
      find.text('Le phare abandonne'),
    );

    expect(recentStoryPosition.dy, lessThan(olderStoryPosition.dy));
  });

  test(
    'recharge les histoires sauvegardees apres reouverture de la boite',
    () async {
      final firstStory = Story(
        title: 'La carte des etoiles',
        content: 'Une quete dans le ciel.',
        createdAt: DateTime(2026, 4, 1),
        blocks: const {'personnage': 'Lina', 'lieu': 'les montagnes'},
        tone: 'Aventure',
      );
      final secondStory = Story(
        title: 'Le dernier wagon',
        content: 'Un voyage nocturne.',
        createdAt: DateTime(2026, 4, 5),
        blocks: const {'personnage': 'Theo', 'lieu': 'le train'},
        tone: 'Suspense',
      );

      await box.putAll({
        firstStory.id: firstStory,
        secondStory.id: secondStory,
      });

      await box.close();
      box = await Hive.openBox<Story>(boxName);

      final notifier = StoriesNotifier(box);

      expect(notifier.state, hasLength(2));
      expect(notifier.state.first.title, 'Le dernier wagon');
      expect(notifier.state.last.title, 'La carte des etoiles');
    },
  );
}

Future<void> _pumpStoriesScreen(WidgetTester tester, Box<Story> box) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [storiesBoxProvider.overrideWith((ref) => box)],
      child: const MaterialApp(home: StoriesScreen()),
    ),
  );

  await tester.pump();
}
