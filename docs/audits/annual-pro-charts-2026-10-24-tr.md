# Yıllık Pro ve okunur grafikler — 24 Ekim 2026

## Son kullanıcı kararı

Yeni satışta tek ücretli seçenek **yıllık Pro**: **yılda 1 ABD doları, KDV/geçerli vergiler hariç temel fiyat**. Mevcut Pro özellikleri korunur: her takvim ayında 100 YZ isteği, reklamsız kullanım ve JSON yedekleme/geri yükleme. Bu, yıllık 1200 istekten oluşan ortak havuz değildir. Ücretsiz planın 10 istek/ay hakkı korunur.

Bu karar önceki yalnız aylık satış talebinin yerini alır. Aylık, Max ve lifetime seçenekleri yeni satışa kapatıldı. Mevcut abonelikler iptal edilmedi; eski satınalmalar, aylık kotaları ve geri yükleme desteği korunur. Mevcut kullanıcılar otomatik yıllık plana geçirilmedi.

## Yapılan değişiklikler

- `subscription_service.dart`: yalnız `nshoptor_pro_v2/yearly` için P1Y, süresiz yinelenen temel teklif satın alınabilir. Native ürün/plan/fiyat aşaması doğrulanır; doğrulanan teklifin tokenı kullanılır. Eski dört ürün kimliği ve 100/300/200/1000 aylık hakları korunur. Aynı ürünün dönem değişimi mevcut satınalma tokenıyla WITHOUT_PRORATION; daha yüksek eski haklardan geçiş deferred kullanır.
- `subscription_paywall.dart`: Free ve yıllık Pro kartları, mağazanın nihai fiyatı, yıllık otomatik yenileme ve aylık kota açıklaması. Statik TL fiyatı veya ikinci vergi hesabı yoktur. Mevcut eski haklar ayrı gösterilir.
- 71 uygulama dili ve üretilen yerelleştirmeler; README, TR/EN site ve 73 mağaza yereli yıllık sözleşmeye uyar. Tüm çevirilerin ana dili uzmanıyla doğrulandığı iddia edilmez.
- `amount_axis_chart.dart`, ürün fiyat geçmişi ve harcama ekranları: ölçeklenen, yüksek kontrastlı eksen metni; ölçülen genişlik; uzun tutarlar için yerelleştirilmiş kısa ölçek ve ayrıca tam değerler. RTL'de eksi işareti korunur. Para hesapları fixed point kalır; double yalnız çizim/kısa gösterim içindir. Geniş harcama grafiğinin tam tutarları tooltip açmadan görünür. Farklı ürün birimleri ayrı çizilir.
- `tool/play/annual_pro.rb`: resmi API önizlemesi, fiyat/bölge/erişilebilirlik ve kapatılacak seçenekleri bağlayan niyet hash'i. Her yazımdan önce özel makbuz, ardından geri okuma. Yanıt belirsizse otomatik tekrar yoktur. Eski `subscriptions.rb` eski planları yeniden açamaz.
- `fastlane push_metadata_text`: yalnız metin günceller; görsel, ekran görüntüsü ve sürüm notlarını korur. `verify_text.rb` canlı metinleri kaynakla karşılaştırır.

## Test ve inceleme sonuçları

| Kontrol | Gerçek sonuç |
|---|---|
| Tam Flutter testi | 568 başarılı, 2 isteğe bağlı test atlandı; 2m09s; `.annual-full-final.log` |
| Grafik/abonelik odaklı test ve UI_REVIEW yakalamaları | 38 başarılı; `.annual-ui-final.log` |
| Statik analiz | Sorun yok; 22.6s; `.annual-analyze-final.log` |
| Sunucu | 37 başarılı; `.annual-server.log` |
| Site | 155 statik kontrol başarılı |
| Mağaza kaynakları | 73 yerel için sınır/sözleşme kontrolleri başarılı |
| Canlı mağaza metinleri | 73 yerel kaynakla eşleşti; sıfır fark |

Mağaza kontrolündeki `HATA en expected failure`, başarısız yakalamanın mevcut görselleri silmediğini sınayan kasıtlı regresyon testidir.

İlk tam koşumda yakalama testinin AppTheme import çakışması ve yeni eksen etiketini hesaba katmayan eski wiring testi başarısız oldu. İkisi düzeltildikten sonra yukarıdaki son tam koşum geçti.

### Görsel ve bağımsız inceleme

- `artifacts/qa/PB-136/`: 320/412/800 genişlik, TRY/JPY/KWD, sıfır/negatif/büyük tutar, RTL, açık/koyu ve 2x yazı. Root, Arapça 320 büyük negatif ekseni ve fiyat grafiğini inceledi; tutarlar okunur, eksi işareti doğru tarafta.
- `artifacts/qa/PB-137/`: gerçek fontlar ve AppTheme ile TR412 koyu, EN412 açık, AR320/2x. Yıllık teklif, restore, eski haklar ve yasal açıklamalar yakalandı. Görüntülerdeki 469,99 TRY yalnız sahte mağaza test verisidir; canlı fiyat değildir.
- Root ve ayrı bağımsız ajan, ücretli teklif ve yasal metin yakalamalarını inceledi; görünür taşma/kontrast engeli yok. Ekran görüntüsü, ekran okuyucu sırası veya native ödeme ekranı kanıtı değildir.
- Ayrı kaynak incelemesi servis/API için PASS verdi. İlk bulunan iki açık — niyet hash'inde erişilebilirlik bağının eksikliği ve final lifetime/offer doğrulaması — giderilip tekrar incelendi. Başka bir ajan paywall ve EN/TR/AR sözleşmesinde engel bulmadı. Bunlar resmi PB Review kayıtları değildir.

## Canlı fiyatlandırma doğrulandı

Google fiyat dönüşümüne **USD 1, vergi hariç** girdi verildi. Bölgesel yuvarlama ve yerel vergiler mağazanın nihai fiyatına yansır; dönüştürülen vergi tutarı uygulamada tekrar eklenmez. Her ülkede nihai tahsilatın tam 1 USD olması vaat edilmez.

Kaynak: [Google fiyat dönüşümü](https://developers.google.com/android-publisher/api-ref/rest/v3/monetization/convertRegionPrices). Plan kapatılması mevcut abonelikleri iptal etmez: [deactivate](https://developers.google.com/android-publisher/api-ref/rest/v3/monetization.subscriptions.basePlans/deactivate).

`annual_pro.rb --apply --expected-sha 9dc0fa34ae689f7a6c48ba857f27b139e59cf76f520e3a6efd68549a60c93de3` ile fiyat yazımı, 7 plan kapatma ve lifetime kapatma ayrı ayrı geri okunup doğrulandı. Ardından ayrı `--status` okuması:

- Yalnız `nshoptor_pro_v2/yearly`: ACTIVE, P1Y.
- Diğer 7 temel plan: INACTIVE.
- `com.crazypenguin.nshoptor.pro_lifetime/lifetime`: INACTIVE.
- ABD: yıllık USD 1,00; Türkiye: yıllık TRY 59,99. Önizlemede Almanya EUR 1,09, Britanya GBP 0,89.
- Yıllık aktif indirim/deneme teklifi yok. Mevcut planın bütün bölgesel fiyat/erişilebilirlik ayarları ilk yazımdan sonra kontrol edildi; dönüşüm 174 bölge sağladı.

Özel makbuz: `D:/AppPublishing/apps/nshoptor/original-notes/annual-pro-2026-10-24.json`, confirmed. Tekrar apply yerine önce status okunmalı.

## GitHub, site ve mağaza metinleri

Kaynak checkpoint: `3b5b5ed6f3725b6985bccdcca1875b9f19372128`, GitHub main'e gönderildi. Pages iş akışı **40064497328 başarılı**. TR/EN canlı HTTP yanıtları, satır sonu normalizasyonundan sonra kaynakla birebir eşleşti. Özel makbuz: `annual-pages-2026-10-24.json`, confirmed.

Mağaza metinleri dış yayın kökünde hazırlanırken eski yerel metinler `annual-metadata-before-2026-10-24/` altında yedeklendi; ayrıca resmi API'deki önceki metin/track bilgisi özel makbuza alındı. Mevcut Fastlane supply ile internal17 referanslı yalnız metin güncellendi; apk/aab/changelog/images/screenshots atlandı. Yükleme başarılı; ayrı `verify_text.rb` okuması 73 yerel için sıfır fark verdi. Metin işleminden önce/sonra bütün trackler aynıydı. Özel makbuz: `annual-metadata-2026-10-24.json`, confirmed. Görseller bu işlemde yenilenmedi.

## İmzalı paket ve dahili test

- Sürüm: **1.3.0 / 18**, paket `com.crazypenguin.nshoptor`, targetSDK36.
- `fastlane android build_release`: 481s başarılı; `.internal18-build.log`.
- AAB: 95.209.571 byte; SHA256 `6d745b40dd7bdd0e4cd652a1d6b85a841a11f7077b38ebea16369a1b666e8556`.
- `verify_bundle.py`: JAR imzası ve uygulamanın upload sertifikası eşleşti; 12 adet 64-bit ELF için LOAD>=16KB; 6 adet 32-bit kütüphane ayrıca mevcut.
- `fastlane android deploy_internal`: 113s başarılı; `.internal18-upload.log`.
- Ayrı resmi API geri okuması: internal/name1.3.0/versionCodes18/statuscompleted; uzak SHA256 yerelle aynı.
- Production önce/sonra aynı: 1.2.7/14 draft ve 1.0.0/1 completed. Üretime terfi yapılmadı.
- Özel makbuz: `internal-18-2026-10-24.json`, confirmed. **18 artık kullanıldı**; sonraki yükleme önce uzak sürümleri okumalı.

[Teste katıl](https://play.google.com/apps/testing/com.crazypenguin.nshoptor). Test hesabıyla 1.3.0 sürümünü kontrol et; API completed her cihazın güncellemeyi anında aldığını kanıtlamaz.

## Project Brain ve devir

PB-135/136/137, C-016, Target ve şartname R71–R74 güncellendi. Eski havuz onayı uyuşmazlığı `PB start` işlemini engelliyor; resmi Evidence/Review/accept uydurulmadı. Gerçek test ve dış işlem sonuçları bu belgede ve görevlerin Resume alanlarında tutulur. Sonraki ajan gerçek güncel havuz seçimiyle onayı uzlaştırıp resmi kapıları çalıştırmalı.

Yayın için release-harbor ve mevcut Fastlane kullanıldı. Prepare helper mevcut README kayıt düzenini kabul etmedi; skillin izin verdiği eşdeğer hesap/paket/imza/sürüm/API kontrolleri mevcut kayıt düzeniyle yapıldı. Yeni registry/profil veya Store Automation oluşturulmadı.

Bu son isteğin kaynak, fiyat, yeni satış seçenekleri, metinler, site ve dahili test işlemleri doğrulandı. Önceki bütün proje talepleri tamamlandı değildir: gerçek ödeme, uzun ses, OCR/etiket, reklam, bildirim, tüm dillerin uzman incelemesi ve iOS kabul kapıları açık kalır. Ücretli model çağrısı veya bu değişiklik için yeni sunucu dağıtımı yapılmadı. Üretime geçiş kullanıcının dahili test kabulünden sonradır.

Eski uygulama17 yalnız aylık teklif filtrelediğinden, 18 kurulana kadar ücretli teklif göstermeyebilir. Kullanıcının 18'e güncellemesi gerekir.
