# Constraints

- C-023: Kullanıcı 2026-10-26: Store Automation kaldırılmıştır; önbellek/yedek kopyası kullanılmaz, geçiş yapılmaz. Geliştirme Project Brain; mağaza yayını Release Harbor. Project Forge yalnız yeni proje başlangıcı içindir. Mevcut yayın yetkisi tekrar sorulmaz; hesap oturumu yoksa somut eksik olarak kaydedilir.
- C-024: Kullanıcının güncel AGENTS.md yönergesi tek ortak Medium_Phone_API_36.0 AVD'sini zorunlu kılar; eski geçici AVD istisnaları kullanılmaz. Başka oturum kullanıyorsa dokunulmaz.

- C-022: Kullanıcı 2026-10-25: Basit işler düşük maliyetli ChatGPT native alt ajanlarına verilebilir; harici CLI/havuz yok. AGENTS.md tek ortak AVD ister. Kullanıcının önceki açık geçici C: AVD izni ve son “hafif bir emülatör başlat” talebi, ortak5554'te oyun çalışırken mevcut task-owned nshoptor_temp_aosp_api36'yı5556'da başlatmak için uygulandı; yeni AVD oluşturulmadı. Bu dar çalışma istisnası dışına çıkılmaz; başka oturumun uygulaması/süreci durdurulmaz veya silinmez. Ayrıntı: references/emulator-stability-2026-10-25.md.

- C-019: Son kullanıcı 2026-10-24: CLI Agent Pool ve harici model/CLI ajanı kullanılmaz; yalnız ChatGPT native alt ajanları sınırlı görevlerle kullanılabilir. Önceki havuz yetkileri bu çalışma için geçersizdir; havuz keşfi/başlatması/onayı istenmez.
- C-020: Yeni ve yarım kalan bütün işlerin tek takip kaynağı Project Brain olur. Yabancı takip dosyaları kapsam/Resume/External aktarımı, kaynak-hedef hash doğrulaması ve geri alınabilir arşivden sonra tam belirtilen yollardan kaldırılır; uygulama, kanıt ve özel yayın dosyaları silinmez.
- C-021: Güncel ayrıntılı kapsam .project-brain/intake-2026-10-24.md N001–N074 ve PB-141..155; özgün kaynak .project-brain/sources/2026-10-24-user-request.txt. Önce kapsam kaydı, ardından uygulama; tamamlanma yalnız taze kanıtla bildirilir.

- C-001: Existing fixed-point/decimal monetary and quantity core stays; do not introduce double arithmetic (source: legacy ADR-001/constraints)
- C-002: SQLite/Drift schema changes require versioned migration and transaction safety (source: legacy C-011)
- C-003: Offline-first, no account/cloud sync, and existing Android-first release setup remain (source: legacy C-002/C-030/C-033)
- C-004: Voice/OCR candidates never mutate shopping lists, purchases or reports before user approval; native voice remains device-local. N012 explicitly authorizes durable pending OCR/media drafts, with no purchase effects or identity reservation until approval (ADR-003; source: legacy C-003/C-005/ADR-006 and user2026-10-24).
- C-005: Existing localization remains ARB/gen-l10n with all locale keys aligned (source: legacy ADR-003)
- C-006: Minimize code/dependencies and reuse existing repositories/controllers (source: user AGENTS.md)

- C-007: Brand icon, NShoptor, slogan and Pro accent stay green regardless of palette (user 2026-10-18).
- C-008: Actual market price presence, including explicit zero, determines purchased state; estimate alone does not (user attachment 2026-10-18).
- C-009: Never use Astra or Antigravity Argon. User authorizes ZCode/MiniMax/Claude strong subscription models, OpenCode free models and other Antigravity models; Luna remains discovery-only. Unknown quotas do not block bounded attempts; handle provider limits and try another approved route. No separately metered paid API (user 2026-10-18).
- C-010: Report only verified completion; preserve open checks and offer reopening completed shopping lists (user 2026-10-18).
- C-011: Keep existing user's untracked build/metadata outputs; no global Flutter configuration changes (source: takeover and legacy SA-018).

- C-012: Kullanıcıya görünen dil nazik ve anlaşılır olsun; YZ ayarı tehlikeli alan içinde bulunmasın (user 2026-10-23).
- C-013: Bildirim ve sunucu için ücretsiz servis/katman seç; ücretli API veya otomatik ücretli yükseltme açma; sağlayıcıların gelecekte kalıcı ücretsiz kalacağını vaat etme (user 2026-10-23).
- C-014: Sohbetin bütün talepleri .project-brain/references/production-master-prompt-tr.md R01–R50 ve görevlerle izlenir; her devralmada açık kanıt/Next/Failing/Dirty ve dış işlem readback korunur (user 2026-10-23).

- C-015: Son kullanıcı sözleşmesi: manuel ve doğal ses fiyatı seçilen miktarın toplamı varsayılanıdır; açık birim bazları ayrıca ele alınır; ev/market bağımsız mod, doğru normalize grafik ve eski veri anlamı korunur (2026-10-23 R54–R60).
- C-016: Güncel karar 2026-10-24: Önceki yalnız aylık yeni satış talebinin yerini yıllık tek Pro alır: vergi hariç yıllık 1 ABD doları temel fiyat, her takvim ayında mevcut Pro 100 YZ isteği, reklamsız kullanım ve JSON yedekleme. Yerel nihai fiyat mağazadan gelir; vergi iki kez eklenmez. Yeni aylık/Max/lifetime satışları kapanır; mevcut ücretli haklar, yenileme sözleşmeleri ve restore iptal edilmez (R71–R74, PB-135..137).
- C-017: Alışveriş tarih+saat isteğe bağlı; liste varsayılan tarih sıralı ve A–Z seçilebilir (2026-10-23 R52–R53).
- C-018: Toplam fiyat varsayılanını ayarlarda yeni seçenekle karmaşıklaştırma. İki fiyat anlamı görünür olsun ve tek dokunuşla seçilsin; fiyat modu için açılır menü açtırma. Ev/market bağımsızlığı, erişilebilirlik ve ekonomik tutar korunur (user 2026-10-23 UX followup).
