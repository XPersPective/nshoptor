# R51–R60 doğrulama kaydı

## Kaynak ve yayın

- Kaynak: `bcc16c3` —196dosya; GitHub `main` dalına gönderildi. Yeni mobil mağaza sürümü yayımlanmadı.
- Aylık metinler: README, uygulama71dil, teklif ve native satınalma P1M korumaları, siteTR/EN ve73mağaza dili üretim kaynağı. Eski/yıllık sahiplik ve restore korunur; uzak ürün/plan silinmedi.
- GitHub Pages Actions40000016783 completed/success. TR veEN canlı sayfalarıHTTP200; sırasıyla “aylık aboneliktir” ve “monthly subscriptions” ifadeleri geriokundu. Bu bir mağaza metadata yüklemesi değildir.

## Çalıştırılan kontroller

- `flutter test --no-pub`:535geçti,2opt-in görsel test atlandı. Log `.price-contract-final-tests-2026-10-23.log`.
- `flutter analyze --no-pub`: sorun yok; son koşum66.9s. Log `.price-contract-final-analyze-2026-10-23.log`.
- Son küçük grafik simgesi/tarih düzeltmesi sonrası history/home23test geçti. Log `.price-visual-fixes-tests-2026-10-23.log`.
- `npm test` server:37geçti; ücretli/model ağ çağrısı yapılmadı. Log `.price-contract-server-2026-10-23.log`.
- Site:147statik kontrol geçti.
- TR/EN store capture testleri birer kez başarılı; her dilde8görsel1080×1920. Güncel klasör: `artifacts/store/2026-10-23-pricing/`. RootTR04fiyat formu ve05grafiği inceledi; eksik●font karakteri MaterialIcon ile düzeltildi, görseller tekrar üretildi.
- Androidx64debug1.2.8+16 derlemesi başarılı,97.1s; emülatör API36 üzerine no-streaming upgrade başarılı. APK SHA256: `D84C539991869487A6A0DB2BAACBAC1D7C4DCFFC19458C02786715CEBC6C391D`.
- Derleyici gelecekteki Flutter sürümleri için `in_app_review` KotlinGradlePlugin geçiş uyarısı verdi; bu koşumda derleme başarısızlığı değildir. Bağımlılık geçişi ayrı takip edilmeli.

## Native gözlem

Önceki QA emülatörünün `İstanbul` listesi ve uygulama ayarları güncellemede korundu. Bu test listesinin para birimiUSD, dilTR ve sayı biçimiEN'dir; native sonuçTRY diye sunulmaz.

- Yeni `QA400g` ürünü:400g, evdeki fiyat350, iki mod varsayılanSatırtoplamı.
- Form875.00USD/kg hesapladı; kaydedilen liste özeti350.00USD, ürün400g/350.00USD gösterdi. Market fiyatı boş kaldı ve daire boştu.
- Ürünü tekrar açınca400g,350toplam ve875/kg korundu; market alanı otomatik odaklıydı (`price-reopened.xml`, focused=true). Tekrar açılınca yeni boş ürün oluşmadı; sonradan açılan boş form QA tıklamasından kaynaklandı ve iptal edildi.
- Market alanına320toplam girildi: form800.00USD/kg gösterdi. Kaydetme sonrası özet350/320/fark−30 ve400g ürünün checked=true durumu XML'de doğrulandı (`price-market-saved.xml`).
- NativeXML `artifacts/qa/PB-125-native/price-saved.xml`; örnekler yalnız bu sınırlı yolun kanıtıdır. Canlı kamera, uzun mikrofon ve gerçek ödeme yapılmadı.

## Devralma

`docs/spec/price-input-contract.md` fiyat niyetini, baz birimini, indirimleri ve şema3ü açıklar. Eski kayıt/backup parasal anlamı korunur; nullable actual pricingInputMode eski birim niyetidir. Etiket açık400g paket bazını ve45/kg bazını ayrı taşır. Paket fiyatı bilinen baz üzerinden birim moda dönüştürülerek sonraki miktar değişimleri doğru ölçeklenir. Tahminler gerçek gözlem istatistiklerine yazılmaz.

Yeni worker priceSemanticsVersion2 kaynakta ve testte; canlı worker'a bu turda dağıtılmadı. Uygulama mağaza yayınıyla koordineli dağıtım/readback gerekir. Eski istemcilerin yanlış tutar çarpmasını önlemek için eski sözleşmeye fiyat yerine boş fiyat döner.

Mağaza açıklamaları/görselleri yüklenmedi; mevcut videolar yeni fiyat ekranından öncedir ve bu tur için nihai materyal sayılmaz. iOS/StoreKit/native köprüleri, gerçek fiş/etiket korpusu, uzun native ses ve ödeme/reklam cihaz kontrolleri halen kapsamlı üretim planında açık. ProjectBrain Evidence/Review alanları elle doldurulmadı; bu kayıt resmî kabul yerine geçmez.

## R61 — Kullanıcının tek dokunuş UX devamı

Toplam varsayılanı korundu; Ayarlar'a yeni fiyat tercihi eklenmedi. Ortak PriceModeSelector iki anlamı birlikte gösterir. Ürün formu, plansız ürün, sesli önizleme ve taslak editöründe fiyat açılır menüsü yoktur. Alanlar bağımsızdır; bilinen tutar mod değişiminde korunur, belirsiz adayda anlam açıkça seçilir. Ürün formunda fiyat odağı/klavye sürer. Taslakta400g/0.875pergram eski anlamı korunur; toplam350ye geçipgeri döner. DialogRoute.completed sonrasında editörcontrolleri bırakılır.

Plansız ürün yolunda da eski birimvarsayımı bulundu ve düzeltildi:2adet/5.50toplam=>5.50; birimseçimi2.75; tekrar toplam5.50 ve kaydedilenpricingInputMode=lineTotal. İndirimli toplamneti kaydetmede indirim tekrar düşülmez. Mevcut satınalma niyeti korunur; yeni genelayar yoktur.

Sonuç:539fulltestPASS/2opt-inskip (`.one-tap-price-full.log`); fullanalyzeCLEAN6.1s; Androidx64debugPASS66.3s. APK SHA256 `206151C86DA58A67769AAA8DD670BA985C573B539DC169CBEB7BBA84F6AE392C`. TR/DE/AR320px/2x kontrollerinde gerçektekdokunuş, seçilisemantik ve48dp hedef doğrulandı. TR8görsel opt-in testiPASS; root `artifacts/store/2026-10-23-one-tap/tr/04.png` görselini inceledi. Bu APKnativekurulmadı veya mağazaya yüklenmedi; üstteki native400gkontrolleri önceki fiyatmantığı sürümüne aittir. Diğer akışların bütün UX incelemesi bu küçük değişiklikle tamamlanmış sayılmaz.
