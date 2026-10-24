# Yıllık tek Pro ve okunur grafikler — 24 Ekim 2026

## Kullanıcı sözleşmesi ve kapsam

Son talep önceki yalnız aylık satış kararını değiştirir: yeni satışta yalnız yıllık Pro; vergi hariç temel fiyat yılda 1 ABD doları, mevcut Pro özellikleri ve her takvim ayında 100 YZ isteği. Aylık haklar yıllık 1200 ortak havuza dönüştürülmez. Free ayda 10 istektir. Mevcut Pro/Max satınalmaları, eski kotaları ve restore korunur. Yeni aylık/Max/lifetime satışları kapatılır; mevcut kullanıcıların abonelikleri iptal edilmez ve otomatik yıllığa dönüştürülmez.

## Kaynak değişiklikleri

- `subscription_service.dart`: yalnız `nshoptor_pro_v2/yearly` P1Y/infinite/base teklifini sorgular ve satın alır. Native ürün/plan/fiyat aşaması doğrulanır; aynı native teklifin tokenı kullanılır. Eski dört ürün kimliği ve 100/300/200/1000 aylık kota hakları korunur. Aynı ürünün dönem değişimi mevcut satınalma tokenıyla WITHOUT_PRORATION, daha yüksek eski haklardan geçiş deferred kullanır. Gerçek ödeme cihaz testi ayrı kabul koşuludur.
- `subscription_paywall.dart`: Free ve yıllık Pro, mağazadan gelen nihai fiyat, yıllık yenileme ve aylık kota açıklaması. Tahmini statik TL fiyatı eklenmez; vergi tekrar hesaplanmaz. Mevcut eski haklar ayrı gösterilir.
- 71 ARB/generated dil, README, TR/EN site ve 73 mağaza yereli yıllık sözleşmeye uyar. Tüm diller ana dili uzmanıyla doğrulanmış sayılmaz.
- `amount_axis_chart.dart`, ürün fiyat geçmişi ve harcama ekranları: ölçeklenen yüksek kontrast metin, ölçülen eksen genişliği, uzun tutarda yerelleştirilmiş kısa ölçek + tam değerler, RTL'de eksi işaretinin korunması. Para hesaplamaları fixed point kalır; double yalnız çizim/kısa gösterim içindir. Geniş harcama grafiğinde tam tutar satırları artık tooltip açmadan görünür. Ürün çizimleri birimlerine göre ayrılır.
- `tool/play/annual_pro.rb`: resmi API ile önce önizleme; niyet hashinde bölge/fiyat/erişilebilirlik, kapatılacak teklifler ve lifetime durumu bağlıdır. Her dış yazımdan önce özel makbuz, sonra geri okuma. Yanıt bilinmezse otomatik tekrar yapılmaz. Eski `subscriptions.rb` yeni planları tekrar açamaz.
- `fastlane push_metadata_text`: yalnız metin, changelog/görsel/ekran kümesini değiştirmez. `verify_text.rb` tüm kaynak metinleri resmi mağaza okumasıyla karşılaştırır. Sürüm 1.3.0+18 hedeflenir.

## Yapılan kontroller

- 38 odaklı Flutter testi, UI_REVIEW gerçek font/AppTheme yakalamaları dahil geçti: `.annual-ui-final.log`.
- Son analyzer temiz: `.annual-analyze-final.log` (22.6s).
- Sunucu kota/satınalma sözleşmesi dahil 37 test geçti: `.annual-server.log`; canlı sunucuya ücretli model çağrısı veya yeni dağıtım yapılmadı.
- Site 155 statik kontrol, mağaza 73 yerel sınır/sözleşme kontrolü geçti. `HATA en expected failure` satırı kasıtlı başarısız ekran yakalamasının mevcut görselleri silmediğini doğrulayan testtir.
- Gerçek fontlu TR412 koyu/EN412 açık/AR320 2x ücretli teklif, restore ve yasal açıklama görüntüleri `artifacts/qa/PB-137/`. TL469.99 bu görüntülerde yalnız sahte mağaza test verisidir; yayımlanacak gerçek fiyat iddiası değildir. Root AR yıllık teklif ve TR yasal son görünümünü inceledi; kesilme/taşma yok.
- Grafik 320/412/800, sıfır/negatif/çok büyük tutar, TRY/JPY/KWD, RTL/açık/koyu/2x kontrolleri `artifacts/qa/PB-136/`. Root AR320 büyük negatif eksen ve AR320 fiyat grafiğini inceledi; tutarlar okunur, eksi doğru tarafta.
- Bağımsız native ajan kaynak incelemesi: servis/API son sürüm PASS; ilk bulunan niyet hashinde erişilebilirlik ve final lifetime/offer doğrulaması açıkları giderildi. Ayrı ajan uygulama/paywall EN/TR/AR sözleşmesi için engel bulmadı. Resmi PB Review kaydı değildir.
- İlk tam koşumda test dosyasına eklenen yakalamanın AppTheme import çakışması ve yeni eksen nedeniyle eski wiring testi sayım beklentisi başarısız oldu; ikisi düzeltildi. Son tam koşum aşağıda ayrıca kaydedilecek.

## Mağaza önizlemesi ve sınırlar

Resmi Google fiyat dönüşümü: USD1 vergi hariç girdi. ABD için charm rounding .99 yerine kullanıcı isteğiyle tam USD1; Türkiye önizlemesi TRY59.99, Almanya EUR1.09, Britanya GBP0.89. Nihai vergi/yerel fiyat mağazadan gelir; dönüştürülen vergi tutarı tekrar eklenmez. Bu önizleme tek başına canlı fiyat güncellendi kanıtı değildir.

Resmi kaynaklar: https://developers.google.com/android-publisher/api-ref/rest/v3/monetization/convertRegionPrices ve https://developers.google.com/android-publisher/api-ref/rest/v3/monetization.subscriptions.basePlans/deactivate . Deactivate mevcut abonelikleri iptal etmez.

## Devir ve açık işler

PB-135/136/137 görevlere, C-016/Target ve şartname R71–R74'e işlendi. Project Brain `start` eski havuz onayı uyuşmazlığı nedeniyle engelli olduğundan resmi Evidence/Review/accept uydurulmadı. Sonuçlar bu denetim ve Resume alanlarında tutulur.

release-harbor kullanılıyor. Prepare helper mevcut README kayıt düzenini kabul etmedi; skillin izin verdiği mevcut Fastlane ve kayıt düzenine göre eşdeğer hesap/paket/imza/sürüm/API kontrolleri yürütülür. Yeni profil/registry veya Store Automation oluşturulmadı.

Önceki bütün proje işleri tamamlandı değildir: gerçek ödeme/uzun ses/OCR/etiket/reklam/bildirim/71 dil uzman incelemesi/iOS ve üretim kabul kapıları korunur. Yalnız Android dahili test yetkisi var; kullanıcı testinden önce üretime terfi yok. Eski uygulama17 yalnız aylık teklif filtrelediğinden eski planlar satışa kapatıldığında yeni18 kurulana kadar ücretli teklif göstermeyebilir.

## Son tam test, derleme ve canlı sonuçlar

Son tam `flutter test --no-pub`: 568 geçti, 2 opt-in atlandı, 2m09s (`.annual-full-final.log`). Son kaynak için 38 UI_REVIEW odaklı test ve analyzer temizliği de yukarıda kaydedildi. İmzalı18 derlemesi ve canlı işlemler sürüyor; sonuçlar yalnız geri okumadan sonra eklenecek.
