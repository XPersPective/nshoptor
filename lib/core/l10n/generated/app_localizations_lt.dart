// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Planuokite namuose. Pirkite pagal planą.';

  @override
  String get listsTitle => 'Sąrašai';

  @override
  String get listsTabActive => 'Aktyvūs';

  @override
  String get listsTabCompleted => 'Užbaigti';

  @override
  String get listsTabArchived => 'Archivuota';

  @override
  String get newListButton => 'Naujas sąrašas';

  @override
  String get listTitleHint => 'Pavadinimas (nebūtina)';

  @override
  String get saveButton => 'Išsaugoti';

  @override
  String get cancelButton => 'Atšaukti';

  @override
  String get deleteButton => 'Pašalinti';

  @override
  String get editAction => 'Redaguoti';

  @override
  String get listDeleted => 'Sąrašas pašalintas';

  @override
  String get invalidAmountError => 'Neteisinga suma';

  @override
  String get duplicateAction => 'Dvigubinti';

  @override
  String get archiveAction => 'Archivuoti';

  @override
  String get unarchiveAction => 'Atarchyvuoti';

  @override
  String get deleteListConfirm =>
      'Ar tikrai norite pašalinti šį sąrašą? Jo suplanuoti produktai taip pat bus pašalinti.';

  @override
  String get undoButton => 'Anuliuoti';

  @override
  String get searchListHint => 'Ieškoti sąrašų';

  @override
  String get currencyLabel => 'Valiuta';

  @override
  String get budgetLabel => 'Biudžetas (nebūtina)';

  @override
  String get noteLabel => 'Pastaba (nebūtina)';

  @override
  String get storeLabel => 'Parduotuvė';

  @override
  String get keepAmountsAction => 'Palikti sumas';

  @override
  String get resetAmountsAction => 'Atstatyti sumas';

  @override
  String get currencyChangeWarning =>
      'Valiuta keičiasi. Ką daryti su esamomis sumomis?';

  @override
  String get listsEmpty =>
      'Dar nėra sąrašų. Sukurkite savo pirmąjį pirkinių planą.';

  @override
  String get statusDraft => 'Juodraštis';

  @override
  String get statusPlanned => 'Suplanuota';

  @override
  String get statusShopping => 'Perkama';

  @override
  String get statusCompleted => 'Užbaigta';

  @override
  String get statusArchived => 'Archivuota';

  @override
  String autoListTitle(String date) {
    return '$date pirkiniai';
  }

  @override
  String get itemFormTitle => 'Pridėti prekę';

  @override
  String get itemNameLabel => 'Prekės pavadinimas';

  @override
  String get brandLabel => 'Prekės ženklas / variantas (nebūtina)';

  @override
  String get categoryLabel => 'Kategorija';

  @override
  String get quantityLabel => 'Kiekis';

  @override
  String get unitLabel => 'Matas';

  @override
  String get pricingModeLabel => 'Kainos įvedimas';

  @override
  String get pricingModeUnitPrice => 'Vieneto kaina';

  @override
  String get pricingModeLineTotal => 'Eilutės suma';

  @override
  String get plannedPriceLabel => 'Suplanuota kaina';

  @override
  String lineTotalCalculated(String value) {
    return 'Eilutės suma: $value';
  }

  @override
  String get requiredItemToggle => 'Būtina prekė';

  @override
  String get maxPriceLabel => 'Maksimali priimtina kaina (nebūtina)';

  @override
  String get itemNoteLabel => 'Pastaba (nebūtina)';

  @override
  String get categoryProduce => 'Vaisiai ir daržovės';

  @override
  String get categoryDairy => 'Pienas';

  @override
  String get categoryMeat => 'Mėsa';

  @override
  String get categoryBakery => 'Kepiniai';

  @override
  String get categoryDrinks => 'Gėrimai';

  @override
  String get categoryCleaning => 'Valymo priemonės';

  @override
  String get categoryPersonalCare => 'Asmeninė higiena';

  @override
  String get categoryHome => 'Namams';

  @override
  String get categoryOther => 'Kita';

  @override
  String get invalidQuantityError => 'Neteisingas kiekis';

  @override
  String get invalidPriceError => 'Neteisinga kaina';

  @override
  String get invalidNameError => 'Įveskite pavadinimą';

  @override
  String unitPriceCalculated(String value) {
    return 'Vieneto kaina: $value';
  }

  @override
  String get shoppingTitle => 'Pirkimo režimas';

  @override
  String get summaryPlannedTotal => 'Suplanuota';

  @override
  String get summaryInCart => 'Krepšelyje';

  @override
  String get summaryRemainingPlan => 'Likusi dalis';

  @override
  String get summaryProjected => 'Apytikslė suma';

  @override
  String get summaryBudgetRemaining => 'Liko biudžeto';

  @override
  String get summaryBudgetOver => 'Viršijo biudžetą';

  @override
  String itemsProgress(String done, String total) {
    return '$done iš $total prekių';
  }

  @override
  String get filterAll => 'Visos';

  @override
  String get filterToBuy => 'Pirkti';

  @override
  String get filterInCart => 'Krepšelyje';

  @override
  String get filterNotFound => 'Nerasta';

  @override
  String get filterRequired => 'Būtinos';

  @override
  String get quickEntryTitle => 'Faktinė kaina';

  @override
  String get actualQuantityLabel => 'Faktinis kiekis';

  @override
  String get actualPriceLabel => 'Faktinė kaina';

  @override
  String get discountLabel => 'Nuolaida (nebūtina)';

  @override
  String get alternativeNameLabel =>
      'Alternatyvaus produkto pavadinimas (nebūtina)';

  @override
  String get savePurchaseButton => 'Įdėti į krepšelį';

  @override
  String get unplannedAddButton => 'Pridėti neplanuotą prekę';

  @override
  String get statusPending => 'Neimta';

  @override
  String get statusInCart => 'Krepšelyje';

  @override
  String get statusNotFound => 'Nerasta';

  @override
  String get statusGaveUp => 'Atsisakyta';

  @override
  String get statusAlternative => 'Rinktas alternatyvus produktas';

  @override
  String get keepScreenAwake => 'Laikyti ekraną aktyvų';

  @override
  String get finishShopping => 'Baigti pirkimą';

  @override
  String get completionWarning =>
      'Yra nepilnų arba nepatikrintų įrašų. Vis tiek galite baigti; rezultate bus pažymėtos šios detalės.';

  @override
  String get continueShoppingButton => 'Tęsti pirkimą';

  @override
  String get resultTitle => 'Rezultatas';

  @override
  String get summarySection => 'Apibendrinimas';

  @override
  String get plannedTotalLabel => 'Suplanuota suma';

  @override
  String get actualTotalLabel => 'Faktinė suma';

  @override
  String get varianceLabel => 'Skirtumas';

  @override
  String get varianceNotComputable => 'Negalima apskaičiuoti';

  @override
  String get budgetStatusLabel => 'Biudžetas';

  @override
  String get savingsLabel => 'Mažiau nei planuota';

  @override
  String get overspendLabel => 'Daugiau nei planuota';

  @override
  String get unplannedTotalLabel => 'Neplanuota suma';

  @override
  String get unpurchasedLabel => 'Suplanuota, bet nepirktą';

  @override
  String get totalDiscountLabel => 'Bendra nuolaida';

  @override
  String get accuracyLabel => 'Įvertinimo tikslumas';

  @override
  String get groupsSection => 'Prekės';

  @override
  String get groupPricier => 'Brangiau nei planuota';

  @override
  String get groupCheaper => 'Pigiau nei planuota';

  @override
  String get groupClose => 'Artima įverčiui';

  @override
  String get groupNotTaken => 'Suplanuota, nepirkta';

  @override
  String get groupUnplanned => 'Pirkta be plano';

  @override
  String get groupQuantityChanged => 'Kiekis pasikeitė';

  @override
  String get groupUnverified => 'Nepatvirtinta';

  @override
  String get plannedQtyLabel => 'Suplanuotas kiekis';

  @override
  String get actualQtyLabel => 'Faktinis kiekis';

  @override
  String get plannedUnitPriceLabel => 'Suplanuota vieneto kaina';

  @override
  String get actualUnitPriceLabel => 'Faktinė vieneto kaina';

  @override
  String get lineVarianceLabel => 'Eilutės skirtumas';

  @override
  String get discountEffectLabel => 'Nuolaidos poveikis';

  @override
  String get notBoughtMark => 'nepirkta';

  @override
  String get noPurchasesNote => 'Pirkimų nebuvo užregistruota.';

  @override
  String get navHome => 'Pradžia';

  @override
  String get navLists => 'Sąrašai';

  @override
  String get navHistory => 'Istorija';

  @override
  String get navSettings => 'Nustatymai';

  @override
  String get homeEmptyTitle => 'Suplanuokite apsipirkimą';

  @override
  String get homeEmptyBody =>
      'Sukurkite pirmąjį sąrašą ir palyginkite numatomas bei faktines išlaidas.';

  @override
  String get homeActiveSection => 'Aktyvūs sąrašai';

  @override
  String get homeCompletedSection => 'Neseniai užbaigti';

  @override
  String get homeMonthlySection => 'Šį mėnesį';

  @override
  String get monthPlannedLabel => 'Numatyta';

  @override
  String get monthActualLabel => 'Faktinė';

  @override
  String get monthVarianceLabel => 'Skirtumas';

  @override
  String get continueShoppingLabel => 'Tęsti apsipirkimą';

  @override
  String get historyEmpty =>
      'Dar nėra užbaigtų apsipirkimų. Jūsų istorija ir įžvalgos bus rodomos čia.';

  @override
  String get aboutTabTitle => 'Apie NShoptor';

  @override
  String get aboutBody =>
      'NShoptor by Crazy Penguin. Pirmiausia veikiantis offline apsipirkimo planuotojas. Licencijuota pagal GPL-3.0.';

  @override
  String get startShoppingLabel => 'Pradėti apsipirkimą';

  @override
  String get finishAndSeeResult => 'Užbaigti ir peržiūrėti rezultatą';

  @override
  String get settingsTitle => 'Nustatymai';

  @override
  String get languageLabel => 'Kalba';

  @override
  String get languageSystem => 'Sistemos';

  @override
  String get languageTr => 'Turkų';

  @override
  String get languageEn => 'Anglų';

  @override
  String get themeLabel => 'Temą';

  @override
  String get themeSystem => 'Sistemos';

  @override
  String get themeLight => 'Šviesi';

  @override
  String get themeDark => 'Tamsi';

  @override
  String get defaultCurrencyLabel => 'Numatyta valiuta';

  @override
  String get defaultUnitLabel => 'Numatyta matavimo vienetai';

  @override
  String get keepAwakeLabel => 'Laikyti ekraną aktyvų apsipirkimo metu';

  @override
  String get backupSection => 'Atsarginės kopijos';

  @override
  String get exportBackupLabel => 'Eksportuoti atsarginę kopiją';

  @override
  String get importBackupLabel => 'Importuoti atsarginę kopiją';

  @override
  String get mergeImportLabel => 'Sujungti su dabartiniais duomenimis';

  @override
  String get separateImportLabel => 'Importuoti kaip atskirą kopiją';

  @override
  String get importCancelled => 'Importas atšauktas.';

  @override
  String get backupExported => 'Atsarginė kopija sėkmingai eksportuota.';

  @override
  String get backupSizeWarning =>
      'Didelė atsarginė kopija: failas gali būti didelis. Ar norite įtraukti ir nuotraukas?';

  @override
  String get deleteAllSection => 'Pavojinga zona';

  @override
  String get deleteAllLabel => 'Ištrinti visus duomenis';

  @override
  String get deleteAllConfirm =>
      'Tai pašalins visus sąrašus, istoriją, kvitų nuotraukas ir kainas. Jūsų eksportuoti failai liks jūsų diske. Tęsti?';

  @override
  String get deleteAllConfirm2 =>
      'Ar tikrai esate visiškai įsitikinęs? Šio veiksmo negalima atšaukti.';

  @override
  String get cancelAction => 'Atšaukti';

  @override
  String get confirmDelete => 'Ištrinti visam laikui';

  @override
  String get dataDeleted => 'Visi vietiniai duomenys buvo ištrinti.';

  @override
  String get privacyInfoLabel => 'Privatumas';

  @override
  String get privacyInfoBody =>
      'Jūsų sąrašai, kainos, kvitai ir nuotraukos lieka jūsų įrenginyje. Nuotraukos ir balsas niekada jo nepalieka. Kai naudojama AI pagalba, į mūsų serverį siunčiamas tik tekstas (pvz., kvito eilutės arba tai, ką diktuojate) apdorojimui ir jis nėra saugomas.';

  @override
  String get aboutSection => 'Apie';

  @override
  String get aboutPublisher => 'Leidėjas: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licencijos (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Balso įvestis';

  @override
  String get voiceStatusUnknown => 'Paslauga: netikrinta';

  @override
  String get permissionsLabel => 'Teisės';

  @override
  String get permissionsBody =>
      'Kamera, mikrofonas ir pranešimai praunami tik tada, kai realiai naudojatės šiomis funkcijomis.';

  @override
  String get unitsSection => 'Numatytieji';

  @override
  String get roundingNote =>
      'Pinigų suapvalinimas vadovaujasi vienu taisykle: pusės suapvalinamos tolyn nuo nulio, taikoma vieną kartą konvertuojant į pinigus.';

  @override
  String get voiceInputTitle => 'Balso įvestis';

  @override
  String get voiceStartListening => 'Pradėti klausytis';

  @override
  String get voiceTranscriptLabel => 'Transkriptas';

  @override
  String get parseAction => 'Analizuoti';

  @override
  String get receiptReviewTitle => 'Peržiūrėti kvitą';

  @override
  String get receiptTotal => 'Pajamų kvito suma';

  @override
  String get receiptTotalUnknown => 'Suma nenustatyta';

  @override
  String get receiptDiff => 'Skirtumas';

  @override
  String get acceptLine => 'Patvirtinti eilutę';

  @override
  String get ignoreLine => 'Ignoruoti eilutę';

  @override
  String get receiptLineActions => 'Susieti su preke, padalinti arba ignoruoti';

  @override
  String get receiptCommit => 'Patvirtinti viską';

  @override
  String get receiptCommitted => 'Kvitas pritaikytas.';

  @override
  String get priceHistoryTitle => 'Kainos istorija';

  @override
  String get noObservations => 'Kainos stebėjimų dar nėra';

  @override
  String get templatesSection => 'Šablonai';

  @override
  String get templateHint => 'Sukurkite naują sąrašą iš ankstesnio apsipirkimo';

  @override
  String get scanReceiptAction => 'Nuskenuoti kvitą';

  @override
  String get shelfLabelAction => 'Kaina nuo lentynos etiketės';

  @override
  String get priceCandidatesTitle => 'Kainos variantai';

  @override
  String get noPriceCandidates => 'Kainos nerasta; įveskite ją rankiniu būdu.';

  @override
  String get voiceUnavailable =>
      'Balso atpažinimas neprieinamas; įveskite rankiniu būdu.';

  @override
  String get linkToItem => 'Susieti su preke';

  @override
  String get splitLine => 'Padalinti į dvi dalis';

  @override
  String get mergeWithNext => 'Sujungti su kitu';

  @override
  String get ocrNoText => 'Teksto nenuskaityta; bandykite dar kartą.';

  @override
  String get priceHistoryAction => 'Kainos istorija';

  @override
  String get itemsEmptyTitle => 'Prekių dar nėra';

  @override
  String get itemsEmptyBody =>
      'Pridėkite pirmąją prekę – čia parduotuvėje įveskite realias kainas.';

  @override
  String get addItemTooltip => 'Pridėti prekę';

  @override
  String get unitAdet => 'vnt.';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'pak.';

  @override
  String get unitKutu => 'dėž.';

  @override
  String get unitSise => 'butelis';

  @override
  String get unitKavanoz => 'indas';

  @override
  String get unitDemet => 'rišulys';

  @override
  String get unitDuzine => 'dešimtis';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Kita';

  @override
  String get setReminderAction => 'Nustatyti priminimą';

  @override
  String get reminderPermissionDenied =>
      'Priminsiams reikia pranešimų leidimo. Jį galite įjungti sistemos nustatymuose.';

  @override
  String get reminderScheduled => 'Priminimas nustatytas.';

  @override
  String get reminderCancelled => 'Priminimas pašalintas.';

  @override
  String get reminderTitle => 'Atpirkimo priminimas';

  @override
  String reminderBody(Object title) {
    return 'Laikas patikrinti sąrašą: $title';
  }

  @override
  String get reminderPickDate => 'Pasirinkite datą';

  @override
  String get reminderPickTime => 'Pasirinkite laiką';

  @override
  String get itemDetailsSection => 'Išsami informacija';

  @override
  String get priceOptionalHint =>
      'Neprivaloma – realią kainą įvesite parduotuvėje';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Suplanuota: $total · $count prekės';
  }

  @override
  String get proActiveLabel => 'Pro aktyvus – ačiū!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Be reklamų, daugiau AI, atsarginės kopijos · už nedidelę mėnesinę kainą';

  @override
  String get proBenefitNoAds => 'Patirtis be reklamų';

  @override
  String get proBenefitBackup => 'Atsarginės kopijos (eksportas/importas)';

  @override
  String aboutVersion(Object version) {
    return 'Versija $version';
  }

  @override
  String get navDiscover => 'Atrasti';

  @override
  String get shareAction => 'Dalintis apie programėlę';

  @override
  String get rateAction => 'Įvertinkite mus';

  @override
  String get aboutOpenRow => 'Apie & atvirojo kodo';

  @override
  String get voiceAddItemAction => 'Pridėti balsu';

  @override
  String get formatLocaleLabel => 'Skaičių ir valiutos formatavimas';

  @override
  String get formatLocaleSystem =>
      'Įrenginio formatas (Lotyniški skaitmenys; kitu atveju anglų kalba)';

  @override
  String get formatLocaleTr => 'Turkų (1.234,56)';

  @override
  String get formatLocaleEn => 'Anglų (1,234.56)';

  @override
  String get aiToggleTitle => 'AI pagalba';

  @override
  String get aiToggleSubtitle =>
      'Sulygina čekius, skaito kainas ir paverčia sakinius sąrašais. Nuotraukos ir balsas lieka jūsų įrenginyje; apdorojamas tik tekstas.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Šį mėnesį išnaudojote AI užklausas ($used/$limit). Atnaujinkite planą, kad gautumėte daugiau, arba tęskite be AI.';
  }

  @override
  String get aiOffline => 'Nėra ryšio – tęsiama be AI.';

  @override
  String get aiFailed => 'AI šiuo metu neprieinamas – tęsiama be jo.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Įrenginys';

  @override
  String get quickListAction => 'Pridėti iš sakinio';

  @override
  String get quickListTitle => 'Greitasis sąrašas';

  @override
  String get quickListHint =>
      'pvz., 1 kg obuolių 20, 2 bandelės, pusė kilo sūrio';

  @override
  String get quickListConvert => 'Paversti į sąrašą';

  @override
  String quickListAdd(int count) {
    return 'Pridėti $count prekių';
  }

  @override
  String get quickListEmpty =>
      'Prekių nerasta. Pabandykite jas išvardyti kableliais atskirtu sąrašu.';

  @override
  String get receiptAiMatched =>
      'AI susietą čekį su jūsų sąrašu. Patikrinkite nuorodas ir patvirtinkite.';

  @override
  String get receiptNeedsCheck => 'Patikrinkite šį sutapimą';

  @override
  String get receiptDiscountLine => 'Nuolaida';

  @override
  String get compareItem => 'Prekė';

  @override
  String get compareEstimated => 'Planuota';

  @override
  String get compareActual => 'Faktinė';

  @override
  String get compareDiff => 'Skirtumas';

  @override
  String get compareTotal => 'Iš viso';

  @override
  String get compareBudget => 'Biudžetas';

  @override
  String get compareNotBought => 'nenupirkta';

  @override
  String get compareUnplanned => 'neplanuota';

  @override
  String get pricierItems => 'Brangiau';

  @override
  String get cheaperItems => 'Pigiau';

  @override
  String get compareAction => 'Lyginti';

  @override
  String get detailsSection => 'Detalės';

  @override
  String get spendingTitle => 'Išlaidos';

  @override
  String get spendingAction => 'Išlaidos';

  @override
  String get spendingMonthTotal => 'Šį mėnesį';

  @override
  String get spendingWeekly => 'Savaitinės išlaidos';

  @override
  String get spendingMonthly => 'Mėnesinės išlaidos';

  @override
  String get monthlyLimitTitle => 'Mėnesinis limitas';

  @override
  String get monthlyLimitHelp =>
      'Kiek norite skirti maisto pirkimams per mėnesį?';

  @override
  String get monthlyLimitRemove => 'Pašalinti';

  @override
  String get monthlyLimitSet => 'Nustatyti';

  @override
  String get monthlyLimitChange => 'Keisti';

  @override
  String get monthlyLimitNone =>
      'Nustatykite mėnesinį limitą, kad matytumėte, kiek liko.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount viršijo limitą';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount liko šiam mėnesiui';
  }

  @override
  String get plansTitle => 'Planai';

  @override
  String get plansHeadline => 'Pirkite protingiau su AI';

  @override
  String get plansSubhead =>
      'Čekų sutapimas, kainų etikečių skaitymas ir sąrašai iš sakinio. Atsisakykite bet kada.';

  @override
  String get plansMonthly => 'Mėnesinis';

  @override
  String get plansYearly => 'Metinis';

  @override
  String get planFree => 'Nemokamas';

  @override
  String get planFreePrice => 'Visada nemokamai';

  @override
  String get planFreeAi => '10 AI užklausų per mėnesį';

  @override
  String get planFreeAds =>
      'Maži baneriniai reklamos pranešimai (pirmąsias 7 dienas jų nėra)';

  @override
  String get planCoreFeatures => 'Sąrašai, kainos, čekiai, išlaidų grafikai';

  @override
  String get plansPerYear => '/ metai';

  @override
  String get plansPerMonth => '/ mėnuo';

  @override
  String get planTrial => '7 dienos nemokamai';

  @override
  String get planProAi => '100 AI užklausų per mėnesį';

  @override
  String get planNoAds => 'Be reklamų';

  @override
  String get planBackup => 'Atsarginės kopijos eksportas ir importavimas';

  @override
  String get planMaxAi => '300 AI užklausų per mėnesį';

  @override
  String get planMaxFamily => 'Didelės šeimos pirkiniams';

  @override
  String get plansStoreUnavailable => 'Parduotuvė šiuo metu nepasiekiama.';

  @override
  String get retryAction => 'Bandyti dar kartą';

  @override
  String get plansPurchaseFailed => 'Pirkimas nepavyko. Bandykite dar kartą.';

  @override
  String get planLifetimeTitle => 'Be reklamų visam gyvenimui';

  @override
  String get planLifetimeSubtitle =>
      'Vienkartinis mokėjimas: be reklamų, atsarginės kopijos; AI paslauga lieka nemokama';

  @override
  String get plansRestore => 'Atkurti pirkinius';

  @override
  String get plansLegal =>
      'Prenumeratos automatiškai atnaujinamos, kol neatsakysite. Atsisakyti bet kada „Google Play“ › Mokėjimai ir prenumeratos. Kainos apima „Google Play“ rodomus mokesčius.';

  @override
  String get planCurrent => 'Dabartinė';

  @override
  String get planStartTrial => 'Pradėti 7 dienų nemokamą bandomąją versiją';

  @override
  String get planChoose => 'Pasirinkti';

  @override
  String get plansAction => 'Planai: Pro ir Max';

  @override
  String get assistantTitle => 'Asistentas';

  @override
  String get assistantGreeting => 'Sveiki! Ko norėtumėte padaryti?';

  @override
  String get assistantNewList => 'Naujas sąrašas';

  @override
  String get assistantVoiceList => 'Sąrašas balsu';

  @override
  String get assistantTextList => 'Sąrašas iš sakinio';

  @override
  String get assistantScanReceipt => 'Skenuoti kvitą';

  @override
  String get assistantSpending => 'Mano išlaidos';

  @override
  String get assistantReceiptHint =>
      'Atidarykite savo sąrašą ir bakstelėkite kvito ikoną, kad jį nuskenuotumėte.';

  @override
  String get assistantToggleTitle => 'Rodyti asistentą';

  @override
  String get assistantToggleSubtitle =>
      'Mažas pagalbininkas dešiniajame apačios kampe';

  @override
  String get scanPriceLabel => 'Skenuoti kainos etiketę';

  @override
  String get saveFailed =>
      'Nepavyko išsaugoti. Jūsų pakeitimai vis dar čia. Bandykite dar kartą.';

  @override
  String get deleteItemConfirm =>
      'Ištrinti šį elementą ir jo įrašytus pirkinius?';

  @override
  String get clearPurchaseConfirm =>
      'Nuimti žymėjimą iš šio elemento ir pašalinti jo įrašytus pirkinius?';

  @override
  String get reportPdfAction => 'Įrašyti PDF ataskaitą';

  @override
  String get reportNotInvoice =>
      'Pirkinių santrauka, ne mokesčių sąskaita. Mokesčių tarifai nežinomi.';

  @override
  String get purchaseVisits => 'Apsilankymai parduotuvėje';

  @override
  String get purchaseInterval => 'Vidutinės dienos tarp pirkinių';

  @override
  String get purchasedQuantity => 'Perkama kiekis';

  @override
  String get purchaseAnalyticsHint =>
      'Pirkiniai nematuojami kaip vartojimas. Valiutos ir vienetai rodomi atskirai.';

  @override
  String get receiptReplaces =>
      'Susietos čekio eilutės pakeičia esamus pirkinius; nesusietos eilutės pridedamos.';

  @override
  String get voiceUnsupportedLanguage =>
      'Ši kalba šiame įrenginyje nepalaikoma balso įvesties funkcijai. Vietoj to galite rašyti.';

  @override
  String get voiceStopListening => 'Nustoti klausytis';

  @override
  String get keepAwakeFailed =>
      'Nepavyko išlaikyti ekrano įjungto. Bandykite dar kartą.';

  @override
  String get purchaseHistoryHint =>
      'Visos užbaigtos pirkinių išvykos. Grąžinimai mažina bendras sumas. Datos nurodo pirkinių išvykų pabaigą. Viena išvyka nepakanka vidurkio intervalui apskaičiuoti.';

  @override
  String get planLegacyRights =>
      'Esančios „Pro“ ir „Max“ prenumeracijos išlaiko savo pradinį mėnesinį AI leidimą. Naujose pasiūlymuose yra 100 ir 300 užklausų.';

  @override
  String get csvExportAction => 'Eksportuoti CSV';
}
