import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/scheme_notifier.dart';

class PreviewPanel extends ConsumerWidget {
  const PreviewPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(flutterColorSchemeProvider);

    return Theme(
      data: ThemeData(colorScheme: colorScheme, useMaterial3: true),
      child: Builder(
        builder: (themeCtx) => Container(
          color: colorScheme.surface,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PreviewAppBar(colorScheme: colorScheme),
                const SizedBox(height: 16),
                _PreviewButtons(ctx: themeCtx),
                const SizedBox(height: 16),
                _PreviewCards(colorScheme: colorScheme),
                const SizedBox(height: 16),
                _PreviewChips(ctx: themeCtx),
                const SizedBox(height: 16),
                _PreviewTextField(ctx: themeCtx),
                const SizedBox(height: 16),
                _PreviewNavBar(colorScheme: colorScheme),
                const SizedBox(height: 16),
                _PreviewFAB(ctx: themeCtx),
                const SizedBox(height: 16),
                _PreviewColorPalette(colorScheme: colorScheme),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PreviewAppBar extends StatelessWidget {
  final ColorScheme colorScheme;
  const _PreviewAppBar({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colorScheme.surface,
      elevation: 2,
      shadowColor: colorScheme.shadow,
      surfaceTintColor: colorScheme.surfaceTint,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.menu, color: colorScheme.onSurface),
            const SizedBox(width: 16),
            Text(
              'App Title',
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Icon(Icons.search, color: colorScheme.onSurface),
            const SizedBox(width: 12),
            Icon(Icons.more_vert, color: colorScheme.onSurface),
          ],
        ),
      ),
    );
  }
}

class _PreviewButtons extends StatelessWidget {
  final BuildContext ctx;
  const _PreviewButtons({required this.ctx});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FilledButton(onPressed: () {}, child: const Text('Filled')),
        FilledButton.tonal(onPressed: () {}, child: const Text('Tonal')),
        OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
        TextButton(onPressed: () {}, child: const Text('Text')),
        ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
      ],
    );
  }
}

class _PreviewCards extends StatelessWidget {
  final ColorScheme colorScheme;
  const _PreviewCards({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _card(context, colorScheme.surfaceContainerLow, 'Elevated Card')),
        const SizedBox(width: 8),
        Expanded(child: _card(context, colorScheme.surfaceContainerHighest, 'Filled Card')),
        const SizedBox(width: 8),
        Expanded(child: _outlinedCard(context, colorScheme)),
      ],
    );
  }

  Widget _card(BuildContext context, Color bg, String label) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: cs.onSurface, fontSize: 14, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text('Supporting text', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _outlinedCard(BuildContext context, ColorScheme cs) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Outlined Card', style: TextStyle(color: cs.onSurface, fontSize: 14, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text('Supporting text', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
        ],
      ),
    );
  }
}

class _PreviewChips extends StatefulWidget {
  final BuildContext ctx;
  const _PreviewChips({required this.ctx});

  @override
  State<_PreviewChips> createState() => _PreviewChipsState();
}

class _PreviewChipsState extends State<_PreviewChips> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (int i = 0; i < 4; i++)
          ChoiceChip(
            label: Text('Chip ${i + 1}'),
            selected: _selected == i,
            onSelected: (_) => setState(() => _selected = i),
          ),
        const FilterChip(label: Text('Filter'), selected: false, onSelected: null),
        ActionChip(
          label: const Text('Action'),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _PreviewTextField extends StatelessWidget {
  final BuildContext ctx;
  const _PreviewTextField({required this.ctx});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Filled TextField',
              hintText: 'Type here…',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Outlined TextField',
              hintText: 'Type here…',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.edit),
            ),
          ),
        ),
      ],
    );
  }
}

class _PreviewNavBar extends StatefulWidget {
  final ColorScheme colorScheme;
  const _PreviewNavBar({required this.colorScheme});

  @override
  State<_PreviewNavBar> createState() => _PreviewNavBarState();
}

class _PreviewNavBarState extends State<_PreviewNavBar> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final cs = widget.colorScheme;
    return Material(
      color: cs.surfaceContainer,
      borderRadius: BorderRadius.circular(12),
      child: NavigationBar(
        selectedIndex: _index,
        backgroundColor: Colors.transparent,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.palette_outlined), selectedIcon: Icon(Icons.palette), label: 'Scheme'),
          NavigationDestination(icon: Icon(Icons.preview_outlined), selectedIcon: Icon(Icons.preview), label: 'Preview'),
          NavigationDestination(icon: Icon(Icons.token_outlined), selectedIcon: Icon(Icons.token), label: 'Tokens'),
          NavigationDestination(icon: Icon(Icons.file_download_outlined), selectedIcon: Icon(Icons.file_download), label: 'Export'),
        ],
      ),
    );
  }
}

class _PreviewFAB extends StatelessWidget {
  final BuildContext ctx;
  const _PreviewFAB({required this.ctx});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        FloatingActionButton(
          heroTag: 'fab_small',
          mini: true,
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        FloatingActionButton(
          heroTag: 'fab_regular',
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        FloatingActionButton.extended(
          heroTag: 'fab_extended',
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Create'),
        ),
        FloatingActionButton.large(
          heroTag: 'fab_large',
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}

class _PreviewColorPalette extends StatelessWidget {
  final ColorScheme colorScheme;
  const _PreviewColorPalette({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final pairs = [
      (colorScheme.primary, colorScheme.onPrimary, 'Primary'),
      (colorScheme.secondary, colorScheme.onSecondary, 'Secondary'),
      (colorScheme.tertiary, colorScheme.onTertiary, 'Tertiary'),
      (colorScheme.error, colorScheme.onError, 'Error'),
      (colorScheme.primaryContainer, colorScheme.onPrimaryContainer, 'PrimaryContainer'),
      (colorScheme.secondaryContainer, colorScheme.onSecondaryContainer, 'SecondaryContainer'),
      (colorScheme.tertiaryContainer, colorScheme.onTertiaryContainer, 'TertiaryContainer'),
      (colorScheme.errorContainer, colorScheme.onErrorContainer, 'ErrorContainer'),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: pairs.map((p) {
        return SizedBox(
          width: 100,
          height: 60,
          child: Material(
            color: p.$1,
            borderRadius: BorderRadius.circular(8),
            child: Center(
              child: Text(
                p.$3,
                style: TextStyle(color: p.$2, fontSize: 10, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
