// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Σχεδίασε στο σπίτι. Ψώνισε όπως σχεδίασες.';

  @override
  String get listsTitle => 'Λίστες';

  @override
  String get listsTabActive => 'Ενεργές';

  @override
  String get listsTabCompleted => 'Ολοκληρωμένες';

  @override
  String get listsTabArchived => 'Αρχειοθετημένες';

  @override
  String get newListButton => 'Νέα λίστα';

  @override
  String get listTitleHint => 'Τίτλος (προαιρετικό)';

  @override
  String get saveButton => 'Αποθήκευση';

  @override
  String get cancelButton => 'Άκυρο';

  @override
  String get deleteButton => 'Διαγραφή';

  @override
  String get editAction => 'Επεξεργασία';

  @override
  String get listDeleted => 'Η λίστα διαγράφηκε';

  @override
  String get invalidAmountError => 'Μη έγκυρη ποσότητα';

  @override
  String get duplicateAction => 'Αντιγραφή';

  @override
  String get archiveAction => 'Αρχειοθέτηση';

  @override
  String get unarchiveAction => 'Κατάργηση αρχειοθέτησης';

  @override
  String get deleteListConfirm =>
      'Διαγραφή αυτής της λίστας; Τα προγραμματισμένα αντικείμενα θα αφαιρεθούν επίσης.';

  @override
  String get undoButton => 'Αναίρεση';

  @override
  String get searchListHint => 'Αναζήτηση λίستων';

  @override
  String get currencyLabel => 'Νόμισμα';

  @override
  String get budgetLabel => 'Προϋπολογισμός (προαιρετικό)';

  @override
  String get noteLabel => 'Σημείωση (προαιρετικό)';

  @override
  String get storeLabel => 'Κατάστημα';

  @override
  String get keepAmountsAction => 'Διατήρηση ποσοτήτων';

  @override
  String get resetAmountsAction => 'Επαναφορά ποσοτήτων';

  @override
  String get currencyChangeWarning =>
      'Το νόμισμα αλλάζει. Τι πρέπει να συμβεί με τις υπάρχουσες ποσότητες;';

  @override
  String get listsEmpty =>
      'Δεν υπάρχουν λίστες ακόμα. Δημιούργησε το πρώτο σου σχέδιο ψώνων.';

  @override
  String get statusDraft => 'Πρόχειρο';

  @override
  String get statusPlanned => 'Προγραμματισμένο';

  @override
  String get statusShopping => 'Σε ψώνια';

  @override
  String get statusCompleted => 'Ολοκληρώθηκε';

  @override
  String get statusArchived => 'Αρχειοθετημένο';

  @override
  String autoListTitle(String date) {
    return 'ψώνια $date';
  }

  @override
  String get itemFormTitle => 'Προσθήκη αντικειμένου';

  @override
  String get itemNameLabel => 'Όνομα αντικειμένου';

  @override
  String get brandLabel => 'Μάρκα / παραλλαγή (προαιρετικό)';

  @override
  String get categoryLabel => 'Κατηγορία';

  @override
  String get quantityLabel => 'Ποσότητα';

  @override
  String get unitLabel => 'Μονάδα';

  @override
  String get pricingModeLabel => 'Τρόπος τιμολόγησης';

  @override
  String get pricingModeUnitPrice => 'Τιμή μονάδας';

  @override
  String get pricingModeLineTotal => 'Σύνολο γραμμής';

  @override
  String get plannedPriceLabel => 'Προγραμματισμένη τιμή';

  @override
  String lineTotalCalculated(String value) {
    return 'Σύνολο γραμμής: $value';
  }

  @override
  String get requiredItemToggle => 'Απαραίτητο αντικείμενο';

  @override
  String get maxPriceLabel => 'Μέγιστη αποδεκτή τιμή (προαιρετικό)';

  @override
  String get itemNoteLabel => 'Σημείωση (προαιρετικό)';

  @override
  String get categoryProduce => 'Φρούτα & λαχανικά';

  @override
  String get categoryDairy => 'Γαλακτοκομικά';

  @override
  String get categoryMeat => 'Κρέας';

  @override
  String get categoryBakery => 'Ζαχαροπλαστική';

  @override
  String get categoryDrinks => 'Ποτά';

  @override
  String get categoryCleaning => 'Καθαριστικά';

  @override
  String get categoryPersonalCare => 'Περιποίηση προσώπου/σώματος';

  @override
  String get categoryHome => 'Οικιακά';

  @override
  String get categoryOther => 'Άλλο';

  @override
  String get invalidQuantityError => 'Μη έγκυρη ποσότητα';

  @override
  String get invalidPriceError => 'Μη έγκυρη τιμή';

  @override
  String get invalidNameError => 'Εισάγετε ένα όνομα';

  @override
  String unitPriceCalculated(String value) {
    return 'Τιμή μονάδας: $value';
  }

  @override
  String get shoppingTitle => 'Λειτουργία ψωνίσματος';

  @override
  String get summaryPlannedTotal => 'Σχεδιασμένο';

  @override
  String get summaryInCart => 'Στο καλάθι';

  @override
  String get summaryRemainingPlan => 'Υπόλοιπο σχεδίου';

  @override
  String get summaryProjected => 'Εκτιμώμενο σύνολο ταμείου';

  @override
  String get summaryBudgetRemaining => 'Υπόλοιπο προϋπολογισμού';

  @override
  String get summaryBudgetOver => 'Εκτός προϋπολογισμού';

  @override
  String itemsProgress(String done, String total) {
    return '$done από $total προϊόντα';
  }

  @override
  String get filterAll => 'Όλα';

  @override
  String get filterToBuy => 'Προς αγορά';

  @override
  String get filterInCart => 'Στο καλάθι';

  @override
  String get filterNotFound => 'Δεν βρέθηκε';

  @override
  String get filterRequired => 'Απαραίτητα';

  @override
  String get quickEntryTitle => 'Πραγματική τιμή';

  @override
  String get actualQuantityLabel => 'Πραγματική ποσότητα';

  @override
  String get actualPriceLabel => 'Πραγματική τιμή';

  @override
  String get discountLabel => 'Έκπτωση (προαιρετικά)';

  @override
  String get alternativeNameLabel =>
      'Εναλλακτικό όνομα προϊόντος (προαιρετικά)';

  @override
  String get savePurchaseButton => 'Προσθήκη στο καλάθι';

  @override
  String get unplannedAddButton => 'Προσθήκη μη σχεδιασμένου προϊόντος';

  @override
  String get statusPending => 'Μη ληφθέν';

  @override
  String get statusInCart => 'Στο καλάθι';

  @override
  String get statusNotFound => 'Δεν βρέθηκε';

  @override
  String get statusGaveUp => 'Παράλειψη';

  @override
  String get statusAlternative => 'Αγοράστηκε εναλλακτικό';

  @override
  String get keepScreenAwake => 'Κράτημα οθόνης ενεργής';

  @override
  String get finishShopping => 'Ολοκλήρωση αγορών';

  @override
  String get completionWarning =>
      'Υπάρχουν ελλείψεις ή μη επαληθευμένα στοιχεία. Μπορείτε να ολοκληρώσετε· το αποτέλεσμα θα τα σημειώνει.';

  @override
  String get continueShoppingButton => 'Συνέχεια αγορών';

  @override
  String get resultTitle => 'Αποτέλεσμα';

  @override
  String get summarySection => 'Σύνοψη';

  @override
  String get plannedTotalLabel => 'Συνολικό σχεδιασμένο';

  @override
  String get actualTotalLabel => 'Συνολικό πραγματικό';

  @override
  String get varianceLabel => 'Διαφορά';

  @override
  String get varianceNotComputable => 'Δεν υπολογίζεται';

  @override
  String get budgetStatusLabel => 'Προϋπολογισμός';

  @override
  String get savingsLabel => 'Κάτω από το σχέδιο';

  @override
  String get overspendLabel => 'Πάνω από το σχέδιο';

  @override
  String get unplannedTotalLabel => 'Συνολικό μη σχεδιασμένο';

  @override
  String get unpurchasedLabel => 'Σχεδιασμένο αλλά όχι αγορασμένο';

  @override
  String get totalDiscountLabel => 'Συνολικές εκπτώσεις';

  @override
  String get accuracyLabel => 'Ακρίβεια εκτίμησης';

  @override
  String get groupsSection => 'Προϊόντα';

  @override
  String get groupPricier => 'Ακριβότερο από το σχεδιασμένο';

  @override
  String get groupCheaper => 'Φθηνότερο από το σχεδιασμένο';

  @override
  String get groupClose => 'Κοντά στην εκτίμηση';

  @override
  String get groupNotTaken => 'Σχεδιασμένο, δεν αγοράστηκε';

  @override
  String get groupUnplanned => 'Αγορασμένο χωρίς σχέδιο';

  @override
  String get groupQuantityChanged => 'Αλλάχθηκε η ποσότητα';

  @override
  String get groupUnverified => 'Μη επαληθευμένο';

  @override
  String get plannedQtyLabel => 'Σχεδιασμένη ποσότητα';

  @override
  String get actualQtyLabel => 'Πραγματική ποσότητα';

  @override
  String get plannedUnitPriceLabel => 'Σχεδιασμένη τιμή μονάδας';

  @override
  String get actualUnitPriceLabel => 'Πραγματική τιμή μονάδας';

  @override
  String get lineVarianceLabel => 'Διαφορά γραμμής';

  @override
  String get discountEffectLabel => 'Επίπτωση έκπτωσης';

  @override
  String get notBoughtMark => 'δεν αγοράστηκε';

  @override
  String get noPurchasesNote => 'Δεν καταγράφηκαν αγορές.';

  @override
  String get navHome => 'Αρχική';

  @override
  String get navLists => 'Λίστες';

  @override
  String get navHistory => 'Ιστορικό';

  @override
  String get navSettings => 'Ρυθμίσεις';

  @override
  String get homeEmptyTitle => 'Σχεδιάστε τις αγορές σας';

  @override
  String get homeEmptyBody =>
      'Δημιουργήστε τη πρώτη σας λίστα και συγκρίνετε τα εκτιμώμενα με τα πραγματικά κόστη.';

  @override
  String get homeActiveSection => 'Ενεργές λίστες';

  @override
  String get homeCompletedSection => 'Ολοκληρώθηκαν πρόσφατα';

  @override
  String get homeMonthlySection => 'Αυτόν τον μήνα';

  @override
  String get monthPlannedLabel => 'Σχεδιασμένο';

  @override
  String get monthActualLabel => 'Πραγματικό';

  @override
  String get monthVarianceLabel => 'Διαφορά';

  @override
  String get continueShoppingLabel => 'Συνέχεια αγορών';

  @override
  String get historyEmpty =>
      'Δεν υπάρχουν ολοκληρωμένες αγορές ακόμη. Το ιστορικό και οι αναλύσεις θα εμφανιστούν εδώ.';

  @override
  String get aboutTabTitle => 'Σχετικά με το NShoptor';

  @override
  String get aboutBody =>
      'NShoptor από Crazy Penguin. Σχεδιαστής αγορών offline-first. Άδεια GPL-3.0.';

  @override
  String get startShoppingLabel => 'Ξεκινήστε αγορές';

  @override
  String get finishAndSeeResult => 'Ολοκλήρωση & προβολή αποτελέσματος';

  @override
  String get settingsTitle => 'Ρυθμίσεις';

  @override
  String get languageLabel => 'Γλώσσα';

  @override
  String get languageSystem => 'Σύστημα';

  @override
  String get languageTr => 'Τουρκικά';

  @override
  String get languageEn => 'Αγγλικά';

  @override
  String get themeLabel => 'Θέμα';

  @override
  String get themeSystem => 'Σύστημα';

  @override
  String get themeLight => 'Ανοιχτό';

  @override
  String get themeDark => 'Σκοτεινό';

  @override
  String get defaultCurrencyLabel => 'Νόμισμα προεπιλογής';

  @override
  String get defaultUnitLabel => 'Μονάδα μέτρησης προεπιλογής';

  @override
  String get keepAwakeLabel => 'Κράτημα οθόνης ενεργής κατά τις αγορές';

  @override
  String get backupSection => 'Αντίγραφο ασφαλείας';

  @override
  String get exportBackupLabel => 'Εξαγωγή αντιγράφου ασφαλείας';

  @override
  String get importBackupLabel => 'Εισαγωγή αντιγράφου ασφαλείας';

  @override
  String get mergeImportLabel => 'Ενοποίηση με τρέχοντα δεδομένα';

  @override
  String get separateImportLabel => 'Εισαγωγή ως ξεχωριστό αντίγραφο';

  @override
  String get importCancelled => 'Η εισαγωγή ακυρώθηκε.';

  @override
  String get backupExported => 'Το αντίγραφο ασφαλείας εξήχθη επιτυχώς.';

  @override
  String get backupSizeWarning =>
      'Μεγάλο αρχείο: το αρχείο μπορεί να είναι μεγάλο. Θέλετε να συμπεριλάβετε και φωτογραφίες;';

  @override
  String get deleteAllSection => 'Ζώνη κινδύνου';

  @override
  String get deleteAllLabel => 'Διαγραφή όλων των δεδομένων';

  @override
  String get deleteAllConfirm =>
      'Αυτό θα αφαιρέσει όλες τις λίστες, το ιστορικό, τις φωτογραφίες αποδείξεων και τις τιμές. Τα αρχεία που εξήγαγες παραμένουν στον υπολογιστή σου. Συνεχίζω;';

  @override
  String get deleteAllConfirm2 =>
      'Είσαι σίγουρος/η; Αυτή η ενέργεια δεν αναστρέφεται.';

  @override
  String get cancelAction => 'Ακύρωση';

  @override
  String get confirmDelete => 'Οριστική διαγραφή';

  @override
  String get dataDeleted => 'Όλα τα τοπικά δεδομένα διαγράφηκαν.';

  @override
  String get privacyInfoLabel => 'Απόρρητο';

  @override
  String get privacyInfoBody =>
      'Οι λίστες, οι τιμές, οι αποδείξεις και οι φωτογραφίες σου παραμένουν στη συσκευή σου. Οι φωτογραφίες και η φωνή δεν την покиνούν ποτέ. Όταν η βοήθεια AI είναι ενεργή, μόνο κείμενο (για παράδειγμα γραμμές απόδειξης ή όσα dictares) στέλνεται στον server μας για επεξεργασία και δεν αποθηκεύεται.';

  @override
  String get aboutSection => 'Σχετικά';

  @override
  String get aboutPublisher => 'Δημοσιευτής: Crazy Penguin';

  @override
  String get aboutLicenses => 'Άδειες (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Φωνητική είσοδος';

  @override
  String get voiceStatusUnknown => 'Υπηρεσία: δεν έχει ελεγχθεί';

  @override
  String get permissionsLabel => 'Άδειες';

  @override
  String get permissionsBody =>
      'Η κάμερα, το μικρόφωνο και οι ειδοποιήσεις ζητούνται μόνο όταν χρησιμοποιείς πραγματικά αυτές τις λειτουργίες.';

  @override
  String get unitsSection => 'Προεπιλογές';

  @override
  String get roundingNote =>
      'Η στρογγυλοποίηση των χρημάτων ακολουθεί έναν κανόνα: τα μισά στρογγυλοποιούνται μακριά από το μηδέν, εφαρμόζεται μία φορά κατά τη μετατροπή σε χρήματα.';

  @override
  String get voiceInputTitle => 'Φωνητική είσοδος';

  @override
  String get voiceStartListening => 'Έναρξη ακρόασης';

  @override
  String get voiceTranscriptLabel => 'Μετάφραση';

  @override
  String get parseAction => 'Ανάλυση';

  @override
  String get receiptReviewTitle => 'Επισκόπηση απόδειξης';

  @override
  String get receiptTotal => 'Σύνολο τιμολογίου';

  @override
  String get receiptTotalUnknown => 'Το σύνολο δεν εντοπίστηκε';

  @override
  String get receiptDiff => 'Διαφορά';

  @override
  String get acceptLine => 'Αποδοχή γραμμής';

  @override
  String get ignoreLine => 'Αγνόηση γραμμής';

  @override
  String get receiptLineActions => 'Σύνδεση με προϊόν, διαίρεση ή αγνόηση';

  @override
  String get receiptCommit => 'Αποδοχή όλων';

  @override
  String get receiptCommitted => 'Η απόδειξη εφαρμόστηκε.';

  @override
  String get priceHistoryTitle => 'Ιστορικό τιμών';

  @override
  String get noObservations => 'Δεν υπάρχουν παρατηρήσεις τιμής ακόμη';

  @override
  String get templatesSection => 'Πρότυπα';

  @override
  String get templateHint => 'Δημιουργία νέου σχεδίου από προηγούμενη αγορά';

  @override
  String get scanReceiptAction => 'Σάρωση απόδειξης';

  @override
  String get shelfLabelAction => 'Τιμή από ετικέτα ραφιού';

  @override
  String get priceCandidatesTitle => 'Υποψήφιες τιμές';

  @override
  String get noPriceCandidates => 'Δεν βρέθηκε τιμή· εισάγετέ την χειροκίνητα.';

  @override
  String get voiceUnavailable =>
      'Η αναγνώριση φωνής δεν είναι διαθέσιμη· εισάγετε χειροκίνητα.';

  @override
  String get linkToItem => 'Σύνδεση με προϊόν';

  @override
  String get splitLine => 'Διαίρεση σε δύο';

  @override
  String get mergeWithNext => 'Συγχώνευση με την επόμενη';

  @override
  String get ocrNoText => 'Δεν αναγνώστηκε κείμενο· δοκιμάστε ξανά.';

  @override
  String get priceHistoryAction => 'Ιστορικό τιμών';

  @override
  String get itemsEmptyTitle => 'Δεν υπάρχουν προϊόντα ακόμη';

  @override
  String get itemsEmptyBody =>
      'Προσθέστε το πρώτο σας προϊόν — θα εισάγετε τις πραγματικές τιμές εδώ στο κατάστημα.';

  @override
  String get addItemTooltip => 'Προσθήκη προϊόντος';

  @override
  String get unitAdet => 'τμχ';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'συσκευασία';

  @override
  String get unitKutu => 'κουτί';

  @override
  String get unitSise => 'μπουκάλι';

  @override
  String get unitKavanoz => 'βάζο';

  @override
  String get unitDemet => 'δέσμη';

  @override
  String get unitDuzine => 'ντουζίνα';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Προσαρμοσμένο';

  @override
  String get setReminderAction => 'Ορισμός υπενθύμισης';

  @override
  String get reminderPermissionDenied =>
      'Απαιτείται άδεια ειδοποιήσεων για τις υπενθυμίσεις. Μπορείτε να την ενεργοποιήσετε στις ρυθμίσεις του συστήματος.';

  @override
  String get reminderScheduled => 'Η υπενθύμιση ορίστηκε.';

  @override
  String get reminderCancelled => 'Η υπενθύμιση αφαιρέθηκε.';

  @override
  String get reminderTitle => 'Υπενθύμιση ψωνίσματος';

  @override
  String reminderBody(Object title) {
    return 'Ώρα να ελέγξετε τη λίστα σας: $title';
  }

  @override
  String get reminderPickDate => 'Επιλέξτε ημερομηνία';

  @override
  String get reminderPickTime => 'Επιλέξτε ώρα';

  @override
  String get itemDetailsSection => 'Λεπτομέρειες';

  @override
  String get priceOptionalHint =>
      'Προαιρετικό — θα εισάγετε την πραγματική τιμή στο κατάστημα';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Σχεδιαζόμενο: $total · $count προϊόντα';
  }

  @override
  String get proActiveLabel => 'Pro ενεργό — ευχαριστούμε!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Χωρίς διαφημίσεις, περισσότερα AI, backup · από μια μικρή μηνιαία χρέωση';

  @override
  String get proBenefitNoAds => 'Εμπειρία χωρίς διαφημίσεις';

  @override
  String get proBenefitBackup => 'Backup (εξαγωγή/εισαγωγή)';

  @override
  String aboutVersion(Object version) {
    return 'Έκδοση $version';
  }

  @override
  String get navDiscover => 'Ανακαλύψτε';

  @override
  String get shareAction => 'Κοινοποίηση της εφαρμογής';

  @override
  String get rateAction => 'Αξιολογήστε μας';

  @override
  String get aboutOpenRow => 'Σχετικά & ανοιχτός κώδικας';

  @override
  String get voiceAddItemAction => 'Προσθήκη με φωνή';

  @override
  String get formatLocaleLabel => 'Μορφή αριθμών και νομίσματος';

  @override
  String get formatLocaleSystem =>
      'Μορφή συσκευής (Λατινικά ψηφία· διαφορετικά Αγγλικά)';

  @override
  String get formatLocaleTr => 'Τουρκικά (1.234,56)';

  @override
  String get formatLocaleEn => 'Αγγλικά (1,234.56)';

  @override
  String get aiToggleTitle => 'Βοήθεια AI';

  @override
  String get aiToggleSubtitle =>
      'Αντιστοιχίζει αποδείξεις, διαβάζει ετικέτες τιμών και μετατρέπει προτάσεις σε λίστες. Οι φωτογραφίες και η φωνή παραμένουν στη συσκευή σας· επεξεργάζεται μόνο το κείμενο.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Έχετε εξαντλήσει τις μηνιαίες αιτήσεις AI ($used/$limit). Αναβαθμίστε για περισσότερες ή συνεχίστε χωρίς AI.';
  }

  @override
  String get aiOffline => 'Χωρίς σύνδεση — συνέχιση χωρίς AI.';

  @override
  String get aiFailed =>
      'Το AI δεν είναι διαθέσιμο αυτή τη στιγμή — συνέχιση χωρίς αυτό.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Συσκευή';

  @override
  String get quickListAction => 'Προσθήκη από πρόταση';

  @override
  String get quickListTitle => 'Γρήγορη λίστα';

  @override
  String get quickListHint => 'π.χ. 1 kg μήλα 20, 2 ψωμιά, μισό κιλό τυρί';

  @override
  String get quickListConvert => 'Μετατροπή σε λίστα';

  @override
  String quickListAdd(int count) {
    return 'Προσθήκη $count αντικειμένων';
  }

  @override
  String get quickListEmpty =>
      'Δεν βρέθηκαν αντικείμενα. Προσπαθήστε να τα αναφέρετε χωρισμένα με κόμμα.';

  @override
  String get receiptAiMatched =>
      'Το AI αντιστοίχισε την απόδειξη με τη λίστα σας. Ελέγξτε τους συνδέσμους και επιβεβαιώστε.';

  @override
  String get receiptNeedsCheck => 'Ελέγξτε αυτή την αντιστοίχιση';

  @override
  String get receiptDiscountLine => 'Έκπτωση';

  @override
  String get compareItem => 'Αντικείμενο';

  @override
  String get compareEstimated => 'Εκτίμηση';

  @override
  String get compareActual => 'Πραγματικό';

  @override
  String get compareDiff => 'Διαφορά';

  @override
  String get compareTotal => 'Σύνολο';

  @override
  String get compareBudget => 'Προϋπολογισμός';

  @override
  String get compareNotBought => 'δεν αγοράστηκε';

  @override
  String get compareUnplanned => 'δεν σχεδιάστηκε';

  @override
  String get pricierItems => 'Κόστησαν περισσότερο';

  @override
  String get cheaperItems => 'Κόστησαν λιγότερο';

  @override
  String get compareAction => 'Σύγκριση';

  @override
  String get detailsSection => 'Λεπτομέρειες';

  @override
  String get spendingTitle => 'Δαπάνες';

  @override
  String get spendingAction => 'Δαπάνες';

  @override
  String get spendingMonthTotal => 'Αυτόν τον μήνα';

  @override
  String get spendingWeekly => 'Εβδομαδιαίες δαπάνες';

  @override
  String get spendingMonthly => 'Μηνιαίες δαπάνες';

  @override
  String get monthlyLimitTitle => 'Μηνιαίος όριο';

  @override
  String get monthlyLimitHelp => 'Πόσο θέλετε να ξοδέψετε για ψώνια ανά μήνα;';

  @override
  String get monthlyLimitRemove => 'Κατάργηση';

  @override
  String get monthlyLimitSet => 'Ορισμός';

  @override
  String get monthlyLimitChange => 'Αλλαγή';

  @override
  String get monthlyLimitNone =>
      'Ορίστε ένα μηνιαίο όριο για να δείτε πόσα σας έχουν απομείνει.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount πάνω από το όριο';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount απομένουν αυτόν τον μήνα';
  }

  @override
  String get plansTitle => 'Πλάνα';

  @override
  String get plansHeadline => 'Ψωνίστε έξυπνα με AI';

  @override
  String get plansSubhead =>
      'Αντιστοίχιση αποδείξεων, ετικέτες τιμών και λίστες από πρόταση. Ακύρωση οποιαδήποτε στιγμή.';

  @override
  String get plansMonthly => 'Μηνιαία';

  @override
  String get plansYearly => 'Ετήσια';

  @override
  String get planFree => 'Δωρεάν';

  @override
  String get planFreePrice => 'Δωρεάν για πάντα';

  @override
  String get planFreeAi => '10 αιτήσεις AI τον μήνα';

  @override
  String get planFreeAds =>
      'Μικρές διαφημίσεις μπάνερ (καμία στις πρώτες 7 ημέρες)';

  @override
  String get planCoreFeatures => 'Λίστες, τιμές, αποδείξεις, γραφήματα δαπανών';

  @override
  String get plansPerYear => '/ έτος';

  @override
  String get plansPerMonth => '/ μήνα';

  @override
  String get planTrial => '7 ημέρες δωρεάν';

  @override
  String get planProAi => '100 αιτήσεις AI τον μήνα';

  @override
  String get planNoAds => 'Χωρίς διαφημίσεις';

  @override
  String get planBackup => 'Εξαγωγή και εισαγωγή αντιγράφων ασφαλείας';

  @override
  String get planMaxAi => '300 αιτήματα AI το μήνα';

  @override
  String get planMaxFamily => 'Για ψώνια μεγάλης οικογένειας';

  @override
  String get plansStoreUnavailable =>
      'Το κατάστημα δεν είναι προσβάσιμο αυτή τη στιγμή.';

  @override
  String get retryAction => 'Δοκιμάστε ξανά';

  @override
  String get plansPurchaseFailed =>
      'Η αγορά δεν ολοκληρώθηκε. Παρακαλώ δοκιμάστε ξανά.';

  @override
  String get planLifetimeTitle => 'Χωρίς διαφημίσεις για πάντα';

  @override
  String get planLifetimeSubtitle =>
      'Μία φορά πληρωμή: χωρίς διαφημίσεις, αντίγραφα ασφαλείας· η χρήση AI παραμένει στο δωρεάν όριο';

  @override
  String get plansRestore => 'Επαναφορά αγορών';

  @override
  String get plansLegal =>
      'Οι συνδρομές ανανεώνονται αυτόματα έως την ακύρωση. Ακυρώστε οποιαδήποτε στιγμή στο Google Play › Πληρωμές & συνδρομές. Οι τιμές περιλαμβάνουν τους φόρους που εμφανίζονται από το Google Play.';

  @override
  String get planCurrent => 'Τρέχουσα';

  @override
  String get planStartTrial => 'Έναρξη δωρεάν δοκιμής 7 ημερών';

  @override
  String get planChoose => 'Επιλογή';

  @override
  String get plansAction => 'Συνδρομές: Pro και Max';

  @override
  String get assistantTitle => 'Βοηθός';

  @override
  String get assistantGreeting => 'Γεια! Τι θα θέλατε να κάνετε;';

  @override
  String get assistantNewList => 'Νέα λίστα';

  @override
  String get assistantVoiceList => 'Λίστα με φωνή';

  @override
  String get assistantTextList => 'Λίστα από πρόταση';

  @override
  String get assistantScanReceipt => 'Σάρωση αποδείξεως';

  @override
  String get assistantSpending => 'Οι δαπάνες μου';

  @override
  String get assistantReceiptHint =>
      'Ανοίξτε τη λίστα σας και πατήστε το εικονίδιο αποδείξεως για σάρωση.';

  @override
  String get assistantToggleTitle => 'Εμφάνιση βοηθού';

  @override
  String get assistantToggleSubtitle => 'Ο μικρός βοηθός κάτω δεξιά';

  @override
  String get scanPriceLabel => 'Σάρωση ετικέτας τιμής';

  @override
  String get saveFailed =>
      'Αποτυχία αποθήκευσης. Οι αλλαγές σας παραμένουν. Παρακαλώ δοκιμάστε ξανά.';

  @override
  String get deleteItemConfirm =>
      'Διαγραφή αυτού του αντικειμένου και των καταχωρημένων αγορών του;';

  @override
  String get clearPurchaseConfirm =>
      'Αποεπιλογή αυτού του αντικειμένου και διαγραφή των καταχωρημένων αγορών του;';

  @override
  String get reportPdfAction => 'Αποθήκευση αναφοράς PDF';

  @override
  String get reportNotInvoice =>
      'Σύνοψη ψωνών, όχι φορολογική απόδειξη. Οι φορολογικοί συντελεστές είναι άγνωστοι.';

  @override
  String get purchaseVisits => 'Επισκέψεις σε ψώνια';

  @override
  String get purchaseInterval => 'Μέσες ημέρες μεταξύ αγορών';

  @override
  String get purchasedQuantity => 'Ποσότητα που αγοράστηκε';

  @override
  String get purchaseAnalyticsHint =>
      'Οι αγορές δεν μετρούν την κατανάλωση. Τα νομίσματα και οι μονάδες εμφανίζονται ξεχωριστά.';

  @override
  String get receiptReplaces =>
      'Οι γραμμές της συνημμένης απόδειξης αντικαθιστούν τις υπάρχουσες αγορές· οι μη συνημμένες γραμμές προστίθενται.';

  @override
  String get voiceUnsupportedLanguage =>
      'Αυτή η γλώσσα δεν υποστηρίζεται για φωνητική είσοδο σε αυτή τη συσκευή. Μπορείτε να πληκτρολογήσετε αντίθετα.';

  @override
  String get voiceStopListening => 'Διακοπή ακρόασης';

  @override
  String get keepAwakeFailed =>
      'Δεν ήταν δυνατόν να παραμείνει η οθόνη ενεργή. Παρακαλώ προσπαθήστε ξανά.';

  @override
  String get purchaseHistoryHint =>
      'Όλες οι ολοκληρωμένες αγορές. Οι επιστροφές μειώνουν τα συνολικά ποσά. Οι ημερομηνίες αφορούν την ολοκλήρωση της αγοράς. Μία επίσκεψη δεν αρκεί για τον υπολογισμό του μέσου διαστήματος.';

  @override
  String get planLegacyRights =>
      'Οι υπάρχουσες συνδρομές Pro και Max διατηρούν το αρχικό μηνιαίο όριο χρήσης AI. Οι νέες προσφορές παρέχουν 100 και 300 αιτήματα.';
}
