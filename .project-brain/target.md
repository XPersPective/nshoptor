# Target Architecture
Status: CONFIRMED

## Goal
“her zaman alışveriş modundaki tikli yapı olması gerekiyor … ürün adı … miktarı … tahmini fiyatı … gerçek fiyatı … Gerçek fiyatının yanında … Fotoğraf … Sesle de ürün girebilmeliyim … kapsamlı bir rapor … çözümler üret, bunları mimariye dök ve yapılacaklar olarak ekle project brain'e olarak yol haritası ve uygula. Mevcut mimariye bağımlı değilsin yani.”

**Son kapsam talimatı (2026-10-09):** “projeyi devral ve tümünü bitir”. Önceki yalnız plan kapsamı sona erdi; açık yol haritası uygulanıp doğrulanacak.

Aşağıdaki durum HEDEFTİR; mevcut çalışan özellik iddiası değildir.
Tam istek: `docs/audits/2026-10-09-user-request.txt`; eleştiri: `docs/audits/2026-10-09-user-experience.md`.
Başlangıç ve yürütme sırası: `roadmap.md`. Tasarım: `decisions/ADR-005.md`.

## Target State
### Tek alışveriş akışı
Evde, markette ve geçmişte aynı liste ekranı. Ürün satırı: tik, uzun adı, miktar/birim, tahmin, gerçek ve varsa fark. Taslak/alışveriş modu ayrı düzenleme ekranları değildir. İlk adımı isim girmek veya konuşmak olan tek yeni liste eylemi. Varsayılan para birimi miras alınır; değişiklik ikincil alandadır.
Alt erişim: ürün ekle, ses/metin, fotoğraf, fiş, bitir. İkincil işlemler taşma menüsündedir; 48dp dokunma, büyük yazı, klavye ve RTL desteklenir. Tamamlanmış liste açılır; eski alışverişi yanlışlıkla yeniden başlatmaz.

### Veri ve hesap
Mevcut drift + decimal çekirdeği korunur. Tahmin ve gerçek bağımsızdır; bilinmeyen fiyat null, sıfır fiyat sıfırdır. Gerçek miktar planlanan miktardan ayrı kalır. Checkbox fiyat uydurmaz. Düzeltme/silme kontrollüdür; bağlı alımlar, gözlemler ve kategori kayıtları tutarlı kalır.
Fiş mevcut elle girilmiş alımı uzlaştırır, ikinci kez toplamaz. Çok satır/indirim/bölme, tekrar onay ve hata rollback testleri bulunur. Kısmi alışveriş tamamlanabilir; alınmayan ürün tasarruf diye sunulmaz. Para birimleri ve uyumsuz miktar birimleri asla toplanmaz.

### Girdi
Ses ve yazı aynı düzenlenebilir AI önizlemesine gider: başlık, ürün, miktar/birim, tahmini fiyatın toplam/birim anlamı, marka, kategori. Kategori yalnız onaylanan yeni öğelere uygulanır; eski kayıtlar otomatik yeniden sınıflandırılmaz.
Fotoğraf cihazda OCR edilir; metinden ad+gerçek fiyat adayı çıkar. Tahmin otomatik doldurulmaz. AI/izin/ağ hatası görünür, elle giriş çalışır. Tek mikrofon yaşam döngüsü; native on-device oturum sahipliği izlenir; ağ fallback yok (ADR-006).
Fiş plansız başlayabilir veya mevcut listeye eklenir; iptalde satın alım oluşmaz. Kamera yalnız gerçek fiyatın yanında bulunur.

### Yerelleştirme ve geri bildirim
İlk kurulumda cihaz ülkesinden para; mevcut kullanıcı tercihi ezilmez. Dil, sayı biçimi, para birbirinden bağımsızdır. Ülke verisi izin istemeden sistem yerelinden alınır; belirsizlikte görülebilir ve değiştirilebilir fallback.
Ekranı açık tut ayarı aktif liste ekranına bağlanır; seçili durum görünür, arka planda ve çıkışta bırakılır. Snackbar kuyruğu birikmez, kapatılabilir; kayıt hatası formda kalır.

### Ticari model
Öneri: ücretsiz/ömür boyu reklamsız 10, Pro 100, Max 300 AYLIK AI isteği. Yıllık plan aynı aylık kotadır. Lifetime mevcut reklam/backup haklarını korur; abonelik AI hakkı vermez. Mağaza fiyatı Play'den gelir.
Aylık 300 kararı muhafazakâr başlangıç önerisidir; gerçek token maliyeti ve yıllık indirimle ölçülür. Referans senaryolar: `docs/audits/ai-economics.md`. Kota sunucuda atomik; satın alma istemci beyanıyla yükselmez. Provider key değişimi/yayın yalnız ilgili yürütme yetkisiyle.

### Rapor
JSON yedek korunur. PDF liste, tarih, para, miktar, tahmin/gerçek/fark ve eksik fiyat işaretini taşır. Android native print/PDF ilk tercih; yeni paket gerekmeden denenir. Bilinmeyen KDV hesaplanmaz; karışık vergi oranlarında tek varsayılan uygulanmaz.
Ürün/kategori harcaması, satın alınan miktar ve alış sıklığı grafiklerle gösterilir. “Tüketim” iddiası yok; ayrı para/birim grupları ve küçük örneklem açıklaması vardır.

## Explicit Non-Goals
Tam DB/state-management yeniden yazımı; gereksiz bağımlılık; hesap/bulut senkronizasyonu; döviz kuru dönüşümü; tahmini vergiyi gerçek fatura diye sunma; geçmiş veriyi onaysız AI ile yeniden sınıflandırma. iOS yayın işi bu Android revizyonunu bloklamaz.

## Success Conditions
- SC1 aynı listeye ana sayfa, aktifler, tamamlananlar ve geçmişten erişim; yeni liste düğmesi editörü açar.
- SC2 aynı ekranda ekle/tik/güncelle/sil; tahmin-gerçek ve miktar ayrımı testlidir.
- SC3 ses ilk/ikinci açılış, izin reddi, desteklenmeyen dil; fotoğraf adı+gerçeği; iptal veri değiştirmez.
- SC4 kısmi fiş, tekrar onay ve elle+fiş toplamı; transaction rollback; JPY/KWD hassasiyeti.
- SC5 ülke varsayılanı, bağımsız biçim, wakelock, kapatılabilir geri bildirim, 320dp/büyük metin/RTL.
- SC6 aylık 10/100/300 taahhütleri client/server/71 dil/yıllıkta tutarlı; maliyet sınırı ve yayın riski açık.
- SC7 PDF gerçek Android'de kaydedilip açılır; miktar/sıklık istatistiği gerçek kayıtlardan hesaplanır.
- SC8 flutter test/analyze ve server test yeşil; release cihaz kanıtı; sadece derleme başarı sayılmaz.

## Open Target Decisions
Gerçek Play net gelir/vergi raporu ve gerçek sağlayıcı token ölçümü henüz yok: maliyet tabloları varsayımdır. Fiziksel mikrofon çalışması henüz doğrulanmadı. Bunlar bağımsız uygulama görevlerini durdurmaz; ticari/canlı başarı iddiasını sınırlar.

AI sağlayıcı kararı (2026-10-09): Qwen Token Plan resmî koşulları özel uygulama backend kullanımını yasaklıyor. Standart API hesabı/anahtar yolu kullanıcıya soruldu; kaynak: https://docs.qwencloud.com/token-plan/personal/token-plan-personal-overview . Yerel kota/istemci/test işi bağımsızdır; bu endpoint ile yeni backend çağrısı veya canlı yayın yapılmaz.
