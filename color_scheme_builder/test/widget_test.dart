import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:color_scheme_builder/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: ColorSchemeBuilderApp()),
    );
    expect(find.text('M3 Color Scheme Builder'), findsAny);
  });
}
