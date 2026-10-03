# NShoptor — apps.json kaydı (Keşfet beslemesi)

ORTAK_UYGULAMA_STANDARDI §3.6: "Diğer uygulamalarımız" beslemesi Crazy
Penguin'in herkese açık reposundaki tek `apps.json` dosyasından gelir.
NShoptor'un kendisi bu kayıtla beslemeye eklenir; uygulama KENDİ paket
adını listede görmez (kendini gizler).

**Sahip yapacak:** aşağıdaki kaydı, besleme reposunun `apps.json`
dosyasına (ve ikonu `icons/` klasörüne) ekleyin. Repo adresi bilinmiyor —
belirlenince `lib/core/config/env_config.dart` içindeki
`NSHOPTOR_OTHER_APPS_URL` dart-define varsayılanı güncellenir.

```json
{
  "id": "nshoptor",
  "androidPackage": "com.example.nshoptor",
  "appStoreId": null,
  "icon": "https://raw.githubusercontent.com/<kullanici>/<apps-repo>/main/icons/nshoptor.png",
  "name": { "en": "NShoptor", "tr": "NShoptor" },
  "description": {
    "en": "Plan shopping costs, compare with what you actually paid.",
    "tr": "Alışverişini planla, evdeki hesap çarşıya uyuyor mu gör."
  },
  "order": 10
}
```

Notlar:
- `androidPackage` production kimliği belirlenince güncellenir (C-030).
- İkon: `assets/brand/icon_1024.png` (1024x1024 PNG) besleme reposuna
  kopyalanır.
- `appStoreId`: iOS ertelendi (C-033) — yayımlandığında eklenir.
