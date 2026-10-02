# Changelog

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
