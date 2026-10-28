// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Prévu à la maison, validé en magasin.';

  @override
  String get listsTitle => 'Listes';

  @override
  String get listsTabActive => 'Actives';

  @override
  String get listsTabCompleted => 'Terminées';

  @override
  String get listsTabArchived => 'Archivées';

  @override
  String get newListButton => 'Nouvelle liste';

  @override
  String get listTitleHint => 'Titre (facultatif)';

  @override
  String get saveButton => 'Enregistrer';

  @override
  String get cancelButton => 'Annuler';

  @override
  String get deleteButton => 'Supprimer';

  @override
  String get editAction => 'Modifier';

  @override
  String get listDeleted => 'Liste supprimée';

  @override
  String get invalidAmountError => 'Montant invalide';

  @override
  String get duplicateAction => 'Dupliquer';

  @override
  String get archiveAction => 'Archiver';

  @override
  String get unarchiveAction => 'Désarchiver';

  @override
  String get deleteListConfirm =>
      'Supprimer cette liste ? Ses articles prévus seront aussi supprimés.';

  @override
  String get undoButton => 'Annuler';

  @override
  String get searchListHint => 'Rechercher des listes';

  @override
  String get currencyLabel => 'Devise';

  @override
  String get budgetLabel => 'Budget (facultatif)';

  @override
  String get noteLabel => 'Note (facultatif)';

  @override
  String get storeLabel => 'Magasin';

  @override
  String get keepAmountsAction => 'Garder les montants';

  @override
  String get resetAmountsAction => 'Réinitialiser les montants';

  @override
  String get currencyChangeWarning =>
      'La devise change. Que faire des montants existants ?';

  @override
  String get listsEmpty =>
      'Aucune liste pour l\'instant. Créez votre premier plan de courses.';

  @override
  String get statusDraft => 'Brouillon';

  @override
  String get statusPlanned => 'Prévue';

  @override
  String get statusShopping => 'En courses';

  @override
  String get statusCompleted => 'Terminée';

  @override
  String get statusArchived => 'Archivée';

  @override
  String autoListTitle(String date) {
    return 'Courses du $date';
  }

  @override
  String get itemFormTitle => 'Ajouter un article';

  @override
  String get itemNameLabel => 'Nom de l\'article';

  @override
  String get brandLabel => 'Marque / variante (facultatif)';

  @override
  String get categoryLabel => 'Catégorie';

  @override
  String get quantityLabel => 'Quantité';

  @override
  String get unitLabel => 'Unité';

  @override
  String get pricingModeLabel => 'Saisie du prix';

  @override
  String get pricingModeUnitPrice => 'Prix unitaire';

  @override
  String get pricingModeLineTotal => 'Prix total';

  @override
  String get plannedPriceLabel => 'Prix prévu';

  @override
  String lineTotalCalculated(String value) {
    return 'Total : $value';
  }

  @override
  String get requiredItemToggle => 'Article indispensable';

  @override
  String get maxPriceLabel => 'Prix maximum accepté (facultatif)';

  @override
  String get itemNoteLabel => 'Note (facultatif)';

  @override
  String get categoryProduce => 'Fruits & légumes';

  @override
  String get categoryDairy => 'Produits laitiers';

  @override
  String get categoryMeat => 'Viande';

  @override
  String get categoryBakery => 'Boulangerie';

  @override
  String get categoryDrinks => 'Boissons';

  @override
  String get categoryCleaning => 'Entretien';

  @override
  String get categoryPersonalCare => 'Hygiène';

  @override
  String get categoryHome => 'Maison';

  @override
  String get categoryOther => 'Autre';

  @override
  String get invalidQuantityError => 'Quantité invalide';

  @override
  String get invalidPriceError => 'Prix invalide';

  @override
  String get invalidNameError => 'Saisissez un nom';

  @override
  String unitPriceCalculated(String value) {
    return 'Prix unitaire : $value';
  }

  @override
  String get shoppingTitle => 'Mode courses';

  @override
  String get summaryPlannedTotal => 'Prévu';

  @override
  String get summaryInCart => 'Au panier';

  @override
  String get summaryRemainingPlan => 'Reste du plan';

  @override
  String get summaryProjected => 'Caisse estimée';

  @override
  String get summaryBudgetRemaining => 'Budget restant';

  @override
  String get summaryBudgetOver => 'Budget dépassé';

  @override
  String itemsProgress(String done, String total) {
    return '$done sur $total articles';
  }

  @override
  String get filterAll => 'Tous';

  @override
  String get filterToBuy => 'À acheter';

  @override
  String get filterInCart => 'Au panier';

  @override
  String get filterNotFound => 'Introuvable';

  @override
  String get filterRequired => 'Indispensable';

  @override
  String get quickEntryTitle => 'Prix réel';

  @override
  String get actualQuantityLabel => 'Quantité réelle';

  @override
  String get actualPriceLabel => 'Prix réel';

  @override
  String get discountLabel => 'Remise (facultatif)';

  @override
  String get alternativeNameLabel => 'Nom du produit alternatif (facultatif)';

  @override
  String get savePurchaseButton => 'Mettre au panier';

  @override
  String get unplannedAddButton => 'Ajouter un article imprévu';

  @override
  String get statusPending => 'Pas pris';

  @override
  String get statusInCart => 'Au panier';

  @override
  String get statusNotFound => 'Introuvable';

  @override
  String get statusGaveUp => 'Abandonné';

  @override
  String get statusAlternative => 'Alternative achetée';

  @override
  String get keepScreenAwake => 'Garder l\'écran allumé';

  @override
  String get finishShopping => 'Terminer les courses';

  @override
  String get completionWarning =>
      'Il manque des données ou certaines ne sont pas vérifiées. Vous pouvez terminer quand même ; le résultat les signalera.';

  @override
  String get continueShoppingButton => 'Continuer les courses';

  @override
  String get resultTitle => 'Résultat';

  @override
  String get summarySection => 'Résumé';

  @override
  String get plannedTotalLabel => 'Total prévu';

  @override
  String get actualTotalLabel => 'Total réel';

  @override
  String get varianceLabel => 'Écart';

  @override
  String get varianceNotComputable => 'Impossible à calculer';

  @override
  String get budgetStatusLabel => 'Budget';

  @override
  String get savingsLabel => 'Sous le plan';

  @override
  String get overspendLabel => 'Au-dessus du plan';

  @override
  String get unplannedTotalLabel => 'Total imprévu';

  @override
  String get unpurchasedLabel => 'Prévu mais non acheté';

  @override
  String get totalDiscountLabel => 'Remises totales';

  @override
  String get accuracyLabel => 'Précision de l\'estimation';

  @override
  String get groupsSection => 'Articles';

  @override
  String get groupPricier => 'Plus cher que prévu';

  @override
  String get groupCheaper => 'Moins cher que prévu';

  @override
  String get groupClose => 'Proche de l\'estimation';

  @override
  String get groupNotTaken => 'Prévu, non acheté';

  @override
  String get groupUnplanned => 'Acheté sans plan';

  @override
  String get groupQuantityChanged => 'Quantité modifiée';

  @override
  String get groupUnverified => 'Non vérifié';

  @override
  String get plannedQtyLabel => 'Quantité prévue';

  @override
  String get actualQtyLabel => 'Quantité réelle';

  @override
  String get plannedUnitPriceLabel => 'Prix unitaire prévu';

  @override
  String get actualUnitPriceLabel => 'Prix unitaire réel';

  @override
  String get lineVarianceLabel => 'Écart';

  @override
  String get discountEffectLabel => 'Effet des remises';

  @override
  String get notBoughtMark => 'non acheté';

  @override
  String get noPurchasesNote => 'Aucun achat n\'a été enregistré.';

  @override
  String get navHome => 'Accueil';

  @override
  String get navLists => 'Listes';

  @override
  String get navHistory => 'Historique';

  @override
  String get navSettings => 'Réglages';

  @override
  String get homeEmptyTitle => 'Planifiez vos courses';

  @override
  String get homeEmptyBody =>
      'Créez votre première liste et comparez le prévu et le réel.';

  @override
  String get homeActiveSection => 'Listes actives';

  @override
  String get homeCompletedSection => 'Terminées récemment';

  @override
  String get homeMonthlySection => 'Ce mois-ci';

  @override
  String get monthPlannedLabel => 'Prévu';

  @override
  String get monthActualLabel => 'Réel';

  @override
  String get monthVarianceLabel => 'Écart';

  @override
  String get continueShoppingLabel => 'Continuer les courses';

  @override
  String get historyEmpty =>
      'Aucune course terminée pour l\'instant. Votre historique et vos analyses apparaîtront ici.';

  @override
  String get aboutTabTitle => 'À propos de NShoptor';

  @override
  String get aboutBody =>
      'NShoptor par Crazy Penguin. Planificateur de courses qui fonctionne hors ligne. Sous licence GPL-3.0.';

  @override
  String get startShoppingLabel => 'Commencer les courses';

  @override
  String get finishAndSeeResult => 'Terminer et voir le résultat';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get languageLabel => 'Langue';

  @override
  String get languageSystem => 'Système';

  @override
  String get languageTr => 'Turc';

  @override
  String get languageEn => 'Anglais';

  @override
  String get themeLabel => 'Thème';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get defaultCurrencyLabel => 'Devise par défaut';

  @override
  String get defaultUnitLabel => 'Unité par défaut';

  @override
  String get keepAwakeLabel => 'Garder l\'écran allumé pendant les courses';

  @override
  String get backupSection => 'Sauvegarde';

  @override
  String get exportBackupLabel => 'Exporter la sauvegarde';

  @override
  String get importBackupLabel => 'Importer une sauvegarde';

  @override
  String get mergeImportLabel => 'Fusionner avec les données actuelles';

  @override
  String get separateImportLabel => 'Importer comme copie séparée';

  @override
  String get importCancelled => 'Importation annulée.';

  @override
  String get backupExported => 'Sauvegarde exportée avec succès.';

  @override
  String get deleteAllSection => 'Zone sensible';

  @override
  String get deleteAllLabel => 'Supprimer toutes les données';

  @override
  String get deleteAllConfirm =>
      'Toutes les listes, l\'historique, les photos de tickets et les prix seront supprimés. Les fichiers que vous avez exportés restent sur votre stockage. Continuer ?';

  @override
  String get deleteAllConfirm2 =>
      'En êtes-vous vraiment sûr ? Cette action est irréversible.';

  @override
  String get cancelAction => 'Annuler';

  @override
  String get confirmDelete => 'Supprimer définitivement';

  @override
  String get dataDeleted => 'Toutes les données locales ont été supprimées.';

  @override
  String get privacyInfoLabel => 'Confidentialité';

  @override
  String get privacyInfoBody =>
      'Vos listes, prix, tickets et photos sont stockés sur votre appareil. La voix ne le quitte jamais. Lorsque l\'aide IA est activée, les photos de tickets et d\'étiquettes de prix (réduites en taille) et le texte, comme les articles dictés, sont envoyés à notre serveur uniquement pour être lus ; ils sont traités immédiatement et jamais stockés.';

  @override
  String get aboutSection => 'À propos';

  @override
  String get aboutPublisher => 'Éditeur : Crazy Penguin';

  @override
  String get aboutLicenses => 'Licences (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Saisie vocale';

  @override
  String get voiceStatusUnknown => 'Service : non vérifié';

  @override
  String get permissionsLabel => 'Autorisations';

  @override
  String get permissionsBody =>
      'L\'appareil photo, le micro et les notifications ne sont demandés que lorsque vous utilisez ces fonctions.';

  @override
  String get unitsSection => 'Valeurs par défaut';

  @override
  String get roundingNote =>
      'Les montants suivent une seule règle d\'arrondi : les moitiés s\'arrondissent en s\'éloignant de zéro, une seule fois à la conversion.';

  @override
  String get voiceInputTitle => 'Saisie vocale';

  @override
  String get voiceStartListening => 'Commencer l\'écoute';

  @override
  String get voiceTranscriptLabel => 'Transcription';

  @override
  String get parseAction => 'Analyser';

  @override
  String get receiptReviewTitle => 'Vérifier le ticket';

  @override
  String get receiptTotal => 'Total du ticket';

  @override
  String get receiptTotalUnknown => 'Total non détecté';

  @override
  String get receiptDiff => 'Écart';

  @override
  String get acceptLine => 'Accepter la ligne';

  @override
  String get ignoreLine => 'Ignorer la ligne';

  @override
  String get receiptLineActions => 'Lier à un article, diviser ou ignorer';

  @override
  String get receiptCommit => 'Tout accepter';

  @override
  String get receiptCommitted => 'Ticket appliqué.';

  @override
  String get priceHistoryTitle => 'Historique des prix';

  @override
  String get noObservations => 'Aucun prix relevé pour l\'instant';

  @override
  String get templatesSection => 'Modèles';

  @override
  String get templateHint =>
      'Créer un nouveau plan à partir de courses précédentes';

  @override
  String get scanReceiptAction => 'Scanner le ticket';

  @override
  String get fromReceiptListButton => 'Depuis un ticket';

  @override
  String get shelfLabelAction => 'Prix depuis l\'étiquette';

  @override
  String get priceCandidatesTitle => 'Prix proposés';

  @override
  String get noPriceCandidates => 'Aucun prix trouvé ; saisissez-le à la main.';

  @override
  String get voiceUnavailable =>
      'Reconnaissance vocale indisponible ; saisissez à la main.';

  @override
  String get linkToItem => 'Lier à un article';

  @override
  String get splitLine => 'Diviser en deux';

  @override
  String get mergeWithNext => 'Fusionner avec la suivante';

  @override
  String get ocrNoText => 'Aucun texte lu ; réessayez.';

  @override
  String get priceHistoryAction => 'Historique des prix';

  @override
  String get itemsEmptyTitle => 'Aucun article';

  @override
  String get itemsEmptyBody =>
      'Ajoutez votre premier article – en magasin, vous saisirez ici les vrais prix.';

  @override
  String get addItemTooltip => 'Ajouter un article';

  @override
  String get unitAdet => 'pce';

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
  String get unitKutu => 'boîte';

  @override
  String get unitSise => 'bouteille';

  @override
  String get unitKavanoz => 'bocal';

  @override
  String get unitDemet => 'botte';

  @override
  String get unitDuzine => 'douzaine';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Personnalisée';

  @override
  String get setReminderAction => 'Programmer un rappel';

  @override
  String get reminderPermissionDenied =>
      'L\'autorisation de notification est nécessaire pour les rappels. Vous pouvez l\'activer dans les réglages du système.';

  @override
  String get reminderScheduled => 'Rappel programmé.';

  @override
  String get reminderCancelled => 'Rappel supprimé.';

  @override
  String get reminderTitle => 'Rappel de courses';

  @override
  String reminderBody(Object title) {
    return 'C\'est le moment de vérifier votre liste : $title';
  }

  @override
  String get reminderPickDate => 'Choisir une date';

  @override
  String get reminderPickTime => 'Choisir une heure';

  @override
  String get itemDetailsSection => 'Détails';

  @override
  String get priceOptionalHint => 'Prix du marché (facultatif)';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Prévu : $total · $count articles';
  }

  @override
  String get proActiveLabel => 'Pro actif – merci !';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Sans publicité · Export et import de sauvegarde · Annuel';

  @override
  String get proBenefitNoAds => 'Sans publicité';

  @override
  String get proBenefitBackup => 'Sauvegarde (export/import)';

  @override
  String aboutVersion(Object version) {
    return 'Version $version';
  }

  @override
  String get navDiscover => 'Découvrir';

  @override
  String get shareAction => 'Partager l\'appli';

  @override
  String get rateAction => 'Noter l\'appli';

  @override
  String get aboutOpenRow => 'À propos & open source';

  @override
  String get voiceAddItemAction => 'Ajouter à la voix';

  @override
  String get formatLocaleLabel => 'Format des nombres et devises';

  @override
  String get formatLocaleSystem =>
      'Format du système (chiffres latins ; sinon anglais)';

  @override
  String get formatLocaleTr => 'Turc (1.234,56)';

  @override
  String get formatLocaleEn => 'Anglais (1,234.56)';

  @override
  String get aiToggleTitle => 'Aide IA';

  @override
  String get aiToggleSubtitle =>
      'Lit les tickets et les étiquettes de prix à partir de photos, rapproche les tickets et transforme des phrases en listes. Les photos sont envoyées uniquement pour être lues et ne sont jamais stockées.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Vous avez utilisé les requêtes IA de ce mois ($used/$limit). Passez à une offre supérieure ou continuez sans IA.';
  }

  @override
  String get aiOffline => 'Pas de connexion – on continue sans IA.';

  @override
  String get aiFailed =>
      'L\'IA est indisponible pour l\'instant – on continue sans elle.';

  @override
  String get aiSourceLabel => 'IA';

  @override
  String get deviceSourceLabel => 'Appareil';

  @override
  String get quickListAction => 'Ajouter à partir d\'une phrase';

  @override
  String get quickListTitle => 'Liste rapide';

  @override
  String get quickListHint =>
      'ex. 1 kg de pommes 3 €, 2 baguettes, une demi-livre de fromage';

  @override
  String get quickListConvert => 'Transformer en liste';

  @override
  String quickListAdd(int count) {
    return 'Ajouter $count articles';
  }

  @override
  String get quickListEmpty =>
      'Aucun article trouvé. Séparez-les par des virgules.';

  @override
  String get receiptAiMatched =>
      'L\'IA a associé le ticket à votre liste. Vérifiez les liens puis confirmez.';

  @override
  String get receiptNeedsCheck => 'Vérifier cette association';

  @override
  String get receiptDiscountLine => 'Remise';

  @override
  String get compareItem => 'Article';

  @override
  String get compareEstimated => 'Prix à la maison';

  @override
  String get compareActual => 'Prix en magasin';

  @override
  String get compareDiff => 'Écart';

  @override
  String get compareTotal => 'Total';

  @override
  String get compareBudget => 'Budget';

  @override
  String get compareNotBought => 'non acheté';

  @override
  String get compareUnplanned => 'imprévu';

  @override
  String get pricierItems => 'Plus cher';

  @override
  String get cheaperItems => 'Moins cher';

  @override
  String get compareAction => 'Comparer';

  @override
  String get detailsSection => 'Détails';

  @override
  String get spendingTitle => 'Dépenses';

  @override
  String get spendingAction => 'Dépenses';

  @override
  String get spendingMonthTotal => 'Ce mois-ci';

  @override
  String get spendingWeekly => 'Dépenses hebdomadaires';

  @override
  String get spendingMonthly => 'Dépenses mensuelles';

  @override
  String get monthlyLimitTitle => 'Limite mensuelle';

  @override
  String get monthlyLimitHelp =>
      'Combien voulez-vous dépenser en courses par mois ?';

  @override
  String get monthlyLimitRemove => 'Retirer';

  @override
  String get monthlyLimitSet => 'Définir';

  @override
  String get monthlyLimitChange => 'Modifier';

  @override
  String get monthlyLimitNone =>
      'Définissez une limite mensuelle pour voir ce qu\'il vous reste.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount au-dessus de la limite';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'Il reste $amount ce mois-ci';
  }

  @override
  String get plansTitle => 'Offres';

  @override
  String get plansHeadline => 'Faites vos courses plus malin avec l\'IA';

  @override
  String get plansSubhead =>
      'Association des tickets, étiquettes de prix et listes à partir d\'une phrase. Résiliable à tout moment.';

  @override
  String get plansMonthly => 'Mensuel';

  @override
  String get plansYearly => 'Annuel';

  @override
  String get planFree => 'Gratuit';

  @override
  String get planFreePrice => 'Gratuit pour toujours';

  @override
  String get planFreeAi => '10 requêtes IA par mois';

  @override
  String get planFreeAds =>
      'Petites bannières publicitaires (aucune les 7 premiers jours)';

  @override
  String get planCoreFeatures =>
      'Listes, prix, tickets, graphiques de dépenses';

  @override
  String get plansPerYear => '/ an';

  @override
  String get plansPerMonth => '/ mois';

  @override
  String get planTrial => 'Essai gratuit';

  @override
  String get planProAi => '100 requêtes IA par mois';

  @override
  String get planNoAds => 'Sans publicité';

  @override
  String get planBackup => 'Export et import de sauvegarde';

  @override
  String get planMaxAi => '300 requêtes IA par mois';

  @override
  String get planMaxFamily => 'Pour les grosses courses en famille';

  @override
  String get plansStoreUnavailable =>
      'La boutique est inaccessible pour le moment.';

  @override
  String get retryAction => 'Réessayer';

  @override
  String get plansPurchaseFailed =>
      'L\'achat n\'a pas abouti. Veuillez réessayer.';

  @override
  String get plansRestore => 'Restaurer les achats';

  @override
  String get plansLegal =>
      'Pro se renouvelle automatiquement chaque année jusqu’à résiliation et inclut 100 requêtes d’IA par mois. Le prix de base est de 1 dollar américain par an hors taxes applicables ; vérifiez le prix local final et les taxes dans la boutique avant de confirmer l’achat. Gérez ou résiliez l’abonnement dans Google Play.';

  @override
  String get planCurrent => 'Actuelle';

  @override
  String get planStartTrial => 'Démarrer l’essai gratuit';

  @override
  String get planChoose => 'Choisir';

  @override
  String get plansAction => 'Offres: Pro';

  @override
  String get assistantTitle => 'Assistant';

  @override
  String get assistantGreeting => 'Bonjour ! Que voulez-vous faire ?';

  @override
  String get assistantNewList => 'Nouvelle liste';

  @override
  String get assistantVoiceList => 'Liste à la voix';

  @override
  String get assistantTextList => 'Liste à partir d\'une phrase';

  @override
  String get assistantScanReceipt => 'Scanner un ticket';

  @override
  String get assistantSpending => 'Mes dépenses';

  @override
  String get assistantReceiptHint =>
      'Ouvrez votre liste et touchez l\'icône du ticket pour le scanner.';

  @override
  String get assistantToggleTitle => 'Afficher l\'assistant';

  @override
  String get assistantToggleSubtitle => 'Le petit assistant en bas à droite';

  @override
  String get scanPriceLabel => 'Scanner l\'étiquette de prix';

  @override
  String get saveFailed =>
      'Échec de l\'enregistrement. Vos modifications sont toujours présentes. Veuillez réessayer.';

  @override
  String get deleteItemConfirm =>
      'Supprimer cet article et ses achats enregistrés ?';

  @override
  String get clearPurchaseConfirm =>
      'Décocher cet article et supprimer ses achats enregistrés ?';

  @override
  String get reportPdfAction => 'Enregistrer le rapport PDF';

  @override
  String get reportNotInvoice =>
      'Résumé des courses, pas une facture fiscale. Les taux de taxe sont inconnus.';

  @override
  String get purchaseVisits => 'Visites d\'achat';

  @override
  String get purchaseInterval => 'Jours moyens entre les achats';

  @override
  String get purchasedQuantity => 'Quantité achetée';

  @override
  String get purchaseAnalyticsHint =>
      'Les achats ne mesurent pas la consommation. Les devises et unités sont affichées séparément.';

  @override
  String get receiptReplaces =>
      'Les articles sans prix sont complétés. Ceux qui ont déjà un prix du marché sont ajoutés comme achats séparés.';

  @override
  String get receiptIncompleteHeader =>
      'Incluez le magasin, la date, l’heure et le numéro du reçu dans la prochaine photo.';

  @override
  String get receiptIncompleteTail =>
      'Photographiez la section suivante avec quelques articles qui se chevauchent et le total final.';

  @override
  String get receiptContinuationRejected =>
      'Cette photo n’a pas pu être assemblée au reçu. Reprenez-la avec des articles qui se chevauchent du même reçu.';

  @override
  String get receiptDraftSaved =>
      'Reçu enregistré comme brouillon. Vous pourrez continuer plus tard.';

  @override
  String get receiptContinueAction => 'Continuer le reçu';

  @override
  String get receiptDraftsTitle => 'Reçus inachevés';

  @override
  String get receiptDuplicate => 'Ce reçu a déjà été ajouté.';

  @override
  String get receiptTotalMismatch =>
      'Les articles ne correspondent pas au total du reçu. Vérifiez que le reçu entier est visible.';

  @override
  String get receiptSaveDraftAction => 'Enregistrer pour plus tard';

  @override
  String get receiptResolveLines =>
      'Acceptez ou ignorez chaque article avant d’enregistrer.';

  @override
  String get receiptPartialConfirm =>
      'Seuls les articles sélectionnés seront ajoutés. Ce reçu sera marqué comme importé. Continuer ?';

  @override
  String get voiceUnsupportedLanguage =>
      'Cette langue n\'est pas disponible pour la saisie vocale sur cet appareil. Vous pouvez taper à la place.';

  @override
  String get voiceStopListening => 'Arrêter l\'écoute';

  @override
  String get keepAwakeFailed =>
      'Impossible de maintenir l\'écran allumé. Veuillez réessayer.';

  @override
  String get purchaseHistoryHint =>
      'Tous les achats terminés. Les retours réduisent les totaux. Les dates correspondent à la fin des courses. Une seule visite ne suffit pas pour calculer un intervalle moyen.';

  @override
  String get planLegacyRights =>
      'Les abonnements Pro et Max existants conservent leur quota mensuel d\'IA initial.';

  @override
  String get csvExportAction => 'Exporter en CSV';

  @override
  String get reportSharePdf => 'Partager en PDF';

  @override
  String get reportShareCsv => 'Partager en CSV';

  @override
  String get reportPrintAction => 'Imprimer';

  @override
  String get backupSizeWarning =>
      'Le JSON contient des enregistrements, pas des fichiers photo. Limite d\'importation : 16 Mo.';

  @override
  String get backupImportFailed =>
      'Impossible d\'importer cette sauvegarde. Vos données n\'ont pas été modifiées.';

  @override
  String get backupImported => 'Sauvegarde importée avec succès.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists listes · $items articles · $entries achats';
  }

  @override
  String get voiceModelDownloading =>
      'Le modèle vocal de cette langue est en cours de téléchargement. Réessayez dans une minute.';

  @override
  String get historyThisWeek => 'Cette semaine';

  @override
  String get historyProductsSection => 'Produits achetés';

  @override
  String get tipReceiptScan =>
      'Scannez un ticket pour rapprocher les prix de votre liste';

  @override
  String get tipVoiceAdd =>
      'Dictez un ou plusieurs articles, puis vérifiez-les avant de les ajouter';

  @override
  String get tipShelfCamera =>
      'Lisez le prix sur l\'étiquette du rayon avec l\'appareil photo';

  @override
  String get tipPlan =>
      'Votre forfait : voir les détails, s\'abonner ou passer à un forfait supérieur';

  @override
  String get guideAddBody =>
      'Touchez + pour ajouter un article. Saisissez le prix prévu maintenant et le prix du marché en caisse.';

  @override
  String get guideVoiceBody =>
      'Touchez le micro et dictez vos articles, par exemple : « 1 kilo de pommes, 1 pain ».';

  @override
  String get guideReceiptBody =>
      'Scannez un ticket pour rapprocher ses prix des articles de votre liste.';

  @override
  String get guidePlanBody =>
      'Touchez l\'icône du forfait pour voir votre forfait, vous abonner ou passer à un forfait supérieur.';

  @override
  String get guideNext => 'OK';

  @override
  String get guideDone => 'Commencer';

  @override
  String get paletteLabel => 'Thème de couleur';

  @override
  String get paletteForest => 'Forêt';

  @override
  String get paletteOcean => 'Océan';

  @override
  String get paletteSunset => 'Coucher de soleil';

  @override
  String get paletteLavender => 'Lavande';

  @override
  String get darkBlackLabel => 'Noir pur en thème sombre';

  @override
  String get spendingOverview => 'Vue d\'ensemble';

  @override
  String get spendingThisYear => 'Cette année';

  @override
  String get spendingYearly => 'Dépenses annuelles';

  @override
  String get productSpending => 'Dépenses par produit';

  @override
  String get spanWeek => 'Semaine';

  @override
  String get spanMonth => 'Mois';

  @override
  String get spanYear => 'Année';

  @override
  String get weeklyLimitTitle => 'Limite hebdomadaire';

  @override
  String get weeklyLimitHelp =>
      'Combien voulez-vous dépenser en courses par semaine ?';

  @override
  String get weeklyLimitNone =>
      'Fixez une limite hebdomadaire pour voir ce qu\'il reste.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'Il reste $amount cette semaine';
  }

  @override
  String get shoppingLimitTitle => 'Limite par course';

  @override
  String get shoppingLimitHelp =>
      'Les nouvelles listes démarrent avec ce budget.';

  @override
  String get shoppingLimitNone =>
      'Fixez un budget par défaut pour chaque nouvelle course.';

  @override
  String get monthlyReportAction => 'Rapport mensuel';

  @override
  String get reportShoppingColumn => 'Course';

  @override
  String get reportDateColumn => 'Date';

  @override
  String get planUnavailable => 'Indisponible dans la boutique pour l\'instant';

  @override
  String get demoDataTitle => 'Données d\'exemple';

  @override
  String get demoDataLoad => 'Essayer avec des données d\'exemple';

  @override
  String get demoDataLoadHelp =>
      'Ajoute 12 mois d\'achats d\'exemple pour voir l\'historique, les graphiques et l\'historique des prix.';

  @override
  String get demoDataRemove => 'Supprimer les données d\'exemple';

  @override
  String get demoDataAdded => 'Données d\'exemple ajoutées';

  @override
  String get demoDataRemoved => 'Données d\'exemple supprimées';

  @override
  String get demoProductApple => 'Pommes';

  @override
  String get demoProductBread => 'Pain';

  @override
  String get demoProductMilk => 'Lait';

  @override
  String get demoProductCheese => 'Fromage';

  @override
  String get demoProductTomato => 'Tomates';

  @override
  String get demoProductEggs => 'Œufs';

  @override
  String get demoProductCoffee => 'Café';

  @override
  String get demoProductDetergent => 'Lessive';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Aide et assistance';

  @override
  String get howToUseLabel => 'Mode d’emploi';

  @override
  String get guidePricesBody =>
      'Un prix en magasin marque l’article comme acheté, même à 0. Le prix à la maison est facultatif. Effacez le prix en magasin pour retirer la coche.';

  @override
  String get shoppingDateLabel => 'Date des courses';

  @override
  String get shoppingDateNone => 'Aucune date sélectionnée';

  @override
  String get clearShoppingDateAction => 'Effacer la date';

  @override
  String get listSortLabel => 'Ordre de la liste';

  @override
  String get listSortDate => 'Date des courses';

  @override
  String get listSortAz => 'Nom (A–Z)';

  @override
  String get listSortManual => 'Ordre manuel';

  @override
  String get imageCameraAction => 'Prendre une photo';

  @override
  String get imageGalleryAction => 'Choisir parmi les photos';

  @override
  String get imageCaptureFailed =>
      'Impossible d\'ouvrir l\'appareil photo ou les photos. Vérifiez l\'autorisation d\'accès et réessayez.';

  @override
  String get imageRecognitionFailed =>
      'La photo n\'a pas pu être traitée. Essayez une autre photo.';

  @override
  String get receiptNoProducts =>
      'Le texte a été lu, mais aucun article du ticket n\'a été trouvé. Incluez les articles et le total dans la photo.';

  @override
  String get keepAwakeOn => 'L’écran reste allumé';

  @override
  String get keepAwakeOff => 'L’écran peut s’éteindre';

  @override
  String get spanDay => 'Jour';

  @override
  String get spanCustom => 'Période';

  @override
  String get reportTotalSpent => 'Total dépensé';

  @override
  String get reportAddedAt => 'Ajouté';

  @override
  String get reportReceiptNumber => 'Numéro de reçu';

  @override
  String get reportPreview => 'Aperçu';

  @override
  String get reportShareAction => 'Partager';

  @override
  String get previousPeriodAction => 'Période précédente';

  @override
  String get nextPeriodAction => 'Période suivante';

  @override
  String get reportSaved => 'Rapport enregistré.';

  @override
  String get reportZoom => 'Zoomer';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days jours restants',
      one: '$days jour restant',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours heures restantes',
      one: '$hours heure restante',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Votre essai Pro est terminé';

  @override
  String get planTrialEndedBody =>
      'Vous pouvez continuer à utiliser gratuitement les listes, la saisie manuelle et la voix sur l’appareil. L’offre gratuite comprend 10 requêtes IA par mois calendaire. Choisissez Pro annuel pour 100 requêtes IA par mois, sans publicité et avec des sauvegardes. Vos données existantes restent avec vous.';

  @override
  String get planContinueFree => 'Continuer gratuitement';

  @override
  String get supportIdLabel => 'ID d’assistance';

  @override
  String get supportEmailLabel => 'Assistance par e-mail';

  @override
  String get captureTipFirst =>
      'Commencez tout en haut : le nom du magasin et la date doivent être visibles. Incluez le plus d’articles possible ; le reste ira dans la photo suivante.';

  @override
  String get captureTipContinue =>
      'Même reçu : incluez le dernier article de la photo précédente.';

  @override
  String get captureTipNeverShow => 'Ne plus afficher';

  @override
  String get captureTipOk => 'Compris';

  @override
  String get captureTipsSetting =>
      'Afficher les conseils de prise de vue du reçu';
}
