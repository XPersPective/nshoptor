import 'package:flutter/material.dart';

/// NShoptor yazı markası: her yerde aynı tipografi. "N" vurgu renginde,
/// "Shoptor" yüzey üstü renkte; kalın, sıkı harf aralığı.
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
