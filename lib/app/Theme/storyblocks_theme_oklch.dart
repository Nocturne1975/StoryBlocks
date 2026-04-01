import 'package:flutter/material.dart';
import 'storyblocks_tokens.dart';

/// StoryBlocks theme generated from your CSS tokens.
/// Source of truth = OKLCH conversions (your "option 2").
///
/// Includes:
/// - Converted OKLCH -> hex tokens (foreground, sidebar, charts, dark mode, etc.)
/// - Your warm palette + block category colors (scene/character/place/idea/theme)
/// - Light + Dark ThemeData (Material 3)
class StoryBlocksThemeOKLCH {
  // ---------------------------------------------------------------------------
  // Typography + radius tokens
  // ---------------------------------------------------------------------------
  static const double fontSizeBase = 16.0;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightNormal = FontWeight.w400;

  /// From CSS: --radius: 1rem  (≈ 16px)
  static const double radius = 16.0;

  // ---------------------------------------------------------------------------
  // Warm palette (hex from your CSS)
  // (Even with option 2, these are still useful for accents / story blocks.)
  // ---------------------------------------------------------------------------
  static const Color primaryAmber = Color(0xFFE07B39);
  static const Color primaryAmberLight = Color(0xFFF59E5F);
  static const Color primaryAmberDark = Color(0xFFC96328);

  static const Color warmCoral = Color(0xFFE57B70);
  static const Color warmCoralLight = Color(0xFFF29A8F);
  static const Color warmCoralDark = Color(0xFFD05A4E);

  static const Color golden = Color(0xFFD4A340);
  static const Color goldenLight = Color(0xFFE5BC60);
  static const Color goldenDark = Color(0xFFB38A2D);

  /// Surfaces warm (hex from your CSS)
  static const Color warmBackground = Color(0xFFFAF7F2);
  static const Color warmForeground = Color(0xFF3A2F28);
  static const Color warmCard = Color(0xFFFFFFFF);

  /// Block category colors (hex from your CSS)
  static const Color blockScene = Color(0xFFE07B39);
  static const Color blockCharacter = Color(0xFFD4A340);
  static const Color blockPlace = Color(0xFFC9694E);
  static const Color blockIdea = Color(0xFFE5BC60);
  static const Color blockTheme = Color(0xFFE57B70);

  // ---------------------------------------------------------------------------
  // OKLCH-converted tokens (your script output)
  // ---------------------------------------------------------------------------
  // Light neutrals
  static const Color foreground = Color(0xFF0A0A0A);
  static const Color popover = Color(0xFFFFFFFF);
  static const Color popoverForeground = Color(0xFF0A0A0A);
  static const Color primaryForeground = Color(0xFFFFFFFF);

  // Charts (light)
  static const Color chart1 = Color(0xFFF54900);
  static const Color chart2 = Color(0xFF009689);
  static const Color chart3 = Color(0xFF104E64);
  static const Color chart4 = Color(0xFFFFB900);
  static const Color chart5 = Color(0xFFFE9A00);

  // Sidebar (light)
  static const Color sidebar = Color(0xFFFAFAFA);
  static const Color sidebarForeground = Color(0xFF0A0A0A);
  static const Color sidebarPrimary = Color(0xFF171717);
  static const Color sidebarPrimaryForeground = Color(0xFFFAFAFA);
  static const Color sidebarAccent = Color(0xFFF5F5F5);
  static const Color sidebarAccentForeground = Color(0xFF171717);
  static const Color sidebarBorder = Color(0xFFE5E5E5);
  static const Color sidebarRing = Color(0xFFA1A1A1);

  // Dark tokens
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkForeground = Color(0xFFFAFAFA);
  static const Color darkCard = Color(0xFF0A0A0A);
  static const Color darkCardForeground = Color(0xFFFAFAFA);
  static const Color darkPopover = Color(0xFF0A0A0A);
  static const Color darkPopoverForeground = Color(0xFFFAFAFA);
  static const Color darkPrimary = Color(0xFFFAFAFA);
  static const Color darkPrimaryForeground = Color(0xFF171717);
  static const Color darkSecondary = Color(0xFF262626);
  static const Color darkSecondaryForeground = Color(0xFFFAFAFA);
  static const Color darkMuted = Color(0xFF262626);
  static const Color darkMutedForeground = Color(0xFFA1A1A1);
  static const Color darkAccent = Color(0xFF262626);
  static const Color darkAccentForeground = Color(0xFFFAFAFA);
  static const Color darkDestructive = Color(0xFF82181A);
  static const Color darkDestructiveForeground = Color(0xFFFB2C36);
  static const Color darkBorder = Color(0xFF262626);
  static const Color darkInput = Color(0xFF262626);
  static const Color darkRing = Color(0xFF525252);

  // Charts (dark)
  static const Color darkChart1 = Color(0xFF1447E6);
  static const Color darkChart2 = Color(0xFF00BC7D);
  static const Color darkChart3 = Color(0xFFFE9A00);
  static const Color darkChart4 = Color(0xFFAD46FF);
  static const Color darkChart5 = Color(0xFFFF2056);

  // Sidebar (dark)
  static const Color darkSidebar = Color(0xFF171717);
  static const Color darkSidebarForeground = Color(0xFFFAFAFA);
  static const Color darkSidebarPrimary = Color(0xFF1447E6);
  static const Color darkSidebarPrimaryForeground = Color(0xFFFAFAFA);
  static const Color darkSidebarAccent = Color(0xFF262626);
  static const Color darkSidebarAccentForeground = Color(0xFFFAFAFA);
  static const Color darkSidebarBorder = Color(0xFF262626);
  static const Color darkSidebarRing = Color(0xFF525252);

  // ---------------------------------------------------------------------------
  // ThemeData builders
  // ---------------------------------------------------------------------------

  /// Light theme: we keep your warm app background (#FAF7F2),
  /// but use OKLCH-converted neutrals for text/sidebar/charts.
  static ThemeData light() {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: primaryAmber,
          brightness: Brightness.light,
        ).copyWith(
          primary: primaryAmber,
          onPrimary: primaryForeground,
          secondary: golden,
          onSecondary: Colors.white,
          surface: warmCard,
          onSurface: foreground,
          error: const Color(0xFFEF4444), // from your CSS hex destructive
          onError: Colors.white,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,

      extensions: const [
        StoryBlocksTokens(
          blockScene: StoryBlocksThemeOKLCH.blockScene,
          blockCharacter: StoryBlocksThemeOKLCH.blockCharacter,
          blockPlace: StoryBlocksThemeOKLCH.blockPlace,
          blockIdea: StoryBlocksThemeOKLCH.blockIdea,
          blockTheme: StoryBlocksThemeOKLCH.blockTheme,

          chart1: StoryBlocksThemeOKLCH.chart1,
          chart2: StoryBlocksThemeOKLCH.chart2,
          chart3: StoryBlocksThemeOKLCH.chart3,
          chart4: StoryBlocksThemeOKLCH.chart4,
          chart5: StoryBlocksThemeOKLCH.chart5,

          sidebar: StoryBlocksThemeOKLCH.sidebar,
          sidebarForeground: StoryBlocksThemeOKLCH.sidebarForeground,
          sidebarPrimary: StoryBlocksThemeOKLCH.sidebarPrimary,
          sidebarPrimaryForeground:
              StoryBlocksThemeOKLCH.sidebarPrimaryForeground,
          sidebarAccent: StoryBlocksThemeOKLCH.sidebarAccent,
          sidebarAccentForeground:
              StoryBlocksThemeOKLCH.sidebarAccentForeground,
          sidebarBorder: StoryBlocksThemeOKLCH.sidebarBorder,
          sidebarRing: StoryBlocksThemeOKLCH.sidebarRing,
        ),
      ],

      scaffoldBackgroundColor: warmBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: warmBackground,
        foregroundColor: Color(0xFF0A0A0A),
        centerTitle: true,
        elevation: 0,
      ),

      cardTheme: CardThemeData(
        color: warmCard,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: const BorderSide(
            color: Color(0xFFE8DFD3),
          ), // border (hex in your CSS)
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(
          0xFFF9F6F1,
        ), // input-background (hex in your CSS)
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: Color(0xFFE8DFD3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: Color(0xFFE8DFD3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: primaryAmber, width: 2),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryAmber,
          foregroundColor: primaryForeground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: const TextStyle(fontWeight: fontWeightMedium),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: foreground,
          side: const BorderSide(color: Color(0xFFE8DFD3)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: const TextStyle(fontWeight: fontWeightMedium),
        ),
      ),

      textTheme: _textTheme(baseColor: foreground),
      dividerTheme: const DividerThemeData(color: Color(0xFFE8DFD3)),

      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFF5EFE7),
        selectedColor: primaryAmberLight.withAlpha(89), // 0.35 * 255 ≈ 89
        labelStyle: const TextStyle(color: Color(0xFF0A0A0A)),
        secondaryLabelStyle: const TextStyle(color: Color(0xFF0A0A0A)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: const BorderSide(color: Color(0xFFE8DFD3)),
        ),
      ),
    );
  }

  static ThemeData dark() {
    final scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: darkPrimary,
      onPrimary: darkPrimaryForeground,
      secondary: darkSecondary,
      onSecondary: darkSecondaryForeground,
      error: darkDestructive,
      onError: darkDestructiveForeground,
      surface: darkCard,
      onSurface: darkForeground,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,

      extensions: const [
        StoryBlocksTokens(
          blockScene: StoryBlocksThemeOKLCH.blockScene,
          blockCharacter: StoryBlocksThemeOKLCH.blockCharacter,
          blockPlace: StoryBlocksThemeOKLCH.blockPlace,
          blockIdea: StoryBlocksThemeOKLCH.blockIdea,
          blockTheme: StoryBlocksThemeOKLCH.blockTheme,

          chart1: StoryBlocksThemeOKLCH.darkChart1,
          chart2: StoryBlocksThemeOKLCH.darkChart2,
          chart3: StoryBlocksThemeOKLCH.darkChart3,
          chart4: StoryBlocksThemeOKLCH.darkChart4,
          chart5: StoryBlocksThemeOKLCH.darkChart5,

          sidebar: StoryBlocksThemeOKLCH.darkSidebar,
          sidebarForeground: StoryBlocksThemeOKLCH.darkSidebarForeground,
          sidebarPrimary: StoryBlocksThemeOKLCH.darkSidebarPrimary,
          sidebarPrimaryForeground:
              StoryBlocksThemeOKLCH.darkSidebarPrimaryForeground,
          sidebarAccent: StoryBlocksThemeOKLCH.darkSidebarAccent,
          sidebarAccentForeground:
              StoryBlocksThemeOKLCH.darkSidebarAccentForeground,
          sidebarBorder: StoryBlocksThemeOKLCH.darkSidebarBorder,
          sidebarRing: StoryBlocksThemeOKLCH.darkSidebarRing,
        ),
      ],

      scaffoldBackgroundColor: darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        foregroundColor: darkForeground,
        centerTitle: true,
        elevation: 0,
      ),

      cardTheme: CardThemeData(
        color: darkCard,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: const BorderSide(color: darkBorder),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkInput,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: darkRing, width: 2),
        ),
      ),

      textTheme: _textTheme(baseColor: darkForeground),
      dividerTheme: const DividerThemeData(color: darkBorder),
    );
  }

  static TextTheme _textTheme({required Color baseColor}) {
    // Approx mapping for your base CSS typography rules
    return const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: fontWeightMedium,
        height: 1.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: fontWeightMedium,
        height: 1.5,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: fontWeightMedium,
        height: 1.5,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: fontWeightMedium,
        height: 1.5,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: fontWeightNormal,
        height: 1.5,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: fontWeightMedium,
        height: 1.5,
      ),
    ).apply(bodyColor: baseColor, displayColor: baseColor);
  }
}
