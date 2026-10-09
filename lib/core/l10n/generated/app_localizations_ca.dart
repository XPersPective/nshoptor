// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Planifica a casa. Compra segons el pla.';

  @override
  String get listsTitle => 'Llistes';

  @override
  String get listsTabActive => 'Actives';

  @override
  String get listsTabCompleted => 'Completades';

  @override
  String get listsTabArchived => 'Arxivades';

  @override
  String get newListButton => 'Nova llista';

  @override
  String get listTitleHint => 'Títol (opcional)';

  @override
  String get saveButton => 'Desa';

  @override
  String get cancelButton => 'Cancel·la';

  @override
  String get deleteButton => 'Suprimeix';

  @override
  String get editAction => 'Edita';

  @override
  String get listDeleted => 'Llista suprimida';

  @override
  String get invalidAmountError => 'Import no vàlid';

  @override
  String get duplicateAction => 'Duplica';

  @override
  String get archiveAction => 'Arxiva';

  @override
  String get unarchiveAction => 'Treu de l\'arxiu';

  @override
  String get deleteListConfirm =>
      'Vols suprimir aquesta llista? Els elements planificats també s\'esborraran.';

  @override
  String get undoButton => 'Desfés';

  @override
  String get searchListHint => 'Cerca llistes';

  @override
  String get currencyLabel => 'Moneda';

  @override
  String get budgetLabel => 'Pressupost (opcional)';

  @override
  String get noteLabel => 'Nota (opcional)';

  @override
  String get storeLabel => 'Botiga';

  @override
  String get keepAmountsAction => 'Mantén els imports';

  @override
  String get resetAmountsAction => 'Restableix els imports';

  @override
  String get currencyChangeWarning =>
      'La moneda està canviant. Què ha de passar amb els imports existents?';

  @override
  String get listsEmpty =>
      'Encara no hi ha llistes. Crea el teu primer pla de compres.';

  @override
  String get statusDraft => 'Esborrany';

  @override
  String get statusPlanned => 'Planificat';

  @override
  String get statusShopping => 'Comprant';

  @override
  String get statusCompleted => 'Completat';

  @override
  String get statusArchived => 'Arxivada';

  @override
  String autoListTitle(String date) {
    return 'Compres del $date';
  }

  @override
  String get itemFormTitle => 'Afegeix un element';

  @override
  String get itemNameLabel => 'Nom de l\'element';

  @override
  String get brandLabel => 'Marca / variant (opcional)';

  @override
  String get categoryLabel => 'Categoria';

  @override
  String get quantityLabel => 'Quantitat';

  @override
  String get unitLabel => 'Unitat';

  @override
  String get pricingModeLabel => 'Tipus de preu';

  @override
  String get pricingModeUnitPrice => 'Preu per unitat';

  @override
  String get pricingModeLineTotal => 'Total de la línia';

  @override
  String get plannedPriceLabel => 'Preu previst';

  @override
  String lineTotalCalculated(String value) {
    return 'Total de la línia: $value';
  }

  @override
  String get requiredItemToggle => 'Element obligatori';

  @override
  String get maxPriceLabel => 'Preu màxim acceptable (opcional)';

  @override
  String get itemNoteLabel => 'Nota (opcional)';

  @override
  String get categoryProduce => 'Fruites i verdures';

  @override
  String get categoryDairy => 'Làctics';

  @override
  String get categoryMeat => 'Carn';

  @override
  String get categoryBakery => 'Pa i pastisseria';

  @override
  String get categoryDrinks => 'Begudes';

  @override
  String get categoryCleaning => 'Neteja';

  @override
  String get categoryPersonalCare => 'Higiene personal';

  @override
  String get categoryHome => 'Llar';

  @override
  String get categoryOther => 'Altres';

  @override
  String get invalidQuantityError => 'Quantitat no vàlida';

  @override
  String get invalidPriceError => 'Preu no vàlid';

  @override
  String get invalidNameError => 'Introdueix un nom';

  @override
  String unitPriceCalculated(String value) {
    return 'Preu unitari: $value';
  }

  @override
  String get shoppingTitle => 'Mode compra';

  @override
  String get summaryPlannedTotal => 'Previst';

  @override
  String get summaryInCart => 'A la cistella';

  @override
  String get summaryRemainingPlan => 'Pla restant';

  @override
  String get summaryProjected => 'Total estimat';

  @override
  String get summaryBudgetRemaining => 'Pressupost restant';

  @override
  String get summaryBudgetOver => 'Per sobre del pressupost';

  @override
  String itemsProgress(String done, String total) {
    return '$done de $total articles';
  }

  @override
  String get filterAll => 'Tots';

  @override
  String get filterToBuy => 'Per comprar';

  @override
  String get filterInCart => 'A la cistella';

  @override
  String get filterNotFound => 'No trobat';

  @override
  String get filterRequired => 'Obligatori';

  @override
  String get quickEntryTitle => 'Preu real';

  @override
  String get actualQuantityLabel => 'Quantitat real';

  @override
  String get actualPriceLabel => 'Preu real';

  @override
  String get discountLabel => 'Descompte (opcional)';

  @override
  String get alternativeNameLabel => 'Nom del producte alternatiu (opcional)';

  @override
  String get savePurchaseButton => 'Afegir a la cistella';

  @override
  String get unplannedAddButton => 'Afegir article no previst';

  @override
  String get statusPending => 'Pendent';

  @override
  String get statusInCart => 'A la cistella';

  @override
  String get statusNotFound => 'No trobat';

  @override
  String get statusGaveUp => 'Abandonat';

  @override
  String get statusAlternative => 'Alternativa comprada';

  @override
  String get keepScreenAwake => 'Mantenir la pantalla encesa';

  @override
  String get finishShopping => 'Finalitzar la compra';

  @override
  String get completionWarning =>
      'Hi ha registres pendents o sense verificar. Encara pots finalitzar; el resultat els indicarà.';

  @override
  String get continueShoppingButton => 'Continuar la compra';

  @override
  String get resultTitle => 'Resultat';

  @override
  String get summarySection => 'Resum';

  @override
  String get plannedTotalLabel => 'Total previst';

  @override
  String get actualTotalLabel => 'Total real';

  @override
  String get varianceLabel => 'Diferència';

  @override
  String get varianceNotComputable => 'No es pot calcular';

  @override
  String get budgetStatusLabel => 'Pressupost';

  @override
  String get savingsLabel => 'Estalvi respecte al pla';

  @override
  String get overspendLabel => 'Superació del pla';

  @override
  String get unplannedTotalLabel => 'Total no previst';

  @override
  String get unpurchasedLabel => 'Previst però no comprat';

  @override
  String get totalDiscountLabel => 'Descomptes totals';

  @override
  String get accuracyLabel => 'Precisió de l\'estimació';

  @override
  String get groupsSection => 'Articles';

  @override
  String get groupPricier => 'Més car del previst';

  @override
  String get groupCheaper => 'Més barat del previst';

  @override
  String get groupClose => 'Prop de l\'estimació';

  @override
  String get groupNotTaken => 'Previst, no comprat';

  @override
  String get groupUnplanned => 'Comprats sense previ avís';

  @override
  String get groupQuantityChanged => 'Quantitat canviada';

  @override
  String get groupUnverified => 'Sense verificar';

  @override
  String get plannedQtyLabel => 'Quantitat prevista';

  @override
  String get actualQtyLabel => 'Quantitat real';

  @override
  String get plannedUnitPriceLabel => 'Preu unitari previst';

  @override
  String get actualUnitPriceLabel => 'Preu unitari real';

  @override
  String get lineVarianceLabel => 'Diferència per línia';

  @override
  String get discountEffectLabel => 'Efecte del descompte';

  @override
  String get notBoughtMark => 'no comprat';

  @override
  String get noPurchasesNote => 'No s\'ha registrat cap compra.';

  @override
  String get navHome => 'Inici';

  @override
  String get navLists => 'Llistes';

  @override
  String get navHistory => 'Historial';

  @override
  String get navSettings => 'Configuració';

  @override
  String get homeEmptyTitle => 'Planifica la teva compra';

  @override
  String get homeEmptyBody =>
      'Crea la teva primera llista i compara els costos previstos amb els reals.';

  @override
  String get homeActiveSection => 'Llistes actives';

  @override
  String get homeCompletedSection => 'Completades recentment';

  @override
  String get homeMonthlySection => 'Aquest mes';

  @override
  String get monthPlannedLabel => 'Previst';

  @override
  String get monthActualLabel => 'Real';

  @override
  String get monthVarianceLabel => 'Diferència';

  @override
  String get continueShoppingLabel => 'Continua comprant';

  @override
  String get historyEmpty =>
      'Encara no hi ha compres completades. El teu historial i les estadístiques apareixeran aquí.';

  @override
  String get aboutTabTitle => 'Sobre NShoptor';

  @override
  String get aboutBody =>
      'NShoptor per Crazy Penguin. Planificador de compres offline-first. Llicenciat sota GPL-3.0.';

  @override
  String get startShoppingLabel => 'Comença a comprar';

  @override
  String get finishAndSeeResult => 'Acaba i veu el resultat';

  @override
  String get settingsTitle => 'Configuració';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get languageTr => 'Turc';

  @override
  String get languageEn => 'Anglès';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Clar';

  @override
  String get themeDark => 'Fosc';

  @override
  String get defaultCurrencyLabel => 'Moneda predeterminada';

  @override
  String get defaultUnitLabel => 'Unitat predeterminada';

  @override
  String get keepAwakeLabel => 'Mantén la pantalla encesa mentre compres';

  @override
  String get backupSection => 'Còpia de seguretat';

  @override
  String get exportBackupLabel => 'Exporta còpia de seguretat';

  @override
  String get importBackupLabel => 'Importa còpia de seguretat';

  @override
  String get mergeImportLabel => 'Fusiona amb les dades actuals';

  @override
  String get separateImportLabel => 'Importa com una còpia separada';

  @override
  String get importCancelled => 'Importació cancel·lada.';

  @override
  String get backupExported => 'Còpia de seguretat exportada correctament.';

  @override
  String get backupSizeWarning =>
      'Còpia de seguretat gran: el fitxer pot ser voluminós. Vols incloure també les fotos?';

  @override
  String get deleteAllSection => 'Zona de perill';

  @override
  String get deleteAllLabel => 'Esborra totes les dades';

  @override
  String get deleteAllConfirm =>
      'Això eliminarà totes les llistes, l\'historial, les fotos dels rebuts i els preus. Els fitxers que hagis exportat es mantindran al teu dispositiu. Continues?';

  @override
  String get deleteAllConfirm2 =>
      'Estàs completament segur? Aquesta acció no es pot desfer.';

  @override
  String get cancelAction => 'Cancel·la';

  @override
  String get confirmDelete => 'Elimina permanentment';

  @override
  String get dataDeleted => 'Totes les dades locals s\'han eliminat.';

  @override
  String get privacyInfoLabel => 'Privadesa';

  @override
  String get privacyInfoBody =>
      'Les teves llistes, preus, rebuts i fotos es queden al teu dispositiu. Les fotos i la veu mai el deixen. Quan l\'ajuda IA està activada, només s\'envia text (per exemple, les línies del rebut o el que dictis) al nostre servidor per ser processat i no es desa.';

  @override
  String get aboutSection => 'Quant a';

  @override
  String get aboutPublisher => 'Editor: Crazy Penguin';

  @override
  String get aboutLicenses => 'Llicències (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Entrada per veu';

  @override
  String get voiceStatusUnknown => 'Servei: no verificat';

  @override
  String get permissionsLabel => 'Permisos';

  @override
  String get permissionsBody =>
      'La càmera, el micròfon i les notificacions es demanen només quan utilitzes realment aquestes funcions.';

  @override
  String get unitsSection => 'Predeterminats';

  @override
  String get roundingNote =>
      'El arrodoniment monetari segueix una regla: els semis s\'arrodoneixen allunyant-se de zero, aplicat un cop en la conversió de diners.';

  @override
  String get voiceInputTitle => 'Entrada per veu';

  @override
  String get voiceStartListening => 'Comença a escoltar';

  @override
  String get voiceTranscriptLabel => 'Transcripció';

  @override
  String get parseAction => 'Analitza';

  @override
  String get receiptReviewTitle => 'Revisa el rebut';

  @override
  String get receiptTotal => 'Total del tiquet';

  @override
  String get receiptTotalUnknown => 'Total no detectat';

  @override
  String get receiptDiff => 'Diferència';

  @override
  String get acceptLine => 'Accepta la línia';

  @override
  String get ignoreLine => 'Ignora la línia';

  @override
  String get receiptLineActions => 'Vincula a l\'article, divideix o ignora';

  @override
  String get receiptCommit => 'Accepta-ho tot';

  @override
  String get receiptCommitted => 'Tiquet aplicat.';

  @override
  String get priceHistoryTitle => 'Historial de preus';

  @override
  String get noObservations => 'Encara no hi ha observacions de preus';

  @override
  String get templatesSection => 'Plantilles';

  @override
  String get templateHint => 'Crea un nou pla a partir d\'una compra anterior';

  @override
  String get scanReceiptAction => 'Escaneja el tiquet';

  @override
  String get shelfLabelAction => 'Preu de l\'etiqueta de l\'estanteria';

  @override
  String get priceCandidatesTitle => 'Candidats a preu';

  @override
  String get noPriceCandidates =>
      'No s\'ha trobat cap preu; introdueix-lo manualment.';

  @override
  String get voiceUnavailable =>
      'El reconeixement de veu no està disponible; introdueix-lo manualment.';

  @override
  String get linkToItem => 'Vincula a l\'article';

  @override
  String get splitLine => 'Divideix en dos';

  @override
  String get mergeWithNext => 'Fusiona amb el següent';

  @override
  String get ocrNoText => 'No s\'ha llegit text; torna-ho a provar.';

  @override
  String get priceHistoryAction => 'Historial de preus';

  @override
  String get itemsEmptyTitle => 'Encara no hi ha articles';

  @override
  String get itemsEmptyBody =>
      'Afegeix el teu primer article: aquí introduiràs els preus reals a la botiga.';

  @override
  String get addItemTooltip => 'Afegeix article';

  @override
  String get unitAdet => 'unitat';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'paquet';

  @override
  String get unitKutu => 'caixa';

  @override
  String get unitSise => 'ampolla';

  @override
  String get unitKavanoz => 'pot';

  @override
  String get unitDemet => 'branc';

  @override
  String get unitDuzine => 'dotzena';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Personalitzat';

  @override
  String get setReminderAction => 'Configura un recordatori';

  @override
  String get reminderPermissionDenied =>
      'Cal permís per a les notificacions per als recordatoris. El pots activar a la configuració del sistema.';

  @override
  String get reminderScheduled => 'Recordatori configurat.';

  @override
  String get reminderCancelled => 'Recordatori eliminat.';

  @override
  String get reminderTitle => 'Recordatori de compres';

  @override
  String reminderBody(Object title) {
    return 'És hora de revisar la teva llista: $title';
  }

  @override
  String get reminderPickDate => 'Tria una data';

  @override
  String get reminderPickTime => 'Tria una hora';

  @override
  String get itemDetailsSection => 'Detalls';

  @override
  String get priceOptionalHint =>
      'Opcional: introduiràs el preu real a la botiga';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Previst: $total · $count articles';
  }

  @override
  String get proActiveLabel => 'Pro actiu — gràcies!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Sense anuncis, més IA, còpia de seguretat · des d\'un petit preu mensual';

  @override
  String get proBenefitNoAds => 'Experiència sense anuncis';

  @override
  String get proBenefitBackup => 'Còpia de seguretat (exporta/importa)';

  @override
  String aboutVersion(Object version) {
    return 'Versió $version';
  }

  @override
  String get navDiscover => 'Descobreix';

  @override
  String get shareAction => 'Comparteix l\'app';

  @override
  String get rateAction => 'Valora\'ns';

  @override
  String get aboutOpenRow => 'Quant a i codi obert';

  @override
  String get voiceAddItemAction => 'Afegeix per veu';

  @override
  String get formatLocaleLabel => 'Format de nombre i moneda';

  @override
  String get formatLocaleSystem =>
      'Format del dispositiu (xifres llatines; altrament, anglès)';

  @override
  String get formatLocaleTr => 'Turc (1.234,56)';

  @override
  String get formatLocaleEn => 'Anglès (1,234.56)';

  @override
  String get aiToggleTitle => 'Ajuda IA';

  @override
  String get aiToggleSubtitle =>
      'Concilia rebuts, llegeix etiquetes de preu i converteix frases en llistes. Les fotos i la veu es queden al teu dispositiu; només es processa el text.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Has utilitzat les sol·licituds d\'IA del mes ($used/$limit). Millora el pla per obtenir-ne més o continua sense IA.';
  }

  @override
  String get aiOffline => 'Sense connexió — continuant sense IA.';

  @override
  String get aiFailed =>
      'La IA no està disponible ara mateix — continuant sense ella.';

  @override
  String get aiSourceLabel => 'IA';

  @override
  String get deviceSourceLabel => 'Dispositiu';

  @override
  String get quickListAction => 'Afegeix des d\'una frase';

  @override
  String get quickListTitle => 'Llista ràpida';

  @override
  String get quickListHint =>
      'p. ex. 1 kg pomes 20, 2 pans, mig quilogram de formatge';

  @override
  String get quickListConvert => 'Converteix en una llista';

  @override
  String quickListAdd(int count) {
    return 'Afegeix $count articles';
  }

  @override
  String get quickListEmpty =>
      'No s\'han trobat articles. Prova de llistar-los separats per comes.';

  @override
  String get receiptAiMatched =>
      'La IA ha conciliat el rebut amb la teva llista. Revisa els vincles i confirma\'ls.';

  @override
  String get receiptNeedsCheck => 'Comprova aquesta conciliació';

  @override
  String get receiptDiscountLine => 'Descompte';

  @override
  String get compareItem => 'Article';

  @override
  String get compareEstimated => 'Estimat';

  @override
  String get compareActual => 'Real';

  @override
  String get compareDiff => 'Diferència';

  @override
  String get compareTotal => 'Total';

  @override
  String get compareBudget => 'Pressupost';

  @override
  String get compareNotBought => 'no comprat';

  @override
  String get compareUnplanned => 'no planificat';

  @override
  String get pricierItems => 'Més cars';

  @override
  String get cheaperItems => 'Més barats';

  @override
  String get compareAction => 'Compara';

  @override
  String get detailsSection => 'Detalls';

  @override
  String get spendingTitle => 'Despeses';

  @override
  String get spendingAction => 'Despeses';

  @override
  String get spendingMonthTotal => 'Aquest mes';

  @override
  String get spendingWeekly => 'Despesa setmanal';

  @override
  String get spendingMonthly => 'Despesa mensual';

  @override
  String get monthlyLimitTitle => 'Límit mensual';

  @override
  String get monthlyLimitHelp => 'Quant vols gastar en compres cada mes?';

  @override
  String get monthlyLimitRemove => 'Elimina';

  @override
  String get monthlyLimitSet => 'Estableix';

  @override
  String get monthlyLimitChange => 'Canvia';

  @override
  String get monthlyLimitNone =>
      'Estableix un límit mensual per veure quant et queda.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount per sobre del límit';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount restants aquest mes';
  }

  @override
  String get plansTitle => 'Plans';

  @override
  String get plansHeadline => 'Compra millor amb IA';

  @override
  String get plansSubhead =>
      'Conciliació de rebuts, etiquetes de preu i llistes a partir d\'una frase. Cancel·la quan vulguis.';

  @override
  String get plansMonthly => 'Mensual';

  @override
  String get plansYearly => 'Anual';

  @override
  String get planFree => 'Gratuït';

  @override
  String get planFreePrice => 'Gratis per sempre';

  @override
  String get planFreeAi => '15 sol·licituds d\'IA al mes';

  @override
  String get planFreeAds =>
      'Petits anuncis en forma de banner (cap durant els primers 7 dies)';

  @override
  String get planCoreFeatures => 'Llistes, preus, rebuts, gràfics de despeses';

  @override
  String get plansPerYear => '/ any';

  @override
  String get plansPerMonth => '/ mes';

  @override
  String get planTrial => '7 dies gratuïts';

  @override
  String get planProAi => '200 sol·licituds d\'IA al mes';

  @override
  String get planNoAds => 'Sense anuncis';

  @override
  String get planBackup => 'Còpia de seguretat, exportació i importació';

  @override
  String get planMaxAi => '1000 peticions d\'IA al mes';

  @override
  String get planMaxFamily => 'Per a compres familiars grans';

  @override
  String get plansStoreUnavailable => 'La botiga no és accessible ara mateix.';

  @override
  String get retryAction => 'Torna-ho a provar';

  @override
  String get plansPurchaseFailed =>
      'La compra no s\'ha pogut completar. Si us plau, torna-ho a intentar.';

  @override
  String get planLifetimeTitle => 'Sense anuncis per sempre';

  @override
  String get planLifetimeSubtitle =>
      'Pagament únic: sense anuncis, còpia de seguretat; l\'IA es manté dins del límit gratuït';

  @override
  String get plansRestore => 'Restaura les compres';

  @override
  String get plansLegal =>
      'Les subscripcions es renoven automàticament fins que es cancel·lin. Es poden cancel·lar en qualsevol moment a Google Play › Pagaments i subscripcions. Els preus inclouen els impostos mostrats per Google Play.';

  @override
  String get planCurrent => 'Actual';

  @override
  String get planStartTrial => 'Comença la prova gratuïta de 7 dies';

  @override
  String get planChoose => 'Tria';

  @override
  String get plansAction => 'Plans: Pro i Max';

  @override
  String get assistantTitle => 'Assistent';

  @override
  String get assistantGreeting => 'Hola! Què vols fer?';

  @override
  String get assistantNewList => 'Nova llista';

  @override
  String get assistantVoiceList => 'Llista per veu';

  @override
  String get assistantTextList => 'Llista a partir d\'una frase';

  @override
  String get assistantScanReceipt => 'Escaneja un rebuig';

  @override
  String get assistantSpending => 'El meu despesa';

  @override
  String get assistantReceiptHint =>
      'Obre la teva llista i toca la icona del rebuig per escanejar-lo.';

  @override
  String get assistantToggleTitle => 'Mostra l\'assistent';

  @override
  String get assistantToggleSubtitle =>
      'El petit ajudant a la cantonada inferior dreta';

  @override
  String get scanPriceLabel => 'Escaneja l\'etiqueta de preu';

  @override
  String get saveFailed =>
      'No s\'ha pogut desar. Els canvis es mantenen. Torna-ho a provar.';

  @override
  String get deleteItemConfirm =>
      'Vols eliminar aquest article i les seves compres registrades?';

  @override
  String get clearPurchaseConfirm =>
      'Vols desmarcar aquest article i eliminar-ne les compres registrades?';

  @override
  String get reportPdfAction => 'Desa l\'informe en PDF';

  @override
  String get reportNotInvoice =>
      'Resum de la compra, no és una factura fiscal. Les taxes fiscals són desconegudes.';

  @override
  String get purchaseVisits => 'Visites de compra';

  @override
  String get purchaseInterval => 'Dies mitjans entre compres';

  @override
  String get purchasedQuantity => 'Quantitat comprada';

  @override
  String get purchaseAnalyticsHint =>
      'Les compres no mesuren el consum. Les monedes i les unitats es mostren per separat.';

  @override
  String get receiptReplaces =>
      'Les línies del rebuig vinculades substitueixen les compres existents; les línies sense vincular s\'afegeixen.';

  @override
  String get voiceUnsupportedLanguage =>
      'Aquest idioma no està disponible per a l\'entrada per veu en aquest dispositiu. Pots escriure en el seu lloc.';
}
