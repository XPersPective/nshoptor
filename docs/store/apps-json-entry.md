# NShoptor — apps.json kaydı (Keşfet beslemesi)

ORTAK_UYGULAMA_STANDARDI §3.6: "Diğer uygulamalarımız" beslemesi Crazy
Penguin'in herkese açık reposundaki tek `apps.json` dosyasından gelir.
NShoptor'un kendisi bu kayıtla beslemeye eklenir; uygulama KENDİ paket
adını listede görmez (kendini gizler).

**Besleme:** [`XPersPective/napp_apps`](https://github.com/XPersPective/napp_apps)
reposundaki [apps.json](https://raw.githubusercontent.com/XPersPective/napp_apps/HEAD/apps.json).
Bu URL, `lib/core/config/env_config.dart` içindeki `NSHOPTOR_OTHER_APPS_URL`
varsayılanında zaten tanımlıdır. İstemci geçerli platform mağaza kimliği olan
kayıtları gösterir ve kendi Android paketini listeden çıkarır.

NShoptor kaydı ve ikonu bu besleme reposuna eklendiğinde diğer uygulamalarda
görünebilir. Aşağıdaki kayıt taslaktır; `appStoreId` ancak gerçek App Store
kaydı oluştuğunda doldurulur. Bu belgede besleme veya mağazaya yazma işlemi yapılmaz.

```json
{
  "id": "nshoptor",
  "androidPackage": "com.crazypenguin.nshoptor",
  "appStoreId": null,
  "icon": "https://raw.githubusercontent.com/XPersPective/napp_apps/HEAD/icons/nshoptor.png",
  "name": { "en": "NShoptor", "tr": "NShoptor" },
  "description": {
    "en": "Plan shopping costs, compare with what you actually paid.",
    "tr": "Alışverişini planla, evdeki hesap çarşıya uyuyor mu gör."
  },
  "order": 10
}
```

Notlar:
- `androidPackage`, uygulamanın mevcut üretim paket kimliğidir.
- İkon: `assets/brand/icon_1024.png` (1024x1024 PNG) besleme reposuna
  kopyalanır.
- `appStoreId`: iOS ertelendi (C-033) — yayımlandığında eklenir.
