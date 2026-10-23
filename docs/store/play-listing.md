# Google Play mağaza listesi — NShoptor

Metin kaynağı `tool/store/listing.py` + `listing_extra.json`:73 Play yereli,
71 uygulama arayüz dili. Dil, sayı biçimi ve para bağımsızdır. Play sınırları
başlık30/kısa80/uzun4000/not500; açıklamalar yeni10/100/300 ve eski200/1000
haklarını ayırır. Yeni Pro/Max teklifleri yalnız aylık, otomatik yenilenen aboneliktir;
yıllık yeni satın alma seçeneği sunulmaz. Mevcut eski/yıllık satın almalar geri
yüklenebilir ve hakları korunur. Fiyat ve varsa deneme uygunluğu Play’den gelir;
sabit fiyat veya deneme süresi pazarlama vaadi verilmez.

`python -B tool/store/listing_translate.py --refresh-all` yalnız açıklama/notları
günceller, doğrulanmış başlık/kısa metni korur. `listing.py <metadata-kökü> <kod>`
yazar. `capture_all.py <metadata-kökü>` uygulamanın gerçek ekranlarını sentetik
örnek kayıtlarla üretir:8 PNG1080x1920 ve tanıtım1024x500; desteklenen bölgesel
mağaza yerellerine kopyalar. Başarısız render eski görselleri silmez, nonzero döner.
`check_assets.py <metadata-kökü>` metin/kota/boyut ve dosyaların açılmasını denetler.

Çıktı: `D:/AppPublishing/apps/nshoptor/stores/google-play/metadata`.
1.2.0+7 internal completed; genel metadata/görseller üretim yayınına kadar yüklenmez.
Kanıt: `docs/audits/internal-release-2026-10-10.md`.
