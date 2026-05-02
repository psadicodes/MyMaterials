import 'package:material_color_utilities/material_color_utilities.dart';
import '../models/color_token.dart';
import '../models/scheme_config.dart';

class SchemeResult {
  final List<ColorToken> tokens;
  final List<TonalPaletteStrip> palettes;

  const SchemeResult({required this.tokens, required this.palettes});
}

class SchemeService {
  static final List<int> _tones = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 99, 100];

  static DynamicScheme buildScheme(SchemeConfig config, {bool? isDark, double? contrast}) {
    final hct = Hct.fromInt(config.sourceArgb);
    final dark = isDark ?? config.isDark;
    final c = contrast ?? config.contrast;
    return switch (config.variant) {
      Variant.monochrome  => SchemeMonochrome(sourceColorHct: hct, isDark: dark, contrastLevel: c),
      Variant.neutral     => SchemeNeutral(sourceColorHct: hct, isDark: dark, contrastLevel: c),
      Variant.tonalSpot   => SchemeTonalSpot(sourceColorHct: hct, isDark: dark, contrastLevel: c),
      Variant.vibrant     => SchemeVibrant(sourceColorHct: hct, isDark: dark, contrastLevel: c),
      Variant.expressive  => SchemeExpressive(sourceColorHct: hct, isDark: dark, contrastLevel: c),
      Variant.content     => SchemeContent(sourceColorHct: hct, isDark: dark, contrastLevel: c),
      Variant.fidelity    => SchemeFidelity(sourceColorHct: hct, isDark: dark, contrastLevel: c),
      Variant.rainbow     => SchemeRainbow(sourceColorHct: hct, isDark: dark, contrastLevel: c),
      Variant.fruitSalad  => SchemeFruitSalad(sourceColorHct: hct, isDark: dark, contrastLevel: c),
    };
  }

  static SchemeResult computeTokens(SchemeConfig config) {
    final scheme = buildScheme(config);
    return SchemeResult(
      tokens: _extractTokens(scheme),
      palettes: _extractPalettes(scheme),
    );
  }

  static List<ColorToken> _extractTokens(DynamicScheme s) => [
    ColorToken('primary',                   MaterialDynamicColors.primary.getArgb(s)),
    ColorToken('onPrimary',                 MaterialDynamicColors.onPrimary.getArgb(s)),
    ColorToken('primaryContainer',          MaterialDynamicColors.primaryContainer.getArgb(s)),
    ColorToken('onPrimaryContainer',        MaterialDynamicColors.onPrimaryContainer.getArgb(s)),
    ColorToken('secondary',                 MaterialDynamicColors.secondary.getArgb(s)),
    ColorToken('onSecondary',               MaterialDynamicColors.onSecondary.getArgb(s)),
    ColorToken('secondaryContainer',        MaterialDynamicColors.secondaryContainer.getArgb(s)),
    ColorToken('onSecondaryContainer',      MaterialDynamicColors.onSecondaryContainer.getArgb(s)),
    ColorToken('tertiary',                  MaterialDynamicColors.tertiary.getArgb(s)),
    ColorToken('onTertiary',                MaterialDynamicColors.onTertiary.getArgb(s)),
    ColorToken('tertiaryContainer',         MaterialDynamicColors.tertiaryContainer.getArgb(s)),
    ColorToken('onTertiaryContainer',       MaterialDynamicColors.onTertiaryContainer.getArgb(s)),
    ColorToken('error',                     MaterialDynamicColors.error.getArgb(s)),
    ColorToken('onError',                   MaterialDynamicColors.onError.getArgb(s)),
    ColorToken('errorContainer',            MaterialDynamicColors.errorContainer.getArgb(s)),
    ColorToken('onErrorContainer',          MaterialDynamicColors.onErrorContainer.getArgb(s)),
    ColorToken('background',                MaterialDynamicColors.background.getArgb(s)),
    ColorToken('onBackground',              MaterialDynamicColors.onBackground.getArgb(s)),
    ColorToken('surface',                   MaterialDynamicColors.surface.getArgb(s)),
    ColorToken('onSurface',                 MaterialDynamicColors.onSurface.getArgb(s)),
    ColorToken('surfaceVariant',            MaterialDynamicColors.surfaceVariant.getArgb(s)),
    ColorToken('onSurfaceVariant',          MaterialDynamicColors.onSurfaceVariant.getArgb(s)),
    ColorToken('outline',                   MaterialDynamicColors.outline.getArgb(s)),
    ColorToken('outlineVariant',            MaterialDynamicColors.outlineVariant.getArgb(s)),
    ColorToken('scrim',                     MaterialDynamicColors.scrim.getArgb(s)),
    ColorToken('inverseSurface',            MaterialDynamicColors.inverseSurface.getArgb(s)),
    ColorToken('inverseOnSurface',          MaterialDynamicColors.inverseOnSurface.getArgb(s)),
    ColorToken('inversePrimary',            MaterialDynamicColors.inversePrimary.getArgb(s)),
    ColorToken('surfaceDim',                MaterialDynamicColors.surfaceDim.getArgb(s)),
    ColorToken('surfaceBright',             MaterialDynamicColors.surfaceBright.getArgb(s)),
    ColorToken('surfaceContainerLowest',    MaterialDynamicColors.surfaceContainerLowest.getArgb(s)),
    ColorToken('surfaceContainerLow',       MaterialDynamicColors.surfaceContainerLow.getArgb(s)),
    ColorToken('surfaceContainer',          MaterialDynamicColors.surfaceContainer.getArgb(s)),
    ColorToken('surfaceContainerHigh',      MaterialDynamicColors.surfaceContainerHigh.getArgb(s)),
    ColorToken('surfaceContainerHighest',   MaterialDynamicColors.surfaceContainerHighest.getArgb(s)),
  ];

  static List<TonalPaletteStrip> _extractPalettes(DynamicScheme s) => [
    TonalPaletteStrip('Primary',         _swatches(s.primaryPalette)),
    TonalPaletteStrip('Secondary',       _swatches(s.secondaryPalette)),
    TonalPaletteStrip('Tertiary',        _swatches(s.tertiaryPalette)),
    TonalPaletteStrip('Neutral',         _swatches(s.neutralPalette)),
    TonalPaletteStrip('Neutral Variant', _swatches(s.neutralVariantPalette)),
    TonalPaletteStrip('Error',           _swatches(s.errorPalette)),
  ];

  static List<TonalSwatch> _swatches(TonalPalette p) =>
      _tones.map((t) => TonalSwatch(t, p.get(t))).toList();

  // Build all 6 contrast schemes for export
  static Map<String, List<ColorToken>> buildExportSchemes(SchemeConfig config) => {
    'light':                _extractTokens(buildScheme(config, isDark: false, contrast: 0.0)),
    'lightMediumContrast':  _extractTokens(buildScheme(config, isDark: false, contrast: 0.5)),
    'lightHighContrast':    _extractTokens(buildScheme(config, isDark: false, contrast: 1.0)),
    'dark':                 _extractTokens(buildScheme(config, isDark: true,  contrast: 0.0)),
    'darkMediumContrast':   _extractTokens(buildScheme(config, isDark: true,  contrast: 0.5)),
    'darkHighContrast':     _extractTokens(buildScheme(config, isDark: true,  contrast: 1.0)),
  };

  // Harmonize a custom color toward the source
  static int harmonize(int customArgb, int sourceArgb) =>
      Blend.harmonize(customArgb, sourceArgb);
}
