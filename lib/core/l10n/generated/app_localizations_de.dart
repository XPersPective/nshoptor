// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Zuhause geplant, im Laden bewährt.';

  @override
  String get listsTitle => 'Listen';

  @override
  String get listsTabActive => 'Aktiv';

  @override
  String get listsTabCompleted => 'Erledigt';

  @override
  String get listsTabArchived => 'Archiviert';

  @override
  String get newListButton => 'Neue Liste';

  @override
  String get listTitleHint => 'Titel (optional)';

  @override
  String get saveButton => 'Speichern';

  @override
  String get cancelButton => 'Abbrechen';

  @override
  String get deleteButton => 'Löschen';

  @override
  String get editAction => 'Bearbeiten';

  @override
  String get listDeleted => 'Liste gelöscht';

  @override
  String get invalidAmountError => 'Ungültiger Betrag';

  @override
  String get duplicateAction => 'Duplizieren';

  @override
  String get archiveAction => 'Archivieren';

  @override
  String get unarchiveAction => 'Wiederherstellen';

  @override
  String get deleteListConfirm =>
      'Diese Liste löschen? Die geplanten Artikel werden ebenfalls entfernt.';

  @override
  String get undoButton => 'Rückgängig';

  @override
  String get searchListHint => 'Listen durchsuchen';

  @override
  String get currencyLabel => 'Währung';

  @override
  String get budgetLabel => 'Budget (optional)';

  @override
  String get noteLabel => 'Notiz (optional)';

  @override
  String get storeLabel => 'Geschäft';

  @override
  String get keepAmountsAction => 'Beträge behalten';

  @override
  String get resetAmountsAction => 'Beträge zurücksetzen';

  @override
  String get currencyChangeWarning =>
      'Die Währung ändert sich. Was soll mit den vorhandenen Beträgen passieren?';

  @override
  String get listsEmpty =>
      'Noch keine Listen. Erstelle deinen ersten Einkaufsplan.';

  @override
  String get statusDraft => 'Entwurf';

  @override
  String get statusPlanned => 'Geplant';

  @override
  String get statusShopping => 'Beim Einkaufen';

  @override
  String get statusCompleted => 'Erledigt';

  @override
  String get statusArchived => 'Archiviert';

  @override
  String autoListTitle(String date) {
    return 'Einkauf am $date';
  }

  @override
  String get itemFormTitle => 'Artikel hinzufügen';

  @override
  String get itemNameLabel => 'Artikelname';

  @override
  String get brandLabel => 'Marke / Variante (optional)';

  @override
  String get categoryLabel => 'Kategorie';

  @override
  String get quantityLabel => 'Menge';

  @override
  String get unitLabel => 'Einheit';

  @override
  String get pricingModeLabel => 'Preiseingabe';

  @override
  String get pricingModeUnitPrice => 'Stückpreis';

  @override
  String get pricingModeLineTotal => 'Gesamtpreis';

  @override
  String get plannedPriceLabel => 'Geplanter Preis';

  @override
  String lineTotalCalculated(String value) {
    return 'Gesamt: $value';
  }

  @override
  String get requiredItemToggle => 'Pflichtartikel';

  @override
  String get maxPriceLabel => 'Höchster akzeptabler Preis (optional)';

  @override
  String get itemNoteLabel => 'Notiz (optional)';

  @override
  String get categoryProduce => 'Obst & Gemüse';

  @override
  String get categoryDairy => 'Milchprodukte';

  @override
  String get categoryMeat => 'Fleisch';

  @override
  String get categoryBakery => 'Backwaren';

  @override
  String get categoryDrinks => 'Getränke';

  @override
  String get categoryCleaning => 'Reinigung';

  @override
  String get categoryPersonalCare => 'Körperpflege';

  @override
  String get categoryHome => 'Haushalt';

  @override
  String get categoryOther => 'Sonstiges';

  @override
  String get invalidQuantityError => 'Ungültige Menge';

  @override
  String get invalidPriceError => 'Ungültiger Preis';

  @override
  String get invalidNameError => 'Gib einen Namen ein';

  @override
  String unitPriceCalculated(String value) {
    return 'Stückpreis: $value';
  }

  @override
  String get shoppingTitle => 'Einkaufsmodus';

  @override
  String get summaryPlannedTotal => 'Geplant';

  @override
  String get summaryInCart => 'Im Wagen';

  @override
  String get summaryRemainingPlan => 'Rest des Plans';

  @override
  String get summaryProjected => 'Geschätzte Kasse';

  @override
  String get summaryBudgetRemaining => 'Budget übrig';

  @override
  String get summaryBudgetOver => 'Budget überschritten';

  @override
  String itemsProgress(String done, String total) {
    return '$done von $total Artikeln';
  }

  @override
  String get filterAll => 'Alle';

  @override
  String get filterToBuy => 'Zu kaufen';

  @override
  String get filterInCart => 'Im Wagen';

  @override
  String get filterNotFound => 'Nicht gefunden';

  @override
  String get filterRequired => 'Pflicht';

  @override
  String get quickEntryTitle => 'Tatsächlicher Preis';

  @override
  String get actualQuantityLabel => 'Tatsächliche Menge';

  @override
  String get actualPriceLabel => 'Tatsächlicher Preis';

  @override
  String get discountLabel => 'Rabatt (optional)';

  @override
  String get alternativeNameLabel => 'Alternativer Produktname (optional)';

  @override
  String get savePurchaseButton => 'In den Wagen';

  @override
  String get unplannedAddButton => 'Ungeplanten Artikel hinzufügen';

  @override
  String get statusPending => 'Nicht genommen';

  @override
  String get statusInCart => 'Im Wagen';

  @override
  String get statusNotFound => 'Nicht gefunden';

  @override
  String get statusGaveUp => 'Verzichtet';

  @override
  String get statusAlternative => 'Alternative gekauft';

  @override
  String get keepScreenAwake => 'Bildschirm anlassen';

  @override
  String get finishShopping => 'Einkauf beenden';

  @override
  String get completionWarning =>
      'Es gibt fehlende oder ungeprüfte Einträge. Du kannst trotzdem beenden; das Ergebnis vermerkt sie.';

  @override
  String get continueShoppingButton => 'Weiter einkaufen';

  @override
  String get resultTitle => 'Ergebnis';

  @override
  String get summarySection => 'Zusammenfassung';

  @override
  String get plannedTotalLabel => 'Geplant gesamt';

  @override
  String get actualTotalLabel => 'Tatsächlich gesamt';

  @override
  String get varianceLabel => 'Differenz';

  @override
  String get varianceNotComputable => 'Nicht berechenbar';

  @override
  String get budgetStatusLabel => 'Budget';

  @override
  String get savingsLabel => 'Unter Plan';

  @override
  String get overspendLabel => 'Über Plan';

  @override
  String get unplannedTotalLabel => 'Ungeplant gesamt';

  @override
  String get unpurchasedLabel => 'Geplant, nicht gekauft';

  @override
  String get totalDiscountLabel => 'Rabatte gesamt';

  @override
  String get accuracyLabel => 'Schätzgenauigkeit';

  @override
  String get groupsSection => 'Artikel';

  @override
  String get groupPricier => 'Teurer als geplant';

  @override
  String get groupCheaper => 'Günstiger als geplant';

  @override
  String get groupClose => 'Nah an der Schätzung';

  @override
  String get groupNotTaken => 'Geplant, nicht gekauft';

  @override
  String get groupUnplanned => 'Ohne Plan gekauft';

  @override
  String get groupQuantityChanged => 'Menge geändert';

  @override
  String get groupUnverified => 'Nicht geprüft';

  @override
  String get plannedQtyLabel => 'Geplante Menge';

  @override
  String get actualQtyLabel => 'Tatsächliche Menge';

  @override
  String get plannedUnitPriceLabel => 'Geplanter Stückpreis';

  @override
  String get actualUnitPriceLabel => 'Tatsächlicher Stückpreis';

  @override
  String get lineVarianceLabel => 'Differenz';

  @override
  String get discountEffectLabel => 'Rabattwirkung';

  @override
  String get notBoughtMark => 'nicht gekauft';

  @override
  String get noPurchasesNote => 'Es wurden keine Einkäufe erfasst.';

  @override
  String get navHome => 'Start';

  @override
  String get navLists => 'Listen';

  @override
  String get navHistory => 'Verlauf';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get homeEmptyTitle => 'Plane deinen Einkauf';

  @override
  String get homeEmptyBody =>
      'Erstelle deine erste Liste und vergleiche geplante mit tatsächlichen Kosten.';

  @override
  String get homeActiveSection => 'Aktive Listen';

  @override
  String get homeCompletedSection => 'Zuletzt erledigt';

  @override
  String get homeMonthlySection => 'Dieser Monat';

  @override
  String get monthPlannedLabel => 'Geplant';

  @override
  String get monthActualLabel => 'Tatsächlich';

  @override
  String get monthVarianceLabel => 'Differenz';

  @override
  String get continueShoppingLabel => 'Weiter einkaufen';

  @override
  String get historyEmpty =>
      'Noch keine erledigten Einkäufe. Dein Verlauf und deine Auswertungen erscheinen hier.';

  @override
  String get aboutTabTitle => 'Über NShoptor';

  @override
  String get aboutBody =>
      'NShoptor von Crazy Penguin. Einkaufsplaner, der offline funktioniert. Lizenziert unter GPL-3.0.';

  @override
  String get startShoppingLabel => 'Einkauf starten';

  @override
  String get finishAndSeeResult => 'Beenden & Ergebnis ansehen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get languageLabel => 'Sprache';

  @override
  String get languageSystem => 'System';

  @override
  String get languageTr => 'Türkisch';

  @override
  String get languageEn => 'Englisch';

  @override
  String get themeLabel => 'Design';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get defaultCurrencyLabel => 'Standardwährung';

  @override
  String get defaultUnitLabel => 'Standardeinheit';

  @override
  String get keepAwakeLabel => 'Bildschirm beim Einkaufen anlassen';

  @override
  String get backupSection => 'Sicherung';

  @override
  String get exportBackupLabel => 'Sicherung exportieren';

  @override
  String get importBackupLabel => 'Sicherung importieren';

  @override
  String get mergeImportLabel => 'Mit aktuellen Daten zusammenführen';

  @override
  String get separateImportLabel => 'Als separate Kopie importieren';

  @override
  String get importCancelled => 'Import abgebrochen.';

  @override
  String get backupExported => 'Sicherung erfolgreich exportiert.';

  @override
  String get deleteAllSection => 'Gefahrenbereich';

  @override
  String get deleteAllLabel => 'Alle Daten löschen';

  @override
  String get deleteAllConfirm =>
      'Dadurch werden alle Listen, der Verlauf, Kassenbonfotos und Preise entfernt. Von dir exportierte Dateien bleiben erhalten. Fortfahren?';

  @override
  String get deleteAllConfirm2 =>
      'Bist du ganz sicher? Das kann nicht rückgängig gemacht werden.';

  @override
  String get cancelAction => 'Abbrechen';

  @override
  String get confirmDelete => 'Endgültig löschen';

  @override
  String get dataDeleted => 'Alle lokalen Daten wurden gelöscht.';

  @override
  String get privacyInfoLabel => 'Datenschutz';

  @override
  String get privacyInfoBody =>
      'Deine Listen, Preise, Kassenbons und Fotos bleiben auf deinem Gerät. Fotos und Sprache verlassen es nie. Ist die KI-Hilfe an, wird nur Text (z. B. Bonzeilen oder Diktiertes) zur Verarbeitung an unseren Server gesendet und nicht gespeichert.';

  @override
  String get aboutSection => 'Über';

  @override
  String get aboutPublisher => 'Herausgeber: Crazy Penguin';

  @override
  String get aboutLicenses => 'Lizenzen (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Spracheingabe';

  @override
  String get voiceStatusUnknown => 'Dienst: nicht geprüft';

  @override
  String get permissionsLabel => 'Berechtigungen';

  @override
  String get permissionsBody =>
      'Kamera, Mikrofon und Benachrichtigungen werden erst angefragt, wenn du diese Funktionen nutzt.';

  @override
  String get unitsSection => 'Standards';

  @override
  String get roundingNote =>
      'Geldbeträge werden nach einer Regel gerundet: Halbe Beträge von null weg, einmalig bei der Umrechnung.';

  @override
  String get voiceInputTitle => 'Spracheingabe';

  @override
  String get voiceStartListening => 'Zuhören starten';

  @override
  String get voiceTranscriptLabel => 'Text';

  @override
  String get parseAction => 'Auswerten';

  @override
  String get receiptReviewTitle => 'Kassenbon prüfen';

  @override
  String get receiptTotal => 'Bonsumme';

  @override
  String get receiptTotalUnknown => 'Summe nicht erkannt';

  @override
  String get receiptDiff => 'Differenz';

  @override
  String get acceptLine => 'Zeile übernehmen';

  @override
  String get ignoreLine => 'Zeile ignorieren';

  @override
  String get receiptLineActions =>
      'Mit Artikel verknüpfen, teilen oder ignorieren';

  @override
  String get receiptCommit => 'Alle übernehmen';

  @override
  String get receiptCommitted => 'Kassenbon übernommen.';

  @override
  String get priceHistoryTitle => 'Preisverlauf';

  @override
  String get noObservations => 'Noch keine Preise erfasst';

  @override
  String get templatesSection => 'Vorlagen';

  @override
  String get templateHint => 'Neuen Plan aus einem früheren Einkauf erstellen';

  @override
  String get scanReceiptAction => 'Kassenbon scannen';

  @override
  String get fromReceiptListButton => 'Aus Kassenbon';

  @override
  String get shelfLabelAction => 'Preis vom Regaletikett';

  @override
  String get priceCandidatesTitle => 'Preisvorschläge';

  @override
  String get noPriceCandidates =>
      'Kein Preis gefunden; bitte manuell eingeben.';

  @override
  String get voiceUnavailable =>
      'Spracherkennung nicht verfügbar; bitte manuell eingeben.';

  @override
  String get linkToItem => 'Mit Artikel verknüpfen';

  @override
  String get splitLine => 'In zwei teilen';

  @override
  String get mergeWithNext => 'Mit nächster zusammenführen';

  @override
  String get ocrNoText => 'Kein Text erkannt; versuch es noch einmal.';

  @override
  String get priceHistoryAction => 'Preisverlauf';

  @override
  String get itemsEmptyTitle => 'Noch keine Artikel';

  @override
  String get itemsEmptyBody =>
      'Füge deinen ersten Artikel hinzu – im Laden trägst du hier die echten Preise ein.';

  @override
  String get addItemTooltip => 'Artikel hinzufügen';

  @override
  String get unitAdet => 'Stk';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'Pkg';

  @override
  String get unitKutu => 'Schachtel';

  @override
  String get unitSise => 'Flasche';

  @override
  String get unitKavanoz => 'Glas';

  @override
  String get unitDemet => 'Bund';

  @override
  String get unitDuzine => 'Dutzend';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Eigene';

  @override
  String get setReminderAction => 'Erinnerung setzen';

  @override
  String get reminderPermissionDenied =>
      'Für Erinnerungen ist die Benachrichtigungsberechtigung nötig. Du kannst sie in den Systemeinstellungen aktivieren.';

  @override
  String get reminderScheduled => 'Erinnerung gesetzt.';

  @override
  String get reminderCancelled => 'Erinnerung entfernt.';

  @override
  String get reminderTitle => 'Einkaufserinnerung';

  @override
  String reminderBody(Object title) {
    return 'Zeit, deine Liste zu prüfen: $title';
  }

  @override
  String get reminderPickDate => 'Datum wählen';

  @override
  String get reminderPickTime => 'Uhrzeit wählen';

  @override
  String get itemDetailsSection => 'Details';

  @override
  String get priceOptionalHint => 'Marktpreis (optional)';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Geplant: $total · $count Artikel';
  }

  @override
  String get proActiveLabel => 'Pro aktiv – danke!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Keine Werbung · Sicherung exportieren und importieren · Monatlich';

  @override
  String get proBenefitNoAds => 'Werbefrei';

  @override
  String get proBenefitBackup => 'Sicherung (Export/Import)';

  @override
  String aboutVersion(Object version) {
    return 'Version $version';
  }

  @override
  String get navDiscover => 'Entdecken';

  @override
  String get shareAction => 'App teilen';

  @override
  String get rateAction => 'Bewerten';

  @override
  String get aboutOpenRow => 'Über & Open Source';

  @override
  String get voiceAddItemAction => 'Per Sprache hinzufügen';

  @override
  String get formatLocaleLabel => 'Zahlen- & Währungsformat';

  @override
  String get formatLocaleSystem =>
      'Geräteformat (lateinische Ziffern; sonst Englisch)';

  @override
  String get formatLocaleTr => 'Türkisch (1.234,56)';

  @override
  String get formatLocaleEn => 'Englisch (1,234.56)';

  @override
  String get aiToggleTitle => 'KI-Hilfe';

  @override
  String get aiToggleSubtitle =>
      'Gleicht Kassenbons ab, liest Preisschilder und macht aus Sätzen Listen. Fotos und Sprache bleiben auf dem Gerät; nur Text wird verarbeitet.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Du hast die KI-Anfragen dieses Monats aufgebraucht ($used/$limit). Upgrade für mehr oder ohne KI weitermachen.';
  }

  @override
  String get aiOffline => 'Keine Verbindung – weiter ohne KI.';

  @override
  String get aiFailed => 'KI gerade nicht verfügbar – weiter ohne sie.';

  @override
  String get aiSourceLabel => 'KI';

  @override
  String get deviceSourceLabel => 'Gerät';

  @override
  String get quickListAction => 'Aus einem Satz hinzufügen';

  @override
  String get quickListTitle => 'Schnelle Liste';

  @override
  String get quickListHint =>
      'z. B. 1 kg Äpfel 3 €, 2 Brote, ein halbes Kilo Käse';

  @override
  String get quickListConvert => 'In eine Liste umwandeln';

  @override
  String quickListAdd(int count) {
    return '$count Artikel hinzufügen';
  }

  @override
  String get quickListEmpty => 'Keine Artikel gefunden. Trenne sie mit Kommas.';

  @override
  String get receiptAiMatched =>
      'Die KI hat den Bon deiner Liste zugeordnet. Prüfe die Zuordnungen und bestätige.';

  @override
  String get receiptNeedsCheck => 'Zuordnung prüfen';

  @override
  String get receiptDiscountLine => 'Rabatt';

  @override
  String get compareItem => 'Artikel';

  @override
  String get compareEstimated => 'Preis zu Hause';

  @override
  String get compareActual => 'Ladenpreis';

  @override
  String get compareDiff => 'Differenz';

  @override
  String get compareTotal => 'Gesamt';

  @override
  String get compareBudget => 'Budget';

  @override
  String get compareNotBought => 'nicht gekauft';

  @override
  String get compareUnplanned => 'ungeplant';

  @override
  String get pricierItems => 'Teurer';

  @override
  String get cheaperItems => 'Günstiger';

  @override
  String get compareAction => 'Vergleichen';

  @override
  String get detailsSection => 'Details';

  @override
  String get spendingTitle => 'Ausgaben';

  @override
  String get spendingAction => 'Ausgaben';

  @override
  String get spendingMonthTotal => 'Dieser Monat';

  @override
  String get spendingWeekly => 'Wöchentliche Ausgaben';

  @override
  String get spendingMonthly => 'Monatliche Ausgaben';

  @override
  String get monthlyLimitTitle => 'Monatslimit';

  @override
  String get monthlyLimitHelp =>
      'Wie viel möchtest du pro Monat für Einkäufe ausgeben?';

  @override
  String get monthlyLimitRemove => 'Entfernen';

  @override
  String get monthlyLimitSet => 'Festlegen';

  @override
  String get monthlyLimitChange => 'Ändern';

  @override
  String get monthlyLimitNone =>
      'Lege ein Monatslimit fest, um zu sehen, wie viel übrig ist.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount über dem Limit';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'Noch $amount in diesem Monat';
  }

  @override
  String get plansTitle => 'Tarife';

  @override
  String get plansHeadline => 'Klüger einkaufen mit KI';

  @override
  String get plansSubhead =>
      'Bonabgleich, Preisschilder und Listen aus einem Satz. Jederzeit kündbar.';

  @override
  String get plansMonthly => 'Monatlich';

  @override
  String get plansYearly => 'Jährlich';

  @override
  String get planFree => 'Kostenlos';

  @override
  String get planFreePrice => 'Für immer kostenlos';

  @override
  String get planFreeAi => '10 KI-Anfragen pro Monat';

  @override
  String get planFreeAds =>
      'Kleine Bannerwerbung (in den ersten 7 Tagen keine)';

  @override
  String get planCoreFeatures =>
      'Listen, Preise, Kassenbons, Ausgabendiagramme';

  @override
  String get plansPerYear => '/ Jahr';

  @override
  String get plansPerMonth => '/ Monat';

  @override
  String get planTrial => 'Kostenlose Testphase';

  @override
  String get planProAi => '100 KI-Anfragen pro Monat';

  @override
  String get planNoAds => 'Keine Werbung';

  @override
  String get planBackup => 'Sicherung exportieren und importieren';

  @override
  String get planMaxAi => '300 KI-Anfragen pro Monat';

  @override
  String get planMaxFamily => 'Für große Familieneinkäufe';

  @override
  String get plansStoreUnavailable => 'Der Store ist gerade nicht erreichbar.';

  @override
  String get retryAction => 'Erneut versuchen';

  @override
  String get plansPurchaseFailed =>
      'Der Kauf wurde nicht abgeschlossen. Bitte versuch es erneut.';

  @override
  String get plansRestore => 'Käufe wiederherstellen';

  @override
  String get plansLegal =>
      'Pro verlängert sich bis zur Kündigung automatisch jedes Jahr und umfasst 100 KI-Anfragen pro Monat. Der Basispreis beträgt 1 US-Dollar pro Jahr vor anfallenden Steuern; prüfe den endgültigen lokalen Preis und die Steuern im Store, bevor du den Kauf bestätigst. Verwalte oder kündige das Abo in Google Play.';

  @override
  String get planCurrent => 'Aktuell';

  @override
  String get planStartTrial => 'Kostenlose Testphase starten';

  @override
  String get planChoose => 'Wählen';

  @override
  String get plansAction => 'Tarife: Pro';

  @override
  String get assistantTitle => 'Assistent';

  @override
  String get assistantGreeting => 'Hallo! Was möchtest du tun?';

  @override
  String get assistantNewList => 'Neue Liste';

  @override
  String get assistantVoiceList => 'Liste per Sprache';

  @override
  String get assistantTextList => 'Liste aus einem Satz';

  @override
  String get assistantScanReceipt => 'Kassenbon scannen';

  @override
  String get assistantSpending => 'Meine Ausgaben';

  @override
  String get assistantReceiptHint =>
      'Öffne deine Liste und tippe auf das Bon-Symbol, um ihn zu scannen.';

  @override
  String get assistantToggleTitle => 'Assistent anzeigen';

  @override
  String get assistantToggleSubtitle => 'Der kleine Helfer unten rechts';

  @override
  String get scanPriceLabel => 'Preisschild scannen';

  @override
  String get saveFailed =>
      'Speichern fehlgeschlagen. Deine Änderungen sind noch vorhanden. Bitte versuche es erneut.';

  @override
  String get deleteItemConfirm =>
      'Diesen Artikel und seine aufgezeichneten Einkäufe löschen?';

  @override
  String get clearPurchaseConfirm =>
      'Diesen Artikel abhaken und seine aufgezeichneten Einkäufe entfernen?';

  @override
  String get reportPdfAction => 'PDF-Bericht speichern';

  @override
  String get reportNotInvoice =>
      'Einkaufsübersicht, keine Steuerrechnung. Steuersätze sind unbekannt.';

  @override
  String get purchaseVisits => 'Einkaufsbesuche';

  @override
  String get purchaseInterval =>
      'Durchschnittliche Tage zwischen den Einkäufen';

  @override
  String get purchasedQuantity => 'Gekaufte Menge';

  @override
  String get purchaseAnalyticsHint =>
      'Einkäufe messen nicht den Verbrauch. Währungen und Einheiten werden separat angezeigt.';

  @override
  String get receiptReplaces =>
      'Artikel ohne Preis werden ergänzt. Artikel mit bereits vorhandenem Marktpreis werden als separate Käufe hinzugefügt.';

  @override
  String get receiptIncompleteHeader =>
      'Füge Geschäft, Datum, Uhrzeit und Belegnummer in das nächste Foto ein.';

  @override
  String get receiptIncompleteTail =>
      'Fotografiere den nächsten Abschnitt mit einigen überlappenden Artikeln und dem Endbetrag.';

  @override
  String get receiptContinuationRejected =>
      'Dieses Foto konnte nicht mit dem Beleg verbunden werden. Nimm es mit überlappenden Artikeln desselben Belegs erneut auf.';

  @override
  String get receiptDraftSaved =>
      'Beleg als Entwurf gespeichert. Du kannst später fortfahren.';

  @override
  String get receiptContinueAction => 'Beleg fortsetzen';

  @override
  String get receiptDraftsTitle => 'Unfertige Belege';

  @override
  String get receiptDuplicate => 'Dieser Beleg wurde bereits hinzugefügt.';

  @override
  String get receiptTotalMismatch =>
      'Die Artikel stimmen nicht mit dem Gesamtbetrag des Belegs überein. Prüfe, ob der gesamte Beleg zu sehen ist.';

  @override
  String get receiptSaveDraftAction => 'Für später speichern';

  @override
  String get receiptResolveLines =>
      'Akzeptiere oder ignoriere jeden Artikel vor dem Speichern.';

  @override
  String get receiptPartialConfirm =>
      'Nur die ausgewählten Artikel werden hinzugefügt. Dieser Beleg wird als importiert markiert. Fortfahren?';

  @override
  String get voiceUnsupportedLanguage =>
      'Diese Sprache ist für die Spracheingabe auf diesem Gerät nicht verfügbar. Du kannst stattdessen tippen.';

  @override
  String get voiceStopListening => 'Hören stoppen';

  @override
  String get keepAwakeFailed =>
      'Bildschirm konnte nicht wach gehalten werden. Bitte versuchen Sie es erneut.';

  @override
  String get purchaseHistoryHint =>
      'Alle abgeschlossenen Einkäufe. Rückgaben reduzieren die Gesamtbeträge. Die Daten beziehen sich auf den Abschluss des Einkaufs. Ein einzelner Besuch reicht nicht aus, um ein durchschnittliches Intervall zu berechnen.';

  @override
  String get planLegacyRights =>
      'Bestehende Pro- und Max-Abonnements behalten ihr ursprüngliches monatliches KI-Kontingent.';

  @override
  String get csvExportAction => 'CSV exportieren';

  @override
  String get backupSizeWarning =>
      'JSON enthält Datensätze, keine Bilddateien. Importlimit: 16 MB.';

  @override
  String get backupImportFailed =>
      'Dieses Backup konnte nicht importiert werden. Deine Daten wurden nicht geändert.';

  @override
  String get backupImported => 'Backup erfolgreich importiert.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists Listen · $items Artikel · $entries Einkäufe';
  }

  @override
  String get voiceModelDownloading =>
      'Das Sprachmodell für diese Sprache wird heruntergeladen. Versuche es in einer Minute erneut.';

  @override
  String get historyThisWeek => 'Diese Woche';

  @override
  String get historyProductsSection => 'Gekaufte Produkte';

  @override
  String get tipReceiptScan =>
      'Beleg scannen, um die Preise mit deiner Liste abzugleichen';

  @override
  String get tipVoiceAdd =>
      'Sage einen oder mehrere Artikel und prüfe sie vor dem Hinzufügen';

  @override
  String get tipShelfCamera => 'Preis vom Regaletikett mit der Kamera auslesen';

  @override
  String get tipPlan => 'Dein Tarif: Details ansehen, abonnieren oder upgraden';

  @override
  String get guideAddBody =>
      'Tippe auf +, um einen Artikel hinzuzufügen. Trage jetzt den geplanten und an der Kasse den Marktpreis ein.';

  @override
  String get guideVoiceBody =>
      'Tippe aufs Mikrofon und sag deine Artikel, z. B.: „1 Kilo Äpfel, 1 Brot“.';

  @override
  String get guideReceiptBody =>
      'Scanne einen Beleg, um seine Preise mit den Artikeln auf deiner Liste abzugleichen.';

  @override
  String get guidePlanBody =>
      'Tippe auf das Tarifsymbol, um deinen Tarif zu sehen, zu abonnieren oder zu upgraden.';

  @override
  String get guideNext => 'OK';

  @override
  String get guideDone => 'Los geht\'s';

  @override
  String get paletteLabel => 'Farbschema';

  @override
  String get paletteForest => 'Wald';

  @override
  String get paletteOcean => 'Ozean';

  @override
  String get paletteSunset => 'Sonnenuntergang';

  @override
  String get paletteLavender => 'Lavendel';

  @override
  String get darkBlackLabel => 'Reines Schwarz im dunklen Design';

  @override
  String get spendingOverview => 'Überblick';

  @override
  String get spendingThisYear => 'Dieses Jahr';

  @override
  String get spendingYearly => 'Jährliche Ausgaben';

  @override
  String get productSpending => 'Ausgaben nach Produkt';

  @override
  String get spanWeek => 'Woche';

  @override
  String get spanMonth => 'Monat';

  @override
  String get spanYear => 'Jahr';

  @override
  String get weeklyLimitTitle => 'Wochenlimit';

  @override
  String get weeklyLimitHelp =>
      'Wie viel möchtest du pro Woche für Einkäufe ausgeben?';

  @override
  String get weeklyLimitNone =>
      'Lege ein Wochenlimit fest, um zu sehen, wie viel übrig ist.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'Diese Woche noch $amount';
  }

  @override
  String get shoppingLimitTitle => 'Limit pro Einkauf';

  @override
  String get shoppingLimitHelp => 'Neue Listen starten mit diesem Budget.';

  @override
  String get shoppingLimitNone =>
      'Lege ein Standardbudget für jeden neuen Einkauf fest.';

  @override
  String get monthlyReportAction => 'Monatsbericht';

  @override
  String get reportShoppingColumn => 'Einkauf';

  @override
  String get reportDateColumn => 'Datum';

  @override
  String get planUnavailable => 'Derzeit im Store nicht verfügbar';

  @override
  String get demoDataTitle => 'Beispieldaten';

  @override
  String get demoDataLoad => 'Mit Beispieldaten ausprobieren';

  @override
  String get demoDataLoadHelp =>
      'Fügt 12 Monate Beispieleinkäufe hinzu, damit du Verlauf, Diagramme und Preisverlauf siehst.';

  @override
  String get demoDataRemove => 'Beispieldaten entfernen';

  @override
  String get demoDataAdded => 'Beispieldaten hinzugefügt';

  @override
  String get demoDataRemoved => 'Beispieldaten entfernt';

  @override
  String get demoProductApple => 'Äpfel';

  @override
  String get demoProductBread => 'Brot';

  @override
  String get demoProductMilk => 'Milch';

  @override
  String get demoProductCheese => 'Käse';

  @override
  String get demoProductTomato => 'Tomaten';

  @override
  String get demoProductEggs => 'Eier';

  @override
  String get demoProductCoffee => 'Kaffee';

  @override
  String get demoProductDetergent => 'Waschmittel';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Hilfe und Unterstützung';

  @override
  String get howToUseLabel => 'So funktioniert’s';

  @override
  String get guidePricesBody =>
      'Ein Ladenpreis markiert den Artikel als gekauft; auch 0 zählt. Der Preis zu Hause ist optional. Lösche den Ladenpreis, um das Häkchen zu entfernen.';

  @override
  String get shoppingDateLabel => 'Einkaufsdatum';

  @override
  String get shoppingDateNone => 'Kein Datum ausgewählt';

  @override
  String get clearShoppingDateAction => 'Datum entfernen';

  @override
  String get listSortLabel => 'Listenreihenfolge';

  @override
  String get listSortDate => 'Einkaufsdatum';

  @override
  String get listSortAz => 'Name (A–Z)';

  @override
  String get listSortManual => 'Manuelle Reihenfolge';

  @override
  String get imageCameraAction => 'Foto aufnehmen';

  @override
  String get imageGalleryAction => 'Aus Fotos auswählen';

  @override
  String get imageCaptureFailed =>
      'Kamera oder Fotos konnten nicht geöffnet werden. Prüfe die Zugriffsberechtigung und versuche es erneut.';

  @override
  String get imageRecognitionFailed =>
      'Das Foto konnte nicht verarbeitet werden. Versuche es mit einem anderen Foto.';

  @override
  String get receiptNoProducts =>
      'Der Text wurde gelesen, aber es wurden keine Kassenbonartikel gefunden. Nimm die Artikel und den Gesamtbetrag mit auf das Foto.';

  @override
  String get keepAwakeOn => 'Bildschirm bleibt eingeschaltet';

  @override
  String get keepAwakeOff => 'Bildschirm kann sich ausschalten';

  @override
  String get spanDay => 'Tag';

  @override
  String get spanCustom => 'Zeitraum';

  @override
  String get reportTotalSpent => 'Insgesamt ausgegeben';

  @override
  String get reportAddedAt => 'Hinzugefügt';

  @override
  String get reportReceiptNumber => 'Belegnummer';

  @override
  String get reportPreview => 'Vorschau';

  @override
  String get reportShareAction => 'Teilen';

  @override
  String get previousPeriodAction => 'Vorheriger Zeitraum';

  @override
  String get nextPeriodAction => 'Nächster Zeitraum';

  @override
  String get reportSaved => 'Bericht gespeichert.';

  @override
  String get reportZoom => 'Vergrößern';
}
