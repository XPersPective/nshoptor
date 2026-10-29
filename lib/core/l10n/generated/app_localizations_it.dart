// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'I conti di casa tornano alla cassa.';

  @override
  String get listsTitle => 'Liste';

  @override
  String get listsTabActive => 'Attive';

  @override
  String get listsTabCompleted => 'Completate';

  @override
  String get listsTabArchived => 'Archiviate';

  @override
  String get newListButton => 'Nuova lista';

  @override
  String get listTitleHint => 'Titolo (facoltativo)';

  @override
  String get saveButton => 'Salva';

  @override
  String get cancelButton => 'Annulla';

  @override
  String get deleteButton => 'Elimina';

  @override
  String get editAction => 'Modifica';

  @override
  String get listDeleted => 'Lista eliminata';

  @override
  String get invalidAmountError => 'Importo non valido';

  @override
  String get duplicateAction => 'Duplica';

  @override
  String get archiveAction => 'Archivia';

  @override
  String get unarchiveAction => 'Ripristina';

  @override
  String get deleteListConfirm =>
      'Eliminare questa lista? Verranno rimossi anche gli articoli previsti.';

  @override
  String get undoButton => 'Annulla';

  @override
  String get searchListHint => 'Cerca liste';

  @override
  String get currencyLabel => 'Valuta';

  @override
  String get budgetLabel => 'Budget (facoltativo)';

  @override
  String get noteLabel => 'Nota (facoltativa)';

  @override
  String get storeLabel => 'Negozio';

  @override
  String get keepAmountsAction => 'Mantieni gli importi';

  @override
  String get resetAmountsAction => 'Azzera gli importi';

  @override
  String get currencyChangeWarning =>
      'La valuta sta cambiando. Cosa fare con gli importi esistenti?';

  @override
  String get listsEmpty =>
      'Nessuna lista. Crea il tuo primo piano della spesa.';

  @override
  String get statusDraft => 'Bozza';

  @override
  String get statusPlanned => 'Pianificata';

  @override
  String get statusShopping => 'In spesa';

  @override
  String get statusCompleted => 'Completata';

  @override
  String get statusArchived => 'Archiviata';

  @override
  String autoListTitle(String date) {
    return 'Spesa del $date';
  }

  @override
  String get itemFormTitle => 'Aggiungi articolo';

  @override
  String get itemNameLabel => 'Nome dell\'articolo';

  @override
  String get brandLabel => 'Marca / variante (facoltativa)';

  @override
  String get categoryLabel => 'Categoria';

  @override
  String get quantityLabel => 'Quantità';

  @override
  String get unitLabel => 'Unità';

  @override
  String get pricingModeLabel => 'Inserimento prezzo';

  @override
  String get pricingModeUnitPrice => 'Prezzo unitario';

  @override
  String get pricingModeLineTotal => 'Prezzo totale';

  @override
  String get plannedPriceLabel => 'Prezzo previsto';

  @override
  String lineTotalCalculated(String value) {
    return 'Totale: $value';
  }

  @override
  String get requiredItemToggle => 'Articolo indispensabile';

  @override
  String get maxPriceLabel => 'Prezzo massimo accettabile (facoltativo)';

  @override
  String get itemNoteLabel => 'Nota (facoltativa)';

  @override
  String get categoryProduce => 'Frutta e verdura';

  @override
  String get categoryDairy => 'Latticini';

  @override
  String get categoryMeat => 'Carne';

  @override
  String get categoryBakery => 'Panetteria';

  @override
  String get categoryDrinks => 'Bevande';

  @override
  String get categoryCleaning => 'Pulizia';

  @override
  String get categoryPersonalCare => 'Cura della persona';

  @override
  String get categoryHome => 'Casa';

  @override
  String get categoryOther => 'Altro';

  @override
  String get invalidQuantityError => 'Quantità non valida';

  @override
  String get invalidPriceError => 'Prezzo non valido';

  @override
  String get invalidNameError => 'Inserisci un nome';

  @override
  String unitPriceCalculated(String value) {
    return 'Prezzo unitario: $value';
  }

  @override
  String get shoppingTitle => 'Modalità spesa';

  @override
  String get summaryPlannedTotal => 'Previsto';

  @override
  String get summaryInCart => 'Nel carrello';

  @override
  String get summaryRemainingPlan => 'Resto del piano';

  @override
  String get summaryProjected => 'Cassa stimata';

  @override
  String get summaryBudgetRemaining => 'Budget rimasto';

  @override
  String get summaryBudgetOver => 'Budget superato';

  @override
  String itemsProgress(String done, String total) {
    return '$done di $total articoli';
  }

  @override
  String get filterAll => 'Tutti';

  @override
  String get filterToBuy => 'Da comprare';

  @override
  String get filterInCart => 'Nel carrello';

  @override
  String get filterNotFound => 'Non trovati';

  @override
  String get filterRequired => 'Indispensabili';

  @override
  String get quickEntryTitle => 'Prezzo reale';

  @override
  String get actualQuantityLabel => 'Quantità reale';

  @override
  String get actualPriceLabel => 'Prezzo reale';

  @override
  String get discountLabel => 'Sconto (facoltativo)';

  @override
  String get alternativeNameLabel =>
      'Nome del prodotto alternativo (facoltativo)';

  @override
  String get savePurchaseButton => 'Metti nel carrello';

  @override
  String get unplannedAddButton => 'Aggiungi articolo non previsto';

  @override
  String get statusPending => 'Non preso';

  @override
  String get statusInCart => 'Nel carrello';

  @override
  String get statusNotFound => 'Non trovato';

  @override
  String get statusGaveUp => 'Rinunciato';

  @override
  String get statusAlternative => 'Alternativa acquistata';

  @override
  String get keepScreenAwake => 'Schermo sempre acceso';

  @override
  String get finishShopping => 'Termina la spesa';

  @override
  String get completionWarning =>
      'Ci sono dati mancanti o non verificati. Puoi terminare comunque; il risultato li segnalerà.';

  @override
  String get continueShoppingButton => 'Continua la spesa';

  @override
  String get resultTitle => 'Risultato';

  @override
  String get summarySection => 'Riepilogo';

  @override
  String get plannedTotalLabel => 'Totale previsto';

  @override
  String get actualTotalLabel => 'Totale reale';

  @override
  String get varianceLabel => 'Differenza';

  @override
  String get varianceNotComputable => 'Non calcolabile';

  @override
  String get budgetStatusLabel => 'Budget';

  @override
  String get savingsLabel => 'Sotto il piano';

  @override
  String get overspendLabel => 'Sopra il piano';

  @override
  String get unplannedTotalLabel => 'Totale non previsto';

  @override
  String get unpurchasedLabel => 'Previsto ma non comprato';

  @override
  String get totalDiscountLabel => 'Sconti totali';

  @override
  String get accuracyLabel => 'Precisione della stima';

  @override
  String get groupsSection => 'Articoli';

  @override
  String get groupPricier => 'Più cari del previsto';

  @override
  String get groupCheaper => 'Più economici del previsto';

  @override
  String get groupClose => 'Vicini alla stima';

  @override
  String get groupNotTaken => 'Previsti, non comprati';

  @override
  String get groupUnplanned => 'Comprati senza piano';

  @override
  String get groupQuantityChanged => 'Quantità cambiata';

  @override
  String get groupUnverified => 'Non verificati';

  @override
  String get plannedQtyLabel => 'Quantità prevista';

  @override
  String get actualQtyLabel => 'Quantità reale';

  @override
  String get plannedUnitPriceLabel => 'Prezzo unitario previsto';

  @override
  String get actualUnitPriceLabel => 'Prezzo unitario reale';

  @override
  String get lineVarianceLabel => 'Differenza';

  @override
  String get discountEffectLabel => 'Effetto sconto';

  @override
  String get notBoughtMark => 'non comprato';

  @override
  String get noPurchasesNote => 'Nessun acquisto registrato.';

  @override
  String get navHome => 'Home';

  @override
  String get navLists => 'Liste';

  @override
  String get navHistory => 'Cronologia';

  @override
  String get navSettings => 'Impostazioni';

  @override
  String get homeEmptyTitle => 'Pianifica la spesa';

  @override
  String get homeEmptyBody =>
      'Crea la tua prima lista e confronta il previsto con il reale.';

  @override
  String get homeActiveSection => 'Liste attive';

  @override
  String get homeCompletedSection => 'Completate di recente';

  @override
  String get homeMonthlySection => 'Questo mese';

  @override
  String get monthPlannedLabel => 'Previsto';

  @override
  String get monthActualLabel => 'Reale';

  @override
  String get monthVarianceLabel => 'Differenza';

  @override
  String get continueShoppingLabel => 'Continua la spesa';

  @override
  String get historyEmpty =>
      'Nessuna spesa completata. Qui compariranno cronologia e statistiche.';

  @override
  String get aboutTabTitle => 'Informazioni su NShoptor';

  @override
  String get aboutBody =>
      'NShoptor di Crazy Penguin. Pianificatore della spesa che funziona offline. Licenza GPL-3.0.';

  @override
  String get startShoppingLabel => 'Inizia la spesa';

  @override
  String get finishAndSeeResult => 'Termina e vedi il risultato';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get languageLabel => 'Lingua';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get languageTr => 'Turco';

  @override
  String get languageEn => 'Inglese';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeDark => 'Scuro';

  @override
  String get defaultCurrencyLabel => 'Valuta predefinita';

  @override
  String get defaultUnitLabel => 'Unità predefinita';

  @override
  String get keepAwakeLabel => 'Schermo acceso durante la spesa';

  @override
  String get backupSection => 'Backup';

  @override
  String get exportBackupLabel => 'Esporta backup';

  @override
  String get importBackupLabel => 'Importa backup';

  @override
  String get mergeImportLabel => 'Unisci ai dati attuali';

  @override
  String get separateImportLabel => 'Importa come copia separata';

  @override
  String get importCancelled => 'Importazione annullata.';

  @override
  String get backupExported => 'Backup esportato correttamente.';

  @override
  String get deleteAllSection => 'Zona pericolosa';

  @override
  String get deleteAllLabel => 'Elimina tutti i dati';

  @override
  String get deleteAllConfirm =>
      'Verranno rimossi tutte le liste, la cronologia, le foto degli scontrini e i prezzi. I file che hai esportato restano dove sono. Continuare?';

  @override
  String get deleteAllConfirm2 =>
      'Sei proprio sicuro? L\'operazione è irreversibile.';

  @override
  String get cancelAction => 'Annulla';

  @override
  String get confirmDelete => 'Elimina definitivamente';

  @override
  String get dataDeleted => 'Tutti i dati locali sono stati eliminati.';

  @override
  String get privacyInfoLabel => 'Privacy';

  @override
  String get privacyInfoBody =>
      'Liste, prezzi, scontrini e foto sono archiviati sul tuo dispositivo. La voce non lo lascia mai. Quando l\'aiuto IA è attivo, le foto di scontrini ed etichette di prezzo (ridotte di dimensioni) e il testo, come gli articoli dettati, vengono inviati al nostro server solo per essere letti; vengono elaborati subito e mai archiviati.';

  @override
  String get aboutSection => 'Informazioni';

  @override
  String get aboutPublisher => 'Editore: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licenze (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Input vocale';

  @override
  String get voiceStatusUnknown => 'Servizio: non verificato';

  @override
  String get permissionsLabel => 'Autorizzazioni';

  @override
  String get permissionsBody =>
      'Fotocamera, microfono e notifiche vengono richiesti solo quando usi queste funzioni.';

  @override
  String get unitsSection => 'Predefiniti';

  @override
  String get roundingNote =>
      'Gli importi seguono un\'unica regola: le metà si arrotondano allontanandosi dallo zero, una sola volta alla conversione.';

  @override
  String get voiceInputTitle => 'Input vocale';

  @override
  String get voiceStartListening => 'Inizia ad ascoltare';

  @override
  String get voiceTranscriptLabel => 'Trascrizione';

  @override
  String get parseAction => 'Analizza';

  @override
  String get receiptReviewTitle => 'Controlla lo scontrino';

  @override
  String get receiptTotal => 'Totale scontrino';

  @override
  String get receiptTotalUnknown => 'Totale non rilevato';

  @override
  String get receiptDiff => 'Differenza';

  @override
  String get acceptLine => 'Accetta riga';

  @override
  String get ignoreLine => 'Ignora riga';

  @override
  String get receiptLineActions => 'Collega a un articolo, dividi o ignora';

  @override
  String get receiptCommit => 'Accetta tutto';

  @override
  String get receiptCommitted => 'Scontrino applicato.';

  @override
  String get priceHistoryTitle => 'Storico prezzi';

  @override
  String get noObservations => 'Nessun prezzo registrato';

  @override
  String get templatesSection => 'Modelli';

  @override
  String get templateHint => 'Crea un nuovo piano da una spesa precedente';

  @override
  String get scanReceiptAction => 'Scansiona scontrino';

  @override
  String get fromReceiptListButton => 'Da scontrino';

  @override
  String get shelfLabelAction => 'Prezzo dall\'etichetta';

  @override
  String get priceCandidatesTitle => 'Prezzi proposti';

  @override
  String get noPriceCandidates => 'Nessun prezzo trovato; inseriscilo a mano.';

  @override
  String get voiceUnavailable =>
      'Riconoscimento vocale non disponibile; inserisci a mano.';

  @override
  String get linkToItem => 'Collega a un articolo';

  @override
  String get splitLine => 'Dividi in due';

  @override
  String get mergeWithNext => 'Unisci alla successiva';

  @override
  String get ocrNoText => 'Nessun testo letto; riprova.';

  @override
  String get priceHistoryAction => 'Storico prezzi';

  @override
  String get itemsEmptyTitle => 'Nessun articolo';

  @override
  String get itemsEmptyBody =>
      'Aggiungi il primo articolo: in negozio inserirai qui i prezzi reali.';

  @override
  String get addItemTooltip => 'Aggiungi articolo';

  @override
  String get unitAdet => 'pz';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'confezione';

  @override
  String get unitKutu => 'scatola';

  @override
  String get unitSise => 'bottiglia';

  @override
  String get unitKavanoz => 'barattolo';

  @override
  String get unitDemet => 'mazzo';

  @override
  String get unitDuzine => 'dozzina';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Personalizzata';

  @override
  String get setReminderAction => 'Imposta promemoria';

  @override
  String get reminderPermissionDenied =>
      'Per i promemoria serve l\'autorizzazione alle notifiche. Puoi attivarla nelle impostazioni di sistema.';

  @override
  String get reminderScheduled => 'Promemoria impostato.';

  @override
  String get reminderCancelled => 'Promemoria rimosso.';

  @override
  String get reminderTitle => 'Promemoria spesa';

  @override
  String reminderBody(Object title) {
    return 'È ora di controllare la lista: $title';
  }

  @override
  String get reminderPickDate => 'Scegli una data';

  @override
  String get reminderPickTime => 'Scegli un orario';

  @override
  String get itemDetailsSection => 'Dettagli';

  @override
  String get priceOptionalHint => 'Prezzo al mercato (facoltativo)';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Previsto: $total · $count articoli';
  }

  @override
  String get proActiveLabel => 'Pro attivo: grazie!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Senza pubblicità · Esporta e importa backup · Annuale';

  @override
  String get proBenefitNoAds => 'Senza pubblicità';

  @override
  String get proBenefitBackup => 'Backup (esporta/importa)';

  @override
  String aboutVersion(Object version) {
    return 'Versione $version';
  }

  @override
  String get navDiscover => 'Scopri';

  @override
  String get shareAction => 'Condividi l\'app';

  @override
  String get rateAction => 'Valutaci';

  @override
  String get aboutOpenRow => 'Informazioni e open source';

  @override
  String get voiceAddItemAction => 'Aggiungi con la voce';

  @override
  String get formatLocaleLabel => 'Formato numeri e valuta';

  @override
  String get formatLocaleSystem => 'Formato del dispositivo';

  @override
  String get formatLocaleTr => 'Turco (1.234,56)';

  @override
  String get formatLocaleEn => 'Inglese (1,234.56)';

  @override
  String get aiToggleTitle => 'Aiuto IA';

  @override
  String get aiToggleSubtitle =>
      'Legge scontrini ed etichette di prezzo dalle foto, abbina gli scontrini e trasforma le frasi in liste. Le foto vengono inviate solo per essere lette e non vengono mai archiviate.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Hai usato le richieste IA di questo mese ($used/$limit). Passa a un piano superiore o continua senza IA.';
  }

  @override
  String get aiOffline => 'Nessuna connessione: si continua senza IA.';

  @override
  String get aiFailed => 'L\'IA non è disponibile ora: si continua senza.';

  @override
  String get aiSourceLabel => 'IA';

  @override
  String get deviceSourceLabel => 'Dispositivo';

  @override
  String get quickListAction => 'Aggiungi da una frase';

  @override
  String get quickListTitle => 'Lista veloce';

  @override
  String get quickListHint =>
      'es. 1 kg di mele 3 €, 2 pagnotte, mezzo chilo di formaggio';

  @override
  String get quickListConvert => 'Trasforma in lista';

  @override
  String quickListAdd(int count) {
    return 'Aggiungi $count articoli';
  }

  @override
  String get quickListEmpty =>
      'Nessun articolo trovato. Separali con delle virgole.';

  @override
  String get receiptAiMatched =>
      'L\'IA ha abbinato lo scontrino alla tua lista. Controlla i collegamenti e conferma.';

  @override
  String get receiptNeedsCheck => 'Controlla questo abbinamento';

  @override
  String get receiptDiscountLine => 'Sconto';

  @override
  String get compareItem => 'Articolo';

  @override
  String get compareEstimated => 'Prezzo a casa';

  @override
  String get compareActual => 'Prezzo in negozio';

  @override
  String get compareDiff => 'Differenza';

  @override
  String get compareTotal => 'Totale';

  @override
  String get compareBudget => 'Budget';

  @override
  String get compareNotBought => 'non comprato';

  @override
  String get compareUnplanned => 'non previsto';

  @override
  String get pricierItems => 'Più cari';

  @override
  String get cheaperItems => 'Più economici';

  @override
  String get compareAction => 'Confronta';

  @override
  String get detailsSection => 'Dettagli';

  @override
  String get spendingTitle => 'Spese';

  @override
  String get spendingAction => 'Spese';

  @override
  String get spendingMonthTotal => 'Questo mese';

  @override
  String get spendingWeekly => 'Spesa settimanale';

  @override
  String get spendingMonthly => 'Spesa mensile';

  @override
  String get monthlyLimitTitle => 'Limite mensile';

  @override
  String get monthlyLimitHelp => 'Quanto vuoi spendere per la spesa ogni mese?';

  @override
  String get monthlyLimitRemove => 'Rimuovi';

  @override
  String get monthlyLimitSet => 'Imposta';

  @override
  String get monthlyLimitChange => 'Cambia';

  @override
  String get monthlyLimitNone =>
      'Imposta un limite mensile per vedere quanto ti resta.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount oltre il limite';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'Restano $amount questo mese';
  }

  @override
  String get plansTitle => 'Piani';

  @override
  String get plansHeadline => 'Fai la spesa in modo più intelligente con l\'IA';

  @override
  String get plansSubhead =>
      'Abbinamento scontrini, etichette dei prezzi e liste da una frase. Disdici quando vuoi.';

  @override
  String get plansMonthly => 'Mensile';

  @override
  String get plansYearly => 'Annuale';

  @override
  String get planFree => 'Gratis';

  @override
  String get planFreePrice => 'Gratis per sempre';

  @override
  String get planFreeAi => '10 richieste IA al mese';

  @override
  String get planFreeAds =>
      'Piccoli banner pubblicitari (nessuno nei primi 7 giorni)';

  @override
  String get planCoreFeatures =>
      'Liste, prezzi, scontrini, grafici delle spese';

  @override
  String get plansPerYear => '/ anno';

  @override
  String get plansPerMonth => '/ mese';

  @override
  String get planTrial => 'Prova gratuita';

  @override
  String get planProAi => '100 richieste IA al mese';

  @override
  String get planNoAds => 'Senza pubblicità';

  @override
  String get planBackup => 'Esporta e importa backup';

  @override
  String get planMaxAi => '300 richieste IA al mese';

  @override
  String get planMaxFamily => 'Per le grandi spese di famiglia';

  @override
  String get plansStoreUnavailable =>
      'Lo store non è raggiungibile al momento.';

  @override
  String get retryAction => 'Riprova';

  @override
  String get plansPurchaseFailed =>
      'L\'acquisto non è andato a buon fine. Riprova.';

  @override
  String get plansRestore => 'Ripristina acquisti';

  @override
  String get plansLegal =>
      'Pro si rinnova automaticamente ogni anno fino alla disdetta e include 100 richieste IA al mese. Il prezzo base è di 1 dollaro USA all’anno prima delle imposte applicabili; verifica il prezzo locale finale e le imposte nello store prima di confermare l’acquisto. Gestisci o annulla l’abbonamento in Google Play.';

  @override
  String get planCurrent => 'Attuale';

  @override
  String get planStartTrial => 'Inizia la prova gratuita';

  @override
  String get planChoose => 'Scegli';

  @override
  String get plansAction => 'Piani: Pro';

  @override
  String get assistantTitle => 'Assistente';

  @override
  String get assistantGreeting => 'Ciao! Cosa vuoi fare?';

  @override
  String get assistantNewList => 'Nuova lista';

  @override
  String get assistantVoiceList => 'Lista con la voce';

  @override
  String get assistantTextList => 'Lista da una frase';

  @override
  String get assistantScanReceipt => 'Scansiona uno scontrino';

  @override
  String get assistantSpending => 'Le mie spese';

  @override
  String get assistantReceiptHint =>
      'Apri la tua lista e tocca l\'icona dello scontrino per scansionarlo.';

  @override
  String get assistantToggleTitle => 'Mostra assistente';

  @override
  String get assistantToggleSubtitle => 'Il piccolo aiutante in basso a destra';

  @override
  String get scanPriceLabel => 'Scansiona l\'etichetta del prezzo';

  @override
  String get saveFailed =>
      'Salvataggio non riuscito. Le modifiche sono ancora qui. Riprova.';

  @override
  String get deleteItemConfirm =>
      'Eliminare questo articolo e gli acquisti registrati?';

  @override
  String get clearPurchaseConfirm =>
      'Deselezionare questo articolo e rimuovere gli acquisti registrati?';

  @override
  String get reportPdfAction => 'Salva rapporto PDF';

  @override
  String get reportNotInvoice =>
      'Riepilogo della spesa, non una fattura fiscale. I tassi fiscali sono sconosciuti.';

  @override
  String get purchaseVisits => 'Visite allo shopping';

  @override
  String get purchaseInterval => 'Giorni medi tra gli acquisti';

  @override
  String get purchasedQuantity => 'Quantità acquistata';

  @override
  String get purchaseAnalyticsHint =>
      'Gli acquisti non misurano il consumo. Valute e unità vengono mostrate separatamente.';

  @override
  String get receiptReplaces =>
      'Gli articoli senza prezzo vengono completati. Quelli con un prezzo di mercato sono aggiunti come acquisti separati.';

  @override
  String get receiptIncompleteHeader =>
      'Nella prossima foto includi negozio, data, ora e numero dello scontrino.';

  @override
  String get receiptIncompleteTail =>
      'Fotografa la sezione successiva con alcuni articoli sovrapposti e il totale finale.';

  @override
  String get receiptContinuationRejected =>
      'Impossibile unire questa foto. Riprova includendo articoli sovrapposti dello stesso scontrino.';

  @override
  String get receiptDraftSaved =>
      'Scontrino salvato come bozza. Puoi continuare più tardi.';

  @override
  String get receiptContinueAction => 'Continua scontrino';

  @override
  String get receiptDraftsTitle => 'Scontrini incompleti';

  @override
  String get receiptDuplicate => 'Questo scontrino è già stato aggiunto.';

  @override
  String get receiptTotalMismatch =>
      'Gli articoli non corrispondono al totale dello scontrino. Verifica che sia visibile per intero.';

  @override
  String get receiptSaveDraftAction => 'Salva per dopo';

  @override
  String get receiptResolveLines =>
      'Accetta o ignora ogni articolo prima di salvare.';

  @override
  String get receiptPartialConfirm =>
      'Verranno aggiunti solo gli articoli selezionati. Questa ricevuta sarà contrassegnata come importata. Continuare?';

  @override
  String get voiceUnsupportedLanguage =>
      'Questa lingua non è disponibile per l\'input vocale su questo dispositivo. Puoi digitare invece.';

  @override
  String get voiceStopListening => 'Ferma l\'ascolto';

  @override
  String get keepAwakeFailed => 'Ecrin ei pysynyt päällä. Yritä uudelleen.';

  @override
  String get purchaseHistoryHint =>
      'Alle abgeschlossenen Einkäufe. Rückerstattungen reduzieren die Gesamtbeträge. Die Daten beziehen sich auf den Abschluss des Einkaufs. Ein einzelner Besuch reicht nicht aus, um ein durchschnittliches Intervall zu berechnen.';

  @override
  String get planLegacyRights =>
      'Gli abbonamenti Pro e Max esistenti mantengono la quota mensile originale di richieste IA.';

  @override
  String get csvExportAction => 'Esporta CSV';

  @override
  String get reportSharePdf => 'Condividi come PDF';

  @override
  String get reportShareCsv => 'Condividi come CSV';

  @override
  String get reportPrintAction => 'Stampa';

  @override
  String get backupSizeWarning =>
      'JSON incluye registros, no archivos de foto. Límite de importación: 16 MB.';

  @override
  String get backupImportFailed =>
      'El respaldo no se pudo importar. Tus datos no cambiaron.';

  @override
  String get backupImported => 'Backup importato con successo.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists liste · $items artiklar · $entries köp';
  }

  @override
  String get voiceModelDownloading =>
      'Download del modello vocale per questa lingua in corso. Riprova tra un minuto.';

  @override
  String get historyThisWeek => 'Questa settimana';

  @override
  String get historyProductsSection => 'Prodotti acquistati';

  @override
  String get tipReceiptScan =>
      'Scansiona lo scontrino per confrontare i prezzi con la tua lista';

  @override
  String get tipVoiceAdd =>
      'Dì uno o più articoli e controllali prima di aggiungerli';

  @override
  String get tipShelfCamera =>
      'Leggi il prezzo dal cartellino dello scaffale con la fotocamera';

  @override
  String get tipPlan =>
      'Il tuo piano: vedi i dettagli, abbonati o passa a un piano superiore';

  @override
  String get guideAddBody =>
      'Tocca + per aggiungere un articolo. Inserisci ora il prezzo previsto e alla cassa quello di mercato.';

  @override
  String get guideVoiceBody =>
      'Tocca il microfono e di\' gli articoli, per esempio: \'1 kg di mele, 1 pane\'.';

  @override
  String get guideReceiptBody =>
      'Scansiona uno scontrino per abbinare i suoi prezzi agli articoli della lista.';

  @override
  String get guidePlanBody =>
      'Tocca l\'icona del piano per vedere il piano, abbonarti o passare a un piano superiore.';

  @override
  String get guideNext => 'OK';

  @override
  String get guideDone => 'Inizia';

  @override
  String get paletteLabel => 'Tema colore';

  @override
  String get paletteForest => 'Foresta';

  @override
  String get paletteOcean => 'Oceano';

  @override
  String get paletteSunset => 'Tramonto';

  @override
  String get paletteLavender => 'Lavanda';

  @override
  String get darkBlackLabel => 'Nero puro nel tema scuro';

  @override
  String get spendingOverview => 'Panoramica';

  @override
  String get spendingThisYear => 'Quest\'anno';

  @override
  String get spendingYearly => 'Spesa annuale';

  @override
  String get productSpending => 'Spesa per prodotto';

  @override
  String get spanWeek => 'Settimana';

  @override
  String get spanMonth => 'Mese';

  @override
  String get spanYear => 'Anno';

  @override
  String get weeklyLimitTitle => 'Limite settimanale';

  @override
  String get weeklyLimitHelp =>
      'Quanto vuoi spendere per la spesa ogni settimana?';

  @override
  String get weeklyLimitNone =>
      'Imposta un limite settimanale per vedere quanto resta.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'Restano $amount questa settimana';
  }

  @override
  String get shoppingLimitTitle => 'Limite per spesa';

  @override
  String get shoppingLimitHelp => 'Le nuove liste partono con questo budget.';

  @override
  String get shoppingLimitNone =>
      'Imposta un budget predefinito per ogni nuova spesa.';

  @override
  String get monthlyReportAction => 'Report mensile';

  @override
  String get reportShoppingColumn => 'Spesa';

  @override
  String get reportDateColumn => 'Data';

  @override
  String get planUnavailable => 'Al momento non disponibile nello store';

  @override
  String get demoDataTitle => 'Dati di esempio';

  @override
  String get demoDataLoad => 'Prova con dati di esempio';

  @override
  String get demoDataLoadHelp =>
      'Aggiunge 12 mesi di spese di esempio per vedere cronologia, grafici e storico prezzi.';

  @override
  String get demoDataRemove => 'Rimuovi dati di esempio';

  @override
  String get demoDataAdded => 'Dati di esempio aggiunti';

  @override
  String get demoDataRemoved => 'Dati di esempio rimossi';

  @override
  String get demoProductApple => 'Mele';

  @override
  String get demoProductBread => 'Pane';

  @override
  String get demoProductMilk => 'Latte';

  @override
  String get demoProductCheese => 'Formaggio';

  @override
  String get demoProductTomato => 'Pomodori';

  @override
  String get demoProductEggs => 'Uova';

  @override
  String get demoProductCoffee => 'Caffè';

  @override
  String get demoProductDetergent => 'Detersivo';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Aiuto e supporto';

  @override
  String get howToUseLabel => 'Come si usa';

  @override
  String get guidePricesBody =>
      'Il prezzo in negozio segna l’articolo come acquistato; vale anche 0. Il prezzo a casa è facoltativo. Cancella il prezzo in negozio per togliere la spunta.';

  @override
  String get shoppingDateLabel => 'Data della spesa';

  @override
  String get shoppingDateNone => 'Nessuna data selezionata';

  @override
  String get clearShoppingDateAction => 'Rimuovi data';

  @override
  String get listSortLabel => 'Ordine della lista';

  @override
  String get listSortDate => 'Data della spesa';

  @override
  String get listSortAz => 'Nome (A–Z)';

  @override
  String get listSortManual => 'Ordine manuale';

  @override
  String get imageCameraAction => 'Scatta una foto';

  @override
  String get imageGalleryAction => 'Scegli dalle foto';

  @override
  String get imageCaptureFailed =>
      'Impossibile aprire la fotocamera o le foto. Controlla l\'autorizzazione di accesso e riprova.';

  @override
  String get imageRecognitionFailed =>
      'Impossibile elaborare la foto. Prova con un\'altra foto.';

  @override
  String get receiptNoProducts =>
      'Il testo è stato letto, ma non sono stati trovati articoli dello scontrino. Includi gli articoli e il totale nella foto.';

  @override
  String get keepAwakeOn => 'Lo schermo resta acceso';

  @override
  String get keepAwakeOff => 'Lo schermo può spegnersi';

  @override
  String get spanDay => 'Giorno';

  @override
  String get spanCustom => 'Intervallo di date';

  @override
  String get reportTotalSpent => 'Totale speso';

  @override
  String get reportAddedAt => 'Aggiunto';

  @override
  String get reportReceiptNumber => 'Numero di ricevuta';

  @override
  String get reportPreview => 'Anteprima';

  @override
  String get reportShareAction => 'Condividi';

  @override
  String get previousPeriodAction => 'Periodo precedente';

  @override
  String get nextPeriodAction => 'Periodo successivo';

  @override
  String get reportSaved => 'Report salvato.';

  @override
  String get reportZoom => 'Ingrandisci';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days giorni rimanenti',
      one: '$days giorno rimanente',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours ore rimanenti',
      one: '$hours ora rimanente',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Il periodo di prova Pro è terminato';

  @override
  String get planTrialEndedBody =>
      'Puoi continuare a usare gratuitamente gli elenchi, l’inserimento manuale e la voce sul dispositivo. Il piano Gratis include 10 richieste AI per mese solare. Scegli Pro annuale per 100 richieste AI al mese, senza annunci e con backup. I tuoi dati esistenti restano con te.';

  @override
  String get planContinueFree => 'Continua gratis';

  @override
  String get supportIdLabel => 'ID di supporto';

  @override
  String get supportEmailLabel => 'Assistenza via e-mail';

  @override
  String get captureTipFirst =>
      'Parti dall’alto: il nome del negozio e la data devono essere visibili. Inquadra più articoli possibile; il resto andrà nella foto successiva.';

  @override
  String get captureTipContinue =>
      'Stesso scontrino: includi l’ultimo articolo della foto precedente.';

  @override
  String get captureTipNeverShow => 'Non mostrare più';

  @override
  String get captureTipOk => 'Ho capito';

  @override
  String get captureTipsSetting =>
      'Mostra i consigli per fotografare lo scontrino';

  @override
  String get receiptReadingProgress => 'Lettura dello scontrino…';

  @override
  String get receiptReadInBackground => 'Continua in background';

  @override
  String get receiptReadDoneTitle => 'Scontrino letto';

  @override
  String get receiptReadDoneBody => 'Tocca per rivederlo e salvarlo.';

  @override
  String get receiptReadMoreTitle => 'Fotografa il resto dello scontrino';

  @override
  String get receiptReadFailedTitle => 'Impossibile leggere lo scontrino';

  @override
  String get listReceiptsSection => 'Scontrini';

  @override
  String get receiptStateComplete => 'Completo';

  @override
  String get receiptStateIncomplete => 'Incompleto';

  @override
  String get receiptStateFailed => 'Non riuscito';

  @override
  String get receiptStoreUnknown => 'Negozio non letto';

  @override
  String get receiptDeleteAction => 'Elimina scontrino';

  @override
  String get receiptDeleteConfirm =>
      'Eliminare questo scontrino e gli articoli che ha aggiunto? Potrai importarlo di nuovo in seguito.';

  @override
  String get receiptDeleted => 'Scontrino eliminato.';

  @override
  String listReceiptsShowAll(int count) {
    return 'Mostra tutti ($count)';
  }

  @override
  String get listReceiptsShowLess => 'Mostra meno';

  @override
  String receiptDateLabel(String date) {
    return 'Data scontrino: $date';
  }

  @override
  String get historyViewShopping => 'Per spesa';

  @override
  String get historyViewStore => 'Per negozio';

  @override
  String get historyViewProduct => 'Per prodotto';

  @override
  String get historyShareAll => 'Condividi tutto';

  @override
  String get historyUnknownStore => 'Negozio sconosciuto';

  @override
  String get historyDailySpending => 'Spesa giornaliera';

  @override
  String get historyResetPeriod => 'Torna a questa settimana';

  @override
  String get tourSkip => 'Salta';

  @override
  String get tourNewListBody =>
      'Crea una lista della spesa e aggiungi ciò che vuoi comprare.';

  @override
  String get tourFromReceiptBody =>
      'Hai già fatto la spesa? Trasforma uno scontrino in una lista con i prezzi.';

  @override
  String get tourReceiptFlowBody =>
      'Parti dall\'alto dello scontrino: prima acquisisci negozio e data, poi continua con le righe restanti.';

  @override
  String get tourTabsBody =>
      'Passa tra liste attive, completate e archiviate. Il pulsante alla fine cambia l\'ordine.';

  @override
  String get tourDiscoverBody => 'Scopri altre app dello stesso sviluppatore.';

  @override
  String get tourHelpBody =>
      'Tocca qui per rivedere questa guida. Apri una lista per vedere spiegati totali e articoli.';

  @override
  String get tourTotalsBody =>
      'I totali previsto, effettivo e la differenza si aggiornano mentre fai la spesa.';

  @override
  String get tourItemsBody =>
      'I tuoi articoli. Cambiane l\'ordine o cercali qui.';

  @override
  String budgetAlertNear(String percent) {
    return 'Usato il $percent% del limite';
  }
}
