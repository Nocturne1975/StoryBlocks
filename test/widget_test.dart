import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storyblocks/main.dart';

void main() {
  testWidgets('L\'application se lance et affiche le titre', (WidgetTester tester) async {
    // Build our app and trigger a frame within a ProviderScope for Riverpod.
    await tester.pumpWidget(
      const ProviderScope(
        child: StoryBlocksApp(),
      ),
    );

    // Vérifie que le titre du Builder est présent
    expect(find.text('StoryBlocks'), findsOneWidget);
  });
}
