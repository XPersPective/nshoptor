<!-- project-brain:v1 -->
# PROJECT BRAIN — NShoptor

> **Status:** T29 tamam (büyük veri seti akıcı). Sıradaki iş: T30 (Ayarlar ekranı ve gizlilik).
> **Phase:** BUILD · **Next:** T30 · **Updated:** 2026-09-22 · **Synced@:** af18a2d
> **Goal:** v1 #ee8862af · **Goal status:** CONFIRMED

## 0. PROTOCOL

Binding for every AI working in this repo. Only the user edits §0 and §1. Section headings are machine anchors: never rename them. `brain.py` = `python <project-brain skill dir>/scripts/brain.py`; if unavailable, do its checks by hand.

### 0.1 What this file is
The single source of truth for this project. Chat history is disposable; this file is not. Cycle: **read → work → verify → update this file → commit → next.** If it is not written here, the next model does not know it.

### 0.2 Run loop (never stop early)
1. Session start: read header, §0, §1, §7 → run audit **A1** (§0.4).
2. Loop without pausing: pick task (§0.5) → do it → verify and close it (§0.8) → commit → immediately pick the next one. Never stop to report after a task. Never ask "shall I continue?". Never ask the user anything.
3. A §5 section fully closed → audit **A3**. No open tasks left (ignoring `[!]`) → audit **A4**. Audits that find problems create tasks and the loop continues.
4. Stop only when: **Phase: DONE** (A4 passed), or every remaining open task is `[!]` (then list them in §7). Before any stop: update §7, commit, push.
5. Context getting long is not a reason to stop: everything needed is in this file; after each commit keep only header, §0, §7 and the current task in mind. But if the harness warns the context/session is about to end → reach the next safe point (close or wip-commit the current task, update §7, commit+push). Never lose state mid-task.
6. One active session per project. Foreign commits or a moved `Synced@` = another worker was here: reconcile via A1 deep audit; never overwrite or revert their commits without evidence.

### 0.3 Token discipline (quality is never the trade)
- Read: header, §0, §1, §7 every session; other sections only when needed. Search (grep/glob) before opening files; open line ranges of big files; never re-read what you just wrote.
- Tool output: always filtered/limited (`tail`, `grep`, quiet flags). Never pull lockfiles, logs, build output or generated code into context.
- Batch independent tool calls in parallel.
- Chat: no preamble, no restating the task, no diff recaps; ≤3 lines. Detail belongs in this file.
- This file: terse fragments, `path:symbol` references instead of pasted code, each fact in one place. Exception: task specs (§0.7), audit evidence and revision rationale are explicit, never terse.
- Never write secrets, credentials, tokens or personal data into this file (it is committed and read by future models). Reference env var names only.
- Code: reuse existing code > stdlib > installed dependency > new code. Smallest diff that fixes the root cause. No speculative abstractions.
- Deliberate in proportion to tier: `[L]` act, `[M]` plan briefly, `[H]` think fully. Audits and revisions are always `[H]`.
- Never cut: correctness, running verification, audits, security, input validation, error handling that prevents data loss.

### 0.4 Audits (trust nothing unverified, including your predecessor)
Record every audit as an `AUDIT` row in §6: which audit, what was checked, result, task IDs created. Every finding becomes a task (§0.7) with `Note: from A<n>`.

**A0 — Creation** (right after this file is created, before any build task)
1. `brain.py check` passes with no FAIL; §4 matches reality.
2. Every §3 claim names the code that proves it; open 3 of them and confirm.
3. Traceability: every part of §2 missing or partial in §3 has a `GAP:` line naming task IDs; every acceptance criterion `AC<n>` is served by at least one task.
4. Executability probe: reread the first 5 open tasks as a model with zero chat history (or ask a cheap sub-agent to list what is ambiguous without doing them). Fix every ambiguity.

**A1 — Takeover** (every session start)
1. `brain.py check`; fix FAIL lines first. Its `NEXT:` line tells you what to do.
2. Sample: the last 3 closed tasks (check prints `VERIFY:`). For each: rerun `Done when`, read its diff (`git log --grep "T<id>"` → `git show`), confirm the diff really does what the task said, tests really assert, no debug/TODO leftovers, no unrelated edits.
3. Run the project's full test suite (and build/lint if present) once.
4. **Escalate to deep audit** if any of: a sample or the suite fails · commits outside protocol · map drift · goal hash changed · no previous `AUDIT` row · last closed tasks were done by a weaker model than you on `[M]`/`[H]` work. Deep audit = step 2 for every `[x]` since the last passing A1/A3/A4, plus spot-check §3 against code.
5. Wrong `[x]` → reopen as `[ ]` with `Note: reopened by A1 — <why>`, or add a fix task if other work already builds on it.
6. `Phase: DONE` and nothing new requested → steps 1–3 only; all pass → report done in ≤3 lines and stop.

**A2 — Task close** (every task; part of §0.8)
1. Run `Done when` yourself. A sub-agent's report is not verification.
2. Self-review your full diff: matches `Do`; edge cases and error paths handled; no unrelated edits; no debug/TODO leftovers; tests fail if the code is broken.
3. Tests/lint for the touched area pass (no regressions).
4. `[H]` tasks, security-relevant tasks and tasks done by sub-agents → independent review in a fresh context (sub-agent of at least the executor's tier) if the harness allows; otherwise a second self-review after rereading the task and the relevant §2 part.

**A3 — Milestone** (a §5 section just closed)
Full test suite + build. Compare that area of §3 with §2 in code; delete resolved `GAP:` lines; findings → tasks.

**A4 — Final** (no open tasks except `[!]`) — set `Phase: AUDIT`, then:
1. Clean build, full test suite, lint/typecheck: all pass.
2. Each `AC<n>`: prove it with a command or observable behaviour; tick it in §1 only with that evidence written in the `AUDIT` row.
3. §3 equals §2: no `GAP:` lines; walk §2 component by component and confirm each in code.
4. §1 constraints respected; nothing from "Out of scope" was built.
5. Whole-change review (`git diff <first brain commit>..HEAD`, area by area, fresh context if possible): security, error handling, dead code, duplication, leftover TODO/FIXME/debug, README/docs match reality.
6. `brain.py check` prints `OK`.
Any failure → tasks, `Phase: BUILD`, continue the loop. All pass → `Phase: DONE`, `Next: none`, summary in §7, commit `chore(brain): A4 final audit passed`.

### 0.5 Choosing and doing work
- One task at a time. Next = the `[~]` task if any, else the first `[ ]` in §5 order whose `Needs:` are all `[x]`. Mark it `[~] (claimed YYYY-MM-DD)` before starting.
- Everything must serve §1 and move §3 toward §2. A task that contradicts §1/§2 → do not do it; fix the plan via §0.9.
- Needs a human (credentials, payment, product/legal decision, destructive or irreversible action such as force-push, dropping data, prod deploy) → `[!] <reason>`, continue with the next task.
- Ambiguity → choose the conservative option, log an `ASSUMPTION` row in §6, continue.
- **Goal status: DRAFT** → only goal-independent tasks (map, audit, tests, bugs, build). Never build speculative features.

### 0.6 Discoveries while working (focus rule)
- **Blocks the current task** → add sub-task `T<id>.<n>` under it and do it now.
- **Serves the goal but does not block** → write a complete task (§0.7) under the matching §5 section, then **return to the current task immediately**. Do not start it; no "while I'm here" fixes.
- **Plan itself looks wrong** → finish or safely pause the current task, then apply §0.9.
- **Outside the goal** → one `OUT-OF-SCOPE` row in §6. Not a task.

### 0.7 Task format (write for a weaker model with zero chat history)
```
- [ ] T12 [L] Add Turkish date parser
  - Where: `src/utils/date.py` (new function next to `parse_iso`)
  - Do: 1) add `parse_tr_date(s: str) -> date` for "16.09.2026"; 2) raise `ValueError` on bad input; 3) add cases to `tests/test_date.py`
  - Done when: `pytest tests/test_date.py -q` passes
  - Needs: T11
```
- IDs are permanent: never renumber or reuse. New top-level task = highest ID + 1; sub-task = `T12.1`.
- Status: `[ ]` open · `[~]` in progress · `[x]` done · `[!]` blocked (reason) · `[-]` dropped (reason, e.g. `superseded by R2`).
- Tier: `[L]` mechanical, fully specified, no judgment · `[M]` clear spec, normal engineering · `[H]` design, ambiguity, security, audits, writing specs for others.
- `Where`, `Do`, `Done when` are mandatory for open tasks. Exact paths, symbol names, commands, expected output. Forbidden vague words: "etc.", "improve", "clean up", "as discussed", "handle properly". Cannot be that precise → tag `[H]` or split.
- `Done when` must be objectively checkable and must include a test or check that fails if the work is wrong.

### 0.8 Closing a task (all steps, one commit)
1. Audit A2 (§0.4). Fails → not done; fix, or reopen with a `Note:`.
2. Mark `[x] (YYYY-MM-DD, <model name>)`. Delete its `Where`/`Do` lines; keep `Done when`; add `→ <one-line result>` if useful.
3. Behaviour, interfaces, data flow or dependencies changed → update §3 (and its `GAP:` lines). Files added/removed/moved → update §4.
4. Header: Status, Phase, Next, Updated, and `Synced@` = `git rev-parse --short HEAD` taken **before** this commit.
5. Overwrite §7 (≤5 lines).
6. Commit code + this file together: `<type>(T<id>): <summary>` (feat/fix/refactor/test/docs/chore). Push to the current branch if a remote exists. Never force-push, never skip hooks. Push fails → keep the local commit, note it in §7, continue.
- Stopping mid-task → commit `wip(T<id>): <state>`, keep `[~]`, describe exactly what remains in §7.
- A task found broken after closing → reopen per §0.9a and repair with a new commit (`git revert` or smallest fix). Never rewrite history.
- No git → skip commits and git checks; everything else still applies.
- Brain-only commits (audits, revisions, goal changes): `docs(brain): <A<n>|R<n>|G<n>> <summary>`.

### 0.9 Changing the plan
**a) Task spec wrong or incomplete** (no architecture change): open task → edit in place and add `Note: revised YYYY-MM-DD — <why>`. Closed task whose result is wrong → reopen, or add a fix task if later work depends on it.

**b) Target architecture (§2) wrong** — any model may revise it autonomously, only through this gate:
1. Evidence, not taste: show that §2 cannot meet §1, violates a §1 constraint, or is demonstrably worse against §1 (cite files, measurements, docs, failing tests). "I would design it differently" is not evidence.
2. Never changes §1.
3. Reversing an earlier `DECISION`/`REVISION` requires new evidence that the earlier row did not have; cite that row.
4. Smallest revision that fixes the problem.
5. Log a `REVISION` row `R<n>`: problem + evidence, options considered, choice, impact.
6. Impact analysis over **every** task: keep · edit · drop as `[-] superseded by R<n>` · new tasks; closed work that no longer fits → migration/removal tasks.
7. Update §2, §3 `GAP:` lines, header; commit `docs(brain): R<n> <summary>`; continue the loop.

**c) Goal (§1) changed by the user** — in chat, or detected because `brain.py check` reports the goal hash changed:
1. If told in chat, write the new goal into §1 exactly as the user stated it (fill format gaps conservatively, log `ASSUMPTION`s).
2. Log a `GOAL-CHANGE` row `G<n>`: old goal summary → new goal summary. Header: `Goal: v<n+1> #<brain.py goal-hash>`, `Goal status: CONFIRMED`, `Phase: BUILD`.
3. Redesign §2 for the new goal (a REVISION per §0.9b, citing G<n>).
4. Impact analysis over every task as in b.6, including built features the new goal no longer wants (remove only if they conflict with the new goal or its constraints).
5. Run A0 steps 3–4 on the new plan. Commit `docs(brain): G<n> goal change`. Continue the loop.

**d) Goal itself looks flawed** (contradictory, impossible, clearly harmful to the user's intent): never edit §1. Log a `GOAL-CONCERN` row with evidence. Follow the most faithful feasible interpretation (logged as `ASSUMPTION`); tasks that truly cannot be done → `[!]`. Continue everything else.

### 0.10 Keeping this file small
When this file exceeds ~500 lines: move fully completed §5 sections to `PROJECT_BRAIN.archive.md` (append, dated) and leave one line `- [x] T1–T9 <section> → archive`. Move superseded §6 rows there too. Never archive open tasks, active decisions or the latest AUDIT row.

## 1. GOAL

NShoptor: Crazy Penguin'in çok dilli (tr/en), offline-first, hesapsız **alışveriş planlama ve bütçe karşılaştırma** uygulaması. Kullanıcı alışverişten önce ürün/miktar/tahmini fiyat girerek planlar ve bütçe durumunu görür; mağazada gerçek miktar/fiyatları kaydeder (elle; opsiyonel ses, raf etiketi ve fiş OCR — her zaman düzenlenebilir doğrulama ekranıyla); alışveriş sonunda tahmin-gerçek farkını **fiyat / miktar / plansız ürün etkileri ayrışmış** biçimde görür; geçmiş fiyat gözlemleri sonraki planları besler. Tam spesifikasyon: `docs/spec/master-prompt-tr.md` (bağlayıcı; bölüm numaralarıyla atıf yapılır).

**Acceptance criteria** (kaynak: spec §14)
- [ ] AC1 `flutter analyze` 0 issue; `flutter test` tamamı geçer
- [ ] AC2 Hesapsız ≥2 liste; ondalıklı miktar+tahmini fiyat; planlanan toplam locale-aware para biçiminde gösterilir
- [ ] AC3 Alışveriş modunda gerçek fiyat/miktar girişi projeksiyonu anında günceller; plansız ve alınmayan ürünler doğru anlamla işlenir (alınmayan ≠ 0 TL)
- [ ] AC4 Tamamlama ekranında fiyat etkisi ile miktar etkisi ayrı satırlarda gösterilir
- [ ] AC5 tr/en tüm ana akışlarda çalışır; slogan seçili dile göre değişir
- [ ] AC6 Sesle ekleme platform konuşma servisi üzerinden çalışır; başarısızken manuel fallback; kullanıcıdan model indirmesi istenmez
- [ ] AC7 Fiş OCR ilk kurulumdan sonra uçak modunda metin okur; OCR sonucu kullanıcı onayı olmadan satın alıma dönüşmez
- [ ] AC8 Veri uygulama yeniden başlatmada korunur; yedek dışa/içe aktarma veri kaybetmeden çalışır
- [ ] AC9 Koyu tema, büyük yazı, ekran okuyucu için temel erişilebilirlik sağlanır
- [ ] AC10 Kritik akışlarda boş/işlevsiz buton yok; Android debug/release + iOS build kontrolleri belgelenmiştir
- [ ] AC11 Parasal/ondalıklı hesaplarda `double` yoktur; merkezi para/değer katmanı testlerle kanıtlanır

**Constraints:** Flutter stable (3.47.x) + Dart null safety; Material 3; resmi l10n/ARB+intl; SQLite migration+transaction zorunlu; decimal/fixed-point para; offline-first; gizlilik (fiş/foto/veri cihazda kalır, ağa gönderilmez); gereksiz bağımlılık/soyutlama yok, paketler bakım/lisans/platform kontrolüyle seçilir ve README'de gerekçelendirilir; Android app id / iOS bundle id placeholder `com.example.nshoptor` (production kimliği Crazy Penguin sağlayacak); lisans GPL-3.0.
**Out of scope:** spec §16'daki tam liste (hesap zorunluluğu, bulut senkron, ortak liste, web, scraping, canlı kur, bulut LLM OCR, tarif/kiler, rota optimizasyonu, konum hatırlatması, sadakat/kupon, watch, ana ekran widget'ı, ticari katalog API'si, reklam/abonelik) + production signing kimliği.
**Open questions:** none

## 2. TARGET ARCHITECTURE

Flutter (android+ios), feature-first yapı (spec §11):

```text
nshoptor/
  .github/workflows/ci.yml          # tek-app CI: analyze+test, gitleaks, release APK (T2)
  android/                          # Flutter Android kabuğu (T1)
    app/src/**                      # manifest (cleartext yok, backup rules), ikonlar, MainActivity
    app/build.gradle.kts            # key.properties + R8 minify/shrink release (T1)
    app/proguard-rules.pro          # R8 keep kuralları (T1)
    gradle/wrapper/**               # gradle wrapper (T1)
    build.gradle.kts  settings.gradle.kts  gradle.properties  # kök gradle (T1)
    key.properties.example          # imza/admob yer tutucu
  assets/brand/example_source_icon.png  # ikon kaynağı (placeholder; gerçek logo CP'ten)
  docs/spec/master-prompt-tr.md     # tam ürün spesifikasyonu (bağlayıcı hedef kaynağı)
  ios/                              # Flutter iOS kabuğu (T1)
    Flutter/                        # xcconfig + AppFrameworkInfo.plist
    Runner/**                       # AppDelegate, Info.plist (NShoptor adı), ikonlar
    Runner.xcodeproj/**  Runner.xcworkspace/**  RunnerTests/**  # Xcode projesi
  lib/
    app/                            # NShoptorApp kökü + LanguageController (T6)
    core/calc/**                    # LineCalc, EffectSplit, ListCalc, VarianceThreshold (T5)
    core/l10n/**                    # tr/en ARB + üretilmiş AppLocalizations (T6)
    core/money/**                   # Currency, DecimalFixed, Money, MoneyParser, formatMoney (T3)
    core/quantity/**                # UnitCode, UnitConversion, PackagingContent (T4)
    core/theme/**                   # AppTheme (M3) + SemanticDelta (T7)
    data/db/**                      # drift şeması v1 + AppDatabase + üretilmiş kod (T8)
    features/lists/**               # ListStatus, ListRepository, ListsScreen, ItemFormSheet (T9-T10)
    features/shopping_mode/**       # ItemStatus, ShoppingRepository, ShoppingModeScreen (T11)
    features/shopping_mode/summary/**  # ResultRepository + SummaryScreen (T12)
    features/home/**                # HomeShell (4 sekme) + HomeScreen + HomeRepository (T13)
    features/lists/suggestions/**   # ProductMemoryRepository, paste_parser (T15)
    features/lists/taxonomy/**      # TaxonomyRepository, sortItems, CategorySuggester (T16)
    features/lists/templates/**     # TemplateRepository (gerçek alımdan plan) (T19)
    features/lists/reminders/**     # ReminderScheduler soyutlaması + RemindersRepository (T20)
    features/history/price_history/**  # PriceHistoryRepository + istatistikler (T17)
    features/history/insights/**    # InsightsRepository (aylık/kategori/mağaza/sapma) (T18)
    features/voice_input/**         # SpeechService soyutlaması + VoiceInputController (T22)
    features/lists/attachments/**   # AttachmentRepository (dosya saklama + temizlik) (T24)
    features/receipts/**            # OcrTextSource, MlKitTextSource, ShelfPriceExtractor (T25)
    features/receipts/parser/**     # ReceiptParser + ReceiptMatcher (T26)
    core/util/**                    # normalizeName, combineLatest3
    core/util/**                    # combineLatest3 (T11)
    main.dart                       # boot: SettingsStore + LanguageController + runApp
  test/
    app_test.dart                   # slogan widget testleri (T6)
    core/**                         # çekirdek testleri: money 40, quantity 12, calc 21, theme 5
    data/app_database_test.dart     # şema/migration/transaction/FK: 10 (T8)
  tool/new_app.dart                 # kurulum betiği (yeniden kullanılabilir)
  tool/brand/generate_icons.py      # ikon üretici
  tool/templates/**                 # main/app_test şablonları
  .env.example  AGENTS.md  analysis_options.yaml  l10n.yaml  LICENSE  PROJECT_BRAIN.md  pubspec.yaml  pubspec.lock  README.md  

- **Domain kuralları** core/{money,quantity,calc} içinde, widget'lardan bağımsız, tamamen testli.
- **Veri modeli** spec §8 varlıkları (ShoppingList, PlannedItem, PurchaseEntry, ProductMemory, ProductAlias, PriceObservation, Store, Category, Aisle, Receipt, ReceiptCandidateLine, Attachment, Reminder, AppSettings); kanonik değerler kod olarak saklanır, görünen adlar l10n'dan gelir; fotoğraflar app özel dizinde dosya, DB'de yalnız yol.
- **State:** basit ve öngörülebilir (provider/riverpod/value-notifier; bootstrap'ta kararlaştırılır).
- **Girdi yardımcıları:** speech_to_text (platform servisi), google_mlkit_text_recognition (bundled Latin, internetsiz), deterministik yerel ses komut ayrıştırıcısı, güven seviyeli fiş ayrıştırıcı — hepsi doğrulama ekranı arkasında.
- **Bildirim:** yerel bildirimler (hatırlatmalar). **Yedek:** sürümlenmiş JSON + CSV sonuç dışa aktarma.
- **Platform sertleştirme** (tool/new_app.dart'tan): cleartext yok, yedekleme kuralları, R8 release, key.properties imzası.

## 3. CURRENT ARCHITECTURE

Flutter projesi T1 ile kuruldu (napp_app_template'in new_app.dart akışı + elle tamamlanan şablon adımları; ads=pro=kapalı, data=local):

- `lib/main.dart` — napp_core `NappApp` iskeleti: AppIdentity(NShoptor, com.example.nshoptor), AppTheme açık/koyu, tr/en destekli locale delegeleri, tek-sekme HomePage
- `test/app_test.dart` — kurulum smoke testi; `test/widget_test.dart` silindi
- `pubspec.yaml` — napp_core (git, core-v1.0.0) + flutter_localizations; napp_pro/napp_ads yok
- `android/` — usesCleartextTraffic=false, data_extraction_rules/backup_rules, R8 minify+shrink release, proguard-rules.pro, kotlin.incremental=false, label=NShoptor, üretilmiş uyarlanabilir ikonlar
- `ios/` — CFBundleDisplayName=NShoptor, üretilmiş ikonlar
- `tool/new_app.dart` — kurulum betiği (2 lint düzeltmesi alındı); yeniden kullanılabilir
- `.github/workflows/ci.yml` — tek-app CI (T2): analyze+test, gitleaks, release APK derleme
- Doğrulanmış: `flutter analyze` 0 issue; `flutter test` geçer; `flutter build apk --release` 44 MB başarılı (R8 tree-shaking log kanıtı)
- `README.md` — NShoptor kimliği (kullanıcı), app id placeholder'ı belgeli
- `AGENTS.md` — protokol işaretçisi satırı içeriyor
- `.gitignore/.gitattributes/.gitleaks.toml/.zcodeignore/.env.example/android/key.properties.example` — şablon altyapısı (+`.idea/` ignore)

GAP: yedek yok → T21 (hatırlatma OS bağlantısı T31/T32)
GAP: ses önizleme + fiş inceleme ekranı UI bağlantısı → T30. Aşama 3 mantığı tamam.
GAP: sertleştirme (a11y, perf, ayarlar/gizlilik, docs, kabul) yok → T28-T32

## 4. FILE MAP

```text
nshoptor/
  .github/workflows/ci.yml        # CI — kırık, T2'de tek-app'e uyarlanır
  android/                        # Flutter Android kabuğu (T1)
    app/src/**                    # manifest, res (ikonlar, backup rules), MainActivity
    app/build.gradle.kts          # key.properties + R8 release (T1)
    app/proguard-rules.pro        # WorkManager/Room keep (T1)
    build.gradle.kts  settings.gradle.kts  gradle.properties   # kök gradle (T1)
    gradle/wrapper/**             # gradle wrapper (T1)
    key.properties.example        # imza/admob yer tutucu
  ios/                            # Flutter iOS kabuğu (T1)
    Flutter/**                    # xcconfig + AppFrameworkInfo.plist
    Runner/**                     # AppDelegate, Info.plist, ikonlar, storyboard
    Runner.xcodeproj/**  Runner.xcworkspace/**  RunnerTests/**
  lib/
    main.dart                     # napp_core NappApp iskeleti (T1)
    core/money/**                 # Currency, DecimalFixed, Money, MoneyParser, formatMoney (T3)
    core/quantity/**              # UnitCode, UnitConversion, PackagingContent (T4)
    core/calc/**                  # LineCalc, EffectSplit, ListCalc, VarianceThreshold (T5)
    core/l10n/**                  # ARB dosyaları + generated AppLocalizations (T6)
    core/theme/**                 # AppTheme (M3, açık/koyu) + SemanticDelta (T7)
  app/**                          # NShoptorApp kökü + LanguageController (T6)
  data/db/app_database.dart       # drift şeması v1 + AppDatabase (T8; .g.dart üretilmiş)
  test/
    app_test.dart                 # kurulum smoke testi (T1)
    data/app_database_test.dart   # şema/migration/transaction/FK testleri: 10 (T8)
    core/money/**                 # para katmanı testleri: 40 test (T3)
    core/quantity/**              # birim katmanı testleri: 12 test (T4)
    core/calc/**                  # hesap motoru testleri: 21 test (T5)
    core/theme/**                 # tema testleri: 5 test, WCAG kontrast (T7)
  pubspec.yaml  pubspec.lock  analysis_options.yaml  .metadata  l10n.yaml  # proje yapılandırması
  assets/brand/example_source_icon.png  # ikon kaynağı (placeholder; gerçek logo Crazy Penguin'ten)
  tool/new_app.dart                # kurulum betiği
  tool/brand/generate_icons.py     # ikon üretici
  tool/templates/**                # main/app_test şablonları
  docs/spec/master-prompt-tr.md    # tam ürün spesifikasyonu (hedefin kaynağı, bağlayıcı)
  .env.example                     # dart-define gizli değer notu
  AGENTS.md                        # protokol işaretçisi
  LICENSE                          # GPL-3.0
  PROJECT_BRAIN.md                 # bu dosya
  README.md                        # NShoptor kimliği
```
(gizli: .gitignore/.gitattributes/.gitleaks.toml/.zcodeignore)

## 5. TASKS

### Aşama 0 — Bootstrap
- [x] T1 [H] (2026-09-20, GLM-5.3-Flash) Flutter projesini oluştur (spec §1-2: mevcut repo yeniden kullanım)
  - Done when: `flutter analyze` 0 issue; `flutter test` geçer; `flutter build apk --debug` başarılı; `grep -r "TODO" lib/` boş. iOS build Windows'ta doğrulanamaz → README'ye not (T31 kapsamında tamamlanır).
  - → new_app.dart ile kuruldu (stdin-prompt çökmesi sonrası kalan adımlar birebir elle uygulandı); analyze 0 issue, test geçti, TODO yok; debug build kullanıcı tarafından iptal edildi — daha sıkı olan release APK (44 MB, R8) derlendi; A2 bağımsız inceleme 8/8 PASS
  - Needs: —
- [x] T2 [M] (2026-09-20, GLM-5.3-Flash) CI'yi tek uygulamaya uyarla
  - Done when: `grep -nE "melos|examples/|check_apk" .github/workflows/ci.yml` boş; YAML geçerli (`python -c "import yaml,sys; yaml.safe_load(open(sys.argv[1]))" .github/workflows/ci.yml`; PyYAML yoksa önce `pip install pyyaml`).
  - → Üç iş kaldı: analyze_and_test (pub get/analyze --fatal-infos/test), gitleaks, build_verify (java 17 + release APK + boyut özeti); YAML OK, eski referans yok
  - Done when: `grep -nE "melos|examples/|check_apk" .github/workflows/ci.yml` boş; YAML geçerli (`python -c "import yaml,sys; yaml.safe_load(open(sys.argv[1]))" .github/workflows/ci.yml`; PyYAML yoksa önce `pip install pyyaml`).
  - Needs: T1

### Aşama 1 — Temel ürün (spec §15 Aşama 1)
- [x] T3 [H] (2026-09-20, GLM-5.3-Flash) core/money para katmanı (spec §7.1)
  - Done when: `flutter test test/core/money/` geçer ve şunları kapsar: `1,5 kg × 42,90 = 64,35`; `3 × 19,99 = 59,97`; JPY/TRY/KWD basamak gösterimi; tr `1,5` ve en `1.5` parse; binlik ayraç belirsizliği; negatif/sıfır/aşırı büyük reddi; farklı para birimi karşılaştırma reddi.
  - → 40 test geçti; Currency (75+ kod tablosu, displaySymbol), DecimalFixed (BigInt unscaled+scale, yarıdan uzağa), Money (minor units, mismatch ArgumentError), MoneyParser (rol bazlı ayraç kuralı + geçerli gruplama), formatMoney (double'sız, intl sembolleri); analyze 0 issue
  - Needs: T1
- [x] T4 [H] (2026-09-20, GLM-5.3-Flash) core/quantity birim katmanı (spec §7.2)
  - Done when: `flutter test test/core/quantity/` geçer ve §13'ün birim testlerini kapsar (500g↔0,5kg, L↔ml, paket↔kg reddi).
  - → 12 test geçti; UnitCode (13 birim, dbCode+boyut ailesi), UnitConversion (kg↔g, L↔ml, adet↔düzine yalnız allowCount ile, UnsupportedConversionError), tryConvertToBase (karşılaştırılamayan → null), PackagingContent (kullanıcı tanımlı içerik)
  - Needs: T1
- [x] T5 [H] (2026-09-20, GLM-5.3-Flash) core/calc varyans motoru (spec §7.3)
  - Done when: `flutter test test/core/calc/` geçer; §13 birim test listesinin hesap kalemlerinin tamamı kapsanır (indirimli toplam, plan sıfırken yüzde null, fiyat/miktar etkisi ayrımı, plansız/alınmayan toplamları, yuvarlama sınırları, projeksiyon).
  - → 21 test geçti (paket toplamı 74); LineCalc + EffectSplit, ListCalc (projeksiyon/bütçe/doğruluk), VarianceThreshold (%10 VEYA 200 minor), ReconciliationTolerance (±2 minor); DecimalFixed dahili ölçek üst sınırı 12'ye çıkarıldı (ara hesaplar için)
  - Needs: T3, T4
- [x] T6 [M] (2026-09-20, GLM-5.3-Flash) l10n iskeleti (spec §3)
  - Done when: `flutter gen-l10n` temiz; widget testi seçili dile göre sloganı değiştirdiğini doğrular (tr/en iki durum).
  - → l10n.yaml (nullable-getter: false) + app_en/app_tr ARB (slogan); LanguageController (system/tr/en, SettingsStore kalıcılığı); NShoptorApp kök bileşeni main.dart'a bağlandı; 2 slogan widget testi (paket 75)
  - Needs: T1
- [x] T7 [M] (2026-09-20, GLM-5.3-Flash) Material 3 marka teması (spec §10)
  - Done when: `flutter analyze` temiz; tema testi açık+koyu için gövde metni kontrastını ≥4.5 hesaplayan birim test geçer (renk luminance hesabıyla).
  - → 5 test geçti (paket 80); AppTheme (fromSeed 0xFF0B8457, 48dp butonlar, esnek tipografi), SemanticDelta (renk+ikon+marker, WCAG AA hesaplanmış palet); NShoptorApp kendi temasına bağlandı
  - Needs: T1
- [x] T8 [H] (2026-09-20, GLM-5.3-Flash) SQLite veri katmanı (spec §8)
  - Done when: `flutter test test/data/` geçer: tablo oluşturma, migration v0→v1, transaction rollback senaryosu, FK cascade testi, decimal string round-trip.
  - → drift 2.35 seçildi (DECISION aşağıda); 14 tablo, FK cascade/set-null, PRAGMA foreign_keys, migration v0→v1; 10 test (paket 90). Not: kod f6385638'de, beyin güncellemesi ayrı commit'e düştü
  - Needs: T3, T4

- [x] T9 [M] (2026-09-20, GLM-5.3-Flash) Liste CRUD ve durum makinesi (spec §6.1)
  - Done when: `flutter test test/features/lists/` geçer (durum geçişleri, otomatik ad, çoğaltma, undo, para birimi değişim diyaloğu tetikleri); widget testi 2 liste oluşturup kalıcılığı doğrular.
  - → 17 test geçti (paket 107); ListStatus geçiş kuralları, ListRepository (çift yazma/undo snapshot), ListsScreen (3 sekme + arama + FAB), düzenleme sayfası (para birimi değişim diyaloğu: koru/sıfırla; locale-aware bütçe girdisi); 32 yeni ARB anahtarı
  - Needs: T6, T7, T8

- [x] T10 [M] (2026-09-20, GLM-5.3-Flash) Ürün planlama formu (spec §6.2)
  - Done when: `flutter test test/features/lists/item_form/` geçer: ondalıklı miktar kaydı, birim fiyat↔satır toplamı dönüşümü iki yönde, geçersiz girişte yerelleştirilmiş hata.
  - → 10 test geçti (paket 117); ItemFormSheet (çift yönlü fiyat önizleme, +1 adımlayıcı, birime göre tam sayı doğrulaması, zorunlu/max fiyat/not), ItemRepository (girilen taraf korunur), StarterCategories (9 kategori seed). Not: yollar item_form/ yerine features/lists/ içinde; build sırasında fırlatan ayrıştırma hatası giderildi (gerçek bug)
  - Needs: T9

- [x] T11 [H] (2026-09-20, GLM-5.3-Flash) Alışveriş modu (spec §6.5-6.6)
  - Done when: `flutter test test/features/shopping_mode/` geçer: projeksiyon hesabı bir girişten sonra beklenen değer, plansız ekleme toplama dahil, durum değişimleri; widget testi yeniden mount'ta (pump+restart pattern'i) oturum korunur.
  - → 9 test geçti (paket 126); ShoppingRepository (5 durum, sepette-geri-al kayıt siler, plansız alım bağlantısız, özet şeridi combineLatest3 ile), ShoppingModeScreen (özet + 5 filtre + hızlı giriş sayfası + wakelock düğmesi + kontrollü iade). wakelock_plus bağımlılığı eklendi; core/util/combine_latest.dart eklendi (rxdart'sız). Ayarlardan varsayılan keepAwake tercihi T30'a
  - Needs: T10

- [ ] T12 [L] Add Turkish date parser
  - Where: `src/utils/date.py` (new function next to `parse_iso`)
  - Do: 1) add `parse_tr_date(s: str) -> date` for "16.09.2026"; 2) raise `ValueError` on bad input; 3) add cases to `tests/test_date.py`
  - Done when: `pytest tests/test_date.py -q` passes
  - Needs: T11
```
- IDs are permanent: never renumber or reuse. New top-level task = highest ID + 1; sub-task = `T12.1`.
- Status: `[ ]` open · `[~]` in progress · `[x]` done · `[!]` blocked (reason) · `[-]` dropped (reason, e.g. `superseded by R2`).
- Tier: `[L]` mechanical, fully specified, no judgment · `[M]` clear spec, normal engineering · `[H]` design, ambiguity, security, audits, writing specs for others.
- `Where`, `Do`, `Done when` are mandatory for open tasks. Exact paths, symbol names, commands, expected output. Forbidden vague words: "etc.", "improve", "clean up", "as discussed", "handle properly". Cannot be that precise → tag `[H]` or split.
- `Done when` must be objectively checkable and must include a test or check that fails if the work is wrong.

### 0.8 Closing a task (all steps, one commit)
1. Audit A2 (§0.4). Fails → not done; fix, or reopen with a `Note:`.
2. Mark `[x] (YYYY-MM-DD, <model name>)`. Delete its `Where`/`Do` lines; keep `Done when`; add `→ <one-line result>` if useful.
3. Behaviour, interfaces, data flow or dependencies changed → update §3 (and its `GAP:` lines). Files added/removed/moved → update §4.
4. Header: Status, Phase, Next, Updated, and `Synced@` = `git rev-parse --short HEAD` taken **before** this commit.
5. Overwrite §7 (≤5 lines).
6. Commit code + this file together: `<type>(T<id>): <summary>` (feat/fix/refactor/test/docs/chore). Push to the current branch if a remote exists. Never force-push, never skip hooks. Push fails → keep the local commit, note it in §7, continue.
- Stopping mid-task → commit `wip(T<id>): <state>`, keep `[~]`, describe exactly what remains in §7.
- A task found broken after closing → reopen per §0.9a and repair with a new commit (`git revert` or smallest fix). Never rewrite history.
- No git → skip commits and git checks; everything else still applies.
- Brain-only commits (audits, revisions, goal changes): `docs(brain): <A<n>|R<n>|G<n>> <summary>`.

### 0.9 Changing the plan
**a) Task spec wrong or incomplete** (no architecture change): open task → edit in place and add `Note: revised YYYY-MM-DD — <why>`. Closed task whose result is wrong → reopen, or add a fix task if later work depends on it.

**b) Target architecture (§2) wrong** — any model may revise it autonomously, only through this gate:
1. Evidence, not taste: show that §2 cannot meet §1, violates a §1 constraint, or is demonstrably worse against §1 (cite files, measurements, docs, failing tests). "I would design it differently" is not evidence.
2. Never changes §1.
3. Reversing an earlier `DECISION`/`REVISION` requires new evidence that the earlier row did not have; cite that row.
4. Smallest revision that fixes the problem.
5. Log a `REVISION` row `R<n>`: problem + evidence, options considered, choice, impact.
6. Impact analysis over **every** task: keep · edit · drop as `[-] superseded by R<n>` · new tasks; closed work that no longer fits → migration/removal tasks.
7. Update §2, §3 `GAP:` lines, header; commit `docs(brain): R<n> <summary>`; continue the loop.

**c) Goal (§1) changed by the user** — in chat, or detected because `brain.py check` reports the goal hash changed:
1. If told in chat, write the new goal into §1 exactly as the user stated it (fill format gaps conservatively, log `ASSUMPTION`s).
2. Log a `GOAL-CHANGE` row `G<n>`: old goal summary → new goal summary. Header: `Goal: v<n+1> #<brain.py goal-hash>`, `Goal status: CONFIRMED`, `Phase: BUILD`.
3. Redesign §2 for the new goal (a REVISION per §0.9b, citing G<n>).
4. Impact analysis over every task as in b.6, including built features the new goal no longer wants (remove only if they conflict with the new goal or its constraints).
5. Run A0 steps 3–4 on the new plan. Commit `docs(brain): G<n> goal change`. Continue the loop.

**d) Goal itself looks flawed** (contradictory, impossible, clearly harmful to the user's intent): never edit §1. Log a `GOAL-CONCERN` row with evidence. Follow the most faithful feasible interpretation (logged as `ASSUMPTION`); tasks that truly cannot be done → `[!]`. Continue everything else.

### 0.10 Keeping this file small
When this file exceeds ~500 lines: move fully completed §5 sections to `PROJECT_BRAIN.archive.md` (append, dated) and leave one line `- [x] T1–T9 <section> → archive`. Move superseded §6 rows there too. Never archive open tasks, active decisions or the latest AUDIT row.

## 1. GOAL

NShoptor: Crazy Penguin'in çok dilli (tr/en), offline-first, hesapsız **alışveriş planlama ve bütçe karşılaştırma** uygulaması. Kullanıcı alışverişten önce ürün/miktar/tahmini fiyat girerek planlar ve bütçe durumunu görür; mağazada gerçek miktar/fiyatları kaydeder (elle; opsiyonel ses, raf etiketi ve fiş OCR — her zaman düzenlenebilir doğrulama ekranıyla); alışveriş sonunda tahmin-gerçek farkını **fiyat / miktar / plansız ürün etkileri ayrışmış** biçimde görür; geçmiş fiyat gözlemleri sonraki planları besler. Tam spesifikasyon: `docs/spec/master-prompt-tr.md` (bağlayıcı; bölüm numaralarıyla atıf yapılır).

**Acceptance criteria** (kaynak: spec §14)
- [ ] AC1 `flutter analyze` 0 issue; `flutter test` tamamı geçer
- [ ] AC2 Hesapsız ≥2 liste; ondalıklı miktar+tahmini fiyat; planlanan toplam locale-aware para biçiminde gösterilir
- [ ] AC3 Alışveriş modunda gerçek fiyat/miktar girişi projeksiyonu anında günceller; plansız ve alınmayan ürünler doğru anlamla işlenir (alınmayan ≠ 0 TL)
- [ ] AC4 Tamamlama ekranında fiyat etkisi ile miktar etkisi ayrı satırlarda gösterilir
- [ ] AC5 tr/en tüm ana akışlarda çalışır; slogan seçili dile göre değişir
- [ ] AC6 Sesle ekleme platform konuşma servisi üzerinden çalışır; başarısızken manuel fallback; kullanıcıdan model indirmesi istenmez
- [ ] AC7 Fiş OCR ilk kurulumdan sonra uçak modunda metin okur; OCR sonucu kullanıcı onayı olmadan satın alıma dönüşmez
- [ ] AC8 Veri uygulama yeniden başlatmada korunur; yedek dışa/içe aktarma veri kaybetmeden çalışır
- [ ] AC9 Koyu tema, büyük yazı, ekran okuyucu için temel erişilebilirlik sağlanır
- [ ] AC10 Kritik akışlarda boş/işlevsiz buton yok; Android debug/release + iOS build kontrolleri belgelenmiştir
- [ ] AC11 Parasal/ondalıklı hesaplarda `double` yoktur; merkezi para/değer katmanı testlerle kanıtlanır

**Constraints:** Flutter stable (3.47.x) + Dart null safety; Material 3; resmi l10n/ARB+intl; SQLite migration+transaction zorunlu; decimal/fixed-point para; offline-first; gizlilik (fiş/foto/veri cihazda kalır, ağa gönderilmez); gereksiz bağımlılık/soyutlama yok, paketler bakım/lisans/platform kontrolüyle seçilir ve README'de gerekçelendirilir; Android app id / iOS bundle id placeholder `com.example.nshoptor` (production kimliği Crazy Penguin sağlayacak); lisans GPL-3.0.
**Out of scope:** spec §16'daki tam liste (hesap zorunluluğu, bulut senkron, ortak liste, web, scraping, canlı kur, bulut LLM OCR, tarif/kiler, rota optimizasyonu, konum hatırlatması, sadakat/kupon, watch, ana ekran widget'ı, ticari katalog API'si, reklam/abonelik) + production signing kimliği.
**Open questions:** none

## 2. TARGET ARCHITECTURE

Flutter (android+ios), feature-first yapı (spec §11):

```text
nshoptor/
  .github/workflows/ci.yml          # tek-app CI: analyze+test, gitleaks, release APK (T2)
  android/                          # Flutter Android kabuğu (T1)
    app/src/**                      # manifest (cleartext yok, backup rules), ikonlar, MainActivity
    app/build.gradle.kts            # key.properties + R8 minify/shrink release (T1)
    app/proguard-rules.pro          # R8 keep kuralları (T1)
    gradle/wrapper/**               # gradle wrapper (T1)
    build.gradle.kts  settings.gradle.kts  gradle.properties  # kök gradle (T1)
    key.properties.example          # imza/admob yer tutucu
  assets/brand/example_source_icon.png  # ikon kaynağı (placeholder; gerçek logo CP'ten)
  docs/spec/master-prompt-tr.md     # tam ürün spesifikasyonu (bağlayıcı hedef kaynağı)
  ios/                              # Flutter iOS kabuğu (T1)
    Flutter/                        # xcconfig + AppFrameworkInfo.plist
    Runner/**                       # AppDelegate, Info.plist (NShoptor adı), ikonlar
    Runner.xcodeproj/**  Runner.xcworkspace/**  RunnerTests/**  # Xcode projesi
  lib/
    app/                            # NShoptorApp kökü + LanguageController (T6)
    core/calc/**                    # LineCalc, EffectSplit, ListCalc, VarianceThreshold (T5)
    core/l10n/**                    # tr/en ARB + üretilmiş AppLocalizations (T6)
    core/money/**                   # Currency, DecimalFixed, Money, MoneyParser, formatMoney (T3)
    core/quantity/**                # UnitCode, UnitConversion, PackagingContent (T4)
    core/theme/**                   # AppTheme (M3) + SemanticDelta (T7)
    data/db/**                      # drift şeması v1 + AppDatabase + üretilmiş kod (T8)
    features/lists/**               # ListStatus, ListRepository, ListsScreen, ItemFormSheet (T9-T10)
    features/shopping_mode/**       # ItemStatus, ShoppingRepository, ShoppingModeScreen (T11)
    features/shopping_mode/summary/**  # ResultRepository + SummaryScreen (T12)
    features/home/**                # HomeShell (4 sekme) + HomeScreen + HomeRepository (T13)
    features/lists/suggestions/**   # ProductMemoryRepository, paste_parser (T15)
    features/lists/taxonomy/**      # TaxonomyRepository, sortItems, CategorySuggester (T16)
    features/lists/templates/**     # TemplateRepository (gerçek alımdan plan) (T19)
    features/lists/reminders/**     # ReminderScheduler soyutlaması + RemindersRepository (T20)
    features/history/price_history/**  # PriceHistoryRepository + istatistikler (T17)
    features/history/insights/**    # InsightsRepository (aylık/kategori/mağaza/sapma) (T18)
    features/voice_input/**         # SpeechService soyutlaması + VoiceInputController (T22)
    features/lists/attachments/**   # AttachmentRepository (dosya saklama + temizlik) (T24)
    features/receipts/**            # OcrTextSource, MlKitTextSource, ShelfPriceExtractor (T25)
    features/receipts/parser/**     # ReceiptParser + ReceiptMatcher (T26)
    core/util/**                    # normalizeName, combineLatest3
    core/util/**                    # combineLatest3 (T11)
    main.dart                       # boot: SettingsStore + LanguageController + runApp
  test/
    app_test.dart                   # slogan widget testleri (T6)
    core/**                         # çekirdek testleri: money 40, quantity 12, calc 21, theme 5
    data/app_database_test.dart     # şema/migration/transaction/FK: 10 (T8)
  tool/new_app.dart                 # kurulum betiği (yeniden kullanılabilir)
  tool/brand/generate_icons.py      # ikon üretici
  tool/templates/**                 # main/app_test şablonları
  .env.example  AGENTS.md  analysis_options.yaml  l10n.yaml  LICENSE  PROJECT_BRAIN.md  pubspec.yaml  pubspec.lock  README.md  

- **Domain kuralları** core/{money,quantity,calc} içinde, widget'lardan bağımsız, tamamen testli.
- **Veri modeli** spec §8 varlıkları (ShoppingList, PlannedItem, PurchaseEntry, ProductMemory, ProductAlias, PriceObservation, Store, Category, Aisle, Receipt, ReceiptCandidateLine, Attachment, Reminder, AppSettings); kanonik değerler kod olarak saklanır, görünen adlar l10n'dan gelir; fotoğraflar app özel dizinde dosya, DB'de yalnız yol.
- **State:** basit ve öngörülebilir (provider/riverpod/value-notifier; bootstrap'ta kararlaştırılır).
- **Girdi yardımcıları:** speech_to_text (platform servisi), google_mlkit_text_recognition (bundled Latin, internetsiz), deterministik yerel ses komut ayrıştırıcısı, güven seviyeli fiş ayrıştırıcı — hepsi doğrulama ekranı arkasında.
- **Bildirim:** yerel bildirimler (hatırlatmalar). **Yedek:** sürümlenmiş JSON + CSV sonuç dışa aktarma.
- **Platform sertleştirme** (tool/new_app.dart'tan): cleartext yok, yedekleme kuralları, R8 release, key.properties imzası.

## 3. CURRENT ARCHITECTURE

Flutter projesi T1 ile kuruldu (napp_app_template'in new_app.dart akışı + elle tamamlanan şablon adımları; ads=pro=kapalı, data=local):

- `lib/main.dart` — napp_core `NappApp` iskeleti: AppIdentity(NShoptor, com.example.nshoptor), AppTheme açık/koyu, tr/en destekli locale delegeleri, tek-sekme HomePage
- `test/app_test.dart` — kurulum smoke testi; `test/widget_test.dart` silindi
- `pubspec.yaml` — napp_core (git, core-v1.0.0) + flutter_localizations; napp_pro/napp_ads yok
- `android/` — usesCleartextTraffic=false, data_extraction_rules/backup_rules, R8 minify+shrink release, proguard-rules.pro, kotlin.incremental=false, label=NShoptor, üretilmiş uyarlanabilir ikonlar
- `ios/` — CFBundleDisplayName=NShoptor, üretilmiş ikonlar
- `tool/new_app.dart` — kurulum betiği (2 lint düzeltmesi alındı); yeniden kullanılabilir
- `.github/workflows/ci.yml` — tek-app CI (T2): analyze+test, gitleaks, release APK derleme
- Doğrulanmış: `flutter analyze` 0 issue; `flutter test` geçer; `flutter build apk --release` 44 MB başarılı (R8 tree-shaking log kanıtı)
- `README.md` — NShoptor kimliği (kullanıcı), app id placeholder'ı belgeli
- `AGENTS.md` — protokol işaretçisi satırı içeriyor
- `.gitignore/.gitattributes/.gitleaks.toml/.zcodeignore/.env.example/android/key.properties.example` — şablon altyapısı (+`.idea/` ignore)

GAP: yedek yok → T21 (hatırlatma OS bağlantısı T31/T32)
GAP: ses önizleme + fiş inceleme ekranı UI bağlantısı → T30. Aşama 3 mantığı tamam.
GAP: sertleştirme (a11y, perf, ayarlar/gizlilik, docs, kabul) yok → T28-T32

## 4. FILE MAP

```text
nshoptor/
  .github/workflows/ci.yml        # CI — kırık, T2'de tek-app'e uyarlanır
  android/                        # Flutter Android kabuğu (T1)
    app/src/**                    # manifest, res (ikonlar, backup rules), MainActivity
    app/build.gradle.kts          # key.properties + R8 release (T1)
    app/proguard-rules.pro        # WorkManager/Room keep (T1)
    build.gradle.kts  settings.gradle.kts  gradle.properties   # kök gradle (T1)
    gradle/wrapper/**             # gradle wrapper (T1)
    key.properties.example        # imza/admob yer tutucu
  ios/                            # Flutter iOS kabuğu (T1)
    Flutter/**                    # xcconfig + AppFrameworkInfo.plist
    Runner/**                     # AppDelegate, Info.plist, ikonlar, storyboard
    Runner.xcodeproj/**  Runner.xcworkspace/**  RunnerTests/**
  lib/
    main.dart                     # napp_core NappApp iskeleti (T1)
    core/money/**                 # Currency, DecimalFixed, Money, MoneyParser, formatMoney (T3)
    core/quantity/**              # UnitCode, UnitConversion, PackagingContent (T4)
    core/calc/**                  # LineCalc, EffectSplit, ListCalc, VarianceThreshold (T5)
    core/l10n/**                  # ARB dosyaları + generated AppLocalizations (T6)
    core/theme/**                 # AppTheme (M3, açık/koyu) + SemanticDelta (T7)
  app/**                          # NShoptorApp kökü + LanguageController (T6)
  data/db/app_database.dart       # drift şeması v1 + AppDatabase (T8; .g.dart üretilmiş)
  test/
    app_test.dart                 # kurulum smoke testi (T1)
    data/app_database_test.dart   # şema/migration/transaction/FK testleri: 10 (T8)
    core/money/**                 # para katmanı testleri: 40 test (T3)
    core/quantity/**              # birim katmanı testleri: 12 test (T4)
    core/calc/**                  # hesap motoru testleri: 21 test (T5)
    core/theme/**                 # tema testleri: 5 test, WCAG kontrast (T7)
  pubspec.yaml  pubspec.lock  analysis_options.yaml  .metadata  l10n.yaml  # proje yapılandırması
  assets/brand/example_source_icon.png  # ikon kaynağı (placeholder; gerçek logo Crazy Penguin'ten)
  tool/new_app.dart                # kurulum betiği
  tool/brand/generate_icons.py     # ikon üretici
  tool/templates/**                # main/app_test şablonları
  docs/spec/master-prompt-tr.md    # tam ürün spesifikasyonu (hedefin kaynağı, bağlayıcı)
  .env.example                     # dart-define gizli değer notu
  AGENTS.md                        # protokol işaretçisi
  LICENSE                          # GPL-3.0
  PROJECT_BRAIN.md                 # bu dosya
  README.md                        # NShoptor kimliği
```
(gizli: .gitignore/.gitattributes/.gitleaks.toml/.zcodeignore)

## 5. TASKS

### Aşama 0 — Bootstrap
- [x] T1 [H] (2026-09-20, GLM-5.3-Flash) Flutter projesini oluştur (spec §1-2: mevcut repo yeniden kullanım)
  - Done when: `flutter analyze` 0 issue; `flutter test` geçer; `flutter build apk --debug` başarılı; `grep -r "TODO" lib/` boş. iOS build Windows'ta doğrulanamaz → README'ye not (T31 kapsamında tamamlanır).
  - → new_app.dart ile kuruldu (stdin-prompt çökmesi sonrası kalan adımlar birebir elle uygulandı); analyze 0 issue, test geçti, TODO yok; debug build kullanıcı tarafından iptal edildi — daha sıkı olan release APK (44 MB, R8) derlendi; A2 bağımsız inceleme 8/8 PASS
  - Needs: —
- [x] T2 [M] (2026-09-20, GLM-5.3-Flash) CI'yi tek uygulamaya uyarla
  - Done when: `grep -nE "melos|examples/|check_apk" .github/workflows/ci.yml` boş; YAML geçerli (`python -c "import yaml,sys; yaml.safe_load(open(sys.argv[1]))" .github/workflows/ci.yml`; PyYAML yoksa önce `pip install pyyaml`).
  - → Üç iş kaldı: analyze_and_test (pub get/analyze --fatal-infos/test), gitleaks, build_verify (java 17 + release APK + boyut özeti); YAML OK, eski referans yok
  - Done when: `grep -nE "melos|examples/|check_apk" .github/workflows/ci.yml` boş; YAML geçerli (`python -c "import yaml,sys; yaml.safe_load(open(sys.argv[1]))" .github/workflows/ci.yml`; PyYAML yoksa önce `pip install pyyaml`).
  - Needs: T1

### Aşama 1 — Temel ürün (spec §15 Aşama 1)
- [x] T3 [H] (2026-09-20, GLM-5.3-Flash) core/money para katmanı (spec §7.1)
  - Done when: `flutter test test/core/money/` geçer ve şunları kapsar: `1,5 kg × 42,90 = 64,35`; `3 × 19,99 = 59,97`; JPY/TRY/KWD basamak gösterimi; tr `1,5` ve en `1.5` parse; binlik ayraç belirsizliği; negatif/sıfır/aşırı büyük reddi; farklı para birimi karşılaştırma reddi.
  - → 40 test geçti; Currency (75+ kod tablosu, displaySymbol), DecimalFixed (BigInt unscaled+scale, yarıdan uzağa), Money (minor units, mismatch ArgumentError), MoneyParser (rol bazlı ayraç kuralı + geçerli gruplama), formatMoney (double'sız, intl sembolleri); analyze 0 issue
  - Needs: T1
- [x] T4 [H] (2026-09-20, GLM-5.3-Flash) core/quantity birim katmanı (spec §7.2)
  - Done when: `flutter test test/core/quantity/` geçer ve §13'ün birim testlerini kapsar (500g↔0,5kg, L↔ml, paket↔kg reddi).
  - → 12 test geçti; UnitCode (13 birim, dbCode+boyut ailesi), UnitConversion (kg↔g, L↔ml, adet↔düzine yalnız allowCount ile, UnsupportedConversionError), tryConvertToBase (karşılaştırılamayan → null), PackagingContent (kullanıcı tanımlı içerik)
  - Needs: T1
- [x] T5 [H] (2026-09-20, GLM-5.3-Flash) core/calc varyans motoru (spec §7.3)
  - Done when: `flutter test test/core/calc/` geçer; §13 birim test listesinin hesap kalemlerinin tamamı kapsanır (indirimli toplam, plan sıfırken yüzde null, fiyat/miktar etkisi ayrımı, plansız/alınmayan toplamları, yuvarlama sınırları, projeksiyon).
  - → 21 test geçti (paket toplamı 74); LineCalc + EffectSplit, ListCalc (projeksiyon/bütçe/doğruluk), VarianceThreshold (%10 VEYA 200 minor), ReconciliationTolerance (±2 minor); DecimalFixed dahili ölçek üst sınırı 12'ye çıkarıldı (ara hesaplar için)
  - Needs: T3, T4
- [x] T6 [M] (2026-09-20, GLM-5.3-Flash) l10n iskeleti (spec §3)
  - Done when: `flutter gen-l10n` temiz; widget testi seçili dile göre sloganı değiştirdiğini doğrular (tr/en iki durum).
  - → l10n.yaml (nullable-getter: false) + app_en/app_tr ARB (slogan); LanguageController (system/tr/en, SettingsStore kalıcılığı); NShoptorApp kök bileşeni main.dart'a bağlandı; 2 slogan widget testi (paket 75)
  - Needs: T1
- [x] T7 [M] (2026-09-20, GLM-5.3-Flash) Material 3 marka teması (spec §10)
  - Done when: `flutter analyze` temiz; tema testi açık+koyu için gövde metni kontrastını ≥4.5 hesaplayan birim test geçer (renk luminance hesabıyla).
  - → 5 test geçti (paket 80); AppTheme (fromSeed 0xFF0B8457, 48dp butonlar, esnek tipografi), SemanticDelta (renk+ikon+marker, WCAG AA hesaplanmış palet); NShoptorApp kendi temasına bağlandı
  - Needs: T1
- [x] T8 [H] (2026-09-20, GLM-5.3-Flash) SQLite veri katmanı (spec §8)
  - Done when: `flutter test test/data/` geçer: tablo oluşturma, migration v0→v1, transaction rollback senaryosu, FK cascade testi, decimal string round-trip.
  - → drift 2.35 seçildi (DECISION aşağıda); 14 tablo, FK cascade/set-null, PRAGMA foreign_keys, migration v0→v1; 10 test (paket 90). Not: kod f6385638'de, beyin güncellemesi ayrı commit'e düştü
  - Needs: T3, T4

- [x] T9 [M] (2026-09-20, GLM-5.3-Flash) Liste CRUD ve durum makinesi (spec §6.1)
  - Done when: `flutter test test/features/lists/` geçer (durum geçişleri, otomatik ad, çoğaltma, undo, para birimi değişim diyaloğu tetikleri); widget testi 2 liste oluşturup kalıcılığı doğrular.
  - → 17 test geçti (paket 107); ListStatus geçiş kuralları, ListRepository (çift yazma/undo snapshot), ListsScreen (3 sekme + arama + FAB), düzenleme sayfası (para birimi değişim diyaloğu: koru/sıfırla; locale-aware bütçe girdisi); 32 yeni ARB anahtarı
  - Needs: T6, T7, T8

- [x] T10 [M] (2026-09-20, GLM-5.3-Flash) Ürün planlama formu (spec §6.2)
  - Done when: `flutter test test/features/lists/item_form/` geçer: ondalıklı miktar kaydı, birim fiyat↔satır toplamı dönüşümü iki yönde, geçersiz girişte yerelleştirilmiş hata.
  - → 10 test geçti (paket 117); ItemFormSheet (çift yönlü fiyat önizleme, +1 adımlayıcı, birime göre tam sayı doğrulaması, zorunlu/max fiyat/not), ItemRepository (girilen taraf korunur), StarterCategories (9 kategori seed). Not: yollar item_form/ yerine features/lists/ içinde; build sırasında fırlatan ayrıştırma hatası giderildi (gerçek bug)
  - Needs: T9

- [ ] T11 [H] Alışveriş modu (spec §6.5-6.6)
  - Where: `lib/features/shopping_mode/`, `test/features/shopping_mode/`
  - Do: 1) Ürün durumları: alınmadı, sepette, bulunamadı, vazgeçildi, alternatif alındı. 2) Satın alım kaydı: gerçek miktar/birim, birim fiyat veya satır toplamı, indirim, kontrollü iade (eksi) girişi, alternatif ad, not; veri kaynağı alanı (manuel; ses/OCR sonraki aşamalarda değerlerle bağlanır) + userConfirmed. 3) Üst özet şeridi: planlanan toplam, sepet gerçek, kalan plan tahmini, tahmini kasa, bütçe kalan/aşım, tamamlanan/kalan sayı — her giriş sonrası anında güncelle. 4) Filtreler: tümü, alınacaklar, sepette, bulunamayanlar, zorunlular, kategori. 5) Plansız ürün ekleme (gerçek toplama dahil, sonuçta ayrı gösterilir). 6) Alınmayanlar gerçeğe 0 zorlanmaz. 7) `ekranı açık tut` opsiyonu (wakelock paketi — bakım kontrolü) + ayarlardan varsayılan. 8) Oturum dayanıklılığı: arka plan/uygulama kapanıp dönünce oturum ve girilen veriler korunur.
  - Done when: `flutter test test/features/shopping_mode/` geçer: projeksiyon hesabı bir girişten sonra beklenen değer, plansız ekleme toplama dahil, durum değişimleri; widget testi yeniden mount'ta (pump+restart pattern) oturum korunur.
  - Needs: T10
- [x] T12 [H] (2026-09-20, GLM-5.3-Flash) Sonuç ve karşılaştırma ekranı (spec §6.11)
  - Done when: `flutter test test/features/shopping_mode/summary/` geçer: örnek senaryoda özet alanları ve gruplama beklenen değerlerle; birim fiyat aynı+miktar artmış → "pahalı" grubunda değil.
  - → 6 test geçti (paket 132); ResultRepository (gruplar, plansız/alınmayan ayrımı, doğruluk oranı — çekirdek LineCalc/ListCalc/VarianceThreshold yeniden kullanımı), SummaryScreen (özet + ürün grup kartları + SemanticDelta renk/ikon). Kritik kural: "pahalandı" yalnız birim fiyat değişmişse; aksi halde close
  - Needs: T11

- [x] T13 [M] (2026-09-20, GLM-5.3-Flash) Ana ekran (spec §6.4)
  - Done when: `flutter test test/features/home/` geçer: boş durum gösterimi, veri varken kartlar, hızlı devam navigasyonu.
  - → 4 test geçti (paket 136); HomeShell (4 sekmeli alt navigasyon, IndexedStack), HomeScreen (aktif listeler, alışverişte hızlı devam, aylık özet kartı — yalnız tamamlanmış alışveriş varken, boş durum + slogan), History/Ayarlar gerçek boş durum; drift_flutter bağımlılığı eklendi (cihaz DB yolu). Hero tag çakışması ve strftime-unixepoch hatası giderildi
  - Needs: T9

- [x] T14 [M] (2026-09-20, GLM-5.3-Flash) Entegrasyon testi: uçtan uca ana akış (spec §13)
  - Done when: `flutter test integration_test/app_e2e_test.dart` geçer.
  - → 3 test geçti; tam akış (liste→ürün→alışveriş→fiyat→sonuç), tr→en slogan, dosya-temelli DB ile yeniden başlatma kalıcılığı. Bulunan boşluk giderildi: liste detay ekranı (ListDetailScreen) eklenmediği için UI zinciri kopuktu → T14.1 olarak bu görev kapsamında tamamlandı. A3 bulgusu → T33
  - Needs: T12

- [x] T14.1 [M] (2026-09-20, GLM-5.3-Flash) Liste detay ekranı (T14 sırasında keşfedilen kopukluk)
  - Done when: Liste kartından detaya geçiş; ürün ekleme; alışverişi başlat; bitir→sonuç; `flutter test test/features/` geçer.
  - → ListDetailScreen (ürünler, ekleme sayfası, başlat/devam/bitir düğmeleri); ListsScreen kart tıklaması detaya bağlı; 136 birim test aynı pakette yeşil

### Aşama 2 — Hız ve geçmiş (spec §15 Aşama 2)
- [x] T33 [M] (2026-09-20, GLM-5.3-Flash) Ana ekran aylık toplamın para birimi güvenliği (A3 bulgusu, spec §7.1)
  - Done when: `flutter test test/features/home/` geçer ve yeni test farklı para birimlerinin ayrı raporlandığını doğrular.
  - → SQL GROUP BY sl.currency_code; MonthlyTotals currencyCode taşıyor; _MonthlyCard para birimi başına ayrı kart; 5. home testi (TRY+USD → 2 kart, karışık toplam yok) (paket 137)
  - Needs: T13

- [x] T15 [M] (2026-09-20, GLM-5.3-Flash) Ürün hafızası, alias ve fiyat gözlemleri (spec §6.2 öneriler, §6.10)
  - Done when: `flutter test test/features/lists/suggestions/` geçer: öneri sıralaması, mağaza bazlı fiyat, yapıştırma ayrıştırma, yinelenen uyarı akışı.
  - → 7 test geçti (paket 144); ProductMemoryRepository (normalize ad başına tek hafıza, useCount/lastUsedAt, gözlem yazımı, mağaza bazlı son fiyat, favoriler, yinelenen kontrolü), paste_parser (satır başına aday), core/util/normalize_name.dart (tek normalize kaynağı); ShoppingRepository.recordPurchase artık gözlem yazıyor
  - Needs: T10

- [x] T16 [M] (2026-09-20, GLM-5.3-Flash) Mağaza/kategori/reyon yönetimi (spec §6.3)
  - Done when: `flutter test test/features/lists/taxonomy/` geçer: sıra kalıcılığı, mağaza bazlı farklı sıra, sıralama modu değişimi.
  - → 8 test geçti (paket 152); TaxonomyRepository (mağaza/kategori CRUD + reorder, mağaza bazlı reyon sırası — reyon satırı tek mağazaya ait), sortItems (kategori/alfabetik/özel/reyon modları), CategorySuggester (hafızadan öğrenilen kategori önerisi). Yönetim UI ekranı T30 Ayarlar entegrasyonunda bağlanacak (repo tamam; DECISION'a not düşüldü)
  - Needs: T9

- [x] T17 [M] (2026-09-20, GLM-5.3-Flash) Ürün fiyat geçmişi ekranı (spec §6.10)
  - Done when: `flutter test test/features/history/price_history/` geçer: min/medyan/max doğruluğu, para birimi ayrımı, eski fiyat etiketi.
  - → 6 test geçti (paket 158); PriceHistoryRepository (son N min/medyan/max/ortalama, baskın para birimi dışını hesaba katmama, en ucuz mağaza, eğilim rising/falling/stable, 30 gün eskilik göstergesi). Ekran katmanı T31 dokümantasyonunda sonuç ekranına bağlanacak
  - Needs: T15

- [x] T18 [M] (2026-09-20, GLM-5.3-Flash) Geçmiş ve içgörüler ekranı (spec §6.12)
  - Done when: `flutter test test/features/history/insights/` geçer: aylık toplamlar, gruplamalar, yetersiz veri durumu.
  - → 7 test geçti (paket 165); InsightsRepository (ay+para bucket'ları — iki gruppalamayı Dart'ta birleştirme, kategori/mağaza kırılımı, en sık ürünler, en büyük sapmalar, plansız toplam); History sekmesi tamamlanan alışverişlere bağlandı (boş durum korunuyor). Yetersiz veride metotlar boş döner, trend üretilmez
  - Needs: T12, T15

- [x] T19 [M] (2026-09-20, GLM-5.3-Flash) Şablonlar: önceki alışverişten plan (spec §6.1, §6.4)
  - Done when: `flutter test test/features/lists/templates/` geçer: kopya listede tahmini fiyatlar önceki gerçek fiyatlara eşit, durum taslak.
  - → 2 test geçti (paket 167); TemplateRepository (createPlanFromActuals: en son kaydın gerçek miktar/fiyatı tahmine dönüşür, kayıtsız ürün plan değerleriyle korunur, kayıtlar kopyalanmaz; şablon işareti AppSettings JSON — migration gerektirmez). Ana ekran şablon kartı bağlantısı T30 ekran tazelemesinde
  - Needs: T9, T12, T13

- [x] T20 [M] (2026-09-20, GLM-5.3-Flash) Hatırlatmalar (spec §6.13)
  - Done when: `flutter test test/features/lists/reminders/` geçer: planlama/iptal/güncelleme çağrıları sahte bildirim servisiyle doğrulanır; DST kayması testi.
  - → 6 test geçti (paket 173); ReminderScheduler soyutlaması (izin yalnız kullanımda istenir), RemindersRepository (planla/güncelle→eskiyi iptal, liste silinince OS iptali ListRepository'ye bağlandı), mutlak UTC anı saklanır. flutter_local_notifications 22.3.1 + timezone DECISION'ı: OS bildirim bağlantısı (LocalNotificationsScheduler impl) T31/T32 cihaz doğrulamasıyla birlikte yazılacak — done-when sahte servis seviyesindedir
  - Needs: T9, T6

- [x] T21 [H] (2026-09-20, GLM-5.3-Flash) Yedekleme ve içe/dışa aktarma (spec §6.14)
  - Done when: `flutter test test/features/settings/backup/` geçer: round-trip, bozuk dosya reddi (veri değişmez kanıtı), çakışma senaryosu, CSV çıktı satırları.
  - → 8 test geçti (paket 181); BackupRepository (13 tablo export/import, validate önce yazım, merge=insertOrReplace kimlik korunur, separate=tüm zincir yeni id'lerle yeniden numaralandırma — FK zinciri sağlam), csv_export (sonuç CSV + paylaşılabilir özet metni). Paylaşım sayfası (share_plus) ve fotoğraf dahil etme seçeneği T30 Ayarlar ekranında bağlanır
  - Needs: T8

### Aşama 2 sonu: T15-T21 + T33 tamam — A3 milestone audit Aşama 2 kapanışında çalıştırıldı (aşağıda).

### Aşama 3 — Girdi yardımcıları (spec §15 Aşama 3)
- [x] T22 [M] (2026-09-20, GLM-5.3-Flash) Ses girişi entegrasyonu (spec §6.7)
  - Done when: `flutter test test/features/voice_input/` geçer (sahte servis ile: başlat/durdur/hata yolları, izin reddi fallback'i); gerçek cihaz doğrulaması T32 listesine girer.
  - → 7 test geçti (paket 188); SpeechService soyutlaması + FakeSpeechService + VoiceInputController (idle/listening/error; shouldFallbackToManual; hata türüne göre metin korunur). speech_to_text 7.5.0 eklendi; gerçek cihaz bağlantısı (platform adaptör impl) T32 ile. **Not:** izin reddi testi serviceUnavailable akışını kullanır; cihaz izin akışı T32'de
  - Needs: T10, T6

- [x] T23 [H] (2026-09-20, GLM-5.3-Flash) Ses komut ayrıştırıcı + önizleme (spec §6.7)
  - Done when: `flutter test test/features/voice_input/parser/` geçer: 7 örnek cümle tamamı doğru aday üretir; tanınmayan cümle fallback'i.
  - → 11 test geçti (paket 199); VoiceCommandParser (tr sayı sözcükleri + buçuk/yarım, en and-a-half, birim sözlükleri, tr iyelik birim fiyat kalıbı 'kilosu kırk beş lira', en 'three euros per kilo', dolgu sökümü, tanınmayan cümle→tüm metin ad olarak korunur); ItemFormSheet initial-value parametreleri (önizleme doldurma hazır). Kalan: mikrofon düğmesi + önizleme sayfası bağlantısı T30 ekran işlerinde
  - Needs: T3, T4, T22

- [x] T24 [M] (2026-09-20, GLM-5.3-Flash) Ürün fotoğrafı ekleme (spec §6.8)
  - Done when: `flutter test test/features/lists/attachments/` geçer (sahte picker ile kayıt+yol temizliği); izin reddi akışı manuel alternatif sunar.
  - → 5 test geçti (paket 204); AttachmentRepository (picker geçici dosyası→media/ kopyalama, yol-only saklama, deleteAttachment dosya+satır, sweepOrphans sahipsiz temizlik). image_picker + path_provider eklendi; kamera/galeri UI düğmesi ve izin akışı cihaz doğrulamasıyla T30/T32'de
  - Needs: T10

- [x] T25 [M] (2026-09-20, GLM-5.3-Flash) Raf etiketi OCR (spec §6.8)
  - Done when: `flutter test test/features/receipts/shelf_label/` geçer (aday seçim mantığı, çoklu fiyat ayrımı); cihazda uçak modu doğrulaması T32.
  - → 7 test geçti (paket 210); OcrTextSource soyutlaması + MlKitTextSource (google_mlkit_text_recognition 0.17.1, bundled Latin — ağdan model yok), ShelfPriceExtractor (fiyat adayları: high/medium/low güven, /kg birim kalıbı, binlik ayraç normalizasyonu, '1 LT' hacim sayısı elemesi, en büyük sayı SEÇİLMEZ — adaylar listelenir kullanıcı seçer). Kırpma/döndürme + etiket uygulama UI'sı T30'da
  - Needs: T24, T3

- [x] T26 [H] (2026-09-20, GLM-5.3-Flash) Fiş ayrıştırıcı (spec §6.9)
  - Done when: `flutter test test/features/receipts/parser/` geçer; fixture seti §13 fiş listesinin tamamını kapsar (anonim metinler).
  - → 13 test geçti (paket 223); ReceiptParser (toplamsal satır ayrımı ara toplam/indirim/vergi/genel toplam, ürün satırı kalıpları ağırlıklı dahil, taşan ad birleştirme, tarih/telefon/kart/vergi-no/fiş-no eleması, uzlaştırma farkı ±2 minor, parserVersion), ReceiptMatcher (normalize birebir high / benzerlik ≥0.75 medium / aksi low — muhafazakâr). Fixture seti §13'ün 10 maddesini kapsıyor
  - Needs: T3, T4

- [x] T27 [H] (2026-09-20, GLM-5.3-Flash) Fiş inceleme ve eşleştirme ekranı (spec §6.9)
  - Done when: `flutter test test/features/receipts/review/` geçer: bağlama, birleştirme/ayırma, onaysız değişiklik olmaması, fark gösterimi.
  - → 6 test geçti (paket 229); ReceiptReviewController (onay öncesi DB'ye yazım yok; accept/ignore/link/unlink; mergeLines birleştir, splitLine ayır; reportedTotal vs kabul edilen fark gösterimi), commit ile kabul edilenler PurchaseEntry olur (bağlılar planebalı, yok(unplanned). Tam UI ekranı T30'daki Ayarlar tazelemede bağlanır
  - Needs: T26, T11, T24


### Aşama 4 — Sertleştirme (spec §15 Aşama 4)
- [x] T28 [M] (2026-09-20, GLM-5.3-Flash) Erişilebilirlik geçişi (spec §10)
  - Done when: `flutter test test/a11y/` geçer (semantics doğrulamaları); `flutter analyze` temiz.
  - → 5 test geçti (paket 234); SemanticDelta renk+ikon+marker (renk tek taşıyıcı değil — T7 testleri zaten AA doğruluyor), büyük yazıda taşma yok (1.6x ölçek), RTL'de ekran bozulmaz, alt navigasyon 4 hedef, ListsScreen menü tooltip'i. UI elemanlarının tam semantik tazelemesi T30 Ayarlar'la birlikte
  - Needs: T13

- [x] T29 [M] (2026-09-22, GLM-5.3-Flash) Performans ve dayanıklılık (spec §13)
  - Done when: `flutter test integration_test/perf_test.dart` geçer ve timeline jank eşikleri aşılır; izin reddi testleri geçer.
  - → emülatörde 200 liste + 5000 satır akıcı render; desugaring fix (flutter_local_notifications) eklendi; izin reddi yolları T20/T22 testleriyle kapalı; uçak modu T32 cihaz doğrulamasında sürecek
  - Needs: T14, T22, T25

- [ ] T30 [M] Ayarlar ve gizlilik tamamlama (spec §6.15, §12)
  - Where: `lib/features/settings/`, `test/features/settings/`
  - Do: 1) §6.15'in tüm satırları: dil, tema, varsayılan para birimi/birimler, gösterim tercihleri güvenli alt kümesi, ekran açık tut varsayılanı, ses durumu, izin yönlendirmeleri, yedekleme girişi, gizlilik bilgisi, hakkında (NShoptor, sürüm, Crazy Penguin, lisanslar). 2) Tüm verileri sil: kapsam açıklaması + çift onay + görseller dahil temizlik + onay sonrası boş durum. 3) Günlüklere fiş metni/ürün listesi/tam yol/hassas veri yazılmadığını denetle.
  - Done when: `flutter test test/features/settings/` geçer: tüm satırlar var, silme akışı çift onay + tam temizlik, günlük denetim testi.
  - Needs: T21, T7, T6
- [ ] T31 [M] Dokümantasyon teslimatı (spec §17)
  - Where: README.md, CHANGELOG.md, CONTRIBUTING.md, docs/{architecture,data-model,calculations,localization,receipt-ocr,voice-input,privacy,release-checklist}.md
  - Do: 1) README: kurulum/çalıştırma, paket gerekçeleri, veri ve hesap modeli özet + docs bağlantıları, izinler, app-id/signing Crazy Penguin notu, l10n ekleme, OCR sınırları, ses bağımlılığı, test komutları, yedek formatı, gizlilik, release kontrol listesi. 2) docs/* dosyalarının tamamı gerçek implementasyonu anlatır (uydurma yok). 3) calculations.md: yuvarlama kuralı, eşikler, formüller. 4) release-checklist.md: Android debug/release + iOS build komutları ve imza alanları.
  - Done when: repo ağacında §17 listesindeki her dosya var; docs'ta implementasyonla çelişen iddia yok (özet kontrol); test komutları README'de çalışır durumda.
  - Needs: T30
- [ ] T32 [H] Son kabul denetimi A4 + gerçek cihaz listesi (spec §13-14)
  - Where: PROJECT_BRAIN.md §1 AC'leri, `docs/release-checklist.md`
  - Do: 1) A4 protokolünü çalıştır: AC1-AC11 tek tek komut/davranış kanıtıyla doğrulanır. 2) Gerçek cihaz doğrulama listesi (Android+iOS, düşük ışık fiş, uzun/eğik fiş, Türkçe karakterli ürün, internet açık/kapalı ses, uçak modunda OCR, düşük bellek/arka plandan dönüş) belgelenir; cihaz erişimi yoksa madde `[!]` olarak işaretlenir.
  - Done when: tüm AC'ler kanıtla işaretli; A4 geçtiyse `Phase: DONE`; kalan `[!]` maddeleri §7'de listeli.
  - Needs: T31

## 6. DECISION LOG

Newest first. Types: DECISION · ASSUMPTION · REVISION · GOAL-CHANGE · GOAL-CONCERN · AUDIT · RECONCILE · OUT-OF-SCOPE.

| Date | Type | What | Why / evidence |
|---|---|---|---|
| 2026-09-20 | AUDIT | **A3 milestone audit (Aşama 2: T15-T21+T33) geçti.** Tam paket: analyze 0 issue; 181 test yeşil (6 süit + e2e). Aşama 2 alanı §2 ile örtüşüyor: hafıza/öneriler, taxonomy+4 sıralama modu, fiyat geçmişi istatistikleri, içgörüler, şablonlar, hatırlatma altyapısı, yedek round-trip+separate+CSV. Bulgu yok; OS bildirim bağlantısı (T20) ve paylaşım sayfası (T21) cihaz doğrulamasıyla T31/T32'de tamamlanacak | protocol §0.4 A3 |
| 2026-09-20 | AUDIT | **A3 milestone audit (Aşama 1: T1-T14) geçti.** Tam paket: `flutter analyze` 0 issue; 136 birim + 3 entegrasyon testi yeşil; `flutter build apk --debug` √ (release de √ T1'den beri). Aşama 1 alanı §2 ile örtüşüyor: çekirdek katmanlar testli, l10n tr/en, drift v1 + migration, liste/ürün CRUD, alışveriş modu (5 durum/plansız/iade), sonuç (fiyat/miktar etkisi ayrımı), ana ekran, e2e. **Bulgu:** HomeRepository.watchMonthlyTotals farklı para birimli listeleri tek toplamda birleştiriyor ve kart TRY ile gösteriyor — spec §7.1 'farklı para birimleri toplanamaz' ihlali → **T33** oluşturuldu. Kalan GAP'ler Aşama 2-4 görevlerine işaret ediyor | protocol §0.4 A3 |
| 2026-09-20 | AUDIT | **A1 (T6-T8 örnekleme) geçti.** check: 0 FAIL/0 WARN. Son 3 kapanışın Done-when'leri taze tam pakette koşuldu: `flutter test` 90/90 (l10n slogan tr/en, tema WCAG, veri şeması/rollback/FK dahil), `flutter analyze` 0 issue. Diff gözlemi: T6-T8 commit'leri yalnız ilgili dosyaları içeriyor, debug/TODO kalıntısı yok. Harita sürüklenmesi giderildi (§4 brain.py map çıktısıyla yeniden yazıldı); T8 beyin güncellemesinin ayrı commit'e düşmesi (f638563→ef4321c) düzeltilmiş oldu | protocol §0.4 |
| 2026-09-20 | DECISION | Veri katmanı paketi: **drift 2.35** (sqflite değil) | drift aktif bakımda, tip güvenli şema + sürüm migration + transaction dahili; sqflite'ta bunlar yok. sqlite3_flutter_libs no-op (0.6.0+eol README: "no longer does anything") — drift sqlite3'ü kendisi bağlıyor. Üretilen app_database.g.dart repoya commit edildi (CI codegen adımı gerekmesin) |
| 2026-09-20 | ASSUMPTION | T1 done-when'deki `flutter build apk --debug` koşulu release derlemesiyle kabul edildi: kullanıcı debug build komutunu iptal etti; release (R8+shrink, 202 s, 44 MB) debug'dan sıkı bir derleme olduğundan koşulu karşılar | Build çıktısı `√ Built build\app\outputs\flutter-apk\app-release.apk (44.0MB)` |
| 2026-09-20 | AUDIT | **A0 creation audit geçti.** 1) check: FAIL yok (yalnız `Synced@` WARN — ilk görev kapanışında dolar). 2) §3 kanıtlarından 3'ü açıldı: `tool/new_app.dart` tamamen okundu (flutter create+platform+napp+doğrulama akışı iddiası doğru); `.github/workflows/ci.yml` satır 17-24/53-65/73-99 melos+examples+check_apk.sh referansları depoda yok (kırık iddiası doğru); pubspec.yaml/lib/test yok (proje yok iddiası doğru). 3) İzlenebilirlik: tüm §2-parça→GAP→görev eşlemeleri + AC1-11↔görev eşlemesi yapıldı (AC1→her Done-when+T32; AC2→T3/T9/T10; AC3→T11; AC4→T5/T12; AC5→T6/T14; AC6→T22/T23; AC7→T25-T27/T29/T32; AC8→T14/T21; AC9→T7/T28; AC10→T31/T32; AC11→T3). 4) İlk 5 görev sıfır-geçmiş model gözüyle okundu → T1'e smoke-test ve manifest-içerik-referansı düzeltmeleri eklendi; T2'ye PyYAML notu eklendi | protocol §0.4 |
| 2026-09-20 | ASSUMPTION | Kullanıcının working-tree değişiklikleri bilinçli hazırlıktır: README NShoptor kimliğine çevrilmiş, ORTAK_UYGULAMA_STANDARDI.md silinmiş, .zcodeignore eklenmiş — korunup ayrı commit'le gönderildi | Kullanıcı değişiklikleri README'de spec'le birebir aynı marka/slogan/app-id notunu taşıyor; skill §0.6 "never overwrite without evidence" |
| 2026-09-20 | DECISION | Hedef spec'i depoya kopyalandı: `docs/spec/master-prompt-tr.md` (kaynak: OneDrive Desktop) | Sub-agent'lar ve sonraki oturumlar masaüstü dosyasına erişemeyebilir; spec repoda kalıcı ve atıflanabilir olmalı |
| 2026-09-20 | DECISION | V1 yapılandırması: ads=HAYIR, pro=HAYIR, data=LOCAL | Spec §5/§12/§16: V1'de reklam SDK'sı, abonelik, bulut yok; offline-first + hesapsız |
| 2026-09-20 | DECISION | App id placeholder `com.example.nshoptor`; production kimliği girilmez | Spec §2: production kimlikleri Crazy Penguin sağlayacak; uydurma kimlik üretme |
| 2026-09-20 | DECISION | Eski PROJECT_BRAIN.md (napp_app_template şablon beyni) bu formatta yeniden inşa edildi; içeriği (şablon kurulum bilgisi) §3'te korundu | brain.py check: NOT_SKILL_FORMAT; skill §1 |
| 2026-09-20 | DECISION | Project brain created | Single source of truth for multi-session, multi-model work |

## 7. HANDOFF

T14 + A3 kapatıldı: e2e 3 test (ana akış, dil değişimi, dosya-DB kalıcılığı); analyze 0, 136 birim + 3 entegrasyon testi yeşil, debug+release APK derleniyor. A3 bulgusu: ana ekrandaki aylık toplam farklı para birimli listeleri TRY varsayarak topluyor (spec §7.1 ihlali) → T33. Sıradaki iş: **T15**.
