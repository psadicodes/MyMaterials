import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/scheme_config.dart';
import '../../providers/scheme_notifier.dart';

// Popular Google Fonts — user can type to filter this list
const _kGoogleFonts = [
  'Roboto', 'Roboto Condensed', 'Roboto Flex', 'Open Sans', 'Lato',
  'Montserrat', 'Source Sans Pro', 'Raleway', 'Ubuntu', 'Nunito',
  'Nunito Sans', 'Inter', 'Poppins', 'DM Sans', 'DM Serif Display',
  'Playfair Display', 'Merriweather', 'PT Sans', 'PT Serif',
  'Noto Sans', 'Noto Serif', 'Work Sans', 'Quicksand', 'Josefin Sans',
  'Fira Sans', 'Fira Code', 'IBM Plex Sans', 'IBM Plex Serif',
  'Space Grotesk', 'Space Mono', 'Sora', 'Outfit', 'Be Vietnam Pro',
  'Rubik', 'Mulish', 'Cabin', 'Karla', 'Jost', 'Lexend', 'Plus Jakarta Sans',
  'Manrope', 'Barlow', 'Exo 2', 'Titillium Web', 'Arimo', 'Asap',
  'Source Code Pro', 'Inconsolata', 'JetBrains Mono', 'Overpass',
];

class FontSelector extends ConsumerStatefulWidget {
  const FontSelector({super.key});

  @override
  ConsumerState<FontSelector> createState() => _FontSelectorState();
}

class _FontSelectorState extends ConsumerState<FontSelector> {
  @override
  Widget build(BuildContext context) {
    final fontConfig = ref.watch(schemeProvider).fontConfig;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Display / Headline font', style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 4),
        _FontPicker(
          current: fontConfig.displayFont,
          onChanged: (fc) => ref
              .read(schemeProvider.notifier)
              .setFontConfig(fontConfig.copyWith(displayFont: fc)),
        ),
        const SizedBox(height: 12),
        Text('Body / Label font', style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 4),
        _FontPicker(
          current: fontConfig.bodyFont,
          onChanged: (fc) => ref
              .read(schemeProvider.notifier)
              .setFontConfig(fontConfig.copyWith(bodyFont: fc)),
        ),
      ],
    );
  }
}

class _FontPicker extends StatefulWidget {
  final FontChoice current;
  final ValueChanged<FontChoice> onChanged;

  const _FontPicker({required this.current, required this.onChanged});

  @override
  State<_FontPicker> createState() => _FontPickerState();
}

class _FontPickerState extends State<_FontPicker> {
  late TextEditingController _ctrl;
  List<String> _filtered = _kGoogleFonts.take(8).toList();
  bool _isGoogle = true;

  @override
  void initState() {
    super.initState();
    _isGoogle = widget.current.isGoogleFont;
    _ctrl = TextEditingController(text: widget.current.name);
    _filter(widget.current.name);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _filter(String q) {
    final lower = q.toLowerCase();
    setState(() {
      _filtered = _kGoogleFonts
          .where((f) => f.toLowerCase().contains(lower))
          .take(8)
          .toList();
    });
  }

  Future<void> _pickLocal() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['ttf', 'otf'],
      withData: false,
    );
    if (result == null || result.files.isEmpty) return;
    final file = result.files.first;
    final name = file.name.replaceAll(RegExp(r'\.(ttf|otf)$', caseSensitive: false), '');
    widget.onChanged(FontChoice.local(name, name));
    setState(() {
      _isGoogle = false;
      _ctrl.text = name;
    });
  }

  TextStyle? _previewStyle(String fontName) {
    try {
      return GoogleFonts.getFont(fontName);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _ctrl,
                decoration: InputDecoration(
                  hintText: _isGoogle ? 'Search Google Fonts…' : 'Font name',
                  border: const OutlineInputBorder(),
                  isDense: true,
                  suffixIcon: _isGoogle ? const Icon(Icons.search) : const Icon(Icons.font_download),
                ),
                onChanged: (v) {
                  if (_isGoogle) _filter(v);
                },
                onSubmitted: (v) {
                  if (_isGoogle) {
                    widget.onChanged(FontChoice.google(v));
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Tooltip(
              message: 'Use local font file (res/font/)',
              child: OutlinedButton.icon(
                icon: const Icon(Icons.upload_file, size: 16),
                label: const Text('Local'),
                onPressed: _pickLocal,
              ),
            ),
          ],
        ),
        if (_isGoogle && _filtered.isNotEmpty) ...[
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: cs.outlineVariant),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: _filtered.map((fontName) {
                final preview = _previewStyle(fontName);
                return ListTile(
                  dense: true,
                  title: Text(fontName, style: preview),
                  onTap: () {
                    widget.onChanged(FontChoice.google(fontName));
                    setState(() {
                      _ctrl.text = fontName;
                      _filtered = [];
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ],
        if (!_isGoogle && _ctrl.text.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            'File will be placed in res/font/${_ctrl.text.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_')}.ttf',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
          ),
        ],
      ],
    );
  }
}
