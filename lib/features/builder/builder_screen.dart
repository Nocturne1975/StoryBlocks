import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/story_engine/story_data.dart';
import 'builder_provider.dart';

class BuilderScreen extends ConsumerWidget {
  const BuilderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final builderState = ref.watch(builderProvider);
    final builderNotifier = ref.read(builderProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('StoryBlocks'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Choisissez le ton :', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: builderState.tone,
            items: StoryData.tones.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
            onChanged: (val) => builderNotifier.updateTone(val!),
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 24),

          ...StoryData.blocks.keys.map((category) {
            final selectedValue = builderState.selectedBlocks[category];
            final options = StoryData.blocks[category]!;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 12, 
                      color: Theme.of(context).colorScheme.primary
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options[index];
                        final isSelected = selectedValue == option;

                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(option),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) builderNotifier.updateBlock(category, option);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 32),

          ElevatedButton(
            onPressed: builderNotifier.isComplete
                ? () => context.push('/reader')
                : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(60),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: const Text(
              'GÉNÉRER MON HISTOIRE',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
