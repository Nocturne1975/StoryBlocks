import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/story_engine/story_data.dart';
import '../../app/Theme/storyblocks_tokens.dart';
import 'builder_provider.dart';

class BuilderScreen extends ConsumerWidget {
  const BuilderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final builderState = ref.watch(builderProvider);
    final builderNotifier = ref.read(builderProvider.notifier);
    final tokens = context.sbTokens;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Créateur d\'Histoires',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primaryContainer.withAlpha(50),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildSectionHeader(
                      "Ton de l'histoire",
                      Icons.palette_outlined,
                      tokens.blockTheme,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: builderState.tone,
                      items: StoryData.tones
                          .map(
                            (t) => DropdownMenuItem(value: t, child: Text(t)),
                          )
                          .toList(),
                      onChanged: (val) => builderNotifier.updateTone(val!),
                      decoration: InputDecoration(
                        labelText: 'Ton',
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(100),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionHeader(
                      "Longueur de l'histoire",
                      Icons.straighten_rounded,
                      tokens.blockIdea,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: builderState.storyLength,
                      items: ['Courte', 'Moyenne', 'Longue']
                          .map(
                            (l) => DropdownMenuItem(value: l, child: Text(l)),
                          )
                          .toList(),
                      onChanged: (val) => builderNotifier.updateLength(val!),
                      decoration: InputDecoration(
                        labelText: 'Longueur',
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(100),
                      ),
                    ),
                    const SizedBox(height: 30),

                    ...StoryData.blocks.keys.map((category) {
                      final selectedValue =
                          builderState.selectedBlocks[category];
                      final options = StoryData.blocks[category]!;

                      Color categoryColor;
                      IconData categoryIcon;
                      switch (category) {
                        case 'personnage':
                          categoryColor = tokens.blockCharacter;
                          categoryIcon = Icons.person_search_rounded;
                          break;
                        case 'lieu':
                          categoryColor = tokens.blockPlace;
                          categoryIcon = Icons.map_rounded;
                          break;
                        case 'objectif':
                          categoryColor = tokens.blockIdea;
                          categoryIcon = Icons.flag_rounded;
                          break;
                        case 'obstacle':
                          categoryColor = tokens.blockTheme;
                          categoryIcon = Icons.warning_amber_rounded;
                          break;
                        case 'twist':
                          categoryColor = tokens.blockScene;
                          categoryIcon = Icons.auto_awesome_rounded;
                          break;
                        default:
                          categoryColor = tokens.blockTheme;
                          categoryIcon = Icons.extension_rounded;
                      }

                      return _CategoryCard(
                        category: category,
                        icon: categoryIcon,
                        color: categoryColor,
                        options: options,
                        selectedValue: selectedValue,
                        onSelected: (val) =>
                            builderNotifier.updateBlock(category, val),
                      );
                    }),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed: builderNotifier.isComplete
              ? () => context.push('/reader')
              : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(65),
            backgroundColor: tokens.blockScene,
            foregroundColor: Colors.white,
            elevation: 8,
            shadowColor: tokens.blockScene.withAlpha(128),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.auto_fix_high_rounded),
              SizedBox(width: 12),
              Text(
                'GÉNÉRER L\'HISTOIRE',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: color,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String category;
  final IconData icon;
  final Color color;
  final List<String> options;
  final String? selectedValue;
  final Function(String) onSelected;

  const _CategoryCard({
    required this.category,
    required this.icon,
    required this.color,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: color.withAlpha(40),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withAlpha(26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  category.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                final isSelected = selectedValue == option;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: AnimatedScale(
                    scale: isSelected ? 1.05 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: ChoiceChip(
                      label: Text(option),
                      selected: isSelected,
                      onSelected: (_) => onSelected(option),
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest
                          .withAlpha(100),
                      selectedColor: color.withAlpha(51),
                      labelStyle: TextStyle(
                        color: isSelected
                            ? color
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: isSelected ? color : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
