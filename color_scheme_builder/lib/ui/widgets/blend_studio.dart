import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/scheme_notifier.dart';

class BlendStudio extends ConsumerStatefulWidget {
  const BlendStudio({super.key});

  @override
  ConsumerState<BlendStudio> createState() => _BlendStudioState();
}

class _BlendStudioState extends ConsumerState<BlendStudio> {
  final _hexCtrl = TextEditingController();

  @override
  void dispose() {
    _hexCtrl.dispose();
    super.dispose();
  }

  int? _fromHex(String s) {
    final clean = s.replaceAll('#', '').trim();
    if (clean.length != 6) return null;
    final v = int.tryParse(clean, radix: 16);
    return v == null ? null : (0xFF000000 | v);
  }

  void _addColor(int argb) {
    ref.read(schemeProvider.notifier).addBlendColor(argb);
    _hexCtrl.clear();
  }

  void _openPicker() {
    Color picked = Colors.blue;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Pick a color to harmonize'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: picked,
            onColorChanged: (c) => picked = c,
            enableAlpha: false,
            pickerAreaHeightPercent: 0.7,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              final argb = (picked.a * 255).round() << 24 |
                  (picked.r * 255).round() << 16 |
                  (picked.g * 255).round() << 8 |
                  (picked.b * 255).round();
              _addColor(argb | 0xFF000000);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final harmonized = ref.watch(harmonizedColorsProvider);
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Blend Studio',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 4),
          Text(
            'Add custom colors to harmonize with the source color using Blend.harmonize.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _hexCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Hex color e.g. #E91E63',
                    border: OutlineInputBorder(),
                    isDense: true,
                    prefixText: '#',
                  ),
                  onSubmitted: (v) {
                    final parsed = _fromHex(v);
                    if (parsed != null) _addColor(parsed);
                  },
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                tooltip: 'Open color picker',
                icon: const Icon(Icons.colorize),
                onPressed: _openPicker,
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Add'),
                onPressed: () {
                  final parsed = _fromHex(_hexCtrl.text);
                  if (parsed != null) _addColor(parsed);
                },
              ),
            ],
          ),
          if (harmonized.isNotEmpty) ...[
            const SizedBox(height: 20),
            ...harmonized.map((hc) => _HarmonizedRow(
                  original: hc.original,
                  harmonized: hc.harmonized,
                  onRemove: () =>
                      ref.read(schemeProvider.notifier).removeBlendColor(hc.original),
                )),
          ],
          if (harmonized.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Center(
                child: Text(
                  'No colors added yet.\nAdd a color above to see how it harmonizes with your source.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: cs.onSurfaceVariant),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _HarmonizedRow extends StatelessWidget {
  final int original;
  final int harmonized;
  final VoidCallback onRemove;

  const _HarmonizedRow({
    required this.original,
    required this.harmonized,
    required this.onRemove,
  });

  String _hex(int argb) =>
      '#${(argb & 0xFFFFFF).toRadixString(16).toUpperCase().padLeft(6, '0')}';

  void _copy(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied $text'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        width: 200,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          _Swatch(
            argb: original,
            label: 'Original',
            hex: _hex(original),
            onCopy: () => _copy(context, _hex(original)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.arrow_forward, color: cs.onSurfaceVariant, size: 18),
          ),
          _Swatch(
            argb: harmonized,
            label: 'Harmonized',
            hex: _hex(harmonized),
            onCopy: () => _copy(context, _hex(harmonized)),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            tooltip: 'Remove',
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  final int argb;
  final String label;
  final String hex;
  final VoidCallback onCopy;

  const _Swatch({
    required this.argb,
    required this.label,
    required this.hex,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    final luminance = Color(argb).computeLuminance();
    final textColor = luminance > 0.35 ? Colors.black87 : Colors.white;

    return Tooltip(
      message: 'Tap to copy',
      child: InkWell(
        onTap: onCopy,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 80,
          height: 56,
          decoration: BoxDecoration(
            color: Color(argb),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(fontSize: 9, color: textColor, fontWeight: FontWeight.w600)),
              Text(hex, style: TextStyle(fontSize: 9, color: textColor.withValues(alpha: 0.8))),
            ],
          ),
        ),
      ),
    );
  }
}
