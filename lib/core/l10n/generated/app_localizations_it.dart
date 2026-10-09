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
  String get slogan => 'Pianifica a casa. Compra come previsto.';

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
  String get backupSizeWarning =>
      'Backup grande: il file può essere pesante. Includere anche le foto?';

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
      'Liste, prezzi, scontrini e foto restano sul tuo dispositivo. Foto e voce non lo lasciano mai. Con l\'aiuto IA attivo, solo il testo (ad esempio righe dello scontrino o ciò che hai dettato) viene inviato al nostro server per l\'elaborazione e non viene conservato.';

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
  String get priceOptionalHint =>
      'Facoltativo: il prezzo reale lo inserirai in negozio';

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
      'Niente pubblicità, più IA, backup · a partire da un piccolo prezzo mensile';

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
  String get formatLocaleSystem =>
      'Formato del dispositivo (cifre latine; altrimenti inglese)';

  @override
  String get formatLocaleTr => 'Turco (1.234,56)';

  @override
  String get formatLocaleEn => 'Inglese (1,234.56)';

  @override
  String get aiToggleTitle => 'Aiuto IA';

  @override
  String get aiToggleSubtitle =>
      'Abbina gli scontrini, legge le etichette dei prezzi e trasforma le frasi in liste. Foto e voce restano sul dispositivo; viene elaborato solo il testo.';

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
  String get compareEstimated => 'Stimato';

  @override
  String get compareActual => 'Reale';

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
  String get planFreeAi => '15 richieste IA al mese';

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
  String get planTrial => '7 giorni gratis';

  @override
  String get planProAi => '200 richieste IA al mese';

  @override
  String get planNoAds => 'Senza pubblicità';

  @override
  String get planBackup => 'Esporta e importa backup';

  @override
  String get planMaxAi => '1000 richieste IA al mese';

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
  String get planLifetimeTitle => 'Senza pubblicità per sempre';

  @override
  String get planLifetimeSubtitle =>
      'Pagamento unico: niente pubblicità, backup; l\'IA resta nella quota gratuita';

  @override
  String get plansRestore => 'Ripristina acquisti';

  @override
  String get plansLegal =>
      'Gli abbonamenti si rinnovano automaticamente fino alla disdetta. Disdici quando vuoi in Google Play › Pagamenti e abbonamenti. I prezzi includono le tasse indicate da Google Play.';

  @override
  String get planCurrent => 'Attuale';

  @override
  String get planStartTrial => 'Prova gratis per 7 giorni';

  @override
  String get planChoose => 'Scegli';

  @override
  String get plansAction => 'Piani: Pro e Max';

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
      'Le righe del scontrino collegate sostituiscono gli acquisti esistenti; le righe non collegate vengono aggiunte.';

  @override
  String get voiceUnsupportedLanguage =>
      'Questa lingua non è disponibile per l\'input vocale su questo dispositivo. Puoi digitare invece.';

  @override
  String get voiceStopListening => 'Ferma l\'ascolto';
}
