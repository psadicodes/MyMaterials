import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import '../../providers/scheme_notifier.dart';

class VariantGrid extends ConsumerWidget {
  const VariantGrid({super.key});

  static const _variants = [
    (Variant.tonalSpot,   'Tonal Spot',   'Default Material You — pastel, low chroma'),
    (Variant.expressive,  'Expressive',   'Detached hue — playful variety'),
    (Variant.vibrant,     'Vibrant',      'Maximum chroma primary palette'),
    (Variant.monochrome,  'Monochrome',   'Fully grayscale, no chroma'),
    (Variant.neutral,     'Neutral',      'Near-gray, hint of chroma'),
    (Variant.content,     'Content',      'Source color fidelity + analogue tertiary'),
    (Variant.fidelity,    'Fidelity',     'Tokens match source, complement tertiary'),
    (Variant.rainbow,     'Rainbow',      'Playful — source hue absent from theme'),
    (Variant.fruitSalad,  'Fruit Salad',  'Playful — rotated hues throughout'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(schemeProvider).variant;
    final cs = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _variants.map(((Variant, String, String) entry) {
        final (v, label, desc) = entry;
        final selected = v == current;
        return Tooltip(
          message: desc,
          child: ChoiceChip(
            label: Text(label),
            selected: selected,
            selectedColor: cs.primaryContainer,
            labelStyle: TextStyle(
              color: selected ? cs.onPrimaryContainer : cs.onSurface,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            ),
            onSelected: (_) => ref.read(schemeProvider.notifier).setVariant(v),
          ),
        );
      }).toList(),
    );
  }
}
