import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/core/theme/brand_wordmark.dart';

void main() {
  Widget host({required ThemeData theme, String? suffix}) => MaterialApp(
        theme: theme,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(2)),
            child: Center(child: BrandWordmark(size: 28, suffix: suffix)),
          ),
        ),
      );

  RenderParagraph paragraph(WidgetTester tester) =>
      tester.renderObject<RenderParagraph>(find.byKey(const Key('brand_wordmark')));

  testWidgets('N and plan suffix keep the fixed brand green across palettes', (tester) async {
    await tester.pumpWidget(host(theme: AppTheme.light(palette: AppPalette.ocean), suffix: 'Pro'));
    var render = paragraph(tester);
    final nSpan = render.text.getSpanForPosition(const TextPosition(offset: 0));
    final suffixSpan = render.text.getSpanForPosition(const TextPosition(offset: 9));
    expect(nSpan?.style?.color, AppTheme.brandSeed);
    expect(suffixSpan?.style?.color, AppTheme.brandSeed);
    expect(nSpan?.style?.fontSize, suffixSpan?.style?.fontSize);
    expect(render.text.toPlainText(), 'NShoptor Pro');
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(host(theme: AppTheme.dark(palette: AppPalette.sunset, black: true), suffix: 'Pro'));
    render = paragraph(tester);
    final darkNSpan = render.text.getSpanForPosition(const TextPosition(offset: 0));
    final darkSuffixSpan = render.text.getSpanForPosition(const TextPosition(offset: 9));
    expect(darkNSpan?.style?.color, AppTheme.brandSeed);
    expect(darkSuffixSpan?.style?.color, AppTheme.brandSeed);
    expect(tester.takeException(), isNull);
  });

  testWidgets('wordmark semantics and no suffix remain stable in a narrow RTL view', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 120));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(host(theme: AppTheme.light(palette: AppPalette.lavender)));
    expect(find.bySemanticsLabel('NShoptor'), findsOneWidget);
    expect(paragraph(tester).text.toPlainText(), 'NShoptor');
    expect(tester.takeException(), isNull);
  });
}
