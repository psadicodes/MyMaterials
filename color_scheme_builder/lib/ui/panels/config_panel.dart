import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/scheme_notifier.dart';
import '../widgets/color_input.dart';
import '../widgets/image_picker_widget.dart';
import '../widgets/variant_grid.dart';
import '../widgets/font_selector.dart';

class ConfigPanel extends ConsumerWidget {
  const ConfigPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(schemeProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(
            title: 'Source Color',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ColorInputWidget(),
                const SizedBox(height: 12),
                const ImagePickerWidget(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _Section(
            title: 'Scheme Variant',
            child: const VariantGrid(),
          ),
          const SizedBox(height: 20),
          _Section(
            title: 'Mode',
            child: Row(
              children: [
                const Text('Light'),
                const SizedBox(width: 12),
                Switch(
                  value: config.isDark,
                  onChanged: (v) =>
                      ref.read(schemeProvider.notifier).setDark(v),
                ),
                const SizedBox(width: 12),
                const Text('Dark'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _Section(
            title: 'Contrast  ${config.contrast.toStringAsFixed(2)}',
            child: Slider(
              min: -1.0,
              max: 1.0,
              divisions: 20,
              value: config.contrast,
              label: config.contrast.toStringAsFixed(2),
              onChanged: (v) =>
                  ref.read(schemeProvider.notifier).setContrast(v),
            ),
          ),
          const SizedBox(height: 20),
          _Section(
            title: 'Typography',
            child: const FontSelector(),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
