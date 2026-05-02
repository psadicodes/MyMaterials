import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/scheme_notifier.dart';

class ColorInputWidget extends ConsumerStatefulWidget {
  const ColorInputWidget({super.key});

  @override
  ConsumerState<ColorInputWidget> createState() => _ColorInputWidgetState();
}

class _ColorInputWidgetState extends ConsumerState<ColorInputWidget> {
  late TextEditingController _hexCtrl;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    final argb = ref.read(schemeProvider).sourceArgb;
    _hexCtrl = TextEditingController(text: _toHex(argb));
  }

  @override
  void dispose() {
    _hexCtrl.dispose();
    super.dispose();
  }

  String _toHex(int argb) =>
      '#${(argb & 0xFFFFFF).toRadixString(16).toUpperCase().padLeft(6, '0')}';

  int? _fromHex(String s) {
    final clean = s.replaceAll('#', '').trim();
    if (clean.length != 6) return null;
    final val = int.tryParse(clean, radix: 16);
    return val == null ? null : (0xFF000000 | val);
  }

  void _openPicker(BuildContext context, int currentArgb) {
    Color pickerColor = Color(currentArgb);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Pick a source color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: (c) => pickerColor = c,
            enableAlpha: false,
            pickerAreaHeightPercent: 0.7,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final argb = ((pickerColor.a * 255).round() << 24 |
                      (pickerColor.r * 255).round() << 16 |
                      (pickerColor.g * 255).round() << 8 |
                      (pickerColor.b * 255).round()) |
                  0xFF000000;
              ref.read(schemeProvider.notifier).setSourceColor(argb);
              setState(() => _hexCtrl.text = _toHex(argb));
              Navigator.pop(context);
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final argb = ref.watch(schemeProvider).sourceArgb;
    final color = Color(argb);

    if (!_editing) {
      _hexCtrl.text = _toHex(argb);
    }

    return Row(
      children: [
        GestureDetector(
          onTap: () => _openPicker(context, argb),
          child: Tooltip(
            message: 'Open color picker',
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Theme.of(context).colorScheme.outline),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: _hexCtrl,
            decoration: const InputDecoration(
              labelText: 'Hex color',
              prefixText: '#',
              border: OutlineInputBorder(),
              isDense: true,
            ),
            onTap: () => setState(() => _editing = true),
            onSubmitted: (v) {
              setState(() => _editing = false);
              final parsed = _fromHex(v);
              if (parsed != null) {
                ref.read(schemeProvider.notifier).setSourceColor(parsed);
              } else {
                _hexCtrl.text = _toHex(argb);
              }
            },
            onChanged: (v) {
              final parsed = _fromHex(v);
              if (parsed != null) {
                ref.read(schemeProvider.notifier).setSourceColor(parsed);
              }
            },
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          tooltip: 'Open color picker',
          icon: const Icon(Icons.colorize),
          onPressed: () => _openPicker(context, argb),
        ),
      ],
    );
  }
}
