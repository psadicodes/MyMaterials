import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'panels/config_panel.dart';
import 'panels/preview_panel.dart';
import 'panels/tokens_panel.dart';
import 'widgets/blend_studio.dart';
import 'widgets/export_dialog.dart';

enum _Tab { scheme, preview, tokens, blend }

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  _Tab _tab = _Tab.preview;

  static const double _kNavRailBreakpoint = 840;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= _kNavRailBreakpoint;

    if (isWide) {
      return _WideLayout(
        tab: _tab,
        onTabChanged: (t) => setState(() => _tab = t),
        configPanel: const ConfigPanel(),
        rightPanel: _rightPanel(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('M3 Color Scheme Builder'),
        actions: [
          IconButton(
            tooltip: 'Export',
            icon: const Icon(Icons.file_download_outlined),
            onPressed: () => _openExport(context),
          ),
        ],
      ),
      body: _rightPanel(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _Tab.values.indexOf(_tab),
        onDestinationSelected: (i) => setState(() => _tab = _Tab.values[i]),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.palette_outlined),
            selectedIcon: Icon(Icons.palette),
            label: 'Config',
          ),
          NavigationDestination(
            icon: Icon(Icons.preview_outlined),
            selectedIcon: Icon(Icons.preview),
            label: 'Preview',
          ),
          NavigationDestination(
            icon: Icon(Icons.token_outlined),
            selectedIcon: Icon(Icons.token),
            label: 'Tokens',
          ),
          NavigationDestination(
            icon: Icon(Icons.blender_outlined),
            selectedIcon: Icon(Icons.blender),
            label: 'Blend',
          ),
        ],
      ),
    );
  }

  Widget _rightPanel() {
    return switch (_tab) {
      _Tab.scheme  => const ConfigPanel(),
      _Tab.preview => const PreviewPanel(),
      _Tab.tokens  => const TokensPanel(),
      _Tab.blend   => const BlendStudio(),
    };
  }

  void _openExport(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const ExportDialog(),
    );
  }
}

class _WideLayout extends StatelessWidget {
  final _Tab tab;
  final ValueChanged<_Tab> onTabChanged;
  final Widget configPanel;
  final Widget rightPanel;

  const _WideLayout({
    required this.tab,
    required this.onTabChanged,
    required this.configPanel,
    required this.rightPanel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Nav rail
          NavigationRail(
            selectedIndex: _Tab.values.indexOf(tab),
            onDestinationSelected: (i) => onTabChanged(_Tab.values[i]),
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.palette_outlined),
                selectedIcon: Icon(Icons.palette),
                label: Text('Config'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.preview_outlined),
                selectedIcon: Icon(Icons.preview),
                label: Text('Preview'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.token_outlined),
                selectedIcon: Icon(Icons.token),
                label: Text('Tokens'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.blender_outlined),
                selectedIcon: Icon(Icons.blender),
                label: Text('Blend'),
              ),
            ],
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _ExportButton(),
                ),
              ),
            ),
          ),
          const VerticalDivider(width: 1),
          // Left config panel (always visible on wide layout)
          SizedBox(
            width: 320,
            child: configPanel,
          ),
          const VerticalDivider(width: 1),
          // Right content area
          Expanded(child: rightPanel),
        ],
      ),
    );
  }
}

class _ExportButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Export Compose theme',
      child: IconButton.filled(
        icon: const Icon(Icons.file_download_outlined),
        onPressed: () => showDialog(
          context: context,
          builder: (_) => const ExportDialog(),
        ),
      ),
    );
  }
}
