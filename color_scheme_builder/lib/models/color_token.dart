import 'package:flutter/material.dart';

class ColorToken {
  final String name;
  final int argb;

  const ColorToken(this.name, this.argb);

  Color get color => Color(argb);

  String get hex {
    final r = (argb >> 16) & 0xFF;
    final g = (argb >> 8) & 0xFF;
    final b = argb & 0xFF;
    return '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}'.toUpperCase();
  }

  String get composeHex =>
      '0x${argb.toRadixString(16).toUpperCase().padLeft(8, '0')}';
}

class TonalPaletteStrip {
  final String name;
  final List<TonalSwatch> swatches;

  const TonalPaletteStrip(this.name, this.swatches);
}

class TonalSwatch {
  final int tone;
  final int argb;

  const TonalSwatch(this.tone, this.argb);

  Color get color => Color(argb);
}

// The 35 tokens that map to Compose's ColorScheme exactly
const List<String> kColorSchemeTokenNames = [
  'primary', 'onPrimary', 'primaryContainer', 'onPrimaryContainer',
  'secondary', 'onSecondary', 'secondaryContainer', 'onSecondaryContainer',
  'tertiary', 'onTertiary', 'tertiaryContainer', 'onTertiaryContainer',
  'error', 'onError', 'errorContainer', 'onErrorContainer',
  'background', 'onBackground',
  'surface', 'onSurface',
  'surfaceVariant', 'onSurfaceVariant',
  'outline', 'outlineVariant',
  'scrim',
  'inverseSurface', 'inverseOnSurface', 'inversePrimary',
  'surfaceDim', 'surfaceBright',
  'surfaceContainerLowest', 'surfaceContainerLow',
  'surfaceContainer', 'surfaceContainerHigh', 'surfaceContainerHighest',
];
