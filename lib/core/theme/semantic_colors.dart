import 'package:flutter/material.dart';

/// Plan-gerçek farkının yönü (spec §10). Renk hiçbir zaman tek bilgi
/// taşıyıcısı değildir: her gösterge renk + ikon + yön simgesiyle sunulur.
enum SpendingDirection { underPlan, overPlan, nearPlan }

/// Fark göstergesinin sunum bilgisi: anlamsal renk, ikon ve metin öneki.
///
/// Yön simgeleri okunur yöne sahiptir (pozitif/negatif anlamı kültüre
/// bırakmaz): altında=↓ (yeşil), üstünde=↑ (kırmızı/turuncu), yakın=~ (nötr).
class SemanticDelta {
  const SemanticDelta({
    required this.color,
    required this.icon,
    required this.marker,
  });

  /// Temaya göre çözülmüş anlamsal renk.
  final Color color;

  /// Erişilebilir etiketiyle birlikte kullanılacak ikon.
  final IconData icon;

  /// Metin yanına eklenen yön işareti (renk görmeyen kullanıcılar için).
  final String marker;

  /// [direction] yönünü [brightness] temasına göre çözer. Renkler gövde
  /// metni büyüklüğünde okunur ve her iki temada AA kontrast hedefine
  /// yaklaşacak şekilde sabitlenmiştir (test/core/theme kontrast testi).
  static SemanticDelta resolve({
    required SpendingDirection direction,
    required Brightness brightness,
  }) {
    final dark = brightness == Brightness.dark;
    return switch (direction) {
      SpendingDirection.underPlan => SemanticDelta(
          color: dark ? const Color(0xFF7BD9A5) : const Color(0xFF146B3A),
          icon: Icons.south_east,
          marker: '↓',
        ),
      SpendingDirection.overPlan => SemanticDelta(
          color: dark ? const Color(0xFFFFB59B) : const Color(0xFFB3261E),
          icon: Icons.north_east,
          marker: '↑',
        ),
      SpendingDirection.nearPlan => SemanticDelta(
          color: dark ? const Color(0xFF9ECAFF) : const Color(0xFF0B5FA5),
          icon: Icons.drag_handle,
          marker: '≈',
        ),
    };
  }

  /// Sabit renklerin WCAG gövde metni kontrastının test edilebilmesi için
  /// her iki temadaki renk çiftleri.
  static ({Color light, Color dark}) palette(SpendingDirection direction) =>
      switch (direction) {
        SpendingDirection.underPlan => (
            light: const Color(0xFF146B3A),
            dark: const Color(0xFF7BD9A5)
          ),
        SpendingDirection.overPlan => (
            light: const Color(0xFFB3261E),
            dark: const Color(0xFFFFB59B)
          ),
        SpendingDirection.nearPlan => (
            light: const Color(0xFF0B5FA5),
            dark: const Color(0xFF9ECAFF)
          ),
      };
}
