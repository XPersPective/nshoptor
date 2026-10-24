# NShoptor — Nihai Flutter Uygulama Geliştirme Promptu

Aşağıdaki talimatların tamamını tek bir ürün şartnamesi olarak kabul et. Yalnızca ekran maketi üretme; çalışan, test edilmiş, Android ve iOS için hazırlanmış bir Flutter uygulaması geliştir.

## 1. Rolün ve çalışma biçimin

Kıdemli bir Flutter ürün mühendisi, mobil UX tasarımcısı ve test mühendisi gibi çalış.

- Önce mevcut repository'yi incele. Çalışan kod, yardımcı sınıf veya yerleşmiş mimari varsa yeniden kullan.
- Repository boşsa güncel kararlı Flutter sürümüyle yeni proje oluştur.
- Gereksiz bağımlılık, soyutlama, servis veya boilerplate ekleme.
- Bir özellik Flutter/Dart standart araçlarıyla çözülebiliyorsa önce onları kullan.
- Paket eklemeden önce güncelliğini, lisansını, platform desteğini ve bakım durumunu kontrol et.
- Sürüm numaralarını bu prompttan kopyalama; uygulama geliştirilirken güncel ve birbirleriyle uyumlu kararlı sürümleri seç.
- Büyük işi çalışan küçük aşamalara böl. Her aşamanın sonunda analiz, format, test ve build kontrollerini çalıştır.
- Belirsizliklerde güvenli ve makul varsayımlar yap, bunları README'de belirt. Kritik olmayan sorular nedeniyle geliştirmeyi durdurma.
- Yalnızca mockup, sahte buton veya TODO bırakma. Kullanıcıya sunulan her eylem gerçekten çalışsın.
- Üretim kodunda zorunlu demo verisi bulundurma. Geliştirici önizlemeleri ve test fixture'ları production verisinden ayrı olsun.
- Parasal hesaplarda `double` veya binary floating point kullanma.
- OCR ve konuşma tanıma sonuçlarını kesin doğru kabul etme; kullanıcı doğrulaması sağla.

## 2. Ürün ve marka kimliği

Uygulamanın kesin adı: **NShoptor**

Yayıncı/geliştirici markası: **Crazy Penguin**

GitHub repository adı: **nshoptor**

Flutter package adı: **nshoptor**

Uygulama adını her yerde tam olarak `NShoptor` biçiminde yaz. Büyük `N` ve büyük `S` kullanılmalı. `Nshoptor`, `Shoptor`, `N Shop Tor` gibi alternatifler kullanma.

Android application ID, Android namespace, iOS bundle identifier, signing bilgileri veya mağaza kimliği için uydurma production değeri oluşturma. Bu değerler Crazy Penguin'in mevcut mağaza/geliştirici kimliğine göre proje sahibi tarafından sağlanacaktır. Gerekli yerleri kurulum dokümanında açıkça belirt fakat prompt içinde sabit ID tanımlama.

Ürün adı NShoptor, yayıncı markası Crazy Penguin'dir.

## 3. Slogan ve yerelleştirme

Türkçe slogan:

> Evdeki hesap çarşıya uyar.

İngilizce slogan:

> Plan at home. Shop as planned.

Slogan, uygulamanın seçili diline göre değişsin. Metinleri kod içine sabit yazma. Flutter'ın resmi `flutter_localizations`, ARB ve `intl` altyapısını kullan.

İlk sürümde eksiksiz desteklenecek diller:

- Türkçe (`tr` / uygun olduğunda `tr_TR`)
- İngilizce (`en` / cihazın uygun bölgesel varyantı)

Dil sistemi sonradan yalnızca yeni ARB dosyaları eklenerek genişletilebilsin. Uygulama ilk açılışta sistem dilini kullansın; kullanıcı Ayarlar ekranında `Sistem`, `Türkçe` veya `English` seçebilsin.

Yerelleştirilmesi gerekenler yalnızca menüler değildir:

- Slogan, başlıklar, formlar ve butonlar
- Hata, doğrulama ve boş durum mesajları
- Kamera, mikrofon ve bildirim izin açıklamaları
- Kategori ve ölçü birimlerinin görünen adları
- Tarih, saat, sayı, yüzde ve para gösterimleri
- OCR inceleme ve fiş eşleştirme metinleri
- Sesli giriş metinleri ve örnekleri
- Erişilebilirlik etiketleri
- Bildirim ve hatırlatmalar
- Dışa aktarılan raporlardaki başlıklar

Kanonik değerleri çevrilmiş metin olarak veri tabanına kaydetme. Örneğin birim `kilogram`, durum `completed`, para birimi `TRY` gibi kararlı kodlarla saklansın; kullanıcıya yerelleştirilmiş karşılığı gösterilsin.

## 4. Ürünün amacı

NShoptor, klasik bir alışveriş listesi değil; alışveriş planını gerçek harcamayla karşılaştıran, offline-first çalışan bir bütçe ve alışveriş yardımcısıdır.

Kullanıcı:

1. Alışverişten önce ürün, miktar ve tahmini fiyatları girer.
2. Planlanan toplamı ve bütçeye göre durumunu görür.
3. Mağazada ürünleri sepete eklerken gerçek miktar ve fiyatları kaydeder.
4. İsterse ürün/raf etiketi fotoğrafı ekler veya fişi tarar.
5. Alışveriş sonunda tahmin ile gerçeği ürün ve liste bazında karşılaştırır.
6. Farkın fiyat değişiminden mi, miktar değişiminden mi, plansız üründen mi kaynaklandığını görür.
7. Sonraki alışverişlerde geçmiş fiyatlardan yararlanır.

Ana değer önerisi:

> Ne kadar harcamayı planlamıştım, gerçekte ne kadar harcadım ve fark neden oluştu?

## 5. Temel ürün ilkeleri

- **Offline-first:** Liste oluşturma, düzenleme, alışveriş modu, hesaplamalar, geçmiş ve raporlar internet olmadan çalışmalı.
- **Hesapsız kullanım:** İlk açılışta üyelik veya giriş zorunlu olmamalı.
- **Hızlı giriş:** Yazı, geçmiş ürün önerisi, ses ve fotoğraf yardımcıları sunulmalı.
- **Doğrulanabilir otomasyon:** OCR ve konuşma tanıma her zaman düzenlenebilir önizlemeye gitmeli.
- **Gizlilik:** Fişler, ürün fotoğrafları ve alışveriş verileri varsayılan olarak cihazda kalmalı.
- **Açıklanabilir karşılaştırma:** Toplam fark gösterilmekle kalmamalı; fiyat, miktar, indirim, alınmayan ve plansız ürün etkileri ayrılmalı.
- **Tek elle mağaza kullanımı:** Alışveriş modu büyük dokunma hedefleri ve az adımla çalışmalı.
- **Erişilebilirlik:** Renk tek bilgi taşıyıcısı olmamalı; ekran okuyucu ve büyük metin desteği sağlanmalı.

## 6. V1 kapsamı

Aşağıdaki özelliklerin tümünü çalışan V1 kapsamına dahil et.

### 6.1 Liste yönetimi

- Birden fazla alışveriş listesi oluşturma
- Başlığı isteğe bağlı bırakabilme
- Başlık boşsa tarih/mağaza üzerinden anlamlı otomatik ad üretme
- Oluşturulma, planlanan alışveriş ve tamamlanma tarihleri
- Mağaza seçme veya yeni mağaza ekleme
- Liste başına tek ISO 4217 para birimi
- İsteğe bağlı bütçe limiti
- Not ve renk/ikon seçimi
- Liste durumları: taslak, planlandı, alışverişte, tamamlandı, arşivlendi
- Listeyi çoğaltma
- Önceki alışverişi yeni plan olarak kopyalama; gerçek fiyatları tahmini fiyat önerisine dönüştürme
- Liste arama, filtreleme, sıralama ve arşivleme
- Silme işleminde onay ve mümkün olduğunda geri alma
- Aktif, tamamlanmış ve arşivlenmiş listeleri ayırma

### 6.2 Ürün planlama

Her planlanan ürün için:

- Ürün adı
- Normalize edilmiş arama adı
- İsteğe bağlı marka/varyant
- Kategori
- İsteğe bağlı mağaza reyonu/sırası
- Planlanan miktar
- Ölçü birimi
- Fiyat giriş tipi: birim fiyat veya satır toplamı
- Planlanan birim fiyat
- Hesaplanan planlanan satır toplamı
- İsteğe bağlı maksimum kabul edilebilir fiyat
- Zorunlu/isteğe bağlı ürün işareti
- Not
- Fotoğraf
- Sıralama değeri

Desteklenen temel birimler:

- adet
- kilogram
- gram
- litre
- mililitre
- paket
- kutu
- şişe
- kavanoz
- demet
- düzine
- metre
- özel birim

Ondalıklı miktarları destekle: `1,5 kg`, `0,25 kg`, `2,75 L` gibi. Adet için varsayılan tam sayı olsa da gerektiğinde ondalık değeri model katmanında engelleme; doğrulama birime göre yapılandırılabilir olsun.

Kullanıcı birim fiyat girerse satır toplamını; satır toplamı girerse mümkünse birim fiyatı hesapla. Hangi alanın kullanıcı tarafından girildiğini kaybetme.

Ürün ekleme deneyimi:

- Yazarken geçmiş ürünlerden öneriler
- Son kullanılan kategori ve birim önerisi
- Son ödenen fiyat ve tarihi
- Aynı mağazadaki son fiyat varsa mağaza bazlı öneri
- Sık alınanlar/favoriler
- Çok satırlı yapıştırma: her satırı ayrı ürün adayına dönüştürme
- Hızlı `+1` adet ve miktar değiştirme kontrolleri
- Yinelenen ürün uyarısı; kullanıcı isterse birleştirebilsin veya ayrı tutabilsin

### 6.3 Kategoriler ve mağaza düzeni

- Meyve-sebze, süt ürünleri, et, fırın, içecek, temizlik, kişisel bakım, ev, diğer gibi başlangıç kategorileri
- Kullanıcının kategori ekleyebilmesi, düzenleyebilmesi ve sıralayabilmesi
- Ürün geçmişine göre kategori önerisi
- Listeyi kategori, alfabetik, özel sıra veya mağaza reyon sırasına göre düzenleme
- Mağaza bazında kategori/reyon sırasını hatırlama
- Otomatik kategori önerisini kesin kabul etmeden kolayca değiştirme

### 6.4 Ana ekran

Ana ekranda:

- `Yeni liste` ana eylemi
- Aktif ve yaklaşan listeler
- Alışverişte olan listeye hızlı devam
- Son tamamlanan listeler
- Bu ay planlanan ve gerçekleşen toplam
- Bu ayki toplam fark/tasarruf
- Yaklaşan alışveriş hatırlatmaları
- Sık kullanılan liste şablonları
- Arama
- Anlamlı boş durumlar

Özet kartları yalnızca yeterli veri varsa göster. Kullanıcıyı boş grafiklerle karşılama.

### 6.5 Alışveriş modu

Tek elle kullanılabilecek, dikkat dağıtmayan ayrı bir mağaza modu tasarla.

Her ürün için durumlar:

- Alınmadı
- Sepette
- Bulunamadı
- Vazgeçildi
- Alternatif ürün alındı

Her satın alım kaydında:

- Gerçek miktar ve birim
- Gerçek birim fiyat veya gerçek satır toplamı
- İndirim
- İade/eksi satır desteği gerekiyorsa kontrollü giriş
- Alternatif ürün adı
- Not ve fotoğraf
- Veri kaynağı: manuel, ses, raf etiketi OCR, fiş OCR
- Kullanıcı tarafından doğrulandı bilgisi

Ekranın üst kısmında sürekli güncellenen bilgiler:

- Planlanan toplam
- Sepetteki gerçek toplam
- Kalan planlı ürünlerin tahmini toplamı
- Tahmini kasa toplamı = sepetteki gerçek + kalan plan
- Bütçe limiti
- Bütçeye kalan veya bütçe aşımı
- Tamamlanan/kalan ürün sayısı

Hızlı filtreler:

- Tümü
- Alınacaklar
- Sepette
- Bulunamayanlar
- Zorunlular
- Kategori/reyon

Alışveriş modunda opsiyonel `ekranı açık tut` seçeneği sun. Kullanıcı ayarlardan varsayılan davranışı değiştirebilsin. Uygulama arka plana gidip geri geldiğinde alışveriş oturumu kaybolmasın.

### 6.6 Plansız ve alınmayan ürünler

- Kullanıcı mağazada listede olmayan bir ürün ekleyebilsin.
- Plansız ürünler gerçek toplama dahil edilsin ve sonuç ekranında ayrı gösterilsin.
- Planlanıp alınmayan ürünler gerçek toplama sıfır olarak zorla yazılmasın; `alınmadı/bulunamadı/vazgeçildi` anlamı korunsun.
- Bütçe karşılaştırması ile tamamlanma karşılaştırmasını ayrı sun.

### 6.7 Sesle ürün ekleme

Konuşma modeli uygulamaya gömülmesin ve kullanıcıdan ayrıca dil modeli indirmesi istenmesin.

Güncel, bakımı devam eden `speech_to_text` paketini veya aynı işi daha güvenilir yapan güncel eşdeğerini değerlendir. Tercih edilen yaklaşım platformun konuşma tanıma hizmetini kullanmaktır:

- Android: cihazın `SpeechRecognizer` hizmeti
- iOS: işletim sisteminin Speech framework'ü

Bu hizmetlerin cihaz, dil paketi, işletim sistemi ve internet bağlantısına bağlı olabileceğini doğru kabul et. Ses çalışmadığında uygulamanın geri kalanı etkilenmemeli.

İzinleri yalnızca kullanıcı mikrofon düğmesine bastığında iste:

- Android mikrofon izni
- iOS konuşma tanıma ve mikrofon izin açıklamaları

Desteklenecek örnekler:

- “Bir buçuk kilo domates, kilosu kırk beş lira”
- “Üç tane süt, tanesi otuz iki lira”
- “İki paket makarna ekle”
- “Yarım kilo elma”
- “Add one and a half kilograms of tomatoes at three euros per kilo”
- “Add three bottles of milk”
- “Two packs of pasta”

Akış:

1. Seçili uygulama diline uygun mevcut speech locale'ini seç.
2. Kısa cümleyi dinle ve metne dönüştür.
3. Metni yerel, deterministik ve test edilebilir kurallarla ürün adı, miktar, birim, fiyat ve para birimi adaylarına ayır.
4. Sonucu düzenlenebilir önizleme formunda göster.
5. Kullanıcı onayladıktan sonra ekle.

Konuşma tanıma sonucu doğrudan kaydedilmesin. Servis yoksa, internet gerekiyorsa veya izin reddedildiyse yerelleştirilmiş hata ve manuel giriş seçeneği göster. V1'de Vosk veya büyük bir offline ASR modeli ekleme.

### 6.8 Ürün ve raf etiketi fotoğrafı

- Kamera veya galeriden görsel ekleme
- Görseli ürün notu/kanıtı olarak saklama
- Uygulama özel dizininde dosya olarak tutma; veritabanına büyük blob koymama
- Görsel silinirse bozuk referans bırakmama
- İsteğe bağlı raf etiketi fiyat okuma

Raf etiketi okuma akışı:

1. Kullanıcı etiketi çeker veya galeriden seçer.
2. Kırpma/döndürme imkânı sunulur.
3. On-device OCR ile metin, sayı ve konum bilgisi çıkarılır.
4. Olası ana fiyat, birim fiyat, ürün adı ve para birimi adayları gösterilir.
5. Kullanıcı doğru fiyatı seçer veya düzeltir.
6. Kullanıcı onayından sonra ürüne uygulanır.

Büyük yazılmış sayıyı körlemesine doğru fiyat kabul etme. Kampanya eski fiyatı, üyelik fiyatı, birim fiyat ve paket fiyatı birlikte bulunabilir.

### 6.9 Fiş tarama ve çevrimdışı OCR

Fiş OCR mümkün olduğu ölçüde cihaz üzerinde ve internetsiz çalışmalıdır.

Teknik yaklaşım:

- Flutter'da güncel `google_mlkit_text_recognition` paketini veya doğrulanmış eşdeğerini kullan.
- Android'de ilk kullanımda ağdan model indirmeye ihtiyaç bırakmayan bundled ML Kit text recognition bağımlılığını seç.
- iOS'ta gerekli OCR modelini uygulamaya statik olarak dahil et.
- Başlangıçta Latin script desteğine odaklan; mimari diğer desteklenen script paketlerini sonradan ekleyebilsin.
- OCR'ı arayüz isolate'ını bloklamayacak biçimde çalıştır.
- OCR nesnelerini ve native kaynakları doğru kapat.

Belge alma akışı:

- Kamera veya galeri
- Uzun fişler için birden fazla fotoğraf ekleyebilme
- Döndürme, kırpma ve perspektif düzeltme
- Okunabilirlik kontrolü; bulanık/karanlık görüntüde yeniden çekme önerisi
- Görüntü boyutunu doğruluğu yok etmeyecek şekilde yönetme

OCR yalnızca metin çıkarır; yapılandırılmış fiş sonucunu garanti etmez. Ayrı bir yerel fiş ayrıştırıcı oluştur:

1. OCR metnini blok, satır, kelime ve bounding box bilgileriyle al.
2. Mağaza adı, tarih/saat, para birimi, ara toplam, indirim, vergi ve genel toplam adaylarını belirle.
3. Ürün satırı, miktar, birim fiyat ve satır toplamı adaylarını çıkar.
4. Tarih, telefon, vergi numarası, kart maskesi, fiş numarası ve toplam gibi ürün olmayan sayıların fiyat sanılmasını azalt.
5. Aynı fişin parçalarını satır konumu ve devamlılığa göre birleştir.
6. Ürün adlarını normalize et; mağaza kodlarını tamamen silmeden kullanıcı alias'larından öğren.
7. Planlanan ürünlerle muhafazakâr fuzzy eşleştirme yap.
8. Her alan ve eşleşme için güven seviyesi üret: yüksek, orta, düşük.
9. Düşük ve orta güvenli sonuçları otomatik kesinleştirme.
10. Çıkarılan satır toplamı ile fiş genel toplamını uzlaştır.

Kullanıcı doğrulama ekranında:

- Fiş görseli ile çıkarılan satırları yan yana veya kolay geçişli göster.
- Mağaza, tarih, para birimi ve toplam düzenlenebilsin.
- Her satır ürün adı, miktar, birim, birim fiyat, satır toplamı ve indirim alanlarına sahip olsun.
- Satır mevcut planlanan ürüne bağlanabilsin.
- Eşleşmeyen satır plansız ürün olarak eklenebilsin veya yok sayılabilsin.
- Yanlış bölünmüş satırlar birleştirilebilsin; birleşmiş satırlar ayrılabilsin.
- Kullanıcı onayı olmadan listeyi değiştirme.
- Fiş toplamı ile kabul edilen satırların toplamı uyuşmuyorsa farkı açıkça göster.

Fiş fotoğrafları ve ham OCR metni varsayılan olarak cihazda kalmalı. Ağ üzerinden OCR/LLM servisine gönderme. Gelecekte bulut tabanlı tarama eklenirse ayrıca ve açık kullanıcı onayı gerektiren opsiyonel özellik olmalıdır; V1 kapsamına dahil etme.

### 6.10 Fiyat hafızası ve ürün geçmişi

Kullanıcı tarafından doğrulanan her gerçek satın alım bir fiyat gözlemi oluştursun:

- Ürün
- Normalize ürün/alias
- Mağaza
- Tarih
- Miktar ve birim
- Ödenen birim fiyat
- Satır toplamı
- Para birimi
- İndirim
- Veri kaynağı

Gösterilecek bilgiler:

- Son ödenen fiyat ve tarih
- Aynı mağazada son ödenen fiyat
- Son N alışverişte minimum, maksimum ve medyan/ortalama fiyat
- Basit fiyat eğilimi
- Hangi mağazada daha ucuz görüldüğü
- Fiyatın eski olabileceğini gösteren tarih

Farklı para birimlerini kur bilgisi olmadan birbirine çevirmeye veya doğrudan karşılaştırmaya çalışma. Farklı ambalaj/miktarları yalnızca ortak temel birime güvenli şekilde dönüştürülebiliyorsa karşılaştır.

### 6.11 Sonuç ve karşılaştırma

Alışveriş tamamlanmadan önce kullanıcıya eksik ve doğrulanmamış kayıtları göster. Tamamlamayı engellemek yerine açıklayıcı uyarı ver.

Özet:

- Planlanan toplam
- Gerçek toplam
- Mutlak fark
- Yüzde fark
- Bütçeye göre durum
- Tasarruf veya fazla harcama
- Plansız ürünlerin toplamı
- Alınmayan ürünlerin planlanan toplamı
- Toplam indirim
- Tahmin doğruluk oranı

Ürün grupları:

- Planlanandan pahalı
- Planlanandan ucuz
- Tahmine yakın
- Planlanıp alınmayan
- Plansız alınan
- Miktarı değişen
- Eşleşmesi doğrulanmamış

Her ürünün detayında:

- Planlanan ve gerçek miktar
- Planlanan ve gerçek birim fiyat
- Planlanan ve gerçek satır toplamı
- Birim fiyat farkı ve yüzdesi
- Miktar farkı
- Satır toplamı farkı
- İndirim etkisi
- Mağaza ve tarih
- Fiyat geçmişine bağlantı

Miktar değişmişse yalnızca satır toplamına bakarak “pahalandı” deme. Birim fiyat değişimini ayrı hesapla.

### 6.12 Geçmiş ve içgörüler

- Tamamlanan alışveriş geçmişi
- Tarih, mağaza, para birimi ve başlığa göre arama/filtreleme
- Aylık planlanan ve gerçekleşen harcama
- Aylık fark/tasarruf
- Kategori bazında harcama
- Mağaza bazında harcama
- En sık alınan ürünler
- En büyük tahmin sapmaları
- Plan dışı harcama toplamı
- Basit fiyat geçmişi grafiği

Grafikler erişilebilir tablo/metin özetiyle desteklensin. Yetersiz veride yanıltıcı trend üretme.

### 6.13 Hatırlatmalar

- Planlanan alışveriş tarihine göre isteğe bağlı yerel bildirim
- Kullanıcının bildirim zamanı seçebilmesi
- Bildirim iznini yalnızca kullanıcı hatırlatma açtığında isteme
- Bildirime dokununca doğru listeyi açma
- Tarih değişince bildirimi güncelleme; liste silinince iptal etme
- Saat dilimi ve yaz saati değişikliklerine dayanıklı olma

Konum tabanlı mağaza hatırlatması V1 kapsamına dahil değildir.

### 6.14 Yedekleme, içe/dışa aktarma

Hesap veya bulut olmadan kullanıcı verisini taşıyabilsin:

- Tam yerel yedek: sürümlenmiş JSON veya uygun taşınabilir format
- Yedeği sistem paylaşım sayfasıyla dışa aktarma
- Yedeği içe aktarmadan önce doğrulama ve özet
- Çakışmada kullanıcıya birleştirme veya ayrı içe aktarma seçeneği
- Bozuk/uyumsuz dosyada veri kaybetmeden hata
- Alışveriş sonucu için CSV dışa aktarma
- İsteğe bağlı paylaşılabilir özet metni

Fotoğrafların yedeğe dahil edilip edilmeyeceğini kullanıcı seçebilsin. Büyük yedek konusunda uyarı göster.

### 6.15 Ayarlar

- Dil: sistem/Türkçe/İngilizce
- Tema: sistem/açık/koyu
- Varsayılan para birimi
- Varsayılan ölçü birimleri
- Yuvarlama/gösterim tercihlerinin güvenli alt kümesi
- Alışveriş modunda ekranı açık tutma
- Sesle giriş hakkında durum ve izin bilgisi
- Kamera/mikrofon/bildirim izinlerine yönlendirme
- Yedekleme ve geri yükleme
- Tüm verileri silme
- Gizlilik bilgisi
- Hakkında: NShoptor, sürüm, Crazy Penguin, lisanslar

## 7. Para, miktar ve hesaplama kuralları

Bu bölüm kritik iş mantığıdır ve kapsamlı test edilmelidir.

### 7.1 Para

- Para birimi ISO 4217 koduyla saklansın: TRY, USD, EUR, JPY, KWD vb.
- Sembol tek başına kimlik değildir; `$` gibi belirsiz sembollerde ISO kodu göster.
- Sistem locale'inden varsayılan para birimi öner fakat kullanıcı değiştirebilsin.
- Her alışveriş listesi tek ana para birimine sahip olsun.
- V1'de döviz kuru veya otomatik para birimi dönüşümü yapma.
- Liste para birimi değiştirildiğinde mevcut rakamları kur dönüşümü yapılmış gibi değiştirme. Kullanıcıya rakamları koruma/sıfırlama etkisini açıkça sor.
- JPY gibi 0, TRY gibi 2, KWD gibi 3 ondalık basamaklı para birimlerini doğru göster.
- Görüntülemede `NumberFormat.currency` benzeri locale-aware formatlama kullan.
- Kullanıcı girişinde yerel virgül/nokta ayracını güvenli biçimde ayrıştır.

Parasal ve ondalıklı hesaplarda `double` kullanma. Denetlenmiş decimal/fixed-point yaklaşımı kullan. Veritabanında:

- Kesinleşmiş bütçe ve satır toplamlarını para biriminin minor unit değeriyle integer olarak,
- Miktar ve birim fiyat gibi ara hassasiyet gerektiren değerleri normalize edilmiş decimal string/fixed scale olarak

saklamayı değerlendir. Seçilen yaklaşımı tek bir para/değer katmanında merkezileştir ve README'de açıkla.

Yuvarlama yalnızca tanımlı sınırda yapılsın. Varsayılan merkezi yuvarlama kuralı belgelenmeli. Her ara çarpımda tekrar tekrar yuvarlama yapma.

### 7.2 Birim dönüşümü

Güvenli dönüşüm grupları:

- Kütle: kg ↔ g
- Hacim: L ↔ ml
- Sayım: adet ↔ düzine yalnızca açık dönüşüm

Paket, kutu, şişe, kavanoz ve özel birimleri içerik miktarı bilinmeden kg/L/adet ile dönüştürme.

Kullanıcı isterse ambalaj içeriği tanımlayabilsin: `1 paket = 500 g` gibi. Bu bilgi ürüne/ambalaj varyantına bağlı olsun ve kullanıcı doğrulaması olmadan genellenmesin.

### 7.3 Formüller

Temel formüller:

```text
plannedLineTotal = plannedQuantity × plannedUnitPrice
actualGrossTotal = actualQuantity × actualUnitPrice
actualLineTotal = actualGrossTotal - lineDiscount
lineVariance = actualLineTotal - plannedLineTotal
lineVariancePercent = plannedLineTotal != 0
  ? lineVariance / plannedLineTotal × 100
  : null
```

Liste düzeyinde:

```text
plannedTotal = tüm planlanan satır toplamları
actualTotal = tüm doğrulanmış satın alım satırları
totalVariance = actualTotal - plannedTotal
projectedCheckoutTotal = purchasedActualTotal + remainingPlannedEstimate
budgetRemaining = budgetLimit - projectedCheckoutTotal
```

Planlanan değer sıfırsa yüzde için sonsuz, NaN veya anlamsız `0%` gösterme; “Hesaplanamaz” göster.

Fiyat etkisi ve miktar etkisini açıklamak için ortak birim mevcutsa:

```text
priceEffect = actualQuantity × (actualUnitPrice - plannedUnitPrice)
quantityEffect = (actualQuantity - plannedQuantity) × plannedUnitPrice
```

İndirim etkisini ayrıca göster. Yuvarlama nedeniyle küçük uzlaştırma farklarını tanımlı toleransla yönet ve gizlice silme.

`Tahmine yakın` eşiğini merkezi ve test edilebilir kural yap. Örneğin kullanıcıya gösterilen varsayılan tolerans yüzde ve küçük mutlak para eşiğinin mantıklı birleşimi olabilir; seçilen davranışı belgeleyip ayarlarda aşırı karmaşa yaratma.

## 8. Veri modeli

Plan ile gerçekleşeni tek kayıtta belirsiz biçimde ezmek yerine ayrıştırılmış, fakat UI'da basit bir model kullan.

Asgari varlıklar:

### ShoppingList

- id
- title nullable
- generatedTitle metadata
- createdAt, updatedAt
- plannedAt, startedAt, completedAt
- storeId nullable
- currencyCode
- budgetMinorUnits nullable
- status
- note
- color/icon metadata
- archivedAt nullable

### PlannedItem

- id, listId
- productId nullable
- name, normalizedName
- brand/variant nullable
- categoryId nullable
- aisleId nullable
- plannedQuantityDecimal
- plannedUnitCode
- pricingInputMode
- plannedUnitPriceDecimal nullable
- plannedLineTotalMinorUnits nullable
- maxAcceptablePrice nullable
- priority/required flag
- note
- sortOrder
- status
- createdAt, updatedAt

### PurchaseEntry

- id, listId
- plannedItemId nullable
- receiptId nullable
- name, normalizedName
- actualQuantityDecimal
- actualUnitCode
- actualUnitPriceDecimal nullable
- grossTotalMinorUnits nullable
- discountMinorUnits
- actualLineTotalMinorUnits
- source enum
- confidence nullable
- userConfirmed
- alternative flag
- note
- createdAt, updatedAt

Bir PlannedItem bir veya birden fazla PurchaseEntry ile eşleşebilsin. PurchaseEntry plansızsa plannedItemId boş olabilir.

### ProductMemory

- id
- canonicalName
- normalizedName
- defaultCategoryId
- defaultUnit
- favorite flag
- useCount
- lastUsedAt

### ProductAlias

- id
- productId
- alias
- normalizedAlias
- storeId nullable
- source

### PriceObservation

- id
- productId/PurchaseEntry bağlantısı
- storeId nullable
- observedAt
- quantity and unit
- normalizedBaseQuantity nullable
- unitPrice
- lineTotal
- discount
- currencyCode
- source

### Store, Category, Aisle

Kullanıcı tarafından düzenlenebilir mağaza, kategori ve reyon sırası verilerini tut.

### Receipt

- id, listId
- image paths
- rawOcrText
- detected/confirmed store
- detected/confirmed date
- detected/confirmed currency
- detected/confirmed total
- parserVersion
- processingStatus
- createdAt

### ReceiptCandidateLine

- id, receiptId
- rawText
- bounding metadata
- parsed fields
- confidence fields
- linkedPlannedItemId nullable
- review status

### Attachment, Reminder, AppSettings

Fotoğraf yolları, hatırlatmalar ve kullanıcı tercihleri ayrı ve yönetilebilir olsun.

Tüm tablolarda migration stratejisi bulunsun. Veritabanı şeması sürümlensin. Silinen ana kayıtların sahipsiz dosya veya çocuk kayıt bırakmaması sağlansın.

## 9. Önerilen ekranlar ve navigasyon

Alt navigasyon mümkün olduğunca sade olsun:

1. Ana Sayfa
2. Listeler
3. Geçmiş
4. Ayarlar

Ana eylemler bağlama göre FAB veya belirgin butonla sunulsun.

Ekranlar:

- Onboarding/ilk kullanım
- Ana sayfa
- Tüm listeler ve filtreler
- Yeni liste/düzenle
- Planlama liste detayı
- Ürün ekle/düzenle
- Sesli ekleme önizlemesi
- Alışveriş modu
- Gerçek fiyat/miktar hızlı giriş alt sayfası
- Fotoğraf/raf etiketi tarama ve doğrulama
- Fiş çekme/seçme
- OCR işleniyor durumu
- Fiş satırları inceleme ve eşleştirme
- Alışveriş tamamlama kontrolü
- Sonuç/karşılaştırma
- Ürün fiyat geçmişi
- Genel geçmiş ve içgörüler
- Mağaza/kategori/reyon yönetimi
- Yedekleme/içe aktarma
- Ayarlar, gizlilik ve hakkında

Derin bağlantı veya bildirim açılışında doğru listeye güvenli navigasyon sağla. Silinmiş hedefte açıklayıcı fallback göster.

## 10. Tasarım sistemi ve UX

Material 3 kullan; ancak varsayılan bileşenleri bilinçsizce dizmek yerine tutarlı bir ürün dili oluştur.

Marka hissi:

- Güvenilir
- Akıllı
- Sakin
- Ekonomik
- Modern
- Finans uygulaması kadar ağır görünmeyen

Renk yaklaşımı:

- Ana marka rengi: modern yeşil/turkuaz ailesi
- Tasarruf/planın altında: yeşil
- Fazla harcama/planın üstünde: kırmızı veya turuncu
- Plana yakın/nötr: mavi veya nötr ton

Renk hiçbir zaman tek bilgi taşıyıcısı olmasın; metin, işaret ve ikonla destekle. Pozitif/negatif anlamı farklı kültürlerde karıştırmayacak etiketler kullan.

Gereksinimler:

- Açık/koyu/sistem teması
- En az WCAG AA düzeyine yaklaşan kontrast
- Dinamik yazı boyutunda taşmayan tasarım
- En az platform önerilerine uygun dokunma hedefleri
- Ekran okuyucu semantiği
- Klavye açıldığında form alanlarının erişilebilir kalması
- Tek elle kullanım
- Kaydırma hareketlerine alternatif görünen eylemler
- Silme için geri alma veya onay
- İşlem sürerken yükleme, başarı ve hata durumu
- Uzun ürün ve mağaza adlarında taşma yönetimi
- RTL diller sonradan eklendiğinde kırılmayacak yön duyarlı layout

Sade animasyonlar kullan; hesaplama veya alışveriş girişini yavaşlatan gösterişli animasyonlar ekleme.

## 11. Teknik mimari

Mimariyi gereksiz katmanlarla büyütme; fakat iş mantığını widget'lardan ayır.

Asgari ayrım:

- Presentation: ekranlar, widget'lar, controller/state
- Domain: para, miktar, hesaplama, eşleştirme ve durum kuralları
- Data: yerel veritabanı, dosya saklama, OCR/speech adaptörleri

Bağımlılıkları arayüz arkasına almak yalnızca test veya platform değişimi için gerçek fayda sağlıyorsa yap.

Teknoloji tercihleri:

- Flutter + Dart null safety
- Material 3
- Resmi Flutter l10n/ARB + intl
- Yerel ilişkisel SQLite çözümü; migration ve transaction desteği zorunlu
- Basit ve öngörülebilir state management; projede mevcut çözüm varsa onu kullan
- Locale-aware para/tarih formatlama
- Decimal/fixed-point hesaplama
- Kamera/galeri için bakımı devam eden minimum paket seti
- On-device ML Kit text recognition
- Sistem konuşma tanımasını kullanan speech-to-text entegrasyonu
- Yerel bildirimler
- Güvenli dosya dizinleri ve sistem paylaşım sayfası

Paket seçimini README'de gerekçelendir. Aynı işi yapan iki paket ekleme. Sırf popüler olduğu için router, DI, codegen veya state paketi ekleme.

Repository yapısı özellik bazlı ve gezinmesi kolay olabilir:

```text
lib/
  app/
  core/
    l10n/
    money/
    quantity/
    theme/
  features/
    lists/
    shopping_mode/
    receipts/
    voice_input/
    history/
    settings/
  data/
test/
integration_test/
docs/
```

Gerçek yapı seçilen mimariye göre değişebilir; boş klasör veya anlamsız katman oluşturma.

## 12. Veri bütünlüğü, gizlilik ve hata yönetimi

- Veritabanı yazmalarında ilgili çoklu değişiklikleri transaction ile yap.
- Uygulama kapanırsa yarım alışveriş verisini kaybetme.
- OCR sırasında hata olursa ham kullanıcı verisini bozma.
- İçe aktarma önce geçici doğrulama yapmalı; başarısız dosya mevcut veriyi değiştirmemeli.
- Fiş ve fotoğrafları kullanıcı izni olmadan internete gönderme.
- Uygulama günlüklerine fiş metni, ürün listesi, tam dosya yolu veya hassas veri yazma.
- Kamera, mikrofon ve bildirim izinlerini bağlam içinde iste.
- İzin reddinde uygulama çalışmaya devam etsin ve manuel alternatif sunsun.
- Tüm verileri sil eyleminde kapsamı açıkla, ikinci onay al ve geride yerel görsel bırakma.
- Kullanıcı tarafından dışa aktarılmış dosyaların artık uygulama kontrolünde olmadığını açıkla.
- İlk sürümde reklam SDK'sı veya davranış takibi ekleme.
- Crash reporting/analytics eklenmesi istenirse gizlilik değerlendirmesi ve kullanıcı tercihi olmadan alışveriş içeriği gönderme.

## 13. Test stratejisi

Non-trivial iş mantığının her biri için en küçük ama anlamlı otomatik kontrolü bırak.

### Birim testleri

- `1,5 kg × 42,90 TRY = 64,35 TRY`
- `3 adet × 19,99 TRY = 59,97 TRY`
- `500 g` ile `0,5 kg` normalizasyonu
- litre/ml dönüşümü
- dönüştürülemeyen paket/kg karşılaştırmasının reddi
- Türkçe `1,5`, İngilizce `1.5` girişi
- binlik ve ondalık ayraç belirsizliği
- JPY 0, TRY 2, KWD 3 ondalık gösterim
- indirimli gerçek toplam
- plan sıfırken yüzde fark
- negatif, sıfır, aşırı büyük ve boş miktar/fiyat doğrulaması
- fiyat etkisi ve miktar etkisi ayrımı
- plansız ürün ve alınmayan ürün toplamları
- yuvarlama sınırları
- farklı para birimlerinin karşılaştırılmaması
- alışveriş projeksiyon toplamı

### Ses ayrıştırıcı testleri

- “Bir buçuk kilo domates, kilosu kırk beş lira”
- “3 süt tanesi 32 lira”
- “yarım kilo elma”
- İngilizce miktar ve birim örnekleri
- Belirsiz fiyatın kullanıcı doğrulamasına bırakılması
- Tanınmayan cümlenin veri kaybı olmadan manuel forma aktarılması

### Fiş ayrıştırıcı testleri

Anonimleştirilmiş fixture metinleri kullan:

- Ürün + fiyat satırı
- Ağırlıklı ürün
- İndirim satırı
- Vergi ve genel toplam
- Ondalık virgül/nokta
- Tarih ve telefonun fiyat sanılmaması
- Çok satıra taşan ürün adı
- Birden fazla olası toplam
- Fiş toplamı uzlaştırma farkı
- Düşük güvenli eşleşmenin otomatik onaylanmaması

### Widget ve entegrasyon testleri

- Liste oluşturma → ürün ekleme → alışverişe başlama → gerçek fiyat girme → tamamlama → sonuç
- Listeyi çoğaltma
- Kamera/mikrofon/bildirim izni reddi
- Uçak modunda temel akış
- Uygulama yeniden başlatıldıktan sonra aktif alışverişe devam
- Dil değiştirme
- Koyu tema ve büyük yazı
- Yedek dışa aktarma ve güvenli içe aktarma
- Bozuk yedek dosyasının mevcut veriyi değiştirmemesi

### Gerçek cihaz doğrulaması

- En az bir Android ve bir iOS cihaz
- Düşük ışıkta fiş
- Uzun fiş
- Kırışık/eğik fiş
- Türkçe karakterli ürünler
- İnternet açık/kapalı ses davranışı
- Uygulamanın ilk kurulumdan sonra OCR'ı uçak modunda çalıştırması
- Düşük bellek ve uygulamanın arka plandan geri dönüşü

## 14. Kabul kriterleri

V1 şu koşullar sağlanmadan tamamlanmış sayılmaz:

- Kullanıcı hesap açmadan iki veya daha fazla liste oluşturabilir.
- Listeye ondalıklı miktar ve tahmini fiyat eklenebilir.
- Planlanan toplam hassas ve yerel para biçiminde gösterilir.
- Alışveriş modunda gerçek fiyat/miktar girilir ve projeksiyon anında güncellenir.
- Plansız ve alınmayan ürünler doğru anlamla işlenir.
- Tamamlama ekranında fiyat ve miktar etkisi ayrıdır.
- Türkçe ve İngilizce bütün ana akışlarda çalışır; slogan dile göre değişir.
- Sesle ekleme platform servisi üzerinden çalışır ve başarısız olduğunda manuel fallback sunar.
- Kullanıcıdan ayrıca konuşma modeli indirmesi istenmez.
- Fiş OCR ilk kurulumdan sonra uçak modunda metin okuyabilir.
- OCR sonuçları kullanıcı doğrulaması olmadan satın alıma dönüşmez.
- Veriler uygulama yeniden başlatılınca korunur.
- Koyu tema, büyük yazı ve ekran okuyucu için temel erişilebilirlik sağlanır.
- Yedek dışa ve içe aktarma veri kaybetmeden çalışır.
- `flutter analyze` temizdir.
- Otomatik testler geçer.
- Android debug/release ve iOS uygun build kontrolleri belgelenmiştir.
- Kritik akışlarda boş veya işlevsiz buton yoktur.

## 15. Aşamalandırma

Geliştirmeyi şu sırayla yap:

### Aşama 1 — Temel ürün

- Marka, tema, l10n
- Veri modeli ve migrations
- Liste/ürün CRUD
- Para/miktar motoru
- Ana sayfa
- Alışveriş modu
- Sonuç karşılaştırması
- Temel testler

### Aşama 2 — Hız ve geçmiş

- Ürün hafızası ve öneriler
- Mağaza/kategori/reyon sırası
- Fiyat geçmişi
- İçgörüler
- Liste çoğaltma/şablon
- Hatırlatmalar
- Yedek ve dışa aktarma

### Aşama 3 — Girdi yardımcıları

- Sistem konuşma tanıma entegrasyonu
- Yerel komut ayrıştırıcı ve doğrulama
- Ürün fotoğrafları
- Raf etiketi OCR
- Fiş OCR proof-of-concept
- Gerçek fişlerle doğruluk ölçümü
- Fiş inceleme/eşleştirme ekranı

### Aşama 4 — Sertleştirme

- Erişilebilirlik
- Performans ve büyük veri seti
- Offline ve izin senaryoları
- Gerçek cihaz testleri
- Gizlilik kontrolü
- Release yapılandırma kontrol listesi

Her aşamanın sonunda çalışan uygulamayı koru. OCR uğruna temel liste ve karşılaştırma işlevini kırma.

## 16. V1 sonrasına bırakılacak özellikler

Aşağıdakileri V1'de geliştirme; yalnızca mimarinin önünü kapatma:

- Crazy Penguin mağaza kimliği kesinleşmeden production application ID/signing
- Zorunlu kullanıcı hesabı
- Bulut senkronizasyonu
- Aile/arkadaşlarla gerçek zamanlı ortak liste
- Web uygulaması
- Market sitelerinden fiyat scraping
- Canlı döviz kuru
- Bulut LLM ile fiş okuma
- Tarif ve öğün planlama
- Kiler/stok ve son kullanma tarihi yönetimi
- Mağaza içi rota optimizasyonu
- Konuma dayalı hatırlatma
- Sadakat kartı ve kupon entegrasyonu
- Apple Watch/Wear OS uygulaması
- Ana ekran widget'ları
- Otomatik ürün kataloğu için üçüncü taraf ticari API
- Reklam veya abonelik sistemi

İkinci aşama ürün yol haritasına aday olarak belgeleyebilirsin:

- Opsiyonel hesap ve şifreli bulut yedeği
- Paylaşılan listeler ve değişiklik geçmişi
- Ana ekran widget'ı
- Barkod okuma; internet olmadan yalnızca kodu okuduğunu, ürün bilgisinin yerel eşleme veya harici katalog gerektirdiğini doğru yönetme
- Tarif/kiler entegrasyonu
- Mağazalar arası normalize birim fiyat karşılaştırması

## 17. Repository ve dokümantasyon teslimatı

Repository adı `nshoptor` olsun ve en az şunları içersin:

```text
README.md
LICENSE
CHANGELOG.md
CONTRIBUTING.md
docs/architecture.md
docs/data-model.md
docs/calculations.md
docs/localization.md
docs/receipt-ocr.md
docs/voice-input.md
docs/privacy.md
docs/release-checklist.md
lib/
test/
integration_test/
pubspec.yaml
```

README başlangıç içeriği:

```markdown
# NShoptor

**Türkçe:** Evdeki hesap çarşıya uyar.  
**English:** Plan at home. Shop as planned.

NShoptor is a multilingual, offline-first shopping planner by Crazy Penguin.
It compares estimated shopping costs with actual quantities and prices.
```

README ve docs içerisinde:

- Ürün amacı ve özellikler
- Kurulum/çalıştırma
- Kullanılan paketlerin gerekçeleri
- Veri ve hesaplama modeli
- Android/iOS izinleri
- Application ID/bundle ID'nin Crazy Penguin bilgileriyle ayrıca sağlanacağı notu
- Yerelleştirme ekleme yöntemi
- OCR'ın çalışma biçimi ve sınırlamaları
- Ses tanımanın platform/internet bağımlılığı
- Test komutları
- Yedek formatı
- Gizlilik yaklaşımı
- Release kontrol listesi

belgelensin.

## 18. Son teslimat biçimi

Çalışmayı bitirdiğinde yalnızca “tamamlandı” deme. Şunları raporla:

1. Uygulanan özelliklerin kısa özeti
2. Ana mimari ve önemli kararlar
3. Eklenen bağımlılıklar ve nedenleri
4. Çalıştırılan analiz/test/build komutları ve sonuçları
5. Gerçek cihazda ayrıca doğrulanması gereken noktalar
6. OCR ve konuşma tanımanın dürüst sınırlamaları
7. Crazy Penguin tarafından daha sonra girilecek mağaza kimliği/signing alanları
8. V1 sonrası yol haritası

Son hedef: Kullanıcı NShoptor ile alışverişten önce gerçekçi bir plan yapabilmeli, mağazada mümkün olan en az dokunuşla gerçekleşen fiyatları kaydedebilmeli ve alışveriş sonunda “evdeki hesap” ile “çarşıdaki hesap” arasındaki farkı güvenilir biçimde anlayabilmelidir.
