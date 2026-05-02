import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/scheme_notifier.dart';
import '../../services/image_service.dart';

class ImagePickerWidget extends ConsumerStatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  ConsumerState<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends ConsumerState<ImagePickerWidget> {
  bool _loading = false;
  List<int> _suggestions = [];
  Uint8List? _thumbBytes;

  Future<void> _pick() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;
    final bytes = result.files.first.bytes;
    if (bytes == null) return;

    setState(() {
      _loading = true;
      _thumbBytes = bytes;
      _suggestions = [];
    });

    final colors = await ImageService.extractSourceColors(bytes);
    setState(() {
      _loading = false;
      _suggestions = colors;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final currentArgb = ref.watch(schemeProvider).sourceArgb;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedButton.icon(
          onPressed: _loading ? null : _pick,
          icon: _loading
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.image_outlined),
          label: const Text('Extract from image'),
        ),
        if (_thumbBytes != null) ...[
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.memory(_thumbBytes!, height: 80, fit: BoxFit.cover),
          ),
        ],
        if (_suggestions.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text('Suggested source colors:', style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 4),
          Wrap(
            spacing: 6,
            children: _suggestions.map((argb) {
              final selected = argb == currentArgb;
              return GestureDetector(
                onTap: () => ref.read(schemeProvider.notifier).setSourceColor(argb),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Color(argb),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected ? cs.primary : cs.outline,
                      width: selected ? 3 : 1,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
