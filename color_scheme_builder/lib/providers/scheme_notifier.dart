import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheme_config.dart';
import '../services/scheme_service.dart';

class SchemeNotifier extends Notifier<SchemeConfig> {
  @override
  SchemeConfig build() => const SchemeConfig(sourceArgb: 0xFFB61137);

  void setSourceColor(int argb) =>
      state = state.copyWith(sourceArgb: argb);

  void setVariant(dynamic variant) =>
      state = state.copyWith(variant: variant);

  void setDark(bool v) => state = state.copyWith(isDark: v);

  void setContrast(double v) => state = state.copyWith(contrast: v);

  void setFontConfig(FontConfig fc) => state = state.copyWith(fontConfig: fc);

  void addBlendColor(int argb) {
    if (state.blendColors.length >= 8) return;
    state = state.copyWith(blendColors: [...state.blendColors, argb]);
  }

  void removeBlendColor(int argb) {
    final list = [...state.blendColors]..remove(argb);
    state = state.copyWith(blendColors: list);
  }
}

final schemeProvider = NotifierProvider<SchemeNotifier, SchemeConfig>(SchemeNotifier.new);

// Derived providers (recomputed when schemeProvider changes)
final schemeResultProvider = Provider<SchemeResult>((ref) {
  final config = ref.watch(schemeProvider);
  return SchemeService.computeTokens(config);
});

final harmonizedColorsProvider = Provider<List<HarmonizedColor>>((ref) {
  final config = ref.watch(schemeProvider);
  return config.blendColors.map((argb) {
    final harmonized = SchemeService.harmonize(argb, config.sourceArgb);
    return HarmonizedColor(original: argb, harmonized: harmonized);
  }).toList();
});

// The Flutter ColorScheme built from the current config (for live preview)
final flutterColorSchemeProvider = Provider<ColorScheme>((ref) {
  final result = ref.watch(schemeResultProvider);
  final config = ref.watch(schemeProvider);
  final t = {for (final tok in result.tokens) tok.name: tok.color};

  return ColorScheme(
    brightness: config.isDark ? Brightness.dark : Brightness.light,
    primary:                t['primary']!,
    onPrimary:              t['onPrimary']!,
    primaryContainer:       t['primaryContainer']!,
    onPrimaryContainer:     t['onPrimaryContainer']!,
    secondary:              t['secondary']!,
    onSecondary:            t['onSecondary']!,
    secondaryContainer:     t['secondaryContainer']!,
    onSecondaryContainer:   t['onSecondaryContainer']!,
    tertiary:               t['tertiary']!,
    onTertiary:             t['onTertiary']!,
    tertiaryContainer:      t['tertiaryContainer']!,
    onTertiaryContainer:    t['onTertiaryContainer']!,
    error:                  t['error']!,
    onError:                t['onError']!,
    errorContainer:         t['errorContainer']!,
    onErrorContainer:       t['onErrorContainer']!,
    surface:                t['surface']!,
    onSurface:              t['onSurface']!,
    surfaceContainerHighest:t['surfaceContainerHighest']!,
    surfaceContainerHigh:   t['surfaceContainerHigh']!,
    surfaceContainer:       t['surfaceContainer']!,
    surfaceContainerLow:    t['surfaceContainerLow']!,
    surfaceContainerLowest: t['surfaceContainerLowest']!,
    surfaceDim:             t['surfaceDim']!,
    surfaceBright:          t['surfaceBright']!,
    onSurfaceVariant:       t['onSurfaceVariant']!,
    outline:                t['outline']!,
    outlineVariant:         t['outlineVariant']!,
    shadow:                 const Color(0xFF000000),
    scrim:                  t['scrim']!,
    inverseSurface:         t['inverseSurface']!,
    onInverseSurface:       t['inverseOnSurface']!,
    inversePrimary:         t['inversePrimary']!,
  );
});

class HarmonizedColor {
  final int original;
  final int harmonized;
  const HarmonizedColor({required this.original, required this.harmonized});
}
