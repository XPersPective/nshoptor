# NShoptor kullanıcı akışı incelemesi — 9 Ekim 2026

## Verdict: architecture fights the requirement, rewrite the offending layer

### Findings
| # | Symptom (user's words) | Root cause (file:line) | Class | Severity | Decision it forces |
|---|---|---|---|---|---|
|1|“her zaman alışveriş modundaki tikli yapı”|lib/features/lists/list_detail_screen.dart:315 ve shopping_mode/shopping_mode_screen.dart:89 ayrı ekranlar|yanlış katman|P1|Tek liste ekranı; durum yalnız yaşam döngüsü, ürün arayüzü aynı.|
|2|“son tamamlananlara … giremiyorum”|lib/features/home/home_screen.dart:415,666 onTap yok; :379 yalnız shopping|eksik bağlantı|P1|Tüm listeleri aynı ayrıntıya aç; ay kartı para birimine ait harcamaları açsın.|
|3|“domatesi silemiyorum”|lib/features/lists/item_repository.dart:80 silme var, görünür çağıran yok; form yalnız insert|eksik CRUD|P1|Satırdan düzenle/sil; satın alınmış veriyi sessizce silme.|
|4|“tahmini … gerçek … fotoğraf”|item_form_sheet.dart:266 kamera tahmine yazıyor; readShelfPrice sadece String döndürüyor|yanlış anlam|P1|Tek formda ayrı tahmin/gerçek; fotoğraf isim ve gerçek fiyat önerisi, kullanıcı onayı.|
|5|“mikrofon çalışmıyor”|voice_input/list_draft_sheet.dart:82 başarısız initialize sessiz; stt_speech_service.dart:17 durum dinlenmiyor; controller:131 start exception yakalamıyor|yaşam döngüsü|P1|Hata görünür, durdur/yeniden dene, desteklenen yerel; gerçek cihaz ayrıca doğrulanmalı.|
|6|“başlığını … marka … kategori”|voice_input/ai_list_parser.dart:9, server/src/tasks.js:25 yalnız items sözleşmesi|eksik veri akışı|P1|Başlık/marka/kategori önizlemede, mevcut kayıtları geriye dönük değiştirme.|
|7|“Fiş okut … direkt”|home_screen.dart:199 yalnız sekme+bildirim; receipt_review_controller.dart:260 ekleme döngüsü|yanlış eylem/veri|P0|Doğrudan fiş; bağlı önceki alımları atomik değiştir; tekrar onay çift kayıt üretmesin.|
|8|“ekranı açık tut … çalışıyor mu”|shopping_mode_screen.dart:51 false; settings_repository.dart:73 okunmuyor|kopuk ayar|P1|Liste içi görünür toggle, kayıtlı ayar, arka planda/çıkışta bırak.|
|9|“bildirimler … gitmiyor”|birçok showSnackBar çağrısı kuyruğa ekliyor; eylemli SnackBar platformda kalıcı olabilir|yaşam döngüsü|P2|Yeni bildirim eskisini kapatsın; kapatma simgesi; önemli hata formda kalsın.|
|10|“ülkelere göre”|main.dart:37 ilk kurulum ülke eşlemesi mevcut; AppDefaults:25 bağlı olmayan durumda TRY; SpendingScreen:44 /100|varsayılan/hassasiyet|P1|Ülke varsayılanını koru, ayarı ezme; sıfır/üç ondalık ve para birimi ayrımını test et.|
|11|“kar bırakacak … token”|server/wrangler.jsonc:27 15/200/1000; quota.js:29 oku-sonra-artır yarışıyor|ticari/güven sınırı|P1|Aylık 10/100/300, atomik kota, token maliyet senaryoları; sunucu ve 71 dil tutarlı.|
|12|“PDF … KDV … istatistik”|pubspec.yaml PDF paketi yok; insights mevcut haftalık/aylık toplamlarla sınırlı|eksik işlev|P2|Android yerel yazdır/PDF; gözlenen alım sıklığı/miktarı; bilinmeyen vergi veya tüketimi uydurma.|

### Deleted (things this critique kills)
- İki farklı liste davranışı: kullanıcı evde/markette aynı satırı yönetir.
- Kamera sonucunu otomatik tahmin sayma: raftaki fiyat gerçek fiyat adayıdır.
- Yeni liste/fiş düğmelerinin yalnız sekme değiştirmesi: eylem adını yerine getirmiyor.
- 15/200/1000 sabit taahhütleri: yeni aylık 10/100/300 kararıyla değişecek.

### Kept under suspicion (with the exact test that would acquit it)
- Mikrofon: izin ver/reddet, Türkçe/İngilizce ve tanıyıcısız cihaz; ilk ve ikinci açılışta sonuç veya görünür hata. Fake test gerçek mikrofonu aklamaz.
- Fiş: önce elle 30 gir, aynı ürünü fişte 32 onayla; toplam 32, iki onay yine 32; bölünmüş iki satır toplamı korunur; işlem hatasında rollback.
- Para: TRY/USD/JPY/KWD aynı yerelde round-trip; farklı paralar asla tek toplam olmaz.
- Dar ekran: 320dp ve 2x metinde uzun ürün adı, klavye ve alt eylemler taşmasın.
- Ekran kilidi: foreground açık/kapalı, arka plana geç, geri dön, çık; platform bayrağını ölç.

### Honest verification ledger
- Verified by me: yukarıdaki kaynak akışları ve Git geçmişi okundu; başlangıç test çalıştırması başlatıldı, sonuç ayrıca görev kanıtına yazılacak. Fiziksel mikrofon henüz denenmedi.
- Only the user can verify: kendi cihazındaki mikrofon sağlayıcısı/izin ve tek elle kullanım rahatlığı; gerçek mağaza fiyatı, hesabına özgü vergi/kesintiler. Otomatik test/build bunları kanıtlamaz.

## Yazılı sorgulama
1. Önceki düzeltmeler neden yetmedi? 847a4fb etiket, ce694b4 satır fiyatları, 5e9d50b yönlendirme/ülke düzeltmesiydi; çift ekran/CRUD/fiş kayıt yaşam döngüsünü çözmedi. c90de33 formu sadeleştirdi, ca04be1 ses düğmesi ekledi, b8ad44e araçları bağladı: erişim var ama aynı sözleşme yok. 9f142d1 grafik, b02e970 asistan, e5907ef AI liste, ddde4bf raf, bd36b00 fiş ayrı yüzeyler ekledi; uçtan uca sözleşme test edilmedi. 5525f15 sunucu, 1711927 abonelik, a0e6e81 reklam işi ticari akışı ekledi; marjı ölçmedi. Diğer ilgili geçmiş: e19d838/8d038f9/de74fd0/e4a0833 dil/yayın; 310d74d cihaz testleri; 700add6/25e1f40/6380793 ortak UI; 02662c6 bildirim; 8937661 ayar; e7a9b6e/9f25668 ses; 9d5fd69/96acc4c/dd2bb60 geçmiş; 4591aff/da8709f/fd6b80f/fbb628c ilk ekranlar. Bunların her birinin tüm eski sürümlerini cihazda yeniden çalıştırmadım; başlıkları başarı kanıtı saymıyorum.
2. Referans kullanıcı isteğidir: oluştur → aynı tikli liste → ad/miktar/tahmin/gerçek → ses/fotoğraf önizle → fişle tamamla → sonuç/PDF. Mevcut fazladan mod geçişi, sekmeye yönlendirme ve gerçek fiyat için ayrı form referanstan sapmadır.
3. İstenmeyen varsayılanlar: bütün yeni ürünlere TRY fallback, AI fiyatının toplam/birim yorumunun formda kaybı, asistanın ayrı metin/ses eylemleri. İlk kurulum ülke eşlemesi zaten var; yeniden yazılmamalı.
4. AI çıktısı güven sınırında uzunluk/birim/kimlik filtresinden geçmeli; fakat başlık/marka/kategori hiç sözleşmede yok. Güvenlik filtresi korunur, kullanıcı bilgisi kaybolmaz. Çıktı asla doğrudan kaydedilmez.
5. Kaldırılacak soyutlama: ikinci shopping ekranının ürün yönetimi. Decimal para, drift repository, OCR/AI önizleme ayrımı kalır.
6. Derlenmiş olmak çalışmak değildir: eski test sayıları güncel kanıt değildir; gerçek ses ve uzun isimli tek elle akış kanıtı yok. Başlangıç ve değişiklik sonrası testler ayrı kaydedilir.
7. En basit mimari: Her liste tek ekrana açılır. Satır tahmin ve gerçek kayıtlarını ayrı tutar. Elle, ses ve OCR aynı düzenlenebilir forma aday verir. Onay transaction içinde kaydeder. Fiş bağlı alımları değiştirir, toplamlar kayıtları bir kez sayar. Geçmiş ve PDF aynı veriyi okur. Sunucu yalnız metni ayrıştırır ve kota uygular.

## Kendime uygulanacak eleştiri promptu
“Yeni bir düğme eklemeden önce kullanıcının evde liste oluşturma, markette plansız ürün ekleme, fotoğraf/sesle giriş, yarım alışveriş, fişle uzlaştırma, geri alma, geçmiş ve PDF senaryolarını kaynak koddan izle. Her iddianın file:line kanıtını yaz. Varsayımı başarı diye sunma. Aynı veri neden iki ekran/formda farklı davranıyor? Bilinmeyen fiyat nerede sıfır oluyor? Fiş ve tekrar dokunuş çift kayıt yaratıyor mu? Kullanıcı iptal edince veri değişiyor mu? Uzun ad, büyük metin, izin reddi, çevrimdışı ve farklı para birimi nasıl davranıyor? En küçük ortak düzeltmeyi seç; gerekli test kırmızıdan yeşile geçmeden bitti deme.”
