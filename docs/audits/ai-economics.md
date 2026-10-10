# AI ekonomisi — 10 Ekim 2026

Mevcut Qwen Token hesabı/endpoint/model kullanıcı kararıyla korunur. Yeni teklifler Free/lifetime10, Pro100, Max300/ay; eski Pro200/Max1000 hakları korunur (ADR-007). Yıllık ödeme aylık kotayı değiştirmez.

## Gerçek mağaza verisi

Salt okunur Android Publisher API çıktısı: `play-prices-2026-10-10.json`. Bu, yayınlanmış katalog fiyatıdır; müşterinin vergi/indirim dahil ekrandaki teklifi ve Play net ödeme raporu değildir. Uygulama teklifi Billing SDK'dan gösterir.

| Mevcut ürün | USD aylık / yıllık | TRY aylık / yıllık | Gerçek mevcut aylık hak |
|---|---:|---:|---:|
|nshoptor_pro|0.99 / 7.99|57.99 / 469.99|200|
|nshoptor_max|2.99 / 24.99|174.99 / 1479.99|1000|

USD yıllık indirimleri katalogdan hesaplanır: Pro yaklaşık%32.7441, Max%30.3512; eski%20 yalnız varsayımdı. TRY ve USD arasında kur türetilmez. Yeni v2 SKU fiyatı, katalog oluşturulup okunana kadar bu tablodaki fiyatla ancak öneri/senaryodur.

## Mevcut hesabın maliyeti

[Qwen Token Plan](https://docs.qwencloud.com/token-plan/personal/token-plan-personal-overview) kredi bazlı aboneliktir. Kredi tüketimi model/token/thinking/tool kullanımına göre değişir; gerçek tüketim konsol kullanım ayrıntısından alınır. Kullanıcının paket/fatura/ortalama kredi-istek ölçümü yok: mevcut hesabın istek başına maliyeti ve marjı **bilinmiyor**, sıfır değil. Paket kotası ve varsa önceden alınmış kredi paketleri bittikten sonra hizmet durabilir; yerel ayrıştırma/elle giriş korunur. Hesap/sağlayıcı değiştirilmedi.

Aşağıdaki dolar hesabı **standart API karşılaştırmasıdır**, mevcut Token hesabının faturası değildir. [Qwen3.6-Flash resmi Model Studio fiyatı](https://www.alibabacloud.com/help/en/model-studio/qwen3-6-flash), Singapore International≤256k: giriş$0.25/M, çıkış$1.50/M (10 Ekim doğrulandı). Cache indirimi varsayılmaz. Cache/yoğun saat senaryosu için ayrı doğrulanmış efektif giriş/çıkış fiyatları CLI'ya verilir.

## Tekrar üretim

```powershell
ruby tool/play/subscriptions.rb --prices-json > docs/audits/play-prices-2026-10-10.json
python tool/ai_economics.py --self-check
python tool/ai_economics.py --offers docs/audits/play-prices-2026-10-10.json --tax .20 --fee .15 --infra 0
```

Net senaryo = fiyat/(1+vergi)×(1−mağaza kesintisi), yıllıkta önce fiyat/12. AI karşılaştırması = istek×(giriş token×giriş oranı+çıkış token×çıkış oranı)/1M. Kalan = net−AI−tahsis edilmiş altyapı. Vergi%20, kesinti%15, altyapı0 **varsayımdır**; iade, destek, ücretsiz kullanıcılar, muhasebe ve gelir vergisi hariç olduğundan işletme kârı değildir. [Play abonelik kesintisi](https://support.google.com/googleplay/android-developer/answer/112622) koşulları hesap/ülke/programla doğrulanmalıdır.

| Aylık istek | 2k giriş+500 çıkış | 6k+1200 | 12k+1200 | 12k+8192 fiş çıkış tavanı senaryosu |
|---|---:|---:|---:|---:|
|10|0.0125|0.033|0.048|0.15288|
|100|0.125|0.33|0.48|1.5288|
|300|0.375|0.99|1.44|4.5864|
|1000|1.25|3.30|4.80|15.288|

Bu değerler USD standart API senaryosudur. Örneğin Max yeni300 hakkı eski$2.99 fiyatında sunulursa varsayımsal aylık net$2.117917; 300 büyük istekte kalan$1.127917, çıkış tavanı senaryosunda−$2.468483. Yıllık$24.99 için aylık net$1.475104; aynı senaryolarda$0.485104/−$3.111296. Bu yeni teklifin yayınlandığı veya mevcut Qwen faturasında bu marjın oluştuğu iddiası değildir. CLI mevcut legacy200/1000 hakları için de yıllık/aylık kalanları üretir.

Önceki DeepSeek tablosu, aşağıdaki **eski duyarlılık parametreleriyle** tekrar üretilebilir; resmi fiyat sayfası 10 Ekimde zaman aşımı verdi, bugünkü doğrulanmış fiyat diye sunulmaz:

```powershell
python tool/ai_economics.py --offers docs/audits/play-prices-2026-10-10.json --input-rate .30 --output-rate 1.20 --scenario-name "Legacy DeepSeek sensitivity; current rate not verified"
```

Gerçek kredi ölçümü edinilirse üç parametre birlikte verilir: `--credit-price <aylık USD fatura> --credit-budget <aylık kredi> --credit-per-request <ölçülen ortalama>`. CLI kapasite ve tahsis edilmiş nakit/istek hesaplar; bu marjinal fatura değildir. Eksik ölçümde unknown üretir; örnek paket değerini gerçek kullanıcı hesabı gibi kabul etmez.

## Uygulanan sınırlar ve kalan ölçüm

PB-082 atomik D1 rezervasyon: kullanıcı aylık ve global günlük hak birlikte alınır. Ücretli hak, doğrulanmış jetonun SHA256 kimliğine bağlı; ücretsiz kurulum kimliği sıfırlanabilir. Global20000/gün bot savunmasının yerine geçmez. Standart API 12k+8192 stresinde$305.76/gün; bu mevcut kredi hesabının günlük faturası veya karakterden türetilmiş garantili token sınırı değildir.

İstek gövdesi16KiB, giriş6000 karakter, parse metni2000, etiket1500; çıktı token tavanları liste4096/fiş8192/etiket512, yanıt64KiB. Kesik ve eksik şema reddedilir; kabul edilmiş sağlayıcı denemesi hata verse de hak tüketir. Hatalı girdi/eksik sağlayıcı yapılandırması tüketmez. Gerçek Qwen konsol kredi tüketimi ve Play net ödeme raporu olmadan kazanç garantisi verilmez.

PDF yalnız kayıtlı miktar/tutarları taşır; doğrulanmış vergi bilgisi olmadığı için KDV uydurulmaz ve mali fatura diye sunulmaz.
