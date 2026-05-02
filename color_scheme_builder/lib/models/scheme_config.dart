import 'package:material_color_utilities/material_color_utilities.dart';

class SchemeConfig {
  final int sourceArgb;
  final Variant variant;
  final bool isDark;
  final double contrast; // -1.0 to 1.0
  final List<int> blendColors; // custom colors to harmonize
  final FontConfig fontConfig;

  const SchemeConfig({
    required this.sourceArgb,
    this.variant = Variant.tonalSpot,
    this.isDark = false,
    this.contrast = 0.0,
    this.blendColors = const [],
    this.fontConfig = const FontConfig(),
  });

  SchemeConfig copyWith({
    int? sourceArgb,
    Variant? variant,
    bool? isDark,
    double? contrast,
    List<int>? blendColors,
    FontConfig? fontConfig,
  }) =>
      SchemeConfig(
        sourceArgb: sourceArgb ?? this.sourceArgb,
        variant: variant ?? this.variant,
        isDark: isDark ?? this.isDark,
        contrast: contrast ?? this.contrast,
        blendColors: blendColors ?? this.blendColors,
        fontConfig: fontConfig ?? this.fontConfig,
      );
}

class FontConfig {
  final FontChoice displayFont;
  final FontChoice bodyFont;

  const FontConfig({
    this.displayFont = const FontChoice.google('Roboto Condensed'),
    this.bodyFont = const FontChoice.google('Roboto Flex'),
  });

  FontConfig copyWith({FontChoice? displayFont, FontChoice? bodyFont}) =>
      FontConfig(
        displayFont: displayFont ?? this.displayFont,
        bodyFont: bodyFont ?? this.bodyFont,
      );
}

class FontChoice {
  final String name;
  final bool isGoogleFont;
  final String? localFileName; // e.g. "my_font" → res/font/my_font.ttf

  const FontChoice.google(this.name)
      : isGoogleFont = true,
        localFileName = null;

  const FontChoice.local(this.name, this.localFileName) : isGoogleFont = false;

  @override
  String toString() => isGoogleFont ? 'Google: $name' : 'Local: $name';
}
