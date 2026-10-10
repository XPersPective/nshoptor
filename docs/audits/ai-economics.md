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
python tool/ai_economics.py --offers docs/audits/play-prices-2026-10-10.json --tax .20 --fee .15 --infra 0 --input-rate .25 --output-rate 1.50 --scenario-name Qwen-Model-Studio-comparator
```

Net senaryo = fiyat/(1+vergi)×(1−mağaza kesintisi), yıllıkta önce fiyat/12. AI karşılaştırması = istek×(giriş token×giriş oranı+çıkış token×çıkış oranı)/1M. Kalan = net−AI−tahsis edilmiş altyapı. Vergi%20, kesinti%15, altyapı0 **varsayımdır**; iade, destek, ücretsiz kullanıcılar, muhasebe ve gelir vergisi hariç olduğundan işletme kârı değildir. [Play abonelik kesintisi](https://support.google.com/googleplay/android-developer/answer/112622) koşulları hesap/ülke/programla doğrulanmalıdır.

| Aylık istek | 2k giriş+500 çıkış | 6k+1200 | 12k+1200 | 12k+8192 fiş çıkış tavanı senaryosu |
|---|---:|---:|---:|---:|
|10|0.0125|0.033|0.048|0.15288|
|100|0.125|0.33|0.48|1.5288|
|300|0.375|0.99|1.44|4.5864|
|1000|1.25|3.30|4.80|15.288|

Bu değerler USD standart API senaryosudur. Örneğin Max yeni300 hakkı eski$2.99 fiyatında sunulursa varsayımsal aylık net$2.117917; 300 büyük istekte kalan$1.127917, çıkış tavanı senaryosunda−$2.468483. Yıllık$24.99 için aylık net$1.475104; aynı senaryolarda$0.485104/−$3.111296. Bu yeni teklifin yayınlandığı veya mevcut Qwen faturasında bu marjın oluştuğu iddiası değildir. CLI mevcut legacy200/1000 hakları için de yıllık/aylık kalanları üretir.

DeepSeek fiyat sayfası önceki kontrolde zaman aşımı vermişti; kullanıcının son yönlendirmesi üzerine10 Ekimde yeniden açıldı ve güncel fiyat aşağıda doğrulandı. Önceki.30/1.20 duyarlılık sayıları güncel peak oranıyla örtüşür; önceki başarısız fetch güncel doğrulama kanıtı olarak kullanılmaz.

Gerçek kredi ölçümü edinilirse üç parametre birlikte verilir: `--credit-price <aylık USD fatura> --credit-budget <aylık kredi> --credit-per-request <ölçülen ortalama>`. CLI kapasite ve tahsis edilmiş nakit/istek hesaplar; bu marjinal fatura değildir. Eksik ölçümde unknown üretir; örnek paket değerini gerçek kullanıcı hesabı gibi kabul etmez.

## Uygulanan sınırlar ve kalan ölçüm

PB-082 atomik D1 rezervasyon: kullanıcı aylık ve global günlük hak birlikte alınır. Ücretli hak, doğrulanmış jetonun SHA256 kimliğine bağlı; ücretsiz kurulum kimliği sıfırlanabilir. Global20000/gün bot savunmasının yerine geçmez. Standart API 12k+8192 stresinde$305.76/gün; bu mevcut kredi hesabının günlük faturası veya karakterden türetilmiş garantili token sınırı değildir.

İstek gövdesi16KiB, giriş6000 karakter, parse metni2000, etiket1500; çıktı token tavanları liste4096/fiş8192/etiket512, yanıt64KiB. Kesik ve eksik şema reddedilir; kabul edilmiş sağlayıcı denemesi hata verse de hak tüketir. Hatalı girdi/eksik sağlayıcı yapılandırması tüketmez. Gerçek Qwen konsol kredi tüketimi ve Play net ödeme raporu olmadan kazanç garantisi verilmez.

PDF yalnız kayıtlı miktar/tutarları taşır; doğrulanmış vergi bilgisi olmadığı için KDV uydurulmaz ve mali fatura diye sunulmaz.


## Kullanıcının güncel ucuz model isteği — 10 Ekim 2026

“En sonki Flash sürümü, ucuz olanı ... kâr bırakacak kullanım senaryosuna göre ... hesapla.” Flash, Gemini model ailesidir. OpenAI tarafında karşılaştırılan güncel verimli model GPT-6 Luna'dır; ChatGPT aboneliği API kullanım bedeli olarak kabul edilmez. Hesap/sağlayıcı değiştirilmedi; aşağıdaki sonuçlar gelecekte standart API'ya geçiş için senaryodur, mevcut Qwen kredilerinin faturası değildir.

| Standart API modeli | Giriş USD/M | Çıkış USD/M |300 büyük fiş:6k giriş+1200 faturalanan çıkış |
|---|---:|---:|---:|
|[GPT-6 Luna](https://developers.openai.com/api/docs/models/gpt-6-luna)|0.10|0.50|0.36 USD|
|[Gemini3.5 Flash-Lite](https://ai.google.dev/gemini-api/docs/pricing)|0.30|2.50|1.44 USD|
|[Gemini3.8 Flash](https://ai.google.dev/gemini-api/docs/latest-model),31 Aralık2026'ya kadar tanıtım|0.75|3.75|2.70 USD|
|Gemini3.8 Flash,1 Ocak2027 standart|1.50|7.50|5.40 USD|

Bu uygulama fotoğraf/sesi sunucuya yollamaz; OCR ve konuşma cihazda, API'ya metin gider. Cache/Batch/Flex/ücretsiz API indirimi yok. Çıkış sayısı faturalanan düşünme tokenlarını da kapsayan varsayımdır. Model kalitesi ve gerçek token tüketimi uygulama korpusu ile ölçülmedi; ucuzluk kalite kanıtı değildir.

### Marj varsayımı ve sınırlar

Katkı payı = vergiden ve mağaza kesintisinden sonraki gelir − ücretli AI − ücretsiz kullanıcı AI payı − tahsis edilen altyapı. Hedef, bu net gelirin%30'u. Senaryo: vergi%20, mağaza%15, altyapı ücretli kullanıcı başına aylık0.10USD; her ücretli kullanıcı10 aktif ücretsiz kullanıcıyı finanse eder ve her biri ayda10 hakkını kullanır. Bu oran tahmin/duyarlılık parametresidir; gerçek kullanıcı oranı değildir. İade, destek, muhasebe, gelir vergisi ve dağıtılmamış sabit giderler hariç: işletme net kârı değil.

Yıllık fiyat/12 aynı aylık100/300 hakkı finanse eder. Giriş12k+çıkış8192 stres senaryosu, mevcut fiş çıkış tavanına dayanır; giriş karakterden türetilmiş garantili token üst sınırı değildir. Daha uzun düşünme/tokenizasyon, saldırı veya ücretsiz kurulum sıfırlama bu senaryoyu aşabilir. Günlük20000 hak gerçek nakit bütçesi değildir; ölçülen kredi/token raporu ve global tavan birlikte izlenmelidir.

Mevcut yıllık fiyat yeni teklifler için kullanılırsa:

|Model|Pro100:7.99/yıl, tipik aylık katkı|Max300:24.99/yıl, tipik aylık katkı|Max300 stres aylık katkı|
|---|---:|---:|---:|
|GPT-6 Luna|+0.1316|+0.8951|−0.7433|
|Flash-Lite|−0.5884|−0.5449|−8.2569|
|Yeni Flash tanıtım|−1.4284|−2.2249|−14.5129|
|Yeni Flash2027|−3.2284|−5.8249|−30.4009|

USD; yeni v2 teklifler henüz yayınlanmadı. GPT-6 Luna ile Pro tipik senaryoda pozitif olsa da%30 hedefini tutturmaz. Aynı yıllık fiyatlarda ve bu ücretsiz kullanıcı yükünde hedefe uygun ücretli aylık istek sınırı GPT-6 Luna için Pro91/Max677 tipik, Pro0/Max76 stres olur; vaat edilen100/300 hakkı keyfi azaltılmaz. CLI10% ücretli kullanım senaryosunu ayrıca gösterir; ücretsiz kullanıcı yükü aynı tam kullanım varsayımında kalır.

### Fiyat kararı için somut seçenek

100/300 hakkını koruyup%30 katkı hedefleyen **yıllık asgari senaryo fiyatları**:

|Model|Pro tipik / stres|Max tipik / stres|
|---|---:|---:|
|GPT-6 Luna|8.23 /28.05|14.04 /53.69|
|Flash-Lite|25.65 /118.98|48.89 /235.53|
|Yeni Flash tanıtım|45.98 /194.68|89.55 /386.94|
|Yeni Flash2027|89.55 /386.94|176.67 /771.45|

Eşikler tabloda yakın iki ondalığa yuvarlanır; yayın fiyatı tam CLI eşiğinin üzerinde seçilir. Son DeepSeek yönlendirmesinden önceki **OpenAI karşılaştırma seçeneği** GPT-6 Luna: yeni Pro2.99USD/ay veya29.99USD/yıl; yeni Max5.99USD/ay veya59.99USD/yıl. Bu OpenAI karşılaştırma fiyatlarının yıllık aylıklaştırılmış ağır senaryo katkısı sırasıyla yaklaşık0.6110USD(%34.5) ve1.3226USD(%37.3) olur.10:1 ücretsiz kullanıcı yükü ve varsayımlar değişirse yeniden hesaplanır. USD fiyatın TRY karşılığına kur uydurulmaz; Play bölgesel fiyatları ayrıca gözden geçirilir.

Bu öneri mevcut Qwen hesabında aynı marjın oluştuğu iddiası veya sağlayıcı geçişi değildir. Qwen standart API karşılaştırmasında aynı stres ve ücretsiz yük için30% yıllık asgari fiyat Pro76.42/Max150.42USD; Token Plan gerçek kredi tüketimi farklıdır. PB-065 yeni katalog fiyatlarını bu raporla değerlendirmeli; legacy200/1000 hakları ve fiyatları değiştirilmez. Legacy SKU maliyeti CLI plans bölümünde tam200/1000 kullanım üzerinden ayrıca yer alır; yeni teklif hesabıyla gizlenmez.

### Tekrar çalıştırma

```powershell
python -B tool/ai_economics.py --self-check
python -B tool/ai_economics.py --offers docs/audits/play-prices-2026-10-10.json --input-rate .10 --output-rate .50 --infra .10 --free-per-paid 10 --margin .30 --scenario-name gpt-6-luna
python -B tool/ai_economics.py --offers docs/audits/play-prices-2026-10-10.json --input-rate .30 --output-rate 2.50 --infra .10 --scenario-name gemini-3.5-flash-lite
python -B tool/ai_economics.py --offers docs/audits/play-prices-2026-10-10.json --input-rate .75 --output-rate 3.75 --infra .10 --scenario-name gemini-3.8-flash-intro
python -B tool/ai_economics.py --offers docs/audits/play-prices-2026-10-10.json --input-rate 1.50 --output-rate 7.50 --infra .10 --scenario-name gemini-3.8-flash-2027
```

CLI proposed_plans bölümü mevcut fiyatlara bağlı varsayımsal teklif ve tipik/stres/full/10% kullanım sonuçlarını gösterir. Minimum fiyat = toplam tahsis edilen maliyet / (1−hedef) / net(1USD); yıllıkta×12. Sustainable request count = floor(max(0,net×(1−hedef)−free−infra)/istek maliyeti). Fatura ve kur varsayımları kullanıcı tarafından değiştirilebilir; bilinmeyenler sıfır kâr/maliyet diye gösterilmez.


## Son yönlendirme: planın esası DeepSeek-V4.1-Flash

“Dipsik’in en sonki modelinin en düşük fiyatlısına göre” (user). [Resmî fiyat tablosu](https://api-docs.deepseek.com/quick_start/pricing/)10 Ekim2026'da açıldı: en yeni ekonomik model **DeepSeek-V4.1-Flash**, API adı **deepseek-flash**. Karşılaştırılan V4-Pro'dan ucuzdur. Yoğun saatte cache miss giriş0.30USD/M, çıkış1.20; sakin saatte0.15/0.60. Cache hit0.006/0.003; hiçbir isteğin cache hit olacağını varsaymıyorum. Yoğun saatler hafta içi01–04 ve06–10 UTC; diğer saatlerde yarı fiyat. Uygulamanın anlık isteği geciktirilmez: fiyat kararı yoğun saat/cache miss üzerinden, sakin saat tasarrufu ayrıca hesaplanır. Model düşünme modunu varsayılan açar; maliyet senaryosunda faturalanan toplam çıkış düşünmeyi de kapsar.

|Hak|Tam tipik kullanım AI maliyeti yoğun / sakin|Yoğun saat30% hedef yıllık asgari fiyat, tipik /8192 çıkış stresi|
|---|---:|---:|
|Pro100|0.324 /0.162|18.10 /67.43 USD|
|Max300|0.972 /0.486|33.79 /132.44 USD|

Tablodaki fiyat alt sınırları yukarıdaki vergi/mağaza/0.10 altyapı/10 ücretsiz kullanıcı varsayımlarını içerir. Fiyat teklifinin sınırını göstermek için iki ayrı kullanım senaryosu korunur; düşük model fiyatı her uzun fişte otomatik kâr anlamına gelmez.

**Uygun başlangıç fiyatı önerisi:** yeni Pro100 için1.99USD/ay veya19.99USD/yıl; yeni Max300 için3.99USD/ay veya39.99USD/yıl. Peak/no-cache, tam tipik kullanımda yıllık aylıklaştırılmış katkı Pro0.43197USD(%36.6), Max0.96452USD(%40.9). Aylık planlarda aynı katkı Pro0.66158USD(%46.9), Max1.43025USD(%50.6). Sürekli12k+8192 stresinde yıllık plan aylık katkısı Pro−1.60611USD, Max−3.11164USD; bu fiyatlarla her kullanımda kâr vaadi yok.10:1 ücretsiz kullanıcı yükü aynı stresdeyse Pro hiç, Max15 ücretli ağır istekten sonra%30 hedefini aşar. Büyük fiş kullanım sıklığı ve faturalanan tokenlar ölçülmeli; yayın fiyatı kullanım verisine göre revize edilebilir. Yeni fiyatlar öneridir, Play'e yazılmadı; eski200/1000 sözleşme hakları ve fiyatları korunur. Mevcut Qwen hesabı değişmedi.

```powershell
python -B tool/ai_economics.py --offers docs/audits/play-prices-2026-10-10.json --infra .10 --free-per-paid 10 --margin .30 --pro-monthly 1.99 --pro-annual 19.99 --max-monthly 3.99 --max-annual 39.99
python -B tool/ai_economics.py --offers docs/audits/play-prices-2026-10-10.json --input-rate .15 --output-rate .60 --infra .10 --scenario-name deepseek-flash-offpeak-no-cache
```

CLI varsayılanı artık doğrulanmış DeepSeek peak/no-cache. Qwen ve OpenAI/Gemini tabloları adı belirtilmiş karşılaştırma olarak kalır. Sakin saatte300 tipik isteğin maliyeti0.486USD; mevcut24.99/yıl Max fiyatında ücretsiz yük+altyapı sonrası aylık katkı0.7271USD olur. Peak'te aynı fiyat yalnız0.0791USD bırakır ve%30 hedefini karşılamaz. Bu nedenle planı yalnız düşük saat fiyatına bağlamıyorum. Mevcut hesap fatura/kredi tüketimi bilinmeden bu sonucu Qwen gerçek kârı diye sunmuyorum.
