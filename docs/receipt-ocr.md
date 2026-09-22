# Fiş ve raf etiketi OCR

## Nasıl çalışır

1. Liste detayında **Fiş tara** → kamera (`image_picker`).
2. `MlKitTextSource`: `google_mlkit_text_recognition`, pakete gömülü Latin
   modeli. Model indirmesi yok; kurulumdan sonra uçak modunda çalışır.
3. `ReceiptParser` (deterministik): mağaza/tarih/para birimi/ara
   toplam/indirim/vergi/toplam adayları ve ürün satırları. Tarih, telefon,
   vergi no, kart maskesi, fiş no satırları ürün sayılmaz; çok satıra taşan
   adlar birleştirilir. Her satır `high` / `medium` / `low` güven taşır.
4. `ReceiptReviewScreen`: satırı kabul et / yoksay / planlanan ürüne bağla /
   ikiye ayır / sonrakiyle birleştir; fiş toplamı ile kabul edilenler
   arasındaki fark gösterilir.
5. **Tümünü onayla** öncesinde veritabanına hiçbir şey yazılmaz. Onayda
   kabul edilen satırlar `PurchaseEntries`'e (`source = receiptOcr`) yazılır.

Raf etiketi: ürün formunda etiket düğmesi → fotoğraf → `ShelfPriceExtractor`
tüm fiyat adaylarını güven derecesiyle listeler (en büyük sayı körlemesine
seçilmez) → kullanıcının seçtiği değer fiyat alanına yazılır.

## Sınırlamalar

- Yalnız Latin alfabesi; el yazısı, soluk termal kağıt, düşük ışık ve
  eğik/kıvrık fişlerde doğruluk düşer.
- Kırpma/döndürme arayüzü yok; kullanıcı adaylar arasından seçer.
- Fiş satırları otomatik eşleştirilmez; bağlamayı kullanıcı yapar
  (`ReceiptMatcher` önerileri henüz ekrana bağlı değil).
- Onaylanan fiş satırları birim olarak `adet` yazılır.
