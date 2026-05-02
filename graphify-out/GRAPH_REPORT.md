# Graph Report - /home/user/MyMaterials  (2026-05-02)

## Corpus Check
- Large corpus: 375 files · ~360,568 words. Semantic extraction will be expensive (many Claude tokens). Consider running on a subfolder, or use --no-semantic to run AST-only.

## Summary
- 3104 nodes · 6866 edges · 46 communities detected
- Extraction: 62% EXTRACTED · 38% INFERRED · 0% AMBIGUOUS · INFERRED: 2581 edges (avg confidence: 0.8)
- Token cost: 2,400 input · 1,900 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Dynamic Scheme & ColorSpec System|Dynamic Scheme & ColorSpec System]]
- [[_COMMUNITY_CAM16 & Blend Operations|CAM16 & Blend Operations]]
- [[_COMMUNITY_C++ Core Color Engine|C++ Core Color Engine]]
- [[_COMMUNITY_Dart Library Core|Dart Library Core]]
- [[_COMMUNITY_Testing & Dislike Filter|Testing & Dislike Filter]]
- [[_COMMUNITY_Dynamic Color & Contrast Curves|Dynamic Color & Contrast Curves]]
- [[_COMMUNITY_Scheme & Palette System|Scheme & Palette System]]
- [[_COMMUNITY_JavaTS Scheme API|Java/TS Scheme API]]
- [[_COMMUNITY_Swift Test Suite|Swift Test Suite]]
- [[_COMMUNITY_Color Blending API|Color Blending API]]
- [[_COMMUNITY_Quantization Engine|Quantization Engine]]
- [[_COMMUNITY_Dart Test Suite|Dart Test Suite]]
- [[_COMMUNITY_Java Color Spec Tokens|Java Color Spec Tokens]]
- [[_COMMUNITY_Material Dynamic Colors API|Material Dynamic Colors API]]
- [[_COMMUNITY_Temperature & Hue Rotation|Temperature & Hue Rotation]]
- [[_COMMUNITY_Color Extraction Concepts|Color Extraction Concepts]]
- [[_COMMUNITY_Tone Contrast Utilities|Tone Contrast Utilities]]
- [[_COMMUNITY_C++ Dynamic Scheme Tokens|C++ Dynamic Scheme Tokens]]
- [[_COMMUNITY_Legacy ColorSpec 2021|Legacy ColorSpec 2021]]
- [[_COMMUNITY_TS Material Dynamic Colors|TS Material Dynamic Colors]]
- [[_COMMUNITY_Material You UI Examples|Material You UI Examples]]
- [[_COMMUNITY_Expressive Scheme Variant|Expressive Scheme Variant]]
- [[_COMMUNITY_Fruit Salad Scheme Variant|Fruit Salad Scheme Variant]]
- [[_COMMUNITY_HCT Color Space Tests|HCT Color Space Tests]]
- [[_COMMUNITY_Android Legacy Scheme|Android Legacy Scheme]]
- [[_COMMUNITY_Image-to-Theme Pipeline|Image-to-Theme Pipeline]]
- [[_COMMUNITY_HCT Color Scheme Concepts|HCT Color Scheme Concepts]]
- [[_COMMUNITY_HCT Solver Algorithm|HCT Solver Algorithm]]
- [[_COMMUNITY_Fidelity & Accessibility Spec|Fidelity & Accessibility Spec]]
- [[_COMMUNITY_Color Tool Overview|Color Tool Overview]]
- [[_COMMUNITY_Scheme Variant Enum|Scheme Variant Enum]]
- [[_COMMUNITY_Math Utilities|Math Utilities]]
- [[_COMMUNITY_Legacy Scheme API (Dart)|Legacy Scheme API (Dart)]]
- [[_COMMUNITY_Quantizer Point Provider|Quantizer Point Provider]]
- [[_COMMUNITY_Wallpaper Color Extraction|Wallpaper Color Extraction]]
- [[_COMMUNITY_Color Spec Registry|Color Spec Registry]]
- [[_COMMUNITY_Core Palettes Multi-lang|Core Palettes Multi-lang]]
- [[_COMMUNITY_Quantizer Result Type|Quantizer Result Type]]
- [[_COMMUNITY_Dart Point Provider|Dart Point Provider]]
- [[_COMMUNITY_Color & String Utilities|Color & String Utilities]]
- [[_COMMUNITY_Dart Example Entry Point|Dart Example Entry Point]]
- [[_COMMUNITY_Dart Quantizer API|Dart Quantizer API]]
- [[_COMMUNITY_Swift Scheme Provider|Swift Scheme Provider]]
- [[_COMMUNITY_Dart Variant Enum|Dart Variant Enum]]
- [[_COMMUNITY_LinearsRGB Color Spaces|Linear/sRGB Color Spaces]]
- [[_COMMUNITY_Soft Constraint Concepts|Soft Constraint Concepts]]

## God Nodes (most connected - your core abstractions)
1. `extendSpecVersion()` - 192 edges
2. `Hct()` - 192 edges
3. `Scheme` - 130 edges
4. `ColorSpec2021` - 82 edges
5. `DynamicScheme` - 80 edges
6. `ColorSpec` - 78 edges
7. `ColorSpec2025` - 73 edges
8. `MaterialDynamicColors` - 73 edges
9. `DynamicScheme()` - 68 edges
10. `DynamicColor()` - 65 edges

## Surprising Connections (you probably didn't know these)
- `Contrast Library` --semantically_similar_to--> `Contrast Component`  [INFERRED] [semantically similar]
  dev_guide/refining_contrast.md → README.md
- `QuantizerCelebi` --semantically_similar_to--> `Quantize Component`  [INFERRED] [semantically similar]
  concepts/color_extraction.md → README.md
- `Color Scoring` --semantically_similar_to--> `Score Component`  [INFERRED] [semantically similar]
  concepts/color_extraction.md → README.md
- `TonalPalette` --semantically_similar_to--> `Tonal Palette (Concept)`  [INFERRED] [semantically similar]
  dart/CHANGELOG.md → concepts/dynamic_color_scheme.md
- `DynamicScheme` --semantically_similar_to--> `DynamicScheme (Concept)`  [INFERRED] [semantically similar]
  dart/CHANGELOG.md → concepts/dynamic_color_scheme.md

## Hyperedges (group relationships)
- **Image Color Extraction to Dynamic Scheme Generation Pipeline** — color_extraction_quantize, color_extraction_scoring, dynamic_color_scheme_source_color, dynamic_color_scheme_tonal_palette, dynamic_color_scheme_dynamic_scheme [EXTRACTED 1.00]
- **HCT Color System Foundation** — color_spaces_cam16_jch, color_spaces_cielab, color_spaces_hct_color_space, dynamic_color_scheme_hct_color_space [EXTRACTED 1.00]
- **Dynamic Scheme Accessibility Compliance** — dynamic_color_scheme_dynamic_scheme, scheme_generation_contrast_tone_adjustments, contrast_accessibility_gar, contrast_accessibility_wcag [EXTRACTED 0.95]

## Communities

### Community 0 - "Dynamic Scheme & ColorSpec System"
Cohesion: 0.04
Nodes (11): ColorSpec, ColorSpec2021, ColorSpec2025, ColorSpecDelegateImpl2025, ColorSpecDelegateImpl2026, ColorSpec2021, ColorSpec2025, ColorSpec2026 (+3 more)

### Community 1 - "CAM16 & Blend Operations"
Cohesion: 0.02
Nodes (96): BlendCam16Ucs(), BlendHctHue(), CamDistance(), CamFromInt(), CamFromIntAndViewingConditions(), CamFromJchAndViewingConditions(), CamFromUcsAndViewingConditions(), CamFromXyzAndViewingConditions() (+88 more)

### Community 2 - "C++ Core Color Engine"
Cohesion: 0.02
Nodes (20): Hct(), FixIfDisliked(), IsDisliked(), TEST(), TEST_P(), DynamicColorTests, _Pair, SchemeContent() (+12 more)

### Community 3 - "Dart Library Core"
Cohesion: 0.01
Nodes (180): ../cam16.dart, ../contrast/contrast.dart, dart:core, dart:math, ../dislike/dislike_analyzer.dart, ../dynamic_color.dart, dynamic_scheme.dart, ../dynamiccolor/dynamic_scheme.dart (+172 more)

### Community 4 - "Testing & Dislike Filter"
Cohesion: 0.02
Nodes (57): TEST(), DislikeAnalyzer, findBestToneForChroma(), tMaxC(), tMinC(), findBestToneForChroma(), tMaxC(), tMinC() (+49 more)

### Community 5 - "Dynamic Color & Contrast Curves"
Cohesion: 0.03
Nodes (73): ContrastCurve, ColorCalculationDelegateImpl2021, ColorCalculationDelegateImpl2025, DynamicColor(), getSpec(), material_color_utilities(), DynamicScheme, Platform (+65 more)

### Community 6 - "Scheme & Palette System"
Cohesion: 0.02
Nodes (30): CorePalettes, DynamicScheme, DynamicSchemeProvider, SchemeFidelity(), SchemeCmf, CorePalettesContent, SchemeContent, SchemeContentProvider (+22 more)

### Community 7 - "Java/TS Scheme API"
Cohesion: 0.02
Nodes (2): CorePalette, Scheme

### Community 8 - "Swift Test Suite"
Cohesion: 0.02
Nodes (22): BlendTests, ContrastTests, DislikeAnalyzerTests, Cam16Tests, ViewingConditionsTests, create(), KeyColor(), max_chroma() (+14 more)

### Community 9 - "Color Blending API"
Cohesion: 0.03
Nodes (32): Blend, BlendHarmonize(), ToInt(), Comparable, DislikeAnalyzer, GetRotatedHue(), Equatable, Hashable (+24 more)

### Community 10 - "Quantization Engine"
Cohesion: 0.03
Nodes (19): PointProvider, PointProviderLab, Quantizer, QuantizerResult, QuantizerCelebi, QuantizerMap, Box, CreateBoxesResult (+11 more)

### Community 11 - "Dart Test Suite"
Cohesion: 0.03
Nodes (68): main, main, main, main, main, _Pair, main, main (+60 more)

### Community 12 - "Java Color Spec Tokens"
Cohesion: 0.03
Nodes (2): ColorSpec, SpecVersion

### Community 13 - "Material Dynamic Colors API"
Cohesion: 0.03
Nodes (1): MaterialDynamicColors

### Community 14 - "Temperature & Hue Rotation"
Cohesion: 0.07
Nodes (7): DynamicSchemePalettesDelegateImpl2021, DynamicSchemePalettesDelegateImpl2025, get(), TemperatureCache(), TEST(), TemperatureCache, TemperatureCacheTests

### Community 15 - "Color Extraction Concepts"
Cohesion: 0.03
Nodes (73): Content-Based Color Extraction, QuantizerCelebi, Color Scoring, Wallpaper-Based Color Extraction, CAM16 Color Appearance Model, CAM16-JCH, CAM16-UCS, CIELAB (L*a*b*) Color Space (+65 more)

### Community 16 - "Tone Contrast Utilities"
Cohesion: 0.05
Nodes (16): Darker(), DarkerUnsafe(), Lighter(), LighterUnsafe(), RatioOfTones(), RatioOfYs(), TEST(), EnableLightForeground() (+8 more)

### Community 17 - "C++ Dynamic Scheme Tokens"
Cohesion: 0.06
Nodes (1): DynamicScheme()

### Community 18 - "Legacy ColorSpec 2021"
Cohesion: 0.03
Nodes (1): ColorSpecDelegateImpl2021

### Community 19 - "TS Material Dynamic Colors"
Cohesion: 0.03
Nodes (1): MaterialDynamicColors

### Community 21 - "Material You UI Examples"
Cohesion: 0.07
Nodes (47): Android Mobile UI, Bottom Navigation Bar, Contact Avatar, Conversation Thread View, Conversation Thread UI, Dark Mode Theme, Dart / Flutter Framework, Dart Programming Language (+39 more)

### Community 22 - "Expressive Scheme Variant"
Cohesion: 0.08
Nodes (5): SchemeExpressive(), CorePalettesExpressive, SchemeExpressive, SchemeExpressiveProvider, SchemeExpressiveTests

### Community 23 - "Fruit Salad Scheme Variant"
Cohesion: 0.09
Nodes (2): SchemeFruitSalad(), SchemeFruitSaladTests

### Community 24 - "HCT Color Space Tests"
Cohesion: 0.06
Nodes (3): allColors(), colorIsOnBoundary(), HctTests

### Community 25 - "Android Legacy Scheme"
Cohesion: 0.07
Nodes (1): SchemeAndroid

### Community 26 - "Image-to-Theme Pipeline"
Cohesion: 0.1
Nodes (34): Album Artwork (Source Image), Color Palette Generation, Color Scheme Generation from Source Color, Color Swatch, Content-Based Color Extraction, Dominant Color, Dynamic Color Theme, HCT Chroma (C) (+26 more)

### Community 27 - "HCT Color Scheme Concepts"
Cohesion: 0.2
Nodes (21): Color Scheme, HCT Color Space, Light Theme, On Primary Container Color Role, On Primary Color Role, On Secondary Container Color Role, On Secondary Color Role, On Tertiary Container Color Role (+13 more)

### Community 28 - "HCT Solver Algorithm"
Cohesion: 0.21
Nodes (1): HctSolver

### Community 29 - "Fidelity & Accessibility Spec"
Cohesion: 0.14
Nodes (18): Chroma Reduction Warning (Accessibility Constraint), HCT Color Space (Hue, Chroma, Tone), Light Theme Vibrant Tonal (Proposed), Material Design Color System, On Primary Color Role (H 270, C 70, T 100), On Primary Container Color Role (H 270, C 70, T 10), On Secondary Color Role (H 285, C 24, T 100), On Secondary Container Color Role (H 285, C 24, T 10) (+10 more)

### Community 30 - "Color Tool Overview"
Cohesion: 0.25
Nodes (15): Blend, Chroma (Colorfulness), Color Scheme, Color Theming, Contrast, Shared Design Language, Material Color Theming Cheat Sheet, HCT Color Space (+7 more)

### Community 31 - "Scheme Variant Enum"
Cohesion: 0.15
Nodes (10): Variant(), content, expressive, fidelity, fruitSalad, monochrome, neutral, rainbow (+2 more)

### Community 32 - "Math Utilities"
Cohesion: 0.2
Nodes (9): clampDouble, clampInt, differenceDegrees, lerp, MathUtils, rotationDirection, sanitizeDegreesDouble, sanitizeDegreesInt (+1 more)

### Community 33 - "Legacy Scheme API (Dart)"
Cohesion: 0.22
Nodes (8): dark, darkContent, darkFromCorePalette, light, lightContent, lightFromCorePalette, Scheme, ../palettes/core_palette.dart

### Community 34 - "Quantizer Point Provider"
Cohesion: 0.29
Nodes (1): PointProvider

### Community 35 - "Wallpaper Color Extraction"
Cohesion: 0.53
Nodes (6): Color Palette, Device Wallpaper, Google Pixel Device, Material You Dynamic Theming, Derived Theme Color, Wallpaper-Based Color Extraction

### Community 36 - "Color Spec Registry"
Cohesion: 0.4
Nodes (1): ColorSpecs

### Community 37 - "Core Palettes Multi-lang"
Cohesion: 0.4
Nodes (1): CorePalettes

### Community 38 - "Quantizer Result Type"
Cohesion: 0.5
Nodes (1): QuantizerResult

### Community 39 - "Dart Point Provider"
Cohesion: 0.5
Nodes (3): distance, PointProvider, toInt

### Community 40 - "Color & String Utilities"
Cohesion: 0.5
Nodes (3): color_utils.dart, hexFromArgb, StringUtils

### Community 41 - "Dart Example Entry Point"
Cohesion: 0.67
Nodes (2): main, package:material_color_utilities/material_color_utilities.dart

### Community 42 - "Dart Quantizer API"
Cohesion: 0.67
Nodes (2): Quantizer, QuantizerResult

### Community 43 - "Swift Scheme Provider"
Cohesion: 0.67
Nodes (1): DynamicSchemeProvider

### Community 44 - "Dart Variant Enum"
Cohesion: 1.0
Nodes (1): Variant

### Community 70 - "Linear/sRGB Color Spaces"
Cohesion: 1.0
Nodes (2): Linear RGB Color Space, sRGB Color Space

### Community 77 - "Soft Constraint Concepts"
Cohesion: 1.0
Nodes (1): Soft Constraints (Scheme Generation)

## Knowledge Gaps
- **332 isolated node(s):** `Platform`, `SpecVersion`, `DeltaConstraint`, `main`, `package:material_color_utilities/palettes/core_palette.dart` (+327 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Java/TS Scheme API`** (137 nodes): `.from()`, `Scheme.java`, `CorePalette`, `.constructor()`, `.contentFromColors()`, `.contentOf()`, `.createPaletteFromColors()`, `.fromColors()`, `.of()`, `.of()`, `Scheme`, `.background()`, `.constructor()`, `.dark()`, `.darkContent()`, `.darkFromCorePalette()`, `.error()`, `.errorContainer()`, `.getBackground()`, `.getError()`, `.getErrorContainer()`, `.getInverseOnSurface()`, `.getInversePrimary()`, `.getInverseSurface()`, `.getOnBackground()`, `.getOnError()`, `.getOnErrorContainer()`, `.getOnPrimary()`, `.getOnPrimaryContainer()`, `.getOnSecondary()`, `.getOnSecondaryContainer()`, `.getOnSurface()`, `.getOnSurfaceVariant()`, `.getOnTertiary()`, `.getOnTertiaryContainer()`, `.getOutline()`, `.getOutlineVariant()`, `.getPrimary()`, `.getPrimaryContainer()`, `.getScrim()`, `.getSecondary()`, `.getSecondaryContainer()`, `.getShadow()`, `.getSurface()`, `.getSurfaceVariant()`, `.getTertiary()`, `.getTertiaryContainer()`, `.hashCode()`, `.inverseOnSurface()`, `.inversePrimary()`, `.inverseSurface()`, `.light()`, `.lightContent()`, `.lightFromCorePalette()`, `.onBackground()`, `.onError()`, `.onErrorContainer()`, `.onPrimary()`, `.onPrimaryContainer()`, `.onSecondary()`, `.onSecondaryContainer()`, `.onSurface()`, `.onSurfaceVariant()`, `.onTertiary()`, `.onTertiaryContainer()`, `.outline()`, `.outlineVariant()`, `.primary()`, `.primaryContainer()`, `.Scheme()`, `.scrim()`, `.secondary()`, `.secondaryContainer()`, `.setError()`, `.setErrorContainer()`, `.setInverseOnSurface()`, `.setInversePrimary()`, `.setInverseSurface()`, `.setOnBackground()`, `.setOnError()`, `.setOnErrorContainer()`, `.setOnPrimary()`, `.setOnPrimaryContainer()`, `.setOnSecondary()`, `.setOnSecondaryContainer()`, `.setOnSurface()`, `.setOnSurfaceVariant()`, `.setOnTertiary()`, `.setOnTertiaryContainer()`, `.setOutline()`, `.setOutlineVariant()`, `.setPrimary()`, `.setPrimaryContainer()`, `.setScrim()`, `.setSecondary()`, `.setSecondaryContainer()`, `.setShadow()`, `.setSurface()`, `.setSurfaceVariant()`, `.setTertiary()`, `.setTertiaryContainer()`, `.shadow()`, `.surface()`, `.surfaceVariant()`, `.tertiary()`, `.tertiaryContainer()`, `.toJSON()`, `.toString()`, `.withBackground()`, `.withError()`, `.withErrorContainer()`, `.withInverseOnSurface()`, `.withInversePrimary()`, `.withInverseSurface()`, `.withOnBackground()`, `.withOnError()`, `.withOnErrorContainer()`, `.withOnPrimary()`, `.withOnPrimaryContainer()`, `.withOnSecondary()`, `.withOnSecondaryContainer()`, `.withOnSurface()`, `.withOnSurfaceVariant()`, `.withOnTertiary()`, `.withOnTertiaryContainer()`, `.withOutline()`, `.withOutlineVariant()`, `.withPrimary()`, `.withPrimaryContainer()`, `.withScrim()`, `.withSecondary()`, `.withSecondaryContainer()`, `.withShadow()`, `.withSurface()`, `.withSurfaceVariant()`, `.withTertiary()`, `.withTertiaryContainer()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Java Color Spec Tokens`** (80 nodes): `ColorSpec`, `.background()`, `.controlActivated()`, `.controlHighlight()`, `.controlNormal()`, `.error()`, `.errorContainer()`, `.errorDim()`, `.errorPaletteKeyColor()`, `.getErrorPalette()`, `.getHct()`, `.getNeutralPalette()`, `.getNeutralVariantPalette()`, `.getPrimaryPalette()`, `.getSecondaryPalette()`, `.getTertiaryPalette()`, `.getTone()`, `.highestSurface()`, `.inverseOnSurface()`, `.inversePrimary()`, `.inverseSurface()`, `.neutralPaletteKeyColor()`, `.neutralVariantPaletteKeyColor()`, `.onBackground()`, `.onError()`, `.onErrorContainer()`, `.onPrimary()`, `.onPrimaryContainer()`, `.onPrimaryFixed()`, `.onPrimaryFixedVariant()`, `.onSecondary()`, `.onSecondaryContainer()`, `.onSecondaryFixed()`, `.onSecondaryFixedVariant()`, `.onSurface()`, `.onSurfaceVariant()`, `.onTertiary()`, `.onTertiaryContainer()`, `.onTertiaryFixed()`, `.onTertiaryFixedVariant()`, `.outline()`, `.outlineVariant()`, `.primary()`, `.primaryContainer()`, `.primaryDim()`, `.primaryFixed()`, `.primaryFixedDim()`, `.primaryPaletteKeyColor()`, `.scrim()`, `.secondary()`, `.secondaryContainer()`, `.secondaryDim()`, `.secondaryFixed()`, `.secondaryFixedDim()`, `.secondaryPaletteKeyColor()`, `.shadow()`, `.surface()`, `.surfaceBright()`, `.surfaceContainer()`, `.surfaceContainerHigh()`, `.surfaceContainerHighest()`, `.surfaceContainerLow()`, `.surfaceContainerLowest()`, `.surfaceDim()`, `.surfaceTint()`, `.surfaceVariant()`, `.tertiary()`, `.tertiaryContainer()`, `.tertiaryDim()`, `.tertiaryFixed()`, `.tertiaryFixedDim()`, `.tertiaryPaletteKeyColor()`, `.textHintInverse()`, `.textPrimaryInverse()`, `.textPrimaryInverseDisableOnly()`, `.textSecondaryAndTertiaryInverse()`, `.textSecondaryAndTertiaryInverseDisabled()`, `SpecVersion`, `ColorSpec.java`, `ColorSpec.kt`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Material Dynamic Colors API`** (76 nodes): `_isFidelity()`, `_isMonochrome()`, `MaterialDynamicColors`, `.allDynamicColors()`, `.background()`, `.controlActivated()`, `.controlHighlight()`, `.controlNormal()`, `.error()`, `.errorContainer()`, `.errorDim()`, `.errorPaletteKeyColor()`, `._findDesiredChromaByTone()`, `.highestSurface()`, `.inverseOnSurface()`, `.inversePrimary()`, `.inverseSurface()`, `.neutralPaletteKeyColor()`, `.neutralVariantPaletteKeyColor()`, `.onBackground()`, `.onError()`, `.onErrorContainer()`, `.onPrimary()`, `.onPrimaryContainer()`, `.onPrimaryFixed()`, `.onPrimaryFixedVariant()`, `.onSecondary()`, `.onSecondaryContainer()`, `.onSecondaryFixed()`, `.onSecondaryFixedVariant()`, `.onSurface()`, `.onSurfaceVariant()`, `.onTertiary()`, `.onTertiaryContainer()`, `.onTertiaryFixed()`, `.onTertiaryFixedVariant()`, `.outline()`, `.outlineVariant()`, `.primary()`, `.primaryContainer()`, `.primaryDim()`, `.primaryFixed()`, `.primaryFixedDim()`, `.primaryPaletteKeyColor()`, `.scrim()`, `.secondary()`, `.secondaryContainer()`, `.secondaryDim()`, `.secondaryFixed()`, `.secondaryFixedDim()`, `.secondaryPaletteKeyColor()`, `.shadow()`, `.surface()`, `.surfaceBright()`, `.surfaceContainer()`, `.surfaceContainerHigh()`, `.surfaceContainerHighest()`, `.surfaceContainerLow()`, `.surfaceContainerLowest()`, `.surfaceDim()`, `.surfaceTint()`, `.surfaceVariant()`, `.tertiary()`, `.tertiaryContainer()`, `.tertiaryDim()`, `.tertiaryFixed()`, `.tertiaryFixedDim()`, `.tertiaryPaletteKeyColor()`, `.textHintInverse()`, `.textPrimaryInverse()`, `.textPrimaryInverseDisableOnly()`, `.textSecondaryAndTertiaryInverse()`, `.textSecondaryAndTertiaryInverseDisabled()`, `MaterialDynamicColors.java`, `MaterialDynamicColors.kt`, `MaterialDynamicColors.swift`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `C++ Dynamic Scheme Tokens`** (63 nodes): `DynamicScheme()`, `.background()`, `.error()`, `.errorContainer()`, `.errorDim()`, `.errorPaletteKeyColor()`, `.getArgb()`, `.getHct()`, `.inverseOnSurface()`, `.inversePrimary()`, `.inverseSurface()`, `.neutralPaletteKeyColor()`, `.neutralVariantPaletteKeyColor()`, `.onBackground()`, `.onError()`, `.onErrorContainer()`, `.onPrimary()`, `.onPrimaryContainer()`, `.onPrimaryFixed()`, `.onPrimaryFixedVariant()`, `.onSecondary()`, `.onSecondaryContainer()`, `.onSecondaryFixed()`, `.onSecondaryFixedVariant()`, `.onSurface()`, `.onSurfaceVariant()`, `.onTertiary()`, `.onTertiaryContainer()`, `.onTertiaryFixed()`, `.onTertiaryFixedVariant()`, `.outline()`, `.outlineVariant()`, `.primary()`, `.primaryContainer()`, `.primaryDim()`, `.primaryFixed()`, `.primaryFixedDim()`, `.primaryPaletteKeyColor()`, `.scrim()`, `.secondary()`, `.secondaryContainer()`, `.secondaryDim()`, `.secondaryFixed()`, `.secondaryFixedDim()`, `.secondaryPaletteKeyColor()`, `.shadow()`, `.surface()`, `.surfaceBright()`, `.surfaceContainer()`, `.surfaceContainerHigh()`, `.surfaceContainerHighest()`, `.surfaceContainerLow()`, `.surfaceContainerLowest()`, `.surfaceDim()`, `.surfaceTint()`, `.surfaceVariant()`, `.tertiary()`, `.tertiaryContainer()`, `.tertiaryDim()`, `.tertiaryFixed()`, `.tertiaryFixedDim()`, `.tertiaryPaletteKeyColor()`, `.toString()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Legacy ColorSpec 2021`** (61 nodes): `ColorSpecDelegateImpl2021`, `.background()`, `.error()`, `.errorContainer()`, `.errorDim()`, `.errorPaletteKeyColor()`, `.highestSurface()`, `.inverseOnSurface()`, `.inversePrimary()`, `.inverseSurface()`, `.neutralPaletteKeyColor()`, `.neutralVariantPaletteKeyColor()`, `.onBackground()`, `.onError()`, `.onErrorContainer()`, `.onPrimary()`, `.onPrimaryContainer()`, `.onPrimaryFixed()`, `.onPrimaryFixedVariant()`, `.onSecondary()`, `.onSecondaryContainer()`, `.onSecondaryFixed()`, `.onSecondaryFixedVariant()`, `.onSurface()`, `.onSurfaceVariant()`, `.onTertiary()`, `.onTertiaryContainer()`, `.onTertiaryFixed()`, `.onTertiaryFixedVariant()`, `.outline()`, `.outlineVariant()`, `.primary()`, `.primaryContainer()`, `.primaryDim()`, `.primaryFixed()`, `.primaryFixedDim()`, `.primaryPaletteKeyColor()`, `.scrim()`, `.secondary()`, `.secondaryContainer()`, `.secondaryDim()`, `.secondaryFixed()`, `.secondaryFixedDim()`, `.secondaryPaletteKeyColor()`, `.shadow()`, `.surface()`, `.surfaceBright()`, `.surfaceContainer()`, `.surfaceContainerHigh()`, `.surfaceContainerHighest()`, `.surfaceContainerLow()`, `.surfaceContainerLowest()`, `.surfaceDim()`, `.surfaceTint()`, `.surfaceVariant()`, `.tertiary()`, `.tertiaryContainer()`, `.tertiaryDim()`, `.tertiaryFixed()`, `.tertiaryFixedDim()`, `.tertiaryPaletteKeyColor()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `TS Material Dynamic Colors`** (61 nodes): `MaterialDynamicColors`, `.background()`, `.error()`, `.errorContainer()`, `.errorDim()`, `.errorPaletteKeyColor()`, `.highestSurface()`, `.inverseOnSurface()`, `.inversePrimary()`, `.inverseSurface()`, `.neutralPaletteKeyColor()`, `.neutralVariantPaletteKeyColor()`, `.onBackground()`, `.onError()`, `.onErrorContainer()`, `.onPrimary()`, `.onPrimaryContainer()`, `.onPrimaryFixed()`, `.onPrimaryFixedVariant()`, `.onSecondary()`, `.onSecondaryContainer()`, `.onSecondaryFixed()`, `.onSecondaryFixedVariant()`, `.onSurface()`, `.onSurfaceVariant()`, `.onTertiary()`, `.onTertiaryContainer()`, `.onTertiaryFixed()`, `.onTertiaryFixedVariant()`, `.outline()`, `.outlineVariant()`, `.primary()`, `.primaryContainer()`, `.primaryDim()`, `.primaryFixed()`, `.primaryFixedDim()`, `.primaryPaletteKeyColor()`, `.scrim()`, `.secondary()`, `.secondaryContainer()`, `.secondaryDim()`, `.secondaryFixed()`, `.secondaryFixedDim()`, `.secondaryPaletteKeyColor()`, `.shadow()`, `.surface()`, `.surfaceBright()`, `.surfaceContainer()`, `.surfaceContainerHigh()`, `.surfaceContainerHighest()`, `.surfaceContainerLow()`, `.surfaceContainerLowest()`, `.surfaceDim()`, `.surfaceTint()`, `.surfaceVariant()`, `.tertiary()`, `.tertiaryContainer()`, `.tertiaryDim()`, `.tertiaryFixed()`, `.tertiaryFixedDim()`, `.tertiaryPaletteKeyColor()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Fruit Salad Scheme Variant`** (40 nodes): `scheme_fruit_salad.cc`, `SchemeFruitSalad()`, `.constructor()`, `SchemeFruitSaladTests`, `.testDarkTheme_maxContrast_onPrimaryContainer()`, `.testDarkTheme_maxContrast_onTertiaryContainer()`, `.testDarkTheme_maxContrast_primary()`, `.testDarkTheme_maxContrast_primaryContainer()`, `.testDarkTheme_maxContrast_surface()`, `.testDarkTheme_minContrast_onPrimaryContainer()`, `.testDarkTheme_minContrast_onTertiaryContainer()`, `.testDarkTheme_minContrast_primary()`, `.testDarkTheme_minContrast_primaryContainer()`, `.testDarkTheme_minContrast_surface()`, `.testDarkTheme_standardContrast_onPrimaryContainer()`, `.testDarkTheme_standardContrast_onTertiaryContainer()`, `.testDarkTheme_standardContrast_primary()`, `.testDarkTheme_standardContrast_primaryContainer()`, `.testDarkTheme_standardContrast_secondary()`, `.testDarkTheme_standardContrast_secondaryContainer()`, `.testDarkTheme_standardContrast_surface()`, `.testKeyColors()`, `.testLightTheme_maxContrast_onPrimaryContainer()`, `.testLightTheme_maxContrast_primary()`, `.testLightTheme_maxContrast_primaryContainer()`, `.testLightTheme_maxContrast_surface()`, `.testLightTheme_maxContrast_tertiaryContainer()`, `.testLightTheme_minContrast_onPrimaryContainer()`, `.testLightTheme_minContrast_primary()`, `.testLightTheme_minContrast_primaryContainer()`, `.testLightTheme_minContrast_surface()`, `.testLightTheme_minContrast_tertiaryContainer()`, `.testLightTheme_standardContrast_onPrimaryContainer()`, `.testLightTheme_standardContrast_primary()`, `.testLightTheme_standardContrast_primaryContainer()`, `.testLightTheme_standardContrast_secondary()`, `.testLightTheme_standardContrast_secondaryContainer()`, `.testLightTheme_standardContrast_surface()`, `.testLightTheme_standardContrast_tertiaryContainer()`, `SchemeFruitSaladTests.swift`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Android Legacy Scheme`** (34 nodes): `SchemeAndroid`, `.accentSurface()`, `.colorAccentPrimary()`, `.colorAccentPrimaryVariant()`, `.colorAccentSecondary()`, `.colorAccentSecondaryVariant()`, `.colorAccentTertiary()`, `.colorAccentTertiaryVariant()`, `.colorBackground()`, `.colorBackgroundFloating()`, `.colorSurface()`, `.colorSurfaceHighlight()`, `.colorSurfaceVariant()`, `.constructor()`, `.dark()`, `.darkContent()`, `.darkFromCorePalette()`, `.light()`, `.lightContent()`, `.lightFromCorePalette()`, `.offState()`, `.scrim()`, `.surfaceHeader()`, `.textColorPrimary()`, `.textColorPrimaryInverse()`, `.textColorSecondary()`, `.textColorSecondaryInverse()`, `.textColorTertiary()`, `.textColorTertiaryInverse()`, `.textPrimaryOnAccent()`, `.textSecondaryOnAccent()`, `.toJSON()`, `.underSurface()`, `.volumeBackground()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `HCT Solver Algorithm`** (20 nodes): `HctSolver`, `.areInCyclicOrder()`, `.bisectToLimit()`, `.bisectToSegment()`, `.chromaticAdaptation()`, `.criticalPlaneAbove()`, `.criticalPlaneBelow()`, `.findResultByJ()`, `.hueOf()`, `.intercept()`, `.inverseChromaticAdaptation()`, `.isBounded()`, `.lerpPoint()`, `.midpoint()`, `.nthVertex()`, `.sanitizeRadians()`, `.setCoordinate()`, `.solveToCam()`, `.solveToInt()`, `.trueDelinearized()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Quantizer Point Provider`** (7 nodes): `PointProvider.java`, `PointProvider.kt`, `PointProvider`, `.distance()`, `.fromInt()`, `.toInt()`, `PointProvider.swift`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Color Spec Registry`** (5 nodes): `ColorSpecs`, `.ColorSpecs()`, `.get()`, `ColorSpecs.java`, `ColorSpecs.kt`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Core Palettes Multi-lang`** (5 nodes): `CorePalettes.java`, `CorePalettes.kt`, `CorePalettes`, `.CorePalettes()`, `CorePalettes.swift`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Quantizer Result Type`** (4 nodes): `QuantizerResult.java`, `QuantizerResult.kt`, `QuantizerResult`, `.QuantizerResult()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Dart Example Entry Point`** (3 nodes): `main.dart`, `main`, `package:material_color_utilities/material_color_utilities.dart`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Dart Quantizer API`** (3 nodes): `quantizer.dart`, `Quantizer`, `QuantizerResult`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Swift Scheme Provider`** (3 nodes): `DynamicSchemeProvider`, `.init()`, `DynamicSchemeProvider.swift`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Dart Variant Enum`** (2 nodes): `variant.dart`, `Variant`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Linear/sRGB Color Spaces`** (2 nodes): `Linear RGB Color Space`, `sRGB Color Space`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Soft Constraint Concepts`** (1 nodes): `Soft Constraints (Scheme Generation)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Hct()` connect `C++ Core Color Engine` to `CAM16 & Blend Operations`, `Dynamic Color & Contrast Curves`, `Scheme & Palette System`, `Swift Test Suite`, `Temperature & Hue Rotation`, `Tone Contrast Utilities`, `Expressive Scheme Variant`?**
  _High betweenness centrality (0.118) - this node is a cross-community bridge._
- **Why does `extendSpecVersion()` connect `Dynamic Scheme & ColorSpec System` to `Testing & Dislike Filter`, `Dynamic Color & Contrast Curves`?**
  _High betweenness centrality (0.074) - this node is a cross-community bridge._
- **Why does `Scheme` connect `Java/TS Scheme API` to `Dynamic Scheme & ColorSpec System`, `Tone Contrast Utilities`, `Testing & Dislike Filter`?**
  _High betweenness centrality (0.067) - this node is a cross-community bridge._
- **Are the 189 inferred relationships involving `extendSpecVersion()` (e.g. with `.background()` and `.onBackground()`) actually correct?**
  _`extendSpecVersion()` has 189 INFERRED edges - model-reasoned connections that need verification._
- **Are the 190 inferred relationships involving `Hct()` (e.g. with `.testSchemeFruitSaladProvider_returnsIdeniticalSchemeWithSameSourceColor()` and `.testSchemeFruitSaladProvider_reusesTonalPalettes()`) actually correct?**
  _`Hct()` has 190 INFERRED edges - model-reasoned connections that need verification._
- **What connects `Platform`, `SpecVersion`, `DeltaConstraint` to the rest of the system?**
  _332 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Dynamic Scheme & ColorSpec System` be split into smaller, more focused modules?**
  _Cohesion score 0.04 - nodes in this community are weakly interconnected._