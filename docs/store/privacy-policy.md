# Gizlilik Politikası — NShoptor

**Son güncelleme:** 2026-10-10 · **Uygulama:** NShoptor (Crazy Penguin)

*English version below.*

## Verileriniz nerede?

Liste, fiyat, fiş/etiket fotoğrafı ve ayarlar **yalnızca cihazınızda**,
uygulamanın deposunda saklanır. Hesap açmazsınız. İsteğe bağlı AI için
seçtiğiniz metin gönderilir; kota/satın alma ilişkili sunucu kayıtları vardır.

## Yapay zeka yardımı

Fiş satırlarını eşleştirme, raf etiketinden fiyat okuma ve cümleden liste
oluşturma için isteğe bağlı yapay zeka yardımı vardır (Ayarlar → Yapay zeka
yardımı ile kapatılabilir).

- OCR ve Android cihaz içi konuşma tanıma fotoğraf/sesi yüklemez; ağ tanıma fallback'i yoktur. Kurulu model yoksa manuel giriş çalışır.
- AI kullanırken metin, dil, kurulum kimliği ve varsa Play satın alma jetonu Cloudflare vekilimize gider. Qwen sağlayıcısına yalnız görev metni/dil iletilir; kimlik ve Play jetonu iletilmez.
- Worker giriş metnini kalıcı kaydetmez. Sağlayıcının saklama/eğitim uygulamaları için doğrulanmamış garanti vermiyoruz.
- Sunucu kurulum veya doğrulanmış satın alma özetiyle aylık kota, günlük toplam ve plan/sahiplik kayıtları tutar; bunları anonim veri diye nitelemiyoruz.

## Abonelik ve satın almalar

Pro/Max abonelikleri ve tek seferlik "ömür boyu reklamsız" satın alımı
Google Play üzerinden yapılır; ödeme bilgilerinizi biz görmeyiz. Yapay zeka
kotanızı belirlemek için satın alma jetonu Google Play'de doğrulanır;
jeton yalnız doğrulamada geçici işlenir. Sunucuda SHA-256 özeti, plan ve
bağlı jetonların ortak kota sahipliği saklanır. Yetki önbelleği süreli;
sahiplik kayıtları otomatik silinmez, belirlenmiş silme süresi yoktur.

## Reklam

Ücretsiz sürüm Google AdMob reklamları (banner, uygulama açılışı ve isteğe
bağlı ödüllü video) gösterir; ilk 7 gün reklam yoktur. AdMob cihazınız için
reklam/cihaz kimlikleri, IP kaynaklı yaklaşık konum, etkileşim ve tanılama
verilerini işleyebilir. AB/İngiltere'de kişiselleştirilmiş reklam
yalnızca onayınızla gösterilir (https://policies.google.com/privacy).
Pro, Max veya ömür boyu reklamsız hakla reklam gösterilmez; onay/SDK
başlatma işlemlerinin hiç çalışmadığı anlamına gelmez.

## İnternet kullanımı

Uygulama yalnızca şunlar için internete bağlanır: yapay zeka yardımı
(yukarıda), reklamlar, Google Play satın alma işlemleri, "Keşfet"
bölümündeki diğer uygulamalar listesi (GitHub'daki genel bir dosya; kişisel
alışveriş verisi eklenmez; bağlantı bilgileri işlenebilir), mağaza/paylaşım
bağlantıları ve seçtiğiniz bulut dosya sağlayıcısı.

## Haklarınız (KVKK/GDPR)

- **Erişim/taşınabilirlik:** Ayarlar → Yedekleme ile verilerinizi JSON olarak
  dışa aktarabilirsiniz (ücretli planlar).
- **Silme:** Ayarlar → Tüm verileri sil alışveriş veritabanını temizler; paylaşılan tercihler silinmez. Kaldırma uygulama özel deposunu kaldırır. Dışa aktarılan dosyalar ve sunucu kota/sahiplik kayıtları bu işlemlerle silinmez. Sunucu verileriyle ilgili talepler için aşağıdaki e-postaya yazabilirsiniz.
- Reklam kimliğini cihaz ayarlarından sıfırlayabilir/kapatabilirsiniz.

## Çocuklar

NShoptor çocuklara yönelik değildir ve bilerek çocuklardan veri toplamaz.

## İletişim

devcrazypenguin@gmail.com

## Açık kaynak

NShoptor GNU GPL-3.0 lisansıyla açık kaynaktır; yukarıdakilerin tamamı
kaynak kodunda doğrulanabilir: https://github.com/XPersPective/nshoptor

---

# Privacy Policy — NShoptor

**Last updated:** 2026-10-10 · **App:** NShoptor (Crazy Penguin)

## Where is your data?

Lists, prices, receipt/label photos and settings are stored **only on your
device**, in the app's storage. No account registration is required.
Optional AI sends selected text; the backend retains quota/purchase metadata.

## AI help

Optional AI help matches receipt lines, reads prices from shelf labels and
turns a sentence into a list (switch it off in Settings → AI help).

- OCR and Android on-device speech do not upload photos/audio. There is no network recognition fallback; missing installed models leave manual input available.
- AI sends text, locale, install ID and an optional Play purchase token to our Cloudflare proxy. Qwen receives only task text/locale, not the install ID or Play token.
- The Worker does not persist input text. We make no unverified guarantee about the provider's retention or training practices.
- The backend retains monthly installation/purchase-hash quota, daily totals and entitlement/ownership metadata; we do not describe these records as anonymous.

## Subscriptions and purchases

Pro/Max subscriptions and the one-time "ad-free for life" purchase are handled
by Google Play; we never see your payment details. To set your AI allowance the
purchase token is processed transiently for Google verification. The server
retains its SHA-256 hash, plan and linked-token quota ownership. Authorization
cache entries expire; ownership metadata has no scheduled deletion period.

## Ads

The free version shows Google AdMob ads (banner, app open and optional
rewarded video); there are no ads in the first 7 days. AdMob may collect your
advertising/device identifiers, IP-derived approximate location, interactions
and diagnostics. In the EU/UK personalised ads are shown only with your
consent (https://policies.google.com/privacy). Pro, Max and ad-free for life
disable ad display; consent/SDK initialization can still run.

## Internet use

The app connects to the internet only for: AI help (above), ads, Google Play
purchases, the "Discover" list of other apps (a public file on GitHub; no
shopping data is attached; connection metadata may be processed), store/share
links and the cloud file provider you choose for an export.

## Your rights (GDPR)

- **Access/portability:** export your data as JSON in Settings → Backup
  (paid plans).
- **Deletion:** Settings → Delete all data clears the shopping database, not shared preferences. Uninstalling removes app-private storage. Neither removes exported files or backend quota/ownership records. Contact the email below about backend data requests.
- You can reset or turn off your advertising ID in your device settings.

## Children

NShoptor is not directed at children and does not knowingly collect data from
children.

## Contact

devcrazypenguin@gmail.com

## Open source

NShoptor is open source under GNU GPL-3.0; everything above can be checked in
the source code: https://github.com/XPersPective/nshoptor
