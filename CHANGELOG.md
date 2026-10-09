# Changelog

## [1.1.4] — 2026-10-09

- Her satırda "Tahmini" ve "Gerçek" etiketleri yazılı (iki etiketli satır)

## [1.1.3] — 2026-10-09

- Liste ve alışveriş ekranında her satırda tahmini ↔ gerçek fiyat ve fark hep görünür
  (ayrıntı ekranına gitmeden); başlıkta toplam tahmini / gerçek / fark
- Gerçek fiyat satırdan girilir: kalem (elle) ya da kamera (raf etiketini şak diye okut);
  yeniden girmek öncekini değiştirir
- Liste kartında bütçe yoksa "0,00" gösterilmez

## [1.1.2] — 2026-10-09

- Cümle/sesle liste önce liste ekranında açılır (fiyatları düzenle, sonra alışverişe başla)
- İlk açılışta varsayılan para birimi cihaz ülkesinden (herkese ₺ değil)
- Sunucu: "2 kg domates 30" gibi ürün sonrası sayı artık fiyat olarak okunur

## [1.1.1] — 2026-10-08

- 71 dil (şablon standardı §3.1): uygulama arayüzü ve para yazımı (ondalık
  virgül/nokta, sembol yeri, rakamlar) dile göre; sağdan sola: ar, fa, he, ur, ps
- Ayarlar'da dil listesi kendi adlarıyla

## [1.1.0] — 2026-10-08

- Yapay zeka (sunucu üzerinden, anahtar uygulamada yok): fiş satırlarını
  listeyle eşleştirme (kullanıcı onaylı), raf etiketinden fiyat, cümleden liste
- Sade planlanan ↔ gerçek tablosu, pahalı/ucuz çıkanlar
- Harcama takvimi, haftalık/aylık grafikler, aylık limit
- Sağ altta kapatılabilir asistan
- Pro/Max abonelikleri (7 gün deneme), ömür boyu reklamsız; ilk 7 gün
  reklamsız, uygulama açılış reklamı, ödüllü reklamla 1 gün reklamsız
- 9 dil: tr, en, de, fr, es, it, pt, ru, ar

## [1.0.0] — geliştirmede

İlk sürüm (V1 kapsamı, spec §6):

- Hesapsız çevrimdışı listeler, ondalıklı miktar ve tahmini fiyat
- Alışveriş modu, plansız / alınmayan ürünler, tahmini kasa toplamı
- Sonuç ekranı: fiyat ve miktar etkisi ayrı
- Fiyat hafızası, fiyat geçmişi, içgörüler, önceki alışverişten plan
- Sesle ürün ekleme, raf etiketinden fiyat, cihazda fiş OCR + inceleme
- Hatırlatmalar: liste başına bildirim (flutter_local_notifications,
  Android 13+ izin akışı; tam alarm izni yoksa toleranslı kip)
- Yedekleme (JSON), CSV dışa aktarma, ayarlar ve tüm verileri silme
- tr/en, koyu tema, erişilebilirlik

### Premium görsel ve ayar sağlamlaştırma (2026-09-29)

- Tema tercihi (Sistem/Açık/Koyu) artık anında uygulanıyor (önceden
  etkisizdi); varsayılan birim ve para birimi tercihleri ürün formuna ve
  yeni listeye gerçekten aktarılıyor
- Birim adları arayüz diline göre görünüyor (tr "adet", en "pc" vb.)
- Material 3 görsel katman: kademeli tipografi, stadium butonlar,
  yumuşak girişler/kartlar, alt sayfa tutamacı, yeni sayfa geçişleri
- Liste detayı: boş-durum metni düzeltildi, FAB erişilebilirlik etiketi
- İlk açılış yerel çözümlemesi belirleyici hale geldi (dil sıçraması yok)
