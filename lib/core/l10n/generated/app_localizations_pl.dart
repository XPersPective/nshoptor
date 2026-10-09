// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Planuj w domu. Kupuj zgodnie z planem.';

  @override
  String get listsTitle => 'Listy';

  @override
  String get listsTabActive => 'Aktywne';

  @override
  String get listsTabCompleted => 'Ukończone';

  @override
  String get listsTabArchived => 'Zarchiwizowane';

  @override
  String get newListButton => 'Nowa lista';

  @override
  String get listTitleHint => 'Tytuł (opcjonalnie)';

  @override
  String get saveButton => 'Zapisz';

  @override
  String get cancelButton => 'Anuluj';

  @override
  String get deleteButton => 'Usuń';

  @override
  String get editAction => 'Edytuj';

  @override
  String get listDeleted => 'Lista usunięta';

  @override
  String get invalidAmountError => 'Nieprawidłowa kwota';

  @override
  String get duplicateAction => 'Duplikuj';

  @override
  String get archiveAction => 'Archiwizuj';

  @override
  String get unarchiveAction => 'Przywróć z archiwum';

  @override
  String get deleteListConfirm =>
      'Usunąć tę listę? Zaplanowane produkty również zostaną usunięte.';

  @override
  String get undoButton => 'Cofnij';

  @override
  String get searchListHint => 'Szukaj list';

  @override
  String get currencyLabel => 'Waluta';

  @override
  String get budgetLabel => 'Budżet (opcjonalnie)';

  @override
  String get noteLabel => 'Notatka (opcjonalnie)';

  @override
  String get storeLabel => 'Sklep';

  @override
  String get keepAmountsAction => 'Zachowaj kwoty';

  @override
  String get resetAmountsAction => 'Resetuj kwoty';

  @override
  String get currencyChangeWarning =>
      'Zmienia się waluta. Co zrobić z istniejącymi kwotami?';

  @override
  String get listsEmpty => 'Brak list. Stwórz swój pierwszy plan zakupowy.';

  @override
  String get statusDraft => 'Szkic';

  @override
  String get statusPlanned => 'Zaplanowane';

  @override
  String get statusShopping => 'Zakupy';

  @override
  String get statusCompleted => 'Ukończone';

  @override
  String get statusArchived => 'Zarchiwizowane';

  @override
  String autoListTitle(String date) {
    return 'Zakupy $date';
  }

  @override
  String get itemFormTitle => 'Dodaj produkt';

  @override
  String get itemNameLabel => 'Nazwa produktu';

  @override
  String get brandLabel => 'Marka / wariant (opcjonalnie)';

  @override
  String get categoryLabel => 'Kategoria';

  @override
  String get quantityLabel => 'Ilość';

  @override
  String get unitLabel => 'Jednostka';

  @override
  String get pricingModeLabel => 'Tryb wprowadzania ceny';

  @override
  String get pricingModeUnitPrice => 'Cena jednostkowa';

  @override
  String get pricingModeLineTotal => 'Suma pozycji';

  @override
  String get plannedPriceLabel => 'Planowana cena';

  @override
  String lineTotalCalculated(String value) {
    return 'Suma pozycji: $value';
  }

  @override
  String get requiredItemToggle => 'Produkt obowiązkowy';

  @override
  String get maxPriceLabel => 'Maksymalna akceptowalna cena (opcjonalnie)';

  @override
  String get itemNoteLabel => 'Notatka (opcjonalnie)';

  @override
  String get categoryProduce => 'Owoce i warzywa';

  @override
  String get categoryDairy => 'Nabiał';

  @override
  String get categoryMeat => 'Mięso';

  @override
  String get categoryBakery => 'Pieczywo';

  @override
  String get categoryDrinks => 'Napoje';

  @override
  String get categoryCleaning => 'Środki czystości';

  @override
  String get categoryPersonalCare => 'Pielęgnacja';

  @override
  String get categoryHome => 'Dom';

  @override
  String get categoryOther => 'Inne';

  @override
  String get invalidQuantityError => 'Nieprawidłowa ilość';

  @override
  String get invalidPriceError => 'Nieprawidłowa cena';

  @override
  String get invalidNameError => 'Wprowadź nazwę';

  @override
  String unitPriceCalculated(String value) {
    return 'Cena jednostkowa: $value';
  }

  @override
  String get shoppingTitle => 'Tryb zakupowy';

  @override
  String get summaryPlannedTotal => 'Zaplanowane';

  @override
  String get summaryInCart => 'W koszyku';

  @override
  String get summaryRemainingPlan => 'Pozostały plan';

  @override
  String get summaryProjected => 'Szacowany rachunek';

  @override
  String get summaryBudgetRemaining => 'Pozostało z budżetu';

  @override
  String get summaryBudgetOver => 'Przekroczony budżet';

  @override
  String itemsProgress(String done, String total) {
    return '$done z $total produktów';
  }

  @override
  String get filterAll => 'Wszystkie';

  @override
  String get filterToBuy => 'Do kupienia';

  @override
  String get filterInCart => 'W koszyku';

  @override
  String get filterNotFound => 'Nie znaleziono';

  @override
  String get filterRequired => 'Wymagane';

  @override
  String get quickEntryTitle => 'Rzeczywista cena';

  @override
  String get actualQuantityLabel => 'Rzeczywista ilość';

  @override
  String get actualPriceLabel => 'Rzeczywista cena';

  @override
  String get discountLabel => 'Rabat (opcjonalnie)';

  @override
  String get alternativeNameLabel =>
      'Nazwa alternatywnego produktu (opcjonalnie)';

  @override
  String get savePurchaseButton => 'Dodaj do koszyka';

  @override
  String get unplannedAddButton => 'Dodaj niezaplanowany produkt';

  @override
  String get statusPending => 'Nie zabrano';

  @override
  String get statusInCart => 'W koszyku';

  @override
  String get statusNotFound => 'Nie znaleziono';

  @override
  String get statusGaveUp => 'Porzucono';

  @override
  String get statusAlternative => 'Kupiono zamiennik';

  @override
  String get keepScreenAwake => 'Utrzymuj ekran włączony';

  @override
  String get finishShopping => 'Zakończ zakupy';

  @override
  String get completionWarning =>
      'Brakujących lub niezweryfikowanych rekordów. Możesz zakończyć; wynik je uwzględni.';

  @override
  String get continueShoppingButton => 'Kontynuuj zakupy';

  @override
  String get resultTitle => 'Wynik';

  @override
  String get summarySection => 'Podsumowanie';

  @override
  String get plannedTotalLabel => 'Łącznie zaplanowane';

  @override
  String get actualTotalLabel => 'Łącznie rzeczywiste';

  @override
  String get varianceLabel => 'Różnica';

  @override
  String get varianceNotComputable => 'Nie można obliczyć';

  @override
  String get budgetStatusLabel => 'Budżet';

  @override
  String get savingsLabel => 'Niżej niż planowano';

  @override
  String get overspendLabel => 'Wyżej niż planowano';

  @override
  String get unplannedTotalLabel => 'Łącznie niezaplanowane';

  @override
  String get unpurchasedLabel => 'Zaplanowane, ale niekupione';

  @override
  String get totalDiscountLabel => 'Łączne rabaty';

  @override
  String get accuracyLabel => 'Dokładność szacunku';

  @override
  String get groupsSection => 'Produkty';

  @override
  String get groupPricier => 'Droższe niż planowano';

  @override
  String get groupCheaper => 'Tańsze niż planowano';

  @override
  String get groupClose => 'Bliskie szacunkowi';

  @override
  String get groupNotTaken => 'Zaplanowane, niekupione';

  @override
  String get groupUnplanned => 'Kupione bez planu';

  @override
  String get groupQuantityChanged => 'Zmieniona ilość';

  @override
  String get groupUnverified => 'Niezweryfikowane';

  @override
  String get plannedQtyLabel => 'Zaplanowana ilość';

  @override
  String get actualQtyLabel => 'Rzeczywista ilość';

  @override
  String get plannedUnitPriceLabel => 'Zaplanowana cena jednostkowa';

  @override
  String get actualUnitPriceLabel => 'Rzeczywista cena jednostkowa';

  @override
  String get lineVarianceLabel => 'Różnica wiersza';

  @override
  String get discountEffectLabel => 'Efekt rabatu';

  @override
  String get notBoughtMark => 'niekupione';

  @override
  String get noPurchasesNote => 'Nie odnotowano żadnych zakupów.';

  @override
  String get navHome => 'Strona główna';

  @override
  String get navLists => 'Listy';

  @override
  String get navHistory => 'Historia';

  @override
  String get navSettings => 'Ustawienia';

  @override
  String get homeEmptyTitle => 'Zaplanuj zakupy';

  @override
  String get homeEmptyBody =>
      'Stwórz swoją pierwszą listę i porównaj planowane koszty z rzeczywistymi.';

  @override
  String get homeActiveSection => 'Aktywne listy';

  @override
  String get homeCompletedSection => 'Ostatnio ukończone';

  @override
  String get homeMonthlySection => 'W tym miesiącu';

  @override
  String get monthPlannedLabel => 'Planowane';

  @override
  String get monthActualLabel => 'Rzeczywiste';

  @override
  String get monthVarianceLabel => 'Różnica';

  @override
  String get continueShoppingLabel => 'Kontynuuj zakupy';

  @override
  String get historyEmpty =>
      'Brak zakończonych zakupów. Twoja historia i analizy pojawią się tutaj.';

  @override
  String get aboutTabTitle => 'O NShoptorze';

  @override
  String get aboutBody =>
      'NShoptor od Crazy Penguin. Planer zakupów offline. Licencjonowany na licencji GPL-3.0.';

  @override
  String get startShoppingLabel => 'Zacznij zakupy';

  @override
  String get finishAndSeeResult => 'Zakończ i zobacz wynik';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get languageLabel => 'Język';

  @override
  String get languageSystem => 'Systemowy';

  @override
  String get languageTr => 'Turecki';

  @override
  String get languageEn => 'Angielski';

  @override
  String get themeLabel => 'Motyw';

  @override
  String get themeSystem => 'Systemowy';

  @override
  String get themeLight => 'Jasny';

  @override
  String get themeDark => 'Ciemny';

  @override
  String get defaultCurrencyLabel => 'Domyślna waluta';

  @override
  String get defaultUnitLabel => 'Domyślna jednostka';

  @override
  String get keepAwakeLabel => 'Nie wygaszaj ekranu podczas zakupów';

  @override
  String get backupSection => 'Kopia zapasowa';

  @override
  String get exportBackupLabel => 'Eksportuj kopię zapasową';

  @override
  String get importBackupLabel => 'Importuj kopię zapasową';

  @override
  String get mergeImportLabel => 'Połącz z aktualnymi danymi';

  @override
  String get separateImportLabel => 'Importuj jako osobną kopię';

  @override
  String get importCancelled => 'Import anulowany.';

  @override
  String get backupExported =>
      'Kopia zapasowa została pomyślnie wyeksportowana.';

  @override
  String get backupSizeWarning =>
      'Duża kopia zapasowa: plik może być duży. Czy chcesz dołączyć zdjęcia?';

  @override
  String get deleteAllSection => 'Strefa niebezpieczeństwa';

  @override
  String get deleteAllLabel => 'Usuń wszystkie dane';

  @override
  String get deleteAllConfirm =>
      'Spowoduje to usunięcie wszystkich list, historii, zdjęć paragonów i cen. Pliki wyeksportowane przez Ciebie pozostaną na dysku. Kontynuować?';

  @override
  String get deleteAllConfirm2 =>
      'Czy jesteś całkowicie pewien? Tej akcji nie można cofnąć.';

  @override
  String get cancelAction => 'Anuluj';

  @override
  String get confirmDelete => 'Usuń trwale';

  @override
  String get dataDeleted => 'Wszystkie lokalne dane zostały usunięte.';

  @override
  String get privacyInfoLabel => 'Prywatność';

  @override
  String get privacyInfoBody =>
      'Twoje listy, ceny, paragony i zdjęcia pozostają na urządzeniu. Zdjęcia i głos nigdy go nie opuszczają. Gdy pomoc AI jest włączona, tylko tekst (np. linie paragonu lub to, co dyktowałeś) jest wysyłany do naszego serwera w celu przetworzenia i nie jest przechowywany.';

  @override
  String get aboutSection => 'O aplikacji';

  @override
  String get aboutPublisher => 'Wydawca: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licencje (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Głosowe wprowadzanie danych';

  @override
  String get voiceStatusUnknown => 'Usługa: nie sprawdzono';

  @override
  String get permissionsLabel => 'Uprawnienia';

  @override
  String get permissionsBody =>
      'Aparat, mikrofon i powiadomienia są wymagane tylko wtedy, gdy faktycznie korzystasz z tych funkcji.';

  @override
  String get unitsSection => 'Domyślne';

  @override
  String get roundingNote =>
      'Zaokrąglanie pieniędzy podlega jednej zasadzie: połowy zaokrąglane są w kierunku dodatnim, stosowane raz przy konwersji kwot.';

  @override
  String get voiceInputTitle => 'Głosowe wprowadzanie danych';

  @override
  String get voiceStartListening => 'Rozpocznij słuchanie';

  @override
  String get voiceTranscriptLabel => 'Transkrypcja';

  @override
  String get parseAction => 'Przetwórz';

  @override
  String get receiptReviewTitle => 'Przejrzyj paragon';

  @override
  String get receiptTotal => 'Suma z paragonu';

  @override
  String get receiptTotalUnknown => 'Nie wykryto sumy';

  @override
  String get receiptDiff => 'Różnica';

  @override
  String get acceptLine => 'Zaakceptuj linię';

  @override
  String get ignoreLine => 'Ignoruj linię';

  @override
  String get receiptLineActions => 'Powiąż z produktem, podziel lub ignoruj';

  @override
  String get receiptCommit => 'Zaakceptuj wszystko';

  @override
  String get receiptCommitted => 'Paragon zastosowany.';

  @override
  String get priceHistoryTitle => 'Historia cen';

  @override
  String get noObservations => 'Brak jeszcze obserwacji cen';

  @override
  String get templatesSection => 'Szablony';

  @override
  String get templateHint =>
      'Utwórz nowy plan na podstawie poprzednich zakupów';

  @override
  String get scanReceiptAction => 'Skanuj paragon';

  @override
  String get shelfLabelAction => 'Cena z etykiety półkowej';

  @override
  String get priceCandidatesTitle => 'Kandydaci na ceny';

  @override
  String get noPriceCandidates => 'Nie znaleziono ceny; wpisz ją ręcznie.';

  @override
  String get voiceUnavailable =>
      'Rozpoznawanie mowy niedostępne; wpisz ręcznie.';

  @override
  String get linkToItem => 'Powiąż z produktem';

  @override
  String get splitLine => 'Podziel na dwie części';

  @override
  String get mergeWithNext => 'Połącz z następnym';

  @override
  String get ocrNoText => 'Nie odczytano tekstu; spróbuj ponownie.';

  @override
  String get priceHistoryAction => 'Historia cen';

  @override
  String get itemsEmptyTitle => 'Brak produktów';

  @override
  String get itemsEmptyBody =>
      'Dodaj swój pierwszy produkt — tutaj wpiszesz rzeczywiste ceny w sklepie.';

  @override
  String get addItemTooltip => 'Dodaj produkt';

  @override
  String get unitAdet => 'szt.';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'l';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'opak.';

  @override
  String get unitKutu => 'karton';

  @override
  String get unitSise => 'butelka';

  @override
  String get unitKavanoz => 'słoik';

  @override
  String get unitDemet => 'pęczek';

  @override
  String get unitDuzine => 'tuzin';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Własna';

  @override
  String get setReminderAction => 'Ustaw przypomnienie';

  @override
  String get reminderPermissionDenied =>
      'Do przypomnień wymagane jest uprawnienie do powiadomień. Możesz je włączyć w ustawieniach systemu.';

  @override
  String get reminderScheduled => 'Przypomnienie ustawione.';

  @override
  String get reminderCancelled => 'Przypomnienie usunięte.';

  @override
  String get reminderTitle => 'Przypomnienie zakupowe';

  @override
  String reminderBody(Object title) {
    return 'Czas sprawdzić listę: $title';
  }

  @override
  String get reminderPickDate => 'Wybierz datę';

  @override
  String get reminderPickTime => 'Wybierz godzinę';

  @override
  String get itemDetailsSection => 'Szczegóły';

  @override
  String get priceOptionalHint =>
      'Opcjonalnie — rzeczywistą cenę wpiszesz w sklepie';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Planowane: $total · $count produktów';
  }

  @override
  String get proActiveLabel => 'Pro aktywne — dziękujemy!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Bez reklam, więcej AI, backup · od niskiej miesięcznej opłaty';

  @override
  String get proBenefitNoAds => 'Doświadczenie bez reklam';

  @override
  String get proBenefitBackup => 'Backup (eksport/import)';

  @override
  String aboutVersion(Object version) {
    return 'Wersja $version';
  }

  @override
  String get navDiscover => 'Odkrywaj';

  @override
  String get shareAction => 'Poleż aplikację';

  @override
  String get rateAction => 'Oceń nas';

  @override
  String get aboutOpenRow => 'O aplikacji i open source';

  @override
  String get voiceAddItemAction => 'Dodaj głosem';

  @override
  String get formatLocaleLabel => 'Format liczb i waluty';

  @override
  String get formatLocaleSystem => 'Systemowy (zgodny z językiem aplikacji)';

  @override
  String get formatLocaleTr => 'Turecki (1.234,56)';

  @override
  String get formatLocaleEn => 'Angielski (1,234.56)';

  @override
  String get aiToggleTitle => 'Pomoc AI';

  @override
  String get aiToggleSubtitle =>
      'Dopasowuje paragoni, czyta ceny na etykietach i zamienia zdania na listy. Zdjęcia i głos pozostają na Twoim urządzeniu; przetwarzany jest tylko tekst.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Wykorzystałeś miesięczną pulę żądań AI ($used/$limit). Uaktualnij plan, aby uzyskać więcej, lub kontynuuj bez AI.';
  }

  @override
  String get aiOffline => 'Brak połączenia — kontynuowanie bez AI.';

  @override
  String get aiFailed =>
      'AI jest obecnie niedostępna — kontynuowanie bez niej.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Urządzenie';

  @override
  String get quickListAction => 'Dodaj z zdania';

  @override
  String get quickListTitle => 'Szybka lista';

  @override
  String get quickListHint =>
      'np. 1 kg jabłek 20, 2 bochenki chleba, pół kilo sera';

  @override
  String get quickListConvert => 'Przekształć na listę';

  @override
  String quickListAdd(int count) {
    return 'Dodaj $count produktów';
  }

  @override
  String get quickListEmpty =>
      'Nie znaleziono produktów. Spróbuj wypisać je oddzielone przecinkami.';

  @override
  String get receiptAiMatched =>
      'AI dopasowała paragon do Twojej listy. Sprawdź powiązania i potwierdź.';

  @override
  String get receiptNeedsCheck => 'Sprawdź to dopasowanie';

  @override
  String get receiptDiscountLine => 'Rabat';

  @override
  String get compareItem => 'Produkt';

  @override
  String get compareEstimated => 'Szacowane';

  @override
  String get compareActual => 'Rzeczywiste';

  @override
  String get compareDiff => 'Różnica';

  @override
  String get compareTotal => 'Suma';

  @override
  String get compareBudget => 'Budżet';

  @override
  String get compareNotBought => 'nie kupiono';

  @override
  String get compareUnplanned => 'nie zaplanowano';

  @override
  String get pricierItems => 'Kosztują więcej';

  @override
  String get cheaperItems => 'Kosztują mniej';

  @override
  String get compareAction => 'Porównaj';

  @override
  String get detailsSection => 'Szczegóły';

  @override
  String get spendingTitle => 'Wydatki';

  @override
  String get spendingAction => 'Wydatki';

  @override
  String get spendingMonthTotal => 'W tym miesiącu';

  @override
  String get spendingWeekly => 'Tygodniowe wydatki';

  @override
  String get spendingMonthly => 'Miesięczne wydatki';

  @override
  String get monthlyLimitTitle => 'Miesięczny limit';

  @override
  String get monthlyLimitHelp => 'Ile chcesz wydawać na zakupy w miesiącu?';

  @override
  String get monthlyLimitRemove => 'Usuń';

  @override
  String get monthlyLimitSet => 'Ustaw';

  @override
  String get monthlyLimitChange => 'Zmień';

  @override
  String get monthlyLimitNone =>
      'Ustaw miesięczny limit, aby zobaczyć, ile zostało.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount powyżej limitu';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount zostało w tym miesiącu';
  }

  @override
  String get plansTitle => 'Plany';

  @override
  String get plansHeadline => 'Zakupuj mądrzej z AI';

  @override
  String get plansSubhead =>
      'Dopasowanie paragonów, odczyt cen z etykiet i tworzenie list ze zdań. Anuluj w dowolnym momencie.';

  @override
  String get plansMonthly => 'Miesięcznie';

  @override
  String get plansYearly => 'Rocznie';

  @override
  String get planFree => 'Za darmo';

  @override
  String get planFreePrice => 'Zawsze za darmo';

  @override
  String get planFreeAi => '15 żądań AI w miesiącu';

  @override
  String get planFreeAds => 'Małe reklamy banerowe (brak przez pierwsze 7 dni)';

  @override
  String get planCoreFeatures => 'Listy, ceny, paragoni, wykresy wydatków';

  @override
  String get plansPerYear => '/ rok';

  @override
  String get plansPerMonth => '/ miesiąc';

  @override
  String get planTrial => '7 dni za darmo';

  @override
  String get planProAi => '200 żądań AI w miesiącu';

  @override
  String get planNoAds => 'Bez reklam';

  @override
  String get planBackup => 'Eksport i import kopii zapasowej';

  @override
  String get planMaxAi => '1000 zapytań AI miesięcznie';

  @override
  String get planMaxFamily => 'Do dużych zakupów rodzinnych';

  @override
  String get plansStoreUnavailable => 'Sklep jest obecnie niedostępny.';

  @override
  String get retryAction => 'Ponów';

  @override
  String get plansPurchaseFailed =>
      'Zakup nie został zrealizowany. Spróbuj ponownie.';

  @override
  String get planLifetimeTitle => 'Bez reklam na zawsze';

  @override
  String get planLifetimeSubtitle =>
      'Płatność jednorazowa: brak reklam, backup; AI pozostaje w darmowym limicie';

  @override
  String get plansRestore => 'Przywróć zakupy';

  @override
  String get plansLegal =>
      'Subskrypcje odnawiają się automatycznie do momentu anulowania. Anuluj w dowolnym momencie w Google Play › Płatności i subskrypcje. Ceny zawierają podatki wyświetlane przez Google Play.';

  @override
  String get planCurrent => 'Obecna';

  @override
  String get planStartTrial => 'Rozpocznij 7-dniowy bezpłatny okres próbny';

  @override
  String get planChoose => 'Wybierz';

  @override
  String get plansAction => 'Plany: Pro i Max';

  @override
  String get assistantTitle => 'Asystent';

  @override
  String get assistantGreeting => 'Cześć! Co chciałbyś zrobić?';

  @override
  String get assistantNewList => 'Nowa lista';

  @override
  String get assistantVoiceList => 'Lista głosowa';

  @override
  String get assistantTextList => 'Lista z zdania';

  @override
  String get assistantScanReceipt => 'Skanuj paragon';

  @override
  String get assistantSpending => 'Moje wydatki';

  @override
  String get assistantReceiptHint =>
      'Otwórz swoją listę i naciśnij ikonę paragonu, aby ją zeskanować.';

  @override
  String get assistantToggleTitle => 'Pokaż asystenta';

  @override
  String get assistantToggleSubtitle => 'Mały pomocnik w prawym dolnym rogu';

  @override
  String get scanPriceLabel => 'Skanuj cenę';
}
