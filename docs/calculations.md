# Hesaplamalar

Tüm para/ondalık hesaplar `lib/core/money` ve `lib/core/calc` içindedir;
`double` kullanılmaz.

## Değer katmanı

- `DecimalFixed`: `BigInt` unscaled + `int` scale. Çarpım tamdır (ölçekler
  toplanır, ara yuvarlama yok).
- `Money`: minor unit `int` + `Currency`. Farklı para birimleri arasında
  aritmetik/karşılaştırma `ArgumentError` verir (kur dönüşümü yok).
- `Currency`: minor basamak sayısı (JPY 0, TRY 2, KWD 3).
- `MoneyParser`: tr/en yerel ayraçlarını (`42,90` / `42.90`) güvenle ayrıştırır.

## Yuvarlama kuralı

Tek kural: **yarıdan uzağa (half away from zero)**. Yalnız tanımlı
sınırlarda uygulanır: `DecimalFixed.rescale`, `divide`, `toMinorUnits` ve
`Money.fromDecimal`. Ara çarpımlarda yuvarlama yapılmaz.

## Formüller (spec §7.3)

```text
plannedLineTotal = plannedQuantity × plannedUnitPrice
actualGrossTotal = actualQuantity × actualUnitPrice
actualLineTotal  = actualGrossTotal − lineDiscount
lineVariance     = actualLineTotal − plannedLineTotal
lineVariance%    = plannedLineTotal ≠ 0 ? lineVariance / plannedLineTotal × 100 : "Hesaplanamaz"

projectedCheckoutTotal = purchasedActualTotal + remainingPlannedEstimate
budgetRemaining        = budgetLimit − projectedCheckoutTotal

priceEffect    = actualQuantity × (actualUnitPrice − plannedUnitPrice)
quantityEffect = (actualQuantity − plannedQuantity) × plannedUnitPrice
```

Fiyat/miktar etkisi yalnız ortak birim varsa ayrılır (`EffectSplit`);
yoksa yalnız toplam fark gösterilir. "Alınmadı" satırı 0 TL alım değildir,
gerçek toplama girmez.

## "Tahmine yakın" eşiği

`VarianceThreshold` (`lib/core/calc/variance.dart`): fark **%10 veya
altı** ya da mutlak olarak **200 minor unit** (TRY'de 2,00 ₺) veya altı
ise "tahmine yakın".

## Birim dönüşümü

Güvenli gruplar: kg ↔ g, L ↔ ml, adet ↔ düzine. Paket/kutu/şişe gibi
birimler yalnız kullanıcı tanımlı ambalaj içeriğiyle (`PackagingContent`,
ör. `1 paket = 500 g`) dönüştürülür.

## Fiş uzlaştırma

Fiş satır toplamları ile fiş toplamı arasındaki fark ±2 minor unit
toleransla raporlanır; fark gizlice silinmez, inceleme ekranında gösterilir.
