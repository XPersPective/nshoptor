# AI ekonomisi — 9 Ekim 2026

Karar: ücretsiz ve ömür boyu reklamsız 10/ay, Pro 100/ay, Max 300/ay. Yıllık ödeme aylık kotayı değiştirmez; haftalık 300 önerilmiyor. Fiyatlar Play teklifinden okunur, TL/USD kuru uydurulmaz.

## Kaynaklar ve varsayımlar
- [DeepSeek resmi fiyatı](https://api-docs.deepseek.com/quick_start/pricing/): deepseek-flash (V4.1), yoğun saat/cache miss 1M giriş $0.30, 1M çıkış $1.20; yoğun olmayan $0.15/$0.60. Hesap muhafazakâr yoğun saat, cache indirimi yok.
- [Google Play service fees](https://support.google.com/googleplay/android-developer/answer/112622): otomatik yenilenen abonelik için %15 taban senaryosu; ülke/program koşulları ayrıca uygulanabilir.
- %20 vergi, $3 müşteri fiyatı, yıllık %20 indirim yalnız duyarlılık varsayımıdır; gerçek Play vergi/ödeme raporu yerine geçmez. Kullanıcının 174 TL ≈ $3 ifadesi döviz kuru kanıtı değildir.
- Repo şu an Qwen Token Plan kullanıyor (`server/wrangler.jsonc`); aşağıdaki DeepSeek modeli geçiş senaryosudur, mevcut faturanın ölçümü değildir. Sağlayıcı/anahtar değiştirilmedi.

## Tekrar üretilebilir hesap
PB-065 uygulayıcısı şu parametrelerle küçük bir hesap betiği eklemeli: fiyat=3 USD, vergi=0.20, kesinti=0.15, yıllık indirim=0.20, altyapı=0. Bu oturumda betik teslim edilmedi.

Net = müşteri fiyatı / (1+vergi) × (1−mağaza kesintisi).
AI = istek × (giriş token × giriş fiyatı + çıkış token × çıkış fiyatı) / 1 milyon.
Kalan = net − AI − tahsis edilmiş altyapı. Bu işletme kârı değildir; iadeler, ücretsiz kullanıcılar, destek, muhasebe ve gelir vergisi ayrıca vardır.

| Aylık istek | 2k giriş + 500 çıkış | 6k giriş + 1200 çıkış | 12k giriş + 1200 çıkış stres |
|---|---:|---:|---:|
|10|$0.012|$0.0324|$0.0504|
|100|$0.120|$0.324|$0.504|
|300|$0.360|$0.972|$1.512|
|1000|$1.200|$3.240|$5.040|

$3 senaryosunda kesinti sonrası $2.125, yıllık indirimde aylık eşdeğer $1.700 kalır. 300 büyük istekten sonra $1.153/$0.728; 1000 büyük istekten sonra −$1.115/−$1.540. Dolayısıyla 1000 taahhüdü güvenli değil; 300 de stres/yıllık indirimde yalnız $0.188 tampon bırakır. Pro $1 olsaydı net $0.708, 100 büyük istekten sonra $0.384 kalır. Sıfır altyapı varsayımı kârı yüksek gösterir.

## Maliyet kontrolünün gerçek sınırları
1200 max output ve 6000 input karakter sınırı var; karakter token değildir. Tablodaki sayılar garantili üst sınır değil, senaryodur. Büyük fiş çıktısı 1200 tokenı aşarsa model JSON tamamlayamaz; hata görünür olmalı, sessiz eksik kayıt olmamalı. Sağlayıcının gerçek usage alanlarıyla fiyatı ölçmeden daha yüksek kota açılmamalı.
Önerilen kota rezervasyonu D1 transaction içinde olmalı; eşzamanlı son hak çift harcanamaz. Başarısız sağlayıcı isteği de hakkı tüketir (mevcut davranış): sağlayıcı maliyeti oluşabilir. Kullanıcı taahhüdü “istek” olarak kalır.
Rastgele kurulum ID'si kimlik doğrulaması değildir; yeniden kurulum/özel istemci ücretsiz sayacı yenileyebilir. Global günlük tavan maliyet sınırıdır, bot savunması yerine geçmez. 20 bin büyük isteklik global tavan bu DeepSeek senaryosunda $64.80/gün olabilir. Canlı ticari açılıştan önce gerçek sağlayıcı bütçe/rate limit ve Play Integrity tasarımı ayrı güvenlik işi olarak kalır.
Ömür boyu ödeme yalnız reklam hakkını kalıcı yapar; AI her ay 10 ile sınırlıdır. Mevcut satın alanların yedek hakkı korunur.

## Vergili PDF
Market KDV oranı ülke/ürün bazında değişir. Fişte ayrıştırılmış ve doğrulanmış vergi verisi olmadığı için uygulama KDV uydurmaz. PDF mevcut tutarları taşır; mali belge/vergisel fatura olarak sunulmaz.
