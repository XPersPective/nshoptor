import 'package:flutter/widgets.dart';

/// Sayı/para BİÇİMİ yereli — DİLDEN BAĞIMSIZ (C-001, PB-042).
///
/// Kullanıcı "İngilizce arayüz + Türkçe biçim (1.234,56 ₺)" isteyebilir.
/// `AppFormatLocale.attach` main'de ayarlardan bağlanır; ayar 'system'
/// olduğunda (varsayılan) biçim, cihazın ülke yerelinden gelir.
class AppFormatLocale {
  AppFormatLocale._();

  static String? _code;

  /// main'de runApp'ten önce çağrılır ('tr' | 'en' | null=system).
  static void attach(String? code) => _code = code;

  /// Ayar değeri ('tr' | 'en' | null=system).
  static String? get setting => _code;

  /// Test temizliği.
  static void attachReset() => _code = null;

  /// Etkin biçim yereli: ayar 'system'/yoksa cihazın ülke yereli.
  static String effective(BuildContext context) =>
      _code ??
      forLanguage(WidgetsBinding.instance.platformDispatcher.locale.toString());

  /// Keep region and numbering data; native and Latin keyboards are both
  /// accepted by MoneyParser. Locale defaults come from installed intl/CLDR.
  static String forLanguage(String languageCode) =>
      languageCode.replaceAll('-', '_');
}

/// Kısayol: parasal/ondalık biçimleme yerel kodu.
String formatLocaleCode(BuildContext context) =>
    AppFormatLocale.effective(context);
