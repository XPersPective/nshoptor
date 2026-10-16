import 'package:flutter/material.dart';

/// NShoptor yazı markası: her yerde aynı tipografi. "N" vurgu renginde,
/// "Shoptor" yüzey üstü renkte; kalın, sıkı harf aralığı.
/// Uygulama simgesi ve yazı markası yan yana (ana sayfa başlığı, splash).
class BrandTitle extends StatelessWidget {
  const BrandTitle({super.key, this.size = 20});

  final double size;

  @override
  Widget build(BuildContext context) => FittedBox(
        fit: BoxFit.scaleDown,
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          key: const Key('brand_title'),
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/brand/icon_1024.png',
              width: size * 1.45,
              height: size * 1.45,
              excludeFromSemantics: true,
            ),
            SizedBox(width: size * 0.45),
            BrandWordmark(size: size),
          ],
        ),
      );
}

class BrandWordmark extends StatelessWidget {
  const BrandWordmark({super.key, this.size = 28, this.suffix});

  final double size;

  /// Plan adı gibi ek ("Pro", "Max"); markadan sonra normal ağırlıkta.
  final String? suffix;

  static TextStyle style(double size) => TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.02 * size,
        height: 1.1,
      );

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = style(size);
    final label = suffix == null ? 'NShoptor' : 'NShoptor $suffix';
    return Semantics(
      label: label,
      excludeSemantics: true,
      child: Text.rich(
        TextSpan(children: [
          TextSpan(text: 'N', style: base.copyWith(color: scheme.primary)),
          TextSpan(text: 'Shoptor', style: base.copyWith(color: scheme.onSurface)),
          if (suffix != null)
            TextSpan(
              text: ' $suffix',
              style: base.copyWith(fontWeight: FontWeight.w500, color: scheme.primary),
            ),
        ]),
        key: const Key('brand_wordmark'),
        textScaler: TextScaler.noScaling,
      ),
    );
  }
}
