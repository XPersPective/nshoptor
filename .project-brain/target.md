# Target Architecture
Status: CONFIRMED

## Goal
"Baştan sona her şeyi kullanıcı dostu, aynı zamanda profesyonel, eksiksiz çalışır hale üretim düzeyine getir. yayına hazır hale getir" (user 2026-10-18).
"Artık Project Brain üzerine yürüyecek işler." (user 2026-10-18).
Önceki onaylı kullanıcı hedefi: "Evdeki Hesap" planlanan/tahmini, "Çarşıdaki Hesap" gerçekleşen fiyat; slogan "Evdeki hesap çarşıya uyar."

## Users and Main Journey
- Evde liste hazırlayan, markette fiyat giren, fiş ekleyen ve geçmiş harcamasını inceleyen kullanıcı.
- Liste oluştur → ürünleri yaz/söyle → fiyatları düzenle/fişten onayla → alışverişi bitir → raporu paylaş/PDF kaydet → yanlış bitirildiyse geri aç.

## Target State
### Lists and prices
- Türkçe i/ı dahil liste adının ilk harfi yazarken ve kaydederken doğru büyür (PB-120).
- Ürüne dokununca iki fiyat boşsa evdeki; diğer tüm durumlarda market fiyatı odaklanır; klavye açılır, mevcut değer korunur (PB-120).
- Market fiyatı var/0 ise tikli; silinince tiksiz; tüm sayaçlar/özetler/restart aynı kuralı kullanır (PB-120). Gösterge boş/dolu dairedir (PB-114).
- Yanlış bitirilen liste verileri kaybetmeden geri açılabilir; fiş onayı listede olmayan ürünleri ekler ve satın alınmış sayar; bitirme ayrı eylemdir (PB-121).
### Voice and receipt
- Uzun konuşma/kısa duraklamada kayıt ürün kaybetmez; kullanıcı kapatabilir; gerçek platform sınırları ölçülür (PB-103/PB-122).
- Miktar/birim/ürün ve toplam-birim fiyat bağlamı ayrılır; belirsiz fiyat kısa doğrulamayla çözülür; market fiyatı ev fiyatından bağımsızdır (PB-122).
- Yerel ayrıştırma ve model çağrısı süreleri ölçülür; gereksiz çağrı/bekleme kaldırılır; fiş/fatura alışveriş tamamlanmadan veya tamamlandıktan sonra güvenle denenir (PB-121/PB-122).
### Brand and help
- Marka, ikon, slogan ve Pro vurgusu sabit yeşildir; yalnız yüzeyler temayı izler (PB-111/PB-112/PB-113).
- İkon açıklamaları, ilk kullanım rehberi ve Ayarlar'dan tekrar açılabilen kısa rehber yerelleştirilir (PB-109/PB-110/PB-118).
### Discover and engagement
- NAppKit platform/dil farkındalığı olan güncellenebilir uygulama kataloğu sağlar; Android Android'i, iOS iOS'u gösterir; çevrimdışı/hata/önbellek davranışı tanımlıdır (PB-123).
- Puanlama/paylaşım mevcut kit politikasını kullanır; hemen/sık çıkmaz, değerlendirdiğini bildiren kullanıcı tekrar zorlanmaz (PB-123).
### Spending and settings
- Genel bakış seçili haftanın/ayın/yılın harcaması ve alışveriş listelerini tutarlarıyla gösterir; dönem → alışveriş → satırlar hiyerarşisi (PB-115/PB-124).
- Grafiklerde para ölçeği/değerler dokunmadan okunur; kategori/ürün ayrıntısı isteğe bağlıdır; takvim ana içeriği sıkıştırmaz (PB-102/PB-115).
- Limitler Ayarlar'da belirlenir; genel bakışta gerçekleşen tutarlar ve belirlenmiş limitler görünür (PB-116/PB-124).
- Alışveriş ve dönem raporları hızlı dışa aktarılır; PDF kaydedilir/paylaşılır; mevcut veri içe aktarma biçimleri açıkça anlatılır (PB-117/PB-124).
- Ayarlar sade gruplar ve hafif kenarlıklarla düzenlenir; örnek veriler tek eylemle yalnız örnek kayıtları siler, kullanıcının verileri korunur (PB-124).
### Monetization and locales
- "Reklam ve abonelik ürün hedefinin parçası" (user 2026-10-16); Free/Pro/Max; lifetime kaldırma ve oranlı yükseltme kanıtlanır (PB-105/PB-106/PB-107/PB-108).
- 71 dilin uygulama metinleri, açıklamaları ve mağaza materyalleri kendi dilinde; üretim hazırlığı bağımsız incelemeyle kanıtlanır (PB-118/PB-125).

## Non-Goals
- Yeni hesap/bulut senkronizasyonu, döviz dönüşümü veya tam mimari yeniden yazımı.
- Bu plan mağazaya yükleme/yayınlama yapmaz; mevcut yayın kayıtları kurtarılabilir arşivde korunur. Yerel mağaza materyali hazırlığı kapsamdadır.
- Kullanıcı onayı olmadan ücretli API, yeni model rotası veya kimlik bilgisi değişikliği yok.

## Riskiest Assumptions
- Cihazdaki ses servisi emülatörde kesintisiz oturum için yeterli mi? Önce mevcut native sınırları ölç; emülatör desteği eksikse gerçek cihaz kanıtını açık bırak.
- NAppKit'in mevcut katalog/prompt API'si gereksinimi karşılıyor mu? Önce yerel paket ve kit deposunu incele; yeni servis eklemeden mevcut yolu kullan.

## Success Conditions
- [machine] Flutter test/analyze ve server test geçer; Android derleme tekrarlanabilir; atlanan testler açıklanır.
- [interaction] Liste → fiyat/fiş → tamamla → rapor → geri aç yolculuğu emülatörde kalıcı veri okumasıyla kanıtlanır.
- [visual] 320/412dp, açık/koyu, 2x yazı ve RTL'de temel ekranlar taşmaz; marka her temada yeşil kalır.
- [accessibility] Etiketler, odak sırası, okunur kontrast ve Android 48dp hedefler doğrulanır.
- [integration] Kit katalog güncellemesi, puanlama politikası, satın alma ve PDF gerçek sınırda kanıtlanır; eksik mağaza/cihaz kanıtı tamamlandı sayılmaz.

## Open Decisions
- Model havuzu: Astra hariç yerel CLI erişim/kota keşfi sürüyor; kullanıcı yalnız Luna keşfini onayladı.
