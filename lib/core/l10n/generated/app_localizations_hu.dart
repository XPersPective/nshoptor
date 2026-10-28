// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Tervezz otthon. Vásárolj tervszerűen.';

  @override
  String get listsTitle => 'Listák';

  @override
  String get listsTabActive => 'Aktív';

  @override
  String get listsTabCompleted => 'Befejezett';

  @override
  String get listsTabArchived => 'Archivált';

  @override
  String get newListButton => 'Új lista';

  @override
  String get listTitleHint => 'Cím (opcionális)';

  @override
  String get saveButton => 'Mentés';

  @override
  String get cancelButton => 'Mégse';

  @override
  String get deleteButton => 'Törlés';

  @override
  String get editAction => 'Szerkesztés';

  @override
  String get listDeleted => 'Lista törölve';

  @override
  String get invalidAmountError => 'Érvénytelen mennyiség';

  @override
  String get duplicateAction => 'Duplikálás';

  @override
  String get archiveAction => 'Archiválás';

  @override
  String get unarchiveAction => 'Visszaállítás archiválástól';

  @override
  String get deleteListConfirm =>
      'Biztosan törlöd ezt a listát? A tervezett tételek is eltávolításra kerülnek.';

  @override
  String get undoButton => 'Visszavonás';

  @override
  String get searchListHint => 'Listák keresése';

  @override
  String get currencyLabel => 'Pénznem';

  @override
  String get budgetLabel => 'Költségkeret (opcionális)';

  @override
  String get noteLabel => 'Megjegyzés (opcionális)';

  @override
  String get storeLabel => 'Áruház';

  @override
  String get keepAmountsAction => 'Mennyiségek megtartása';

  @override
  String get resetAmountsAction => 'Mennyiségek visszaállítása';

  @override
  String get currencyChangeWarning =>
      'A pénznem változik. Mi történjen a meglévő összegekkel?';

  @override
  String get listsEmpty =>
      'Még nincsenek listák. Hozd létre az első bevásárlási terved!';

  @override
  String get statusDraft => 'Vázlat';

  @override
  String get statusPlanned => 'Tervezett';

  @override
  String get statusShopping => 'Vásárlás alatt';

  @override
  String get statusCompleted => 'Befejezett';

  @override
  String get statusArchived => 'Archivált';

  @override
  String autoListTitle(String date) {
    return '$date bevásárlás';
  }

  @override
  String get itemFormTitle => 'Tétel hozzáadása';

  @override
  String get itemNameLabel => 'Tétel neve';

  @override
  String get brandLabel => 'Márka / variáns (opcionális)';

  @override
  String get categoryLabel => 'Kategória';

  @override
  String get quantityLabel => 'Mennyiség';

  @override
  String get unitLabel => 'Egység';

  @override
  String get pricingModeLabel => 'Árbevitel módja';

  @override
  String get pricingModeUnitPrice => 'Egységár';

  @override
  String get pricingModeLineTotal => 'Sorösszeg';

  @override
  String get plannedPriceLabel => 'Tervezett ár';

  @override
  String lineTotalCalculated(String value) {
    return 'Sorösszeg: $value';
  }

  @override
  String get requiredItemToggle => 'Kötelező tétel';

  @override
  String get maxPriceLabel => 'Maximálisan elfogadható ár (opcionális)';

  @override
  String get itemNoteLabel => 'Megjegyzés (opcionális)';

  @override
  String get categoryProduce => 'Gyümölcsök és zöldségek';

  @override
  String get categoryDairy => 'Tejtermékek';

  @override
  String get categoryMeat => 'Húsok';

  @override
  String get categoryBakery => 'Sütemények';

  @override
  String get categoryDrinks => 'Italok';

  @override
  String get categoryCleaning => 'Tisztítószerek';

  @override
  String get categoryPersonalCare => 'Személyes higiénia';

  @override
  String get categoryHome => 'Otthoni cikkek';

  @override
  String get categoryOther => 'Egyéb';

  @override
  String get invalidQuantityError => 'Érvénytelen mennyiség';

  @override
  String get invalidPriceError => 'Érvénytelen ár';

  @override
  String get invalidNameError => 'Adj meg egy nevet';

  @override
  String unitPriceCalculated(String value) {
    return 'Egységár: $value';
  }

  @override
  String get shoppingTitle => 'Vásárlási mód';

  @override
  String get summaryPlannedTotal => 'Tervezett';

  @override
  String get summaryInCart => 'Kosárban';

  @override
  String get summaryRemainingPlan => 'Hátralévő terv';

  @override
  String get summaryProjected => 'Becsült fizetés';

  @override
  String get summaryBudgetRemaining => 'Maradék keret';

  @override
  String get summaryBudgetOver => 'Keret túllépve';

  @override
  String itemsProgress(String done, String total) {
    return '$done/$total termék';
  }

  @override
  String get filterAll => 'Összes';

  @override
  String get filterToBuy => 'Venni való';

  @override
  String get filterInCart => 'Kosárban';

  @override
  String get filterNotFound => 'Nem található';

  @override
  String get filterRequired => 'Szükséges';

  @override
  String get quickEntryTitle => 'Valós ár';

  @override
  String get actualQuantityLabel => 'Valós mennyiség';

  @override
  String get actualPriceLabel => 'Valós ár';

  @override
  String get discountLabel => 'Kedvezmény (opcionális)';

  @override
  String get alternativeNameLabel => 'Alternatív termék neve (opcionális)';

  @override
  String get savePurchaseButton => 'Kosárba tesz';

  @override
  String get unplannedAddButton => 'Tervezetlen termék hozzáadása';

  @override
  String get statusPending => 'Nincs kiválasztva';

  @override
  String get statusInCart => 'Kosárban';

  @override
  String get statusNotFound => 'Nem található';

  @override
  String get statusGaveUp => 'Feladva';

  @override
  String get statusAlternative => 'Alternatívát vettünk';

  @override
  String get keepScreenAwake => 'Képernyő ébren tartása';

  @override
  String get finishShopping => 'Vásárlás befejezése';

  @override
  String get completionWarning =>
      'Hiányos vagy ellenőrizetlen adatok vannak. Még mindig befejezheti; az eredmény ezt jelzi.';

  @override
  String get continueShoppingButton => 'Folytatás';

  @override
  String get resultTitle => 'Eredmény';

  @override
  String get summarySection => 'Összegzés';

  @override
  String get plannedTotalLabel => 'Tervezett összesen';

  @override
  String get actualTotalLabel => 'Valós összesen';

  @override
  String get varianceLabel => 'Különbség';

  @override
  String get varianceNotComputable => 'Nem számítható ki';

  @override
  String get budgetStatusLabel => 'Keret';

  @override
  String get savingsLabel => 'A terv alatt';

  @override
  String get overspendLabel => 'A terv felett';

  @override
  String get unplannedTotalLabel => 'Tervezetlen összesen';

  @override
  String get unpurchasedLabel => 'Tervezett, de nem vásárolt';

  @override
  String get totalDiscountLabel => 'Összes kedvezmény';

  @override
  String get accuracyLabel => 'Becslés pontossága';

  @override
  String get groupsSection => 'Termékek';

  @override
  String get groupPricier => 'Drágább, mint tervezve';

  @override
  String get groupCheaper => 'Olcsóbb, mint tervezve';

  @override
  String get groupClose => 'Közel a becsléshez';

  @override
  String get groupNotTaken => 'Tervezett, de nem vásárolt';

  @override
  String get groupUnplanned => 'Tervezetlenül vásárolt';

  @override
  String get groupQuantityChanged => 'Mennyiség változott';

  @override
  String get groupUnverified => 'Ellenőrizetlen';

  @override
  String get plannedQtyLabel => 'Tervezett mennyiség';

  @override
  String get actualQtyLabel => 'Valós mennyiség';

  @override
  String get plannedUnitPriceLabel => 'Tervezett egységár';

  @override
  String get actualUnitPriceLabel => 'Valós egységár';

  @override
  String get lineVarianceLabel => 'Sor különbség';

  @override
  String get discountEffectLabel => 'Kedvezmény hatása';

  @override
  String get notBoughtMark => 'nem vásárolt';

  @override
  String get noPurchasesNote => 'Nem rögzítettek vásárlásokat.';

  @override
  String get navHome => 'Kezdőlap';

  @override
  String get navLists => 'Listák';

  @override
  String get navHistory => 'Előzmények';

  @override
  String get navSettings => 'Beállítások';

  @override
  String get homeEmptyTitle => 'Tervezd meg a bevásárlást';

  @override
  String get homeEmptyBody =>
      'Készítsd el az első listádat, és hasonlítsd össze a tervezett és a tényleges költségeket.';

  @override
  String get homeActiveSection => 'Aktív listák';

  @override
  String get homeCompletedSection => 'Nemrég befejezettek';

  @override
  String get homeMonthlySection => 'Ez a hónap';

  @override
  String get monthPlannedLabel => 'Tervezett';

  @override
  String get monthActualLabel => 'Tényleges';

  @override
  String get monthVarianceLabel => 'Különbség';

  @override
  String get continueShoppingLabel => 'Folytasd a vásárlást';

  @override
  String get historyEmpty =>
      'Még nincs befejezett bevásárlás. Az előzményeid és elemzéseid itt jelennek meg.';

  @override
  String get aboutTabTitle => 'Az NShoptorról';

  @override
  String get aboutBody =>
      'NShoptor by Crazy Penguin. Offline-first bevásárlásterv. A GPL-3.0 licenc alatt elérhető.';

  @override
  String get startShoppingLabel => 'Kezdés';

  @override
  String get finishAndSeeResult => 'Befejezés & eredmény';

  @override
  String get settingsTitle => 'Beállítások';

  @override
  String get languageLabel => 'Nyelv';

  @override
  String get languageSystem => 'Rendszer';

  @override
  String get languageTr => 'Török';

  @override
  String get languageEn => 'Angol';

  @override
  String get themeLabel => 'Téma';

  @override
  String get themeSystem => 'Rendszer';

  @override
  String get themeLight => 'Világos';

  @override
  String get themeDark => 'Sötét';

  @override
  String get defaultCurrencyLabel => 'Alapértelmezett pénznem';

  @override
  String get defaultUnitLabel => 'Alapértelmezett mértékegység';

  @override
  String get keepAwakeLabel => 'Képernyő ébren tartása vásárlás közben';

  @override
  String get backupSection => 'Biztonsági mentés';

  @override
  String get exportBackupLabel => 'Biztonsági mentés exportálása';

  @override
  String get importBackupLabel => 'Biztonsági mentés importálása';

  @override
  String get mergeImportLabel => 'Ötvözés a jelenlegi adatokkal';

  @override
  String get separateImportLabel => 'Importálás külön másolatként';

  @override
  String get importCancelled => 'Importálás megszakítva.';

  @override
  String get backupExported => 'A biztonsági mentés sikeresen exportálva.';

  @override
  String get deleteAllSection => 'Veszélyes zóna';

  @override
  String get deleteAllLabel => 'Összes adat törlése';

  @override
  String get deleteAllConfirm =>
      'Ez eltávolítja az összes listát, előzményt, nyugtafotót és árat. A te általad exportált fájlok a meghajtódon maradnak. Folytatod?';

  @override
  String get deleteAllConfirm2 =>
      'Biztos vagy benne? Ez a művelet nem vonható vissza.';

  @override
  String get cancelAction => 'Mégsem';

  @override
  String get confirmDelete => 'Végleges törlés';

  @override
  String get dataDeleted => 'Az összes helyi adat törölve.';

  @override
  String get privacyInfoLabel => 'Adatvédelem';

  @override
  String get privacyInfoBody =>
      'A listáid, árak, nyugták és fotók az eszközödön tárolódnak. A hang soha nem hagyja el. Ha az AI segítség be van kapcsolva, a nyugták és árcímkék fotói (csökkentett méretben), valamint a szöveg, például a diktált tételek, kizárólag beolvasás céljából kerülnek a szerverünkre; azonnal feldolgozzuk őket, és soha nem tároljuk.';

  @override
  String get aboutSection => 'Névjegy';

  @override
  String get aboutPublisher => 'Kiadó: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licencek (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Hangbevitel';

  @override
  String get voiceStatusUnknown => 'Szolgáltatás: ellenőrizetlen';

  @override
  String get permissionsLabel => 'Engedélyek';

  @override
  String get permissionsBody =>
      'A kamera, mikrofon és értesítések csak akkor kérhetők, amikor ténylegesen használod ezeket a funkciókat.';

  @override
  String get unitsSection => 'Alapértelmezések';

  @override
  String get roundingNote =>
      'A pénz kerekítése egy szabály szerint történik: a felektől elfelé kerekítünk, egyszer alkalmazva a Pénz konverziókor.';

  @override
  String get voiceInputTitle => 'Hangbevitel';

  @override
  String get voiceStartListening => 'Figyelés indítása';

  @override
  String get voiceTranscriptLabel => 'Átirat';

  @override
  String get parseAction => 'Elemzés';

  @override
  String get receiptReviewTitle => 'Nyugta áttekintése';

  @override
  String get receiptTotal => 'Számla végösszege';

  @override
  String get receiptTotalUnknown => 'Végösszeg nem észlelhető';

  @override
  String get receiptDiff => 'Különbség';

  @override
  String get acceptLine => 'Sor elfogadása';

  @override
  String get ignoreLine => 'Sor figyelmen kívül hagyása';

  @override
  String get receiptLineActions =>
      'Tételhez rendelés, felosztás vagy figyelmen kívül hagyás';

  @override
  String get receiptCommit => 'Összes elfogadása';

  @override
  String get receiptCommitted => 'Számla alkalmazva.';

  @override
  String get priceHistoryTitle => 'Ártörténet';

  @override
  String get noObservations => 'Még nincsenek ármegfigyelések';

  @override
  String get templatesSection => 'Sablonok';

  @override
  String get templateHint =>
      'Új bevásárlólista létrehozása egy korábbi vásárlásból';

  @override
  String get scanReceiptAction => 'Számla beolvasása';

  @override
  String get fromReceiptListButton => 'Nyugtából';

  @override
  String get shelfLabelAction => 'Ár a polc címkéjéről';

  @override
  String get priceCandidatesTitle => 'Árkandidátusok';

  @override
  String get noPriceCandidates => 'Nincs találat; adja meg manuálisan.';

  @override
  String get voiceUnavailable =>
      'A beszédfelismerés nem elérhető; adja meg manuálisan.';

  @override
  String get linkToItem => 'Tételhez rendelés';

  @override
  String get splitLine => 'Felosztás két részre';

  @override
  String get mergeWithNext => 'Egyesítés a következővel';

  @override
  String get ocrNoText => 'Szöveg nem olvasható; próbálja újra.';

  @override
  String get priceHistoryAction => 'Ártörténet';

  @override
  String get itemsEmptyTitle => 'Még nincsenek tételek';

  @override
  String get itemsEmptyBody =>
      'Adja hozzá az első tételt — itt fogja megadni a valós árakat a boltban.';

  @override
  String get addItemTooltip => 'Tétel hozzáadása';

  @override
  String get unitAdet => 'db';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'csomag';

  @override
  String get unitKutu => 'doboz';

  @override
  String get unitSise => 'palack';

  @override
  String get unitKavanoz => 'üveg';

  @override
  String get unitDemet => 'csomó';

  @override
  String get unitDuzine => 'tucat';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Egyedi';

  @override
  String get setReminderAction => 'Emlékeztető beállítása';

  @override
  String get reminderPermissionDenied =>
      'Az emlékeztetőkhez értesítési engedély szükséges. Ezt a rendszerbeállításokban engedélyezheti.';

  @override
  String get reminderScheduled => 'Emlékeztető beállítva.';

  @override
  String get reminderCancelled => 'Emlékeztető eltávolítva.';

  @override
  String get reminderTitle => 'Bevásárlólista emlékeztető';

  @override
  String reminderBody(Object title) {
    return 'Ideje átnézni a listáját: $title';
  }

  @override
  String get reminderPickDate => 'Dátum kiválasztása';

  @override
  String get reminderPickTime => 'Időpont kiválasztása';

  @override
  String get itemDetailsSection => 'Részletek';

  @override
  String get priceOptionalHint =>
      'Opcionális — a valós árat a boltban adhatja meg';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Tervezett: $total · $count tétel';
  }

  @override
  String get proActiveLabel => 'Pro aktív — köszönjük!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Nincsenek hirdetések · Biztonsági mentés export és import · Éves';

  @override
  String get proBenefitNoAds => 'Reklámmentes élmény';

  @override
  String get proBenefitBackup => 'Biztonsági mentés (export/import)';

  @override
  String aboutVersion(Object version) {
    return 'Verzió: $version';
  }

  @override
  String get navDiscover => 'Felfedezés';

  @override
  String get shareAction => 'Alkalmazás megosztása';

  @override
  String get rateAction => 'Értékelés';

  @override
  String get aboutOpenRow => 'Névjegy és nyílt forráskód';

  @override
  String get voiceAddItemAction => 'Hozzáadás hanggal';

  @override
  String get formatLocaleLabel => 'Szám- és pénznemformátum';

  @override
  String get formatLocaleSystem =>
      'Eszköz formátuma (Latin számjegyek; egyébként angol)';

  @override
  String get formatLocaleTr => 'Török (1.234,56)';

  @override
  String get formatLocaleEn => 'Angol (1,234.56)';

  @override
  String get aiToggleTitle => 'AI segítség';

  @override
  String get aiToggleSubtitle =>
      'Fotókról beolvassa a nyugtákat és árcímkéket, párosítja a nyugtákat, és mondatokból listát készít. A fotókat csak beolvasásra küldi el, és soha nem tárolja.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Ebben a hónapban már felhasználtad az AI kéréseidet ($used/$limit). Frissíts többért, vagy folytasd AI nélkül.';
  }

  @override
  String get aiOffline => 'Nincs kapcsolat – AI nélkül folytatódik.';

  @override
  String get aiFailed => 'Az AI jelenleg nem elérhető – folytatás nélküle.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Eszköz';

  @override
  String get quickListAction => 'Hozzáadás mondatból';

  @override
  String get quickListTitle => 'Gyors lista';

  @override
  String get quickListHint => 'pl. 1 kg alma 20, 2 kenyér, fél kiló sajt';

  @override
  String get quickListConvert => 'Listává alakítás';

  @override
  String quickListAdd(int count) {
    return '$count tétel hozzáadása';
  }

  @override
  String get quickListEmpty =>
      'Nem találtam tételeket. Próbáld meg vesszővel elválasztva felsorolni őket.';

  @override
  String get receiptAiMatched =>
      'Az AI összepárosította a nyugtát a listáddal. Ellenőrizd a hivatkozásokat, és erősítsd meg.';

  @override
  String get receiptNeedsCheck => 'Ellenőrizd ezt a párosítást';

  @override
  String get receiptDiscountLine => 'Kedvezmény';

  @override
  String get compareItem => 'Tétel';

  @override
  String get compareEstimated => 'Becsült';

  @override
  String get compareActual => 'Valós';

  @override
  String get compareDiff => 'Különbség';

  @override
  String get compareTotal => 'Összesen';

  @override
  String get compareBudget => 'Költségvetés';

  @override
  String get compareNotBought => 'nem vásárolt';

  @override
  String get compareUnplanned => 'nem tervezett';

  @override
  String get pricierItems => 'Drágábbak';

  @override
  String get cheaperItems => 'Olcsóbbak';

  @override
  String get compareAction => 'Összehasonlítás';

  @override
  String get detailsSection => 'Részletek';

  @override
  String get spendingTitle => 'Kiadások';

  @override
  String get spendingAction => 'Kiadások';

  @override
  String get spendingMonthTotal => 'Ez a hónap';

  @override
  String get spendingWeekly => 'Heti kiadások';

  @override
  String get spendingMonthly => 'Havi kiadások';

  @override
  String get monthlyLimitTitle => 'Havi keret';

  @override
  String get monthlyLimitHelp =>
      'Mennyit szeretnél havonta költött bevásárlásra?';

  @override
  String get monthlyLimitRemove => 'Eltávolítás';

  @override
  String get monthlyLimitSet => 'Beállítás';

  @override
  String get monthlyLimitChange => 'Módosítás';

  @override
  String get monthlyLimitNone =>
      'Állíts be havi keretet, hogy lásd, mennyid maradt.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount túllépve a kereten';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount maradt ebben a hónapban';
  }

  @override
  String get plansTitle => 'Csomagok';

  @override
  String get plansHeadline => 'Vásárolj okosabban AI-val';

  @override
  String get plansSubhead =>
      'Nyugta-párosítás, árcímkék és listák mondatból. Bármikor lemondható.';

  @override
  String get plansMonthly => 'Havi';

  @override
  String get plansYearly => 'Éves';

  @override
  String get planFree => 'Ingyenes';

  @override
  String get planFreePrice => 'Örökké ingyenes';

  @override
  String get planFreeAi => '10 AI kérés havonta';

  @override
  String get planFreeAds => 'Kis banner hirdetések (az első 7 napban nincs)';

  @override
  String get planCoreFeatures => 'Listák, árak, nyugták, kiadási diagramok';

  @override
  String get plansPerYear => '/ év';

  @override
  String get plansPerMonth => '/ hó';

  @override
  String get planTrial => 'Ingyenes próbaidőszak';

  @override
  String get planProAi => '100 AI kérés havonta';

  @override
  String get planNoAds => 'Nincsenek hirdetések';

  @override
  String get planBackup => 'Biztonsági mentés export és import';

  @override
  String get planMaxAi => '300 AI kérés havonta';

  @override
  String get planMaxFamily => 'Nagy családok bevásárlásához';

  @override
  String get plansStoreUnavailable => 'Az üzlet jelenleg nem elérhető.';

  @override
  String get retryAction => 'Újrapróbálkozás';

  @override
  String get plansPurchaseFailed =>
      'A vásárlás sikertelen. Kérjük, próbálja meg újra.';

  @override
  String get plansRestore => 'Vásárlások visszaállítása';

  @override
  String get plansLegal =>
      'A Pro lemondásig évente automatikusan megújul, és havonta 100 AI-kérést tartalmaz. Az alapár évi 1 amerikai dollár az alkalmazandó adók nélkül; a vásárlás megerősítése előtt ellenőrizd a végleges helyi árat és az adókat az áruházban. Az előfizetést a Google Playben kezelheted vagy mondhatod le.';

  @override
  String get planCurrent => 'Jelenlegi';

  @override
  String get planStartTrial => 'Ingyenes próbaidőszak indítása';

  @override
  String get planChoose => 'Kiválasztás';

  @override
  String get plansAction => 'Csomagok: Pro';

  @override
  String get assistantTitle => 'Asszisztens';

  @override
  String get assistantGreeting => 'Szia! Mit szeretnél csinálni?';

  @override
  String get assistantNewList => 'Új lista';

  @override
  String get assistantVoiceList => 'Lista hanggal';

  @override
  String get assistantTextList => 'Lista mondatból';

  @override
  String get assistantScanReceipt => 'Számla beolvasása';

  @override
  String get assistantSpending => 'Költségeim';

  @override
  String get assistantReceiptHint =>
      'Nyisd meg a listádat, és koppints a számla ikonra a beolvasáshoz.';

  @override
  String get assistantToggleTitle => 'Asszisztens megjelenítése';

  @override
  String get assistantToggleSubtitle => 'A kis segítő az alsó jobb sarokban';

  @override
  String get scanPriceLabel => 'Ár címkéjének beolvasása';

  @override
  String get saveFailed =>
      'Mentés sikertelen. A módosításaid megmaradtak. Kérjük, próbáld újra.';

  @override
  String get deleteItemConfirm =>
      'Töröljük ezt a tételt és a rögzített vásárlásokat?';

  @override
  String get clearPurchaseConfirm =>
      'Kijelölést töröljük erről a tételről és eltávolítjuk a rögzített vásárlásokat?';

  @override
  String get reportPdfAction => 'PDF jelentés mentése';

  @override
  String get reportNotInvoice =>
      'Vásárlási összefoglaló, nem adóigazolás. Az adókulcsok ismeretlenek.';

  @override
  String get purchaseVisits => 'Vásárlási látogatások';

  @override
  String get purchaseInterval => 'Átlagos napok a vásárlások között';

  @override
  String get purchasedQuantity => 'Megvásárolt mennyiség';

  @override
  String get purchaseAnalyticsHint =>
      'A vásárlások nem mérik a fogyasztást. A pénznemek és egységek külön jelennek meg.';

  @override
  String get receiptReplaces =>
      'Az ár nélküli tételek ára kitöltődik. A már piaci árral rendelkező tételek külön vásárlásként kerülnek hozzáadásra.';

  @override
  String get receiptIncompleteHeader =>
      'A következő fotón szerepeljen az üzlet neve, a dátum, az idő és a nyugtaszám.';

  @override
  String get receiptIncompleteTail =>
      'Fotózd le a következő részt néhány átfedő tétellel és a végösszeggel.';

  @override
  String get receiptContinuationRejected =>
      'Ezt a fotót nem sikerült a nyugtához illeszteni. Készíts új képet ugyanarról a nyugtáról, néhány átfedő tétellel.';

  @override
  String get receiptDraftSaved =>
      'A nyugta piszkozatként mentve. Később folytathatod.';

  @override
  String get receiptContinueAction => 'Nyugta folytatása';

  @override
  String get receiptDraftsTitle => 'Befejezetlen nyugták';

  @override
  String get receiptDuplicate => 'Ezt a nyugtát már hozzáadtad.';

  @override
  String get receiptTotalMismatch =>
      'A tételek összege nem egyezik a nyugta végösszegével. Ellenőrizd, hogy a teljes nyugta látható-e.';

  @override
  String get receiptSaveDraftAction => 'Mentés későbbre';

  @override
  String get receiptResolveLines =>
      'Mentés előtt fogadjon el vagy hagyjon figyelmen kívül minden tételt.';

  @override
  String get receiptPartialConfirm =>
      'Csak a kiválasztott tételek kerülnek hozzáadásra. Ez a nyugta importáltként lesz megjelölve. Folytatja?';

  @override
  String get voiceUnsupportedLanguage =>
      'Ez a nyelv nem érhető el hangbemenetre ezen az eszközön. Ehelyett gépelheted.';

  @override
  String get voiceStopListening => 'Figyelés leállítása';

  @override
  String get keepAwakeFailed =>
      'Nem sikerült aktívan tartani a képernyőt. Kérjük, próbálja újra.';

  @override
  String get purchaseHistoryHint =>
      'Az összes befejezett bevásárlás. A visszaküldések csökkentik az összegeket. A dátumok a bevásárlás befejezésére vonatkoznak. Egy vásárlási alkalom nem elegendő az átlagos időköz kiszámításához.';

  @override
  String get planLegacyRights =>
      'A meglévő Pro és Max előfizetések megőrzik az eredeti havi AI keretüket.';

  @override
  String get csvExportAction => 'CSV export';

  @override
  String get reportSharePdf => 'Megosztás PDF-ként';

  @override
  String get reportShareCsv => 'Megosztás CSV-ként';

  @override
  String get reportPrintAction => 'Nyomtatás';

  @override
  String get backupSizeWarning =>
      'A JSON fájlok rekordokat tartalmaznak, nem képfájlokat. Importálási korlát: 16 MB.';

  @override
  String get backupImportFailed =>
      'Nem sikerült importálni ezt a mentést. Az adatai nem változtak.';

  @override
  String get backupImported => 'A biztonsági mentés sikeresen importálva.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists lista · $items tétel · $entries vásárlás';
  }

  @override
  String get voiceModelDownloading =>
      'A nyelv hangmodellje letöltés alatt áll. Próbáld újra egy perc múlva.';

  @override
  String get historyThisWeek => 'Ez a hét';

  @override
  String get historyProductsSection => 'Vásárolt termékek';

  @override
  String get tipReceiptScan =>
      'Olvassa be a nyugtát, hogy az árakat egyeztesse a listájával';

  @override
  String get tipVoiceAdd =>
      'Mondjon egy vagy több terméket, és ellenőrizze őket hozzáadás előtt';

  @override
  String get tipShelfCamera => 'Olvassa le az árat a polccímkéről a kamerával';

  @override
  String get tipPlan => 'Az Ön csomagja: részletek, előfizetés vagy váltás';

  @override
  String get guideAddBody =>
      'Koppintson a +-ra egy termék hozzáadásához. Írja be a tervezett árat most, a piaci árat a pénztárnál.';

  @override
  String get guideVoiceBody =>
      'Koppintson a mikrofonra, és mondja el a termékeket, például: \'1 kiló alma, 1 kenyér\'.';

  @override
  String get guideReceiptBody =>
      'Olvassa be a nyugtát, hogy az árait a listája termékeivel egyeztesse.';

  @override
  String get guidePlanBody =>
      'Koppintson a csomagikonra a csomag megtekintéséhez, előfizetéshez vagy váltáshoz.';

  @override
  String get guideNext => 'OK';

  @override
  String get guideDone => 'Indítás';

  @override
  String get paletteLabel => 'Színtéma';

  @override
  String get paletteForest => 'Erdő';

  @override
  String get paletteOcean => 'Óceán';

  @override
  String get paletteSunset => 'Naplemente';

  @override
  String get paletteLavender => 'Levendula';

  @override
  String get darkBlackLabel => 'Tiszta fekete sötét témában';

  @override
  String get spendingOverview => 'Áttekintés';

  @override
  String get spendingThisYear => 'Idén';

  @override
  String get spendingYearly => 'Éves költés';

  @override
  String get productSpending => 'Költés termékenként';

  @override
  String get spanWeek => 'Hét';

  @override
  String get spanMonth => 'Hónap';

  @override
  String get spanYear => 'Év';

  @override
  String get weeklyLimitTitle => 'Heti limit';

  @override
  String get weeklyLimitHelp => 'Mennyit szeretne hetente vásárlásra költeni?';

  @override
  String get weeklyLimitNone =>
      'Állítson be heti limitet, hogy lássa, mennyi maradt.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'Ezen a héten $amount maradt';
  }

  @override
  String get shoppingLimitTitle => 'Vásárlásonkénti limit';

  @override
  String get shoppingLimitHelp => 'Az új listák ezzel a kerettel indulnak.';

  @override
  String get shoppingLimitNone =>
      'Állítson be alapértelmezett keretet minden új vásárláshoz.';

  @override
  String get monthlyReportAction => 'Havi jelentés';

  @override
  String get reportShoppingColumn => 'Vásárlás';

  @override
  String get reportDateColumn => 'Dátum';

  @override
  String get planUnavailable => 'Jelenleg nem érhető el az áruházban';

  @override
  String get demoDataTitle => 'Mintaadatok';

  @override
  String get demoDataLoad => 'Kipróbálás mintaadatokkal';

  @override
  String get demoDataLoadHelp =>
      '12 hónapnyi mintavásárlást ad hozzá, hogy lássa az előzményeket, grafikonokat és ártörténetet.';

  @override
  String get demoDataRemove => 'Mintaadatok törlése';

  @override
  String get demoDataAdded => 'Mintaadatok hozzáadva';

  @override
  String get demoDataRemoved => 'Mintaadatok törölve';

  @override
  String get demoProductApple => 'Alma';

  @override
  String get demoProductBread => 'Kenyér';

  @override
  String get demoProductMilk => 'Tej';

  @override
  String get demoProductCheese => 'Sajt';

  @override
  String get demoProductTomato => 'Paradicsom';

  @override
  String get demoProductEggs => 'Tojás';

  @override
  String get demoProductCoffee => 'Kávé';

  @override
  String get demoProductDetergent => 'Mosószer';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Súgó és támogatás';

  @override
  String get howToUseLabel => 'Használati útmutató';

  @override
  String get guidePricesBody =>
      'A bolti ár megadása megvásároltnak jelöli a tételt; a 0 is érvényes. Az otthoni ár nem kötelező. A jelölés törléséhez töröld a bolti árat.';

  @override
  String get shoppingDateLabel => 'Vásárlás dátuma';

  @override
  String get shoppingDateNone => 'Nincs dátum kiválasztva';

  @override
  String get clearShoppingDateAction => 'Dátum törlése';

  @override
  String get listSortLabel => 'Lista sorrendje';

  @override
  String get listSortDate => 'Vásárlás dátuma';

  @override
  String get listSortAz => 'Név (A–Z)';

  @override
  String get listSortManual => 'Kézi sorrend';

  @override
  String get imageCameraAction => 'Fénykép készítése';

  @override
  String get imageGalleryAction => 'Választás a fotók közül';

  @override
  String get imageCaptureFailed =>
      'Nem sikerült megnyitni a kamerát vagy a fotókat. Ellenőrizd a hozzáférési engedélyt, és próbáld újra.';

  @override
  String get imageRecognitionFailed =>
      'Nem sikerült feldolgozni a fotót. Próbálj másik fotót.';

  @override
  String get receiptNoProducts =>
      'A szöveg olvasható volt, de a nyugta tételei nem találhatók. A tételek és a végösszeg is legyen a fotón.';

  @override
  String get keepAwakeOn => 'A képernyő bekapcsolva marad';

  @override
  String get keepAwakeOff => 'A képernyő kikapcsolhat';

  @override
  String get spanDay => 'Nap';

  @override
  String get spanCustom => 'Dátumtartomány';

  @override
  String get reportTotalSpent => 'Összes kiadás';

  @override
  String get reportAddedAt => 'Hozzáadva';

  @override
  String get reportReceiptNumber => 'Nyugtaszám';

  @override
  String get reportPreview => 'Előnézet';

  @override
  String get reportShareAction => 'Megosztás';

  @override
  String get previousPeriodAction => 'Előző időszak';

  @override
  String get nextPeriodAction => 'Következő időszak';

  @override
  String get reportSaved => 'A jelentés mentve.';

  @override
  String get reportZoom => 'Nagyítás';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days nap van hátra',
      one: '$days nap van hátra',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours óra van hátra',
      one: '$hours óra van hátra',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Lejárt a Pro próbaidőszakod';

  @override
  String get planTrialEndedBody =>
      'Továbbra is ingyen használhatod a listákat, a kézi bevitelt és az eszközön működő hangfunkciót. Az ingyenes csomag naptári hónaponként 10 AI-kérést tartalmaz. Válaszd az éves Prót havi 100 AI-kérésért, reklámok nélkül és biztonsági mentésekkel. A meglévő adataid megmaradnak.';

  @override
  String get planContinueFree => 'Folytatás ingyenesen';

  @override
  String get supportIdLabel => 'Támogatási azonosító';

  @override
  String get supportEmailLabel => 'E-mailes támogatás';

  @override
  String get captureTipFirst =>
      'Kezdje a legfelülről: az üzlet nevének és a dátumnak látszania kell. Annyi tételt vegyen fel, amennyi elfér; a többi a következő fotóra kerül.';

  @override
  String get captureTipContinue =>
      'Ugyanaz a nyugta: az előző fotó utolsó tételét is tegye rá.';

  @override
  String get captureTipNeverShow => 'Ne jelenjen meg újra';

  @override
  String get captureTipOk => 'Értem';

  @override
  String get captureTipsSetting => 'Nyugtafotózási tippek megjelenítése';
}
