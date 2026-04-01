import 'package:flutter/material.dart';

@immutable
class StoryBlocksTokens extends ThemeExtension<StoryBlocksTokens> {
  const StoryBlocksTokens({
    // Block category colors
    required this.blockScene,
    required this.blockCharacter,
    required this.blockPlace,
    required this.blockIdea,
    required this.blockTheme,

    // Charts
    required this.chart1,
    required this.chart2,
    required this.chart3,
    required this.chart4,
    required this.chart5,

    // Sidebar
    required this.sidebar,
    required this.sidebarForeground,
    required this.sidebarPrimary,
    required this.sidebarPrimaryForeground,
    required this.sidebarAccent,
    required this.sidebarAccentForeground,
    required this.sidebarBorder,
    required this.sidebarRing,
  });

  final Color blockScene;
  final Color blockCharacter;
  final Color blockPlace;
  final Color blockIdea;
  final Color blockTheme;

  final Color chart1;
  final Color chart2;
  final Color chart3;
  final Color chart4;
  final Color chart5;

  final Color sidebar;
  final Color sidebarForeground;
  final Color sidebarPrimary;
  final Color sidebarPrimaryForeground;
  final Color sidebarAccent;
  final Color sidebarAccentForeground;
  final Color sidebarBorder;
  final Color sidebarRing;

  @override
  StoryBlocksTokens copyWith({
    Color? blockScene,
    Color? blockCharacter,
    Color? blockPlace,
    Color? blockIdea,
    Color? blockTheme,
    Color? chart1,
    Color? chart2,
    Color? chart3,
    Color? chart4,
    Color? chart5,
    Color? sidebar,
    Color? sidebarForeground,
    Color? sidebarPrimary,
    Color? sidebarPrimaryForeground,
    Color? sidebarAccent,
    Color? sidebarAccentForeground,
    Color? sidebarBorder,
    Color? sidebarRing,
  }) {
    return StoryBlocksTokens(
      blockScene: blockScene ?? this.blockScene,
      blockCharacter: blockCharacter ?? this.blockCharacter,
      blockPlace: blockPlace ?? this.blockPlace,
      blockIdea: blockIdea ?? this.blockIdea,
      blockTheme: blockTheme ?? this.blockTheme,
      chart1: chart1 ?? this.chart1,
      chart2: chart2 ?? this.chart2,
      chart3: chart3 ?? this.chart3,
      chart4: chart4 ?? this.chart4,
      chart5: chart5 ?? this.chart5,
      sidebar: sidebar ?? this.sidebar,
      sidebarForeground: sidebarForeground ?? this.sidebarForeground,
      sidebarPrimary: sidebarPrimary ?? this.sidebarPrimary,
      sidebarPrimaryForeground:
          sidebarPrimaryForeground ?? this.sidebarPrimaryForeground,
      sidebarAccent: sidebarAccent ?? this.sidebarAccent,
      sidebarAccentForeground:
          sidebarAccentForeground ?? this.sidebarAccentForeground,
      sidebarBorder: sidebarBorder ?? this.sidebarBorder,
      sidebarRing: sidebarRing ?? this.sidebarRing,
    );
  }

  @override
  StoryBlocksTokens lerp(ThemeExtension<StoryBlocksTokens>? other, double t) {
    if (other is! StoryBlocksTokens) return this;

    Color lerpColor(Color a, Color b) => Color.lerp(a, b, t)!;

    return StoryBlocksTokens(
      blockScene: lerpColor(blockScene, other.blockScene),
      blockCharacter: lerpColor(blockCharacter, other.blockCharacter),
      blockPlace: lerpColor(blockPlace, other.blockPlace),
      blockIdea: lerpColor(blockIdea, other.blockIdea),
      blockTheme: lerpColor(blockTheme, other.blockTheme),
      chart1: lerpColor(chart1, other.chart1),
      chart2: lerpColor(chart2, other.chart2),
      chart3: lerpColor(chart3, other.chart3),
      chart4: lerpColor(chart4, other.chart4),
      chart5: lerpColor(chart5, other.chart5),
      sidebar: lerpColor(sidebar, other.sidebar),
      sidebarForeground: lerpColor(sidebarForeground, other.sidebarForeground),
      sidebarPrimary: lerpColor(sidebarPrimary, other.sidebarPrimary),
      sidebarPrimaryForeground: lerpColor(
        sidebarPrimaryForeground,
        other.sidebarPrimaryForeground,
      ),
      sidebarAccent: lerpColor(sidebarAccent, other.sidebarAccent),
      sidebarAccentForeground: lerpColor(
        sidebarAccentForeground,
        other.sidebarAccentForeground,
      ),
      sidebarBorder: lerpColor(sidebarBorder, other.sidebarBorder),
      sidebarRing: lerpColor(sidebarRing, other.sidebarRing),
    );
  }
}

/// Convenience accessor
extension StoryBlocksTokensX on BuildContext {
  StoryBlocksTokens get sbTokens =>
      Theme.of(this).extension<StoryBlocksTokens>()!;
}
