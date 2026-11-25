# Gizlilik Politikası — NShoptor

**Son güncelleme:** 2026-10-30 · **Uygulama:** NShoptor (Crazy Penguin)

*English version below.*

## Verileriniz nerede?

Liste, fiyat, fiş/etiket fotoğrafı ve ayarlar **yalnızca cihazınızda**,
uygulamanın deposunda saklanır. Hesap açmazsınız. İsteğe bağlı AI yardımı açıkken
küçültülmüş fiş/etiket fotoğrafları (JPEG) ve seçtiğiniz görev metni yalnızca
okunmak üzere gönderilir; kota ve satın alma doğrulamasıyla ilişkili sunucu kayıtları vardır.

## Yapay zeka yardımı

Fiş ve raf etiketi fotoğraflarını okuma, fiş satırlarını eşleştirme ve cümleden liste
oluşturma için isteğe bağlı yapay zeka yardımı vardır (Ayarlar → Yapay zeka
yardımı ile kapatılabilir).

- Yapay zeka kapalıyken cihaz içi OCR ve desteklenen cihaz içi konuşma tanıma fotoğraf veya sesi karşıya yüklemez; ses hiçbir zaman cihazdan çıkmaz ve ağ üzerinden ses tanıma fallback'i yoktur. Kurulu model yoksa manuel giriş çalışır.
- AI kullanırken küçültülmüş fiş/etiket fotoğrafları (JPEG), görev metni, dil, kurulum kimliği ve varsa mağaza satın alma kanıtı (Google Play jetonu veya desteklenen iOS sürümünde Apple imzalı işlem) HTTPS üzerinden Cloudflare vekilimize gider. Qwen görüntü/metin sağlayıcısına yalnız görev girdisi (küçültülmüş fotoğraf veya metin) ve dil iletilir; kurulum kimliği ve satın alma kanıtı iletilmez.
- Worker gönderilen fotoğrafları ve giriş metnini kalıcı kaydetmez; anında işleyip sonucu döner. Sağlayıcının saklama/eğitim uygulamaları için doğrulanmamış garanti vermiyoruz.
- Sunucu kurulum veya doğrulanmış satın alma özetiyle aylık kota, günlük toplam ve plan/sahiplik kayıtları tutar; bunları anonim veri diye nitelemiyoruz.

## Abonelik ve satın almalar

Yeni yıllık Pro aboneliği (`nshoptor_pro_v2`, geçerli vergiler öncesi baz fiyat yılda 1 ABD doları, ayda 100 yapay zeka isteği) cihazın desteklenen mağazası üzerinden yapılır. Mevcut Pro/Max ve
önceden alınmış ömür boyu reklamsız haklar korunur; ödeme bilgilerinizi biz görmeyiz. Yapay zeka
kotanızı belirlemek için satın alma jetonu Google Play'de doğrulanır;
jeton yalnız doğrulamada geçici işlenir. Sunucuda SHA-256 özeti, plan ve
bağlı jetonların ortak kota sahipliği saklanır. Yetki önbelleği süreli;
sahiplik kayıtları otomatik silinmez, belirlenmiş silme süresi yoktur.
Desteklenen iOS sürümünde Apple imzalı işlem kanıtı sunucuda geçici doğrulanır;
güncel abonelik durumu Apple’dan sorgulanır. Kota kimliği ortam, uygulama ve
orijinal abonelik numarasının SHA-256 özetidir; yenileme veya yeniden kurulum yeni
ücretli kota oluşturmaz. Apple ödeme bilgileri bize verilmez. Bu açıklama App Store
yayınının veya Apple hesabı bağlantısının tamamlandığı anlamına gelmez.

## Reklam

Ücretsiz sürüm Google AdMob reklamları (banner ve isteğe
bağlı ödüllü video) gösterir; ilk 7 gün reklam yoktur. AdMob cihazınız için
reklam/cihaz kimlikleri, IP kaynaklı yaklaşık konum, etkileşim ve tanılama
verilerini işleyebilir. AB/İngiltere'de kişiselleştirilmiş reklam
yalnızca onayınızla gösterilir (https://policies.google.com/privacy).
Pro, Max veya ömür boyu reklamsız hakla reklam gösterilmez; onay/SDK
başlatma işlemlerinin hiç çalışmadığı anlamına gelmez.

## İnternet kullanımı

Uygulama yalnızca şunlar için internete bağlanır: yapay zeka yardımı
(yukarıda), reklamlar, desteklenen Google Play/App Store satın alma işlemleri, "Keşfet"
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

**Last updated:** 2026-10-30 · **App:** NShoptor (Crazy Penguin)

## Where is your data?

Lists, prices, receipt/label photos and settings are stored **only on your
device**, in the app's storage. No account registration is required.
When optional AI help is enabled, reduced-size receipt/label photos (JPEG) and
selected task text are sent only to be read; the backend retains quota and
purchase-verification metadata.

## AI help

Optional AI help reads receipt and shelf-label photos, matches receipt lines and
turns a sentence into a list (switch it off in Settings → AI help).

- When AI help is off, on-device OCR and supported on-device speech do not upload photos or audio; voice audio never leaves the device and there is no network speech fallback. Missing installed models leave manual input available.
- When AI help is used, reduced-size receipt/label photos (JPEG), task text, locale, install ID and optional store purchase proof (a Google Play token or, in supported iOS builds, an Apple-signed transaction) are sent over HTTPS to our Cloudflare proxy. Qwen receives only the task input (reduced-size photo or text) and locale, not the install ID or purchase proof.
- The Worker processes photos and input text transiently and never stores them. We make no unverified guarantee about the provider's retention or training practices.
- The backend retains monthly installation/purchase-hash quota, daily totals and entitlement/ownership metadata; we do not describe these records as anonymous.

## Subscriptions and purchases

New annual Pro subscriptions (`nshoptor_pro_v2`, USD 1/year base price before applicable taxes, 100 AI requests/month) are handled
by the device's supported store; we never see your payment details. Existing Pro/Max and previously
purchased ad-free for life entitlements remain supported. To set your AI allowance the
purchase token is processed transiently for Google verification. The server
retains its SHA-256 hash, plan and linked-token quota ownership. Authorization
cache entries expire; ownership metadata has no scheduled deletion period.
In supported iOS builds the Apple-signed transaction is verified transiently on
the server and current subscription status is queried from Apple. The quota
identity is a SHA-256 hash of environment, app and original subscription ID;
renewal or reinstallation does not create a fresh paid quota. Apple does not
provide us with your payment details. This description does not establish that
an App Store release or Apple account connection has been completed.

## Ads

The free version shows Google AdMob ads (banner and optional
rewarded video); there are no ads in the first 7 days. AdMob may collect your
advertising/device identifiers, IP-derived approximate location, interactions
and diagnostics. In the EU/UK personalised ads are shown only with your
consent (https://policies.google.com/privacy). Pro, Max and ad-free for life
disable ad display; consent/SDK initialization can still run.

## Internet use

The app connects to the internet only for: AI help (above), ads, supported Google Play/App Store
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
