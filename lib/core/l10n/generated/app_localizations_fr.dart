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
  String get slogan => 'Planifiez à la maison. Achetez comme prévu.';

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
  String get backupSizeWarning =>
      'Sauvegarde volumineuse : le fichier peut être gros. Inclure aussi les photos ?';

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
      'Vos listes, prix, tickets et photos restent sur votre appareil. Les photos et la voix ne le quittent jamais. Quand l\'aide IA est activée, seul du texte (par exemple des lignes de ticket ou ce que vous avez dicté) est envoyé à notre serveur pour être traité, sans être conservé.';

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
  String get priceOptionalHint =>
      'Facultatif – vous saisirez le vrai prix en magasin';

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
      'Sans pub, plus d\'IA, sauvegarde · pour un petit prix mensuel';

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
  String get formatLocaleSystem => 'Système (suit la langue)';

  @override
  String get formatLocaleTr => 'Turc (1.234,56)';

  @override
  String get formatLocaleEn => 'Anglais (1,234.56)';

  @override
  String get aiToggleTitle => 'Aide IA';

  @override
  String get aiToggleSubtitle =>
      'Associe les tickets, lit les étiquettes de prix et transforme des phrases en listes. Photos et voix restent sur l\'appareil ; seul le texte est traité.';

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
  String get compareEstimated => 'Estimé';

  @override
  String get compareActual => 'Réel';

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
  String get planFreeAi => '15 requêtes IA par mois';

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
  String get planTrial => '7 jours gratuits';

  @override
  String get planProAi => '200 requêtes IA par mois';

  @override
  String get planNoAds => 'Sans publicité';

  @override
  String get planBackup => 'Export et import de sauvegarde';

  @override
  String get planMaxAi => '1000 requêtes IA par mois';

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
  String get planLifetimeTitle => 'Sans pub à vie';

  @override
  String get planLifetimeSubtitle =>
      'Paiement unique : sans pub, sauvegarde ; l\'IA reste au quota gratuit';

  @override
  String get plansRestore => 'Restaurer les achats';

  @override
  String get plansLegal =>
      'Les abonnements se renouvellent automatiquement jusqu\'à résiliation. Résiliez à tout moment dans Google Play › Paiements et abonnements. Les prix incluent les taxes indiquées par Google Play.';

  @override
  String get planCurrent => 'Actuelle';

  @override
  String get planStartTrial => 'Essai gratuit de 7 jours';

  @override
  String get planChoose => 'Choisir';

  @override
  String get plansAction => 'Offres : Pro et Max';

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
}
