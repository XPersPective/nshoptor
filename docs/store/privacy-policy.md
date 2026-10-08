# Gizlilik Politikası — NShoptor

**Son güncelleme:** 2026-10-08 · **Uygulama:** NShoptor (Crazy Penguin)

*English version below.*

## Verileriniz nerede?

Liste, fiyat, fiş/etiket fotoğrafı ve ayarlar **yalnızca cihazınızda**,
uygulamanın deposunda saklanır. Hesap açmazsınız; sunucumuzda sizinle
ilgili bir profil oluşturulmaz.

## Yapay zeka yardımı

Fiş satırlarını eşleştirme, raf etiketinden fiyat okuma ve cümleden liste
oluşturma için isteğe bağlı yapay zeka yardımı vardır (Ayarlar → Yapay zeka
yardımı ile kapatılabilir).

- **Fotoğraf ve ses cihazdan çıkmaz.** Fotoğraftaki yazı cihaz içinde okunur;
  sesiniz telefonunuzun konuşma tanıma hizmetiyle metne çevrilir (bu hizmeti
  Android/Google sağlar ve kendi koşullarına tabidir).
- Yapay zeka kullandığınızda yalnızca bu **metin** (ör. fiş satırları, ürün
  adları), dil kodu ve rastgele bir kurulum kimliği, Cloudflare üzerinde
  çalışan sunucumuz aracılığıyla bir yapay zeka model sağlayıcısına
  (şu an Alibaba Cloud Model Studio – Qwen) gönderilir.
- Gönderilen metin **saklanmaz**, kaydedilmez, eğitimde kullanılmak üzere
  paylaşılmaz; yanıt uygulamaya döner ve işlem biter.
- Sunucu yalnızca aylık kota sayacını tutar: rastgele kurulum kimliği + ay +
  istek sayısı. Bu kimlik kişisel bilgiyle ilişkilendirilmez.

## Abonelik ve satın almalar

Pro/Max abonelikleri ve tek seferlik "ömür boyu reklamsız" satın alımı
Google Play üzerinden yapılır; ödeme bilgilerinizi biz görmeyiz. Yapay zeka
kotanızı belirlemek için satın alma jetonu Google Play'de doğrulanır;
sunucuda jetonun kendisi değil, yalnızca tek yönlü özeti (SHA-256) ve
planınız kısa süreli önbellekte tutulur.

## Reklam

Ücretsiz sürüm Google AdMob reklamları (banner, uygulama açılışı ve isteğe
bağlı ödüllü video) gösterir; ilk 7 gün reklam yoktur. AdMob cihazınız için
reklam kimliği toplayabilir. AB/İngiltere'de kişiselleştirilmiş reklam
yalnızca onayınızla gösterilir (https://policies.google.com/privacy).
Pro, Max veya ömür boyu reklamsız sürümde reklam kodu çalışmaz.

## İnternet kullanımı

Uygulama yalnızca şunlar için internete bağlanır: yapay zeka yardımı
(yukarıda), reklamlar, Google Play satın alma işlemleri, "Keşfet"
bölümündeki diğer uygulamalar listesi (GitHub'daki genel bir dosya; kişisel
veri gönderilmez) ve mağaza/paylaşım bağlantıları.

## Haklarınız (KVKK/GDPR)

- **Erişim/taşınabilirlik:** Ayarlar → Yedekleme ile verilerinizi JSON olarak
  dışa aktarabilirsiniz (ücretli planlar).
- **Silme:** Uygulamayı kaldırmak tüm verileri siler. Ayarlar → Tüm verileri
  sil de kullanılabilir. Sunucudaki kota sayacı kişisel veri içermez ve
  dönem bitince anlamını yitirir.
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

**Last updated:** 2026-10-08 · **App:** NShoptor (Crazy Penguin)

## Where is your data?

Lists, prices, receipt/label photos and settings are stored **only on your
device**, in the app's storage. There is no account and no profile about you
on our server.

## AI help

Optional AI help matches receipt lines, reads prices from shelf labels and
turns a sentence into a list (switch it off in Settings → AI help).

- **Photos and voice never leave your device.** Text in photos is read on the
  device; your voice is turned into text by your phone's speech recognition
  (provided by Android/Google under its own terms).
- When you use AI, only that **text** (e.g. receipt lines, item names), a
  language code and a random install ID are sent through our server running on
  Cloudflare to an AI model provider (currently Alibaba Cloud Model Studio –
  Qwen).
- The text is **not stored**, not logged and not shared for training; the
  answer goes back to the app and that is the end of it.
- The server keeps only a monthly quota counter: random install ID + month +
  request count. This ID is not linked to any personal information.

## Subscriptions and purchases

Pro/Max subscriptions and the one-time "ad-free for life" purchase are handled
by Google Play; we never see your payment details. To set your AI allowance the
purchase token is verified with Google Play; the server keeps only a one-way
hash (SHA-256) of the token and your plan in a short-lived cache, never the
token itself.

## Ads

The free version shows Google AdMob ads (banner, app open and optional
rewarded video); there are no ads in the first 7 days. AdMob may collect your
device's advertising ID. In the EU/UK personalised ads are shown only with your
consent (https://policies.google.com/privacy). With Pro, Max or ad-free for
life no ad code runs.

## Internet use

The app connects to the internet only for: AI help (above), ads, Google Play
purchases, the "Discover" list of other apps (a public file on GitHub; no
personal data is sent) and store/share links.

## Your rights (GDPR)

- **Access/portability:** export your data as JSON in Settings → Backup
  (paid plans).
- **Deletion:** uninstalling the app deletes all data; Settings → Delete all
  data does the same. The quota counter on the server holds no personal data.
- You can reset or turn off your advertising ID in your device settings.

## Children

NShoptor is not directed at children and does not knowingly collect data from
children.

## Contact

devcrazypenguin@gmail.com

## Open source

NShoptor is open source under GNU GPL-3.0; everything above can be checked in
the source code: https://github.com/XPersPective/nshoptor
