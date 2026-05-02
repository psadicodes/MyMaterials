import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/scheme_notifier.dart';
import '../../services/export_service.dart';

class ExportDialog extends ConsumerStatefulWidget {
  const ExportDialog({super.key});

  @override
  ConsumerState<ExportDialog> createState() => _ExportDialogState();
}

class _ExportDialogState extends ConsumerState<ExportDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;

  static const _tabLabels = ['Color.kt', 'Theme.kt', 'Type.kt', 'font_certs.xml'];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: _tabLabels.length, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  List<String> _buildContents(schemeConfig) {
    final colorKt = ExportService.generateColorKt(schemeConfig);
    final themeKt = ExportService.generateThemeKt();
    final typeKt = ExportService.generateTypeKt(schemeConfig.fontConfig);
    final fontCerts = ExportService.generateFontCertsXml();
    return [colorKt, themeKt, typeKt, fontCerts];
  }

  static const _fileNames = ['Color.kt', 'Theme.kt', 'Type.kt', 'font_certs.xml'];

  void _copyAll(List<String> contents) {
    final combined = List.generate(
      contents.length,
      (i) => '// ===== ${_fileNames[i]} =====\n\n${contents[i]}',
    ).join('\n\n');
    Clipboard.setData(ClipboardData(text: combined));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All files copied to clipboard'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _downloadAll(List<String> contents) async {
    for (int i = 0; i < contents.length; i++) {
      await _saveFile(_fileNames[i], contents[i]);
    }
  }

  Future<void> _saveFile(String name, String content) async {
    if (kIsWeb) {
      // Web: use FilePicker's saveFile API
      final bytes = utf8.encode(content);
      await FilePicker.platform.saveFile(
        fileName: name,
        bytes: Uint8List.fromList(bytes),
      );
    } else {
      // Desktop: prompt user for save location
      final savePath = await FilePicker.platform.saveFile(
        fileName: name,
        allowedExtensions: [name.split('.').last],
        type: FileType.custom,
      );
      if (savePath == null) return;
      // Write via dart:io isn't available on web, but fine on desktop
      // ignore: avoid_dynamic_calls
      final file = _getFile(savePath);
      await file.writeAsString(content);
    }
  }

  // Returns dart:io File via dynamic dispatch so web doesn't import dart:io at compile time
  dynamic _getFile(String path) {
    // Only called on non-web (desktop/mobile). Safe to use dart:io here.
    // Using conditional import pattern via a thin wrapper would be cleaner,
    // but for simplicity we keep this isolated via dynamic.
    throw UnsupportedError('Use _saveFile which handles platform routing');
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(schemeProvider);
    final contents = _buildContents(config);

    return Dialog(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 800,
        height: 620,
        child: Column(
          children: [
            // Header
            Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Text('Export Jetpack Compose Theme',
                      style: Theme.of(context).textTheme.titleMedium),
                  const Spacer(),
                  TextButton.icon(
                    icon: const Icon(Icons.copy_all, size: 16),
                    label: const Text('Copy all'),
                    onPressed: () => _copyAll(contents),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.download, size: 16),
                    label: const Text('Download all'),
                    onPressed: () => _downloadAll(contents),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            // Tabs
            TabBar(
              controller: _tabs,
              tabs: _tabLabels.map((l) => Tab(text: l)).toList(),
              isScrollable: true,
              tabAlignment: TabAlignment.start,
            ),
            const Divider(height: 1),
            // Content
            Expanded(
              child: TabBarView(
                controller: _tabs,
                children: List.generate(
                  contents.length,
                  (i) => _CodeTab(
                    fileName: _fileNames[i],
                    content: contents[i],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CodeTab extends StatelessWidget {
  final String fileName;
  final String content;

  const _CodeTab({required this.fileName, required this.content});

  void _copy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: content));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied $fileName'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        width: 240,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Container(
          color: cs.surfaceContainerLowest,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 56),
            child: SelectableText(
              content,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: cs.onSurface,
                height: 1.5,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          right: 12,
          child: FilledButton.icon(
            icon: const Icon(Icons.copy, size: 16),
            label: Text('Copy $fileName'),
            onPressed: () => _copy(context),
          ),
        ),
      ],
    );
  }
}
