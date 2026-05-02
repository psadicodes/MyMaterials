import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/color_token.dart';
import '../../providers/scheme_notifier.dart';
import '../widgets/token_chip.dart';
import '../widgets/tonal_strip.dart';

class TokensPanel extends ConsumerWidget {
  const TokensPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(schemeResultProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TokenGroup(title: 'Primary', tokens: result.tokens.where((t) => t.name.toLowerCase().contains('primary')).toList()),
          const SizedBox(height: 12),
          _TokenGroup(title: 'Secondary', tokens: result.tokens.where((t) => t.name.toLowerCase().contains('secondary')).toList()),
          const SizedBox(height: 12),
          _TokenGroup(title: 'Tertiary', tokens: result.tokens.where((t) => t.name.toLowerCase().contains('tertiary')).toList()),
          const SizedBox(height: 12),
          _TokenGroup(title: 'Error', tokens: result.tokens.where((t) => t.name.toLowerCase().contains('error')).toList()),
          const SizedBox(height: 12),
          _TokenGroup(
            title: 'Surface & Background',
            tokens: result.tokens.where((t) {
              final n = t.name.toLowerCase();
              return n.contains('surface') || n.contains('background') || n.contains('scrim');
            }).toList(),
          ),
          const SizedBox(height: 12),
          _TokenGroup(
            title: 'Outline & Inverse',
            tokens: result.tokens.where((t) {
              final n = t.name.toLowerCase();
              return n.contains('outline') || n.contains('inverse');
            }).toList(),
          ),
          const SizedBox(height: 24),
          Text('Tonal Palettes', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          ...result.palettes.map((strip) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TonalStrip(strip: strip),
              )),
        ],
      ),
    );
  }
}

class _TokenGroup extends StatelessWidget {
  final String title;
  final List<ColorToken> tokens;

  const _TokenGroup({required this.title, required this.tokens});

  @override
  Widget build(BuildContext context) {
    if (tokens.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 6),
        LayoutBuilder(
          builder: (context, constraints) {
            const chipWidth = 100.0;
            final crossCount = (constraints.maxWidth / (chipWidth + 8)).floor().clamp(2, 8);
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossCount,
                childAspectRatio: 1.5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: tokens.length,
              itemBuilder: (_, i) => TokenChip(token: tokens[i]),
            );
          },
        ),
      ],
    );
  }
}
