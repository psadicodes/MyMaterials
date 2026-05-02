import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/scheme_notifier.dart';
import 'ui/shell.dart';

class ColorSchemeBuilderApp extends ConsumerWidget {
  const ColorSchemeBuilderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(flutterColorSchemeProvider);

    return MaterialApp(
      title: 'M3 Color Scheme Builder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
      ),
      home: const AppShell(),
    );
  }
}
