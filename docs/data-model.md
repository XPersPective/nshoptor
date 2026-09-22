# Veri modeli

drift şema sürümü **1**, 14 tablo (`lib/data/db/app_database.dart`).
`PRAGMA foreign_keys = ON`; çok adımlı yazımlar transaction içinde.

| Tablo | Amaç |
|---|---|
| ShoppingLists | Liste; tek para birimi (ISO 4217), durum (draft → planned → shopping → completed / archived) |
| PlannedItems | Planlanan satır: ondalık miktar (string), birim kodu, birim fiyat, plan satır toplamı (minor unit) |
| PurchaseEntries | Gerçek alım; plansız ise `plannedItemId` null; `source` = manual / voice / receiptOcr |
| ProductMemory | Ürün hafızası (normalize ad, varsayılan birim/kategori, favori) |
| ProductAliases | Mağazaya göre takma adlar / fiş kodları |
| PriceObservations | Doğrulanmış alımdan fiyat gözlemi (fiyat geçmişi kaynağı) |
| Stores, Categories, Aisles | Taksonomi; kod olarak saklanır, görünen ad l10n'dan |
| Receipts, ReceiptCandidateLines | Fiş başlığı ve aday satırlar |
| Attachments | Fotoğraf yolları (dosyalar uygulama özel `media/` dizininde) |
| Reminders | Hatırlatma kayıtları |
| AppSettings | Anahtar–değer ayarlar (ör. şablon liste kimlikleri) |

## Değer saklama

- Kesinleşmiş tutarlar: minor unit `int` (ör. kuruş).
- Miktar, birim fiyat: kanonik ondalık string (`1.5`, `42.90`).
- Silme: liste silinince ürün/alım satırları cascade; diğer referanslar
  gerektiğinde `SET NULL`.

## Migration

`onUpgrade` sürümlü adımlar; v0 → v1 ve transaction geri alma testleri
`test/data/app_database_test.dart` içinde.
