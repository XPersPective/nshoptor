# Google Play mağaza listesi — NShoptor

Metin kaynağı `tool/store/listing.py` + `listing_extra.json`:73 Play yereli,
71 uygulama arayüz dili. Dil, sayı biçimi ve para bağımsızdır. Play sınırları
başlık30/kısa80/uzun4000/not500. Yeni ücretli teklif yalnız yıllık Pro'dur:
her ay 100 yapay zeka isteği, reklamsız kullanım ve yedekleme/geri yükleme.
Ücretsiz plan ayda 10 istek sunar. Baz fiyat geçerli yerel vergiler öncesinde
yılda 1 ABD dolarıdır; yerelleştirilmiş nihai fiyat ve geçerli vergiler satın
almadan önce Google Play'de gösterilir. Her ülkede ödenecek tutarın tam 1 ABD
doları olması garanti edilmez. Abonelik iptal edilene kadar yıllık yenilenir.
Mevcut Pro/Max satın almaları geri yüklenebilir ve kazanılmış hakları korunur.
Mağaza plan bölümü, uygulamanın yerelleştirilmiş `plansLegal` ve
`planLegacyRights` metinlerinden bir kez üretilir.

`python -B tool/store/listing_translate.py --refresh-all` yalnız açıklama/notları
günceller, doğrulanmış başlık/kısa metni korur. `listing.py <metadata-kökü> <kod>`
yazar. `capture_all.py <metadata-kökü>` uygulamanın gerçek ekranlarını sentetik
örnek kayıtlarla üretir:8 PNG1080x1920 ve tanıtım1024x500; desteklenen bölgesel
mağaza yerellerine kopyalar. Başarısız render eski görselleri silmez, nonzero döner.
`check_assets.py <metadata-kökü>` metin/kota/boyut ve dosyaların açılmasını denetler.

Çıktı: `D:/AppPublishing/apps/nshoptor/stores/google-play/metadata`.
1.2.0+7 internal completed; genel metadata/görseller üretim yayınına kadar yüklenmez.
Kanıt: `docs/audits/internal-release-2026-10-10.md`.
