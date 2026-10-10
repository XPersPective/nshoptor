// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'תכנון בבית. קנייה לפי התוכנית.';

  @override
  String get listsTitle => 'רשימות';

  @override
  String get listsTabActive => 'פעילות';

  @override
  String get listsTabCompleted => 'הושלמו';

  @override
  String get listsTabArchived => 'ארכיון';

  @override
  String get newListButton => 'רשימה חדשה';

  @override
  String get listTitleHint => 'שם (לא חובה)';

  @override
  String get saveButton => 'שמור';

  @override
  String get cancelButton => 'ביטול';

  @override
  String get deleteButton => 'מחק';

  @override
  String get editAction => 'עריכה';

  @override
  String get listDeleted => 'הרשימה נמחקה';

  @override
  String get invalidAmountError => 'סכום לא תקין';

  @override
  String get duplicateAction => 'שכפל';

  @override
  String get archiveAction => 'אחסן בארכיון';

  @override
  String get unarchiveAction => 'הצג מהארכיון';

  @override
  String get deleteListConfirm =>
      'למחוק את הרשימה הזו? הפריטים המתוכננים בה יוסרו גם הם.';

  @override
  String get undoButton => 'בטל';

  @override
  String get searchListHint => 'חיפוש רשימות';

  @override
  String get currencyLabel => 'מטבע';

  @override
  String get budgetLabel => 'תקציב (לא חובה)';

  @override
  String get noteLabel => 'הערה (לא חובה)';

  @override
  String get storeLabel => 'חנות';

  @override
  String get keepAmountsAction => 'שמור על הסכומים';

  @override
  String get resetAmountsAction => 'אפס סכומים';

  @override
  String get currencyChangeWarning =>
      'המטבע משתנה. מה צריך לקרות עם הסכומים הקיימים?';

  @override
  String get listsEmpty =>
      'אין עדיין רשימות. צור את תוכנית הקניות הראשונה שלך.';

  @override
  String get statusDraft => 'טיוטה';

  @override
  String get statusPlanned => 'מתוכנן';

  @override
  String get statusShopping => 'בקנייה';

  @override
  String get statusCompleted => 'הושלם';

  @override
  String get statusArchived => 'בארכיון';

  @override
  String autoListTitle(String date) {
    return 'קניות $date';
  }

  @override
  String get itemFormTitle => 'הוסף פריט';

  @override
  String get itemNameLabel => 'שם הפריט';

  @override
  String get brandLabel => 'מותג / וריאנט (לא חובה)';

  @override
  String get categoryLabel => 'קטגוריה';

  @override
  String get quantityLabel => 'כמות';

  @override
  String get unitLabel => 'יחידה';

  @override
  String get pricingModeLabel => 'אופן כניסת מחיר';

  @override
  String get pricingModeUnitPrice => 'מחיר ליחידה';

  @override
  String get pricingModeLineTotal => 'סה״כ שורה';

  @override
  String get plannedPriceLabel => 'מחיר מתוכנן';

  @override
  String lineTotalCalculated(String value) {
    return 'סה״כ שורה: $value';
  }

  @override
  String get requiredItemToggle => 'פריט הכרחי';

  @override
  String get maxPriceLabel => 'מחיר מקסימלי סביר (לא חובה)';

  @override
  String get itemNoteLabel => 'הערה (לא חובה)';

  @override
  String get categoryProduce => 'פירות וירקות';

  @override
  String get categoryDairy => 'מוצרי חלב';

  @override
  String get categoryMeat => 'בשר';

  @override
  String get categoryBakery => 'מאפה ומאפים';

  @override
  String get categoryDrinks => 'משקאות';

  @override
  String get categoryCleaning => 'ניקיון';

  @override
  String get categoryPersonalCare => 'טיפוח אישי';

  @override
  String get categoryHome => 'בית';

  @override
  String get categoryOther => 'אחר';

  @override
  String get invalidQuantityError => 'כמות לא תקינה';

  @override
  String get invalidPriceError => 'מחיר לא תקין';

  @override
  String get invalidNameError => 'הזן שם';

  @override
  String unitPriceCalculated(String value) {
    return 'מחיר ליחידה: $value';
  }

  @override
  String get shoppingTitle => 'מצב קניות';

  @override
  String get summaryPlannedTotal => 'מתוכנן';

  @override
  String get summaryInCart => 'בעגלה';

  @override
  String get summaryRemainingPlan => 'תוכנית שנותרה';

  @override
  String get summaryProjected => 'סכום משוער בקופה';

  @override
  String get summaryBudgetRemaining => 'יתרת תקציב';

  @override
  String get summaryBudgetOver => 'מעבר לתקציב';

  @override
  String itemsProgress(String done, String total) {
    return '$done מתוך $total פריטים';
  }

  @override
  String get filterAll => 'הכל';

  @override
  String get filterToBuy => 'לקנייה';

  @override
  String get filterInCart => 'בעגלה';

  @override
  String get filterNotFound => 'לא נמצא';

  @override
  String get filterRequired => 'חובה';

  @override
  String get quickEntryTitle => 'מחיר בפועל';

  @override
  String get actualQuantityLabel => 'כמות בפועל';

  @override
  String get actualPriceLabel => 'מחיר בפועל';

  @override
  String get discountLabel => 'הנחה (אופציונלי)';

  @override
  String get alternativeNameLabel => 'שם מוצר חלופי (אופציונלי)';

  @override
  String get savePurchaseButton => 'הוסף לעגלה';

  @override
  String get unplannedAddButton => 'הוסף פריט שלא היה בתוכנית';

  @override
  String get statusPending => 'טרם נלקח';

  @override
  String get statusInCart => 'בעגלה';

  @override
  String get statusNotFound => 'לא נמצא';

  @override
  String get statusGaveUp => 'ויתרתי';

  @override
  String get statusAlternative => 'נרכש חלופי';

  @override
  String get keepScreenAwake => 'שמור על תאורת המסך';

  @override
  String get finishShopping => 'סיים קניות';

  @override
  String get completionWarning =>
      'יש רשומות חסרות או שאינן מאומתות. עדיין ניתן לסיים; התוצאה תציין זאת.';

  @override
  String get continueShoppingButton => 'המשך לקנות';

  @override
  String get resultTitle => 'תוצאה';

  @override
  String get summarySection => 'סיכום';

  @override
  String get plannedTotalLabel => 'סה״כ מתוכנן';

  @override
  String get actualTotalLabel => 'סה״כ בפועל';

  @override
  String get varianceLabel => 'הפרש';

  @override
  String get varianceNotComputable => 'לא ניתן לחישוב';

  @override
  String get budgetStatusLabel => 'תקציב';

  @override
  String get savingsLabel => 'מתחת לתוכנית';

  @override
  String get overspendLabel => 'מעל לתוכנית';

  @override
  String get unplannedTotalLabel => 'סה״כ פריטים שלא היו בתוכנית';

  @override
  String get unpurchasedLabel => 'מתוכנן אך לא נרכש';

  @override
  String get totalDiscountLabel => 'סה״כ הנחות';

  @override
  String get accuracyLabel => 'דיוק ההערכה';

  @override
  String get groupsSection => 'פריטים';

  @override
  String get groupPricier => 'יקר יותר מהמתוכנן';

  @override
  String get groupCheaper => 'זול יותר מהמתוכנן';

  @override
  String get groupClose => 'קרוב להערכה';

  @override
  String get groupNotTaken => 'מתוכנן, לא נרכש';

  @override
  String get groupUnplanned => 'נרכש ללא תוכנית';

  @override
  String get groupQuantityChanged => 'כמות השתנתה';

  @override
  String get groupUnverified => 'לא אומת';

  @override
  String get plannedQtyLabel => 'כמות מתוכננת';

  @override
  String get actualQtyLabel => 'כמות בפועל';

  @override
  String get plannedUnitPriceLabel => 'מחיר יחידה מתוכנן';

  @override
  String get actualUnitPriceLabel => 'מחיר יחידה בפועל';

  @override
  String get lineVarianceLabel => 'הפרש שורה';

  @override
  String get discountEffectLabel => 'אפקט הנחה';

  @override
  String get notBoughtMark => 'לא נרכש';

  @override
  String get noPurchasesNote => 'לא נרשמו רכישות.';

  @override
  String get navHome => 'בית';

  @override
  String get navLists => 'רשימות';

  @override
  String get navHistory => 'היסטוריה';

  @override
  String get navSettings => 'הגדרות';

  @override
  String get homeEmptyTitle => 'תכנן את הקניות שלך';

  @override
  String get homeEmptyBody =>
      'צור את הרשימה הראשונה והשווה בין עלויות מתוכננות למעשיות.';

  @override
  String get homeActiveSection => 'רשימות פעילות';

  @override
  String get homeCompletedSection => 'הושלמו לאחרונה';

  @override
  String get homeMonthlySection => 'חודש זה';

  @override
  String get monthPlannedLabel => 'מתוכנן';

  @override
  String get monthActualLabel => 'מעשי';

  @override
  String get monthVarianceLabel => 'הפרש';

  @override
  String get continueShoppingLabel => 'המשך קניות';

  @override
  String get historyEmpty =>
      'אין עדיין קניות שהושלמו. ההיסטוריה והתובנות יופיעו כאן.';

  @override
  String get aboutTabTitle => 'אודות NShoptor';

  @override
  String get aboutBody =>
      'NShoptor מאת Crazy Penguin. מתכנן קניות שפועל ללא אינטרנט. מורשה תחת GPL-3.0.';

  @override
  String get startShoppingLabel => 'התחל קניות';

  @override
  String get finishAndSeeResult => 'סיים וראה תוצאה';

  @override
  String get settingsTitle => 'הגדרות';

  @override
  String get languageLabel => 'שפה';

  @override
  String get languageSystem => 'מערכת';

  @override
  String get languageTr => 'טורקית';

  @override
  String get languageEn => 'אנגלית';

  @override
  String get themeLabel => 'ערכת נושא';

  @override
  String get themeSystem => 'מערכת';

  @override
  String get themeLight => 'בהיר';

  @override
  String get themeDark => 'כהה';

  @override
  String get defaultCurrencyLabel => 'מטבע ברירת מחדל';

  @override
  String get defaultUnitLabel => 'יחידת ברירת מחדל';

  @override
  String get keepAwakeLabel => 'שמור על מסך דלוק במהלך הקניות';

  @override
  String get backupSection => 'גיבוי';

  @override
  String get exportBackupLabel => 'ייצוא גיבוי';

  @override
  String get importBackupLabel => 'ייבוא גיבוי';

  @override
  String get mergeImportLabel => 'מיזוג לנתונים הנוכחיים';

  @override
  String get separateImportLabel => 'ייבוא כעותק נפרד';

  @override
  String get importCancelled => 'הייבוא בוטל.';

  @override
  String get backupExported => 'הגיבוי ייוצא בהצלחה.';

  @override
  String get backupSizeWarning =>
      'גיבוי גדול: הקובץ עשוי להיות גדול. האם לכלול גם תמונות?';

  @override
  String get deleteAllSection => 'אזור סכנה';

  @override
  String get deleteAllLabel => 'מחק את כל הנתונים';

  @override
  String get deleteAllConfirm =>
      'פעולה זו תסיר את כל הרשימות, ההיסטוריה, תמונות הקבלות והמחירים. קבצים שיצאת על ידיך נשארים בדיסק שלך. להמשיך?';

  @override
  String get deleteAllConfirm2 =>
      'האם אתה בטוח לחלוטין? פעולה זו לא ניתנת לביטול.';

  @override
  String get cancelAction => 'ביטול';

  @override
  String get confirmDelete => 'מחק לצמיתות';

  @override
  String get dataDeleted => 'כל הנתונים המקומיים נמחקו.';

  @override
  String get privacyInfoLabel => 'פרטיות';

  @override
  String get privacyInfoBody =>
      'הרשימות, המחירים, הקבלות והתמונות שלך נשארים במכשיר. תמונות וקול לעולם לא יוצאים ממנו. כאשר עזרת AI פועלת, רק טקסט (למשל שורות בקבלה או מה שהקלטת) נשלח לשרת שלנו לעיבוד ואינו נשמר.';

  @override
  String get aboutSection => 'אודות';

  @override
  String get aboutPublisher => 'מוציא לאור: Crazy Penguin';

  @override
  String get aboutLicenses => 'רישיונות (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'קלט קולי';

  @override
  String get voiceStatusUnknown => 'שירות: לא נבדק';

  @override
  String get permissionsLabel => 'הרשאות';

  @override
  String get permissionsBody =>
      'מצלמה, מיקרופון והתראות מבוקשות רק כאשר אתה משתמש בפונקציות אלה בפועל.';

  @override
  String get unitsSection => 'ברירות מחדל';

  @override
  String get roundingNote =>
      'עיגול כסף עוקב אחרי כלל אחד: חצאים מעוגלים הרחק מאפס, מיושם פעם אחת בהמרת כסף.';

  @override
  String get voiceInputTitle => 'קלט קולי';

  @override
  String get voiceStartListening => 'התחל הקשבה';

  @override
  String get voiceTranscriptLabel => 'תמליל';

  @override
  String get parseAction => 'ניתוח';

  @override
  String get receiptReviewTitle => 'סקור קבלה';

  @override
  String get receiptTotal => 'סך הכל בקבלה';

  @override
  String get receiptTotalUnknown => 'לא זוהה סכום כולל';

  @override
  String get receiptDiff => 'הפרש';

  @override
  String get acceptLine => 'קבל שורה';

  @override
  String get ignoreLine => 'התעלם משורה';

  @override
  String get receiptLineActions => 'קישור לפריט, פיצול או התעלמות';

  @override
  String get receiptCommit => 'קבל הכל';

  @override
  String get receiptCommitted => 'הקבלה הוחלה.';

  @override
  String get priceHistoryTitle => 'היסטוריית מחירים';

  @override
  String get noObservations => 'טרם נרשמו תצפיות מחיר';

  @override
  String get templatesSection => 'תבניות';

  @override
  String get templateHint => 'צור תוכנית חדשה מבילוי קניות קודם';

  @override
  String get scanReceiptAction => 'סרוק קבלה';

  @override
  String get shelfLabelAction => 'מחיר מתווית מדף';

  @override
  String get priceCandidatesTitle => 'מועמדים למחיר';

  @override
  String get noPriceCandidates => 'לא נמצא מחיר; הזן ידנית.';

  @override
  String get voiceUnavailable => 'זיהוי דיבור לא זמין; הזן ידנית.';

  @override
  String get linkToItem => 'קשר לפריט';

  @override
  String get splitLine => 'פצל לשניים';

  @override
  String get mergeWithNext => 'מיזוג עם הבאה';

  @override
  String get ocrNoText => 'לא נקרא טקסט; נסה שוב.';

  @override
  String get priceHistoryAction => 'היסטוריית מחירים';

  @override
  String get itemsEmptyTitle => 'אין עדיין פריטים';

  @override
  String get itemsEmptyBody =>
      'הוסף את הפריט הראשון שלך — כאן תזין מחירים אמיתיים בחנות.';

  @override
  String get addItemTooltip => 'הוסף פריט';

  @override
  String get unitAdet => 'יח\'';

  @override
  String get unitKilogram => 'ק״ג';

  @override
  String get unitGram => 'גר׳';

  @override
  String get unitLitre => 'ליטר';

  @override
  String get unitMililitre => 'מ״ל';

  @override
  String get unitPaket => 'חבילה';

  @override
  String get unitKutu => 'קופסה';

  @override
  String get unitSise => 'בקבוק';

  @override
  String get unitKavanoz => 'צנצנת';

  @override
  String get unitDemet => 'אלומה';

  @override
  String get unitDuzine => 'תריסר';

  @override
  String get unitMetre => 'מ׳';

  @override
  String get unitCustom => 'מותאם אישית';

  @override
  String get setReminderAction => 'הגדר תזכורת';

  @override
  String get reminderPermissionDenied =>
      'נדרשת הרשאת התראות לתזכורות. ניתן להפעיל זאת בהגדרות המערכת.';

  @override
  String get reminderScheduled => 'התזכורת הוגדרה.';

  @override
  String get reminderCancelled => 'התזכורת הוסרה.';

  @override
  String get reminderTitle => 'תזכורת לקניות';

  @override
  String reminderBody(Object title) {
    return 'זמן לבדוק את הרשימה: $title';
  }

  @override
  String get reminderPickDate => 'בחר תאריך';

  @override
  String get reminderPickTime => 'בחר שעה';

  @override
  String get itemDetailsSection => 'פרטים';

  @override
  String get priceOptionalHint => 'אופציונלי — המחיר האמיתי יוזן בחנות';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'מתוכנן: $total · $count פריטים';
  }

  @override
  String get proActiveLabel => 'Pro פעיל — תודה!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'ללא מודעות, יותר AI, גיבוי · החל ממחיר חודשי נמוך';

  @override
  String get proBenefitNoAds => 'חוויה ללא מודעות';

  @override
  String get proBenefitBackup => 'גיבוי (ייצוא/ייבוא)';

  @override
  String aboutVersion(Object version) {
    return 'גרסה $version';
  }

  @override
  String get navDiscover => 'גלה';

  @override
  String get shareAction => 'שתף את האפליקציה';

  @override
  String get rateAction => 'דרג אותנו';

  @override
  String get aboutOpenRow => 'אודות וקוד פתוח';

  @override
  String get voiceAddItemAction => 'הוסף בקול';

  @override
  String get formatLocaleLabel => 'פורמט מספרים ומטבע';

  @override
  String get formatLocaleSystem => 'תצורת המכשיר (ספרות לטיניות; אחרת באנגלית)';

  @override
  String get formatLocaleTr => 'טורקי (1.234,56)';

  @override
  String get formatLocaleEn => 'אנגלית (1,234.56)';

  @override
  String get aiToggleTitle => 'עזרה של AI';

  @override
  String get aiToggleSubtitle =>
      'תואם קבלות, קורא תוויות מחיר והופך משפטים לרשימות. תמונות וקול נשארים במכשיר שלך; רק טקסט מעובד.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'השתמשת בכל בקשות ה-AI החודשיות ($used/$limit). שדרג לקבלת יותר, או המשך בלי AI.';
  }

  @override
  String get aiOffline => 'אין חיבור — ממשיכים בלי AI.';

  @override
  String get aiFailed => 'AI לא זמין כרגע — ממשיכים בלעדיו.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'מכשיר';

  @override
  String get quickListAction => 'הוסף ממשפט';

  @override
  String get quickListTitle => 'רשימה מהירה';

  @override
  String get quickListHint => 'למשל 1 ק\"ג תפוחים 20, 2 לחמים, חצי ק\"ג גבינה';

  @override
  String get quickListConvert => 'הפוך לרשימה';

  @override
  String quickListAdd(int count) {
    return 'הוסף $count פריטים';
  }

  @override
  String get quickListEmpty =>
      'לא נמצאו פריטים. נסה לרשום אותם מופרדים בפסיקים.';

  @override
  String get receiptAiMatched =>
      'AI התאים את הקבלה לרשימה שלך. בדוק את הקישורים ואשר.';

  @override
  String get receiptNeedsCheck => 'בדוק התאמה זו';

  @override
  String get receiptDiscountLine => 'הנחה';

  @override
  String get compareItem => 'פריט';

  @override
  String get compareEstimated => 'הערכה';

  @override
  String get compareActual => 'פועל';

  @override
  String get compareDiff => 'הפרש';

  @override
  String get compareTotal => 'סה״כ';

  @override
  String get compareBudget => 'תקציב';

  @override
  String get compareNotBought => 'לא נקנה';

  @override
  String get compareUnplanned => 'לא מתוכנן';

  @override
  String get pricierItems => 'יקר יותר';

  @override
  String get cheaperItems => 'זול יותר';

  @override
  String get compareAction => 'השווה';

  @override
  String get detailsSection => 'פרטים';

  @override
  String get spendingTitle => 'הוצאות';

  @override
  String get spendingAction => 'הוצאות';

  @override
  String get spendingMonthTotal => 'החודש הזה';

  @override
  String get spendingWeekly => 'הוצאה שבועית';

  @override
  String get spendingMonthly => 'הוצאה חודשית';

  @override
  String get monthlyLimitTitle => 'תקרה חודשית';

  @override
  String get monthlyLimitHelp => 'כמה ברצונך להוציא על קניות בחודש?';

  @override
  String get monthlyLimitRemove => 'הסר';

  @override
  String get monthlyLimitSet => 'הגדר';

  @override
  String get monthlyLimitChange => 'שנה';

  @override
  String get monthlyLimitNone => 'הגדר תקרה חודשית כדי לראות כמה נותר לך.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount מעבר לתקרה';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount נותרו החודש';
  }

  @override
  String get plansTitle => 'תוכניות';

  @override
  String get plansHeadline => 'קנה חכם עם AI';

  @override
  String get plansSubhead =>
      'התאמת קבלות, תוויות מחיר ורשימות ממשפט. ניתן לבטל בכל עת.';

  @override
  String get plansMonthly => 'חודשי';

  @override
  String get plansYearly => 'שנתי';

  @override
  String get planFree => 'חינם';

  @override
  String get planFreePrice => 'חינם לנצח';

  @override
  String get planFreeAi => '15 בקשות AI לחודש';

  @override
  String get planFreeAds =>
      'פרסומות באנר קטנות (ללא פרסומות ב-7 הימים הראשונים)';

  @override
  String get planCoreFeatures => 'רשימות, מחירים, קבלות, גרפי הוצאות';

  @override
  String get plansPerYear => '/ שנה';

  @override
  String get plansPerMonth => '/ חודש';

  @override
  String get planTrial => '7 ימים חינם';

  @override
  String get planProAi => '200 בקשות AI לחודש';

  @override
  String get planNoAds => 'ללא פרסומות';

  @override
  String get planBackup => 'גיבוי ייצוא וייבוא';

  @override
  String get planMaxAi => '1000 בקשות AI בחודש';

  @override
  String get planMaxFamily => 'לקניות של משפחה גדולה';

  @override
  String get plansStoreUnavailable => 'החנות לא זמינה כרגע.';

  @override
  String get retryAction => 'נסה שוב';

  @override
  String get plansPurchaseFailed => 'הרכישה לא הושלמה. אנא נסה שוב.';

  @override
  String get planLifetimeTitle => 'ללא פרסומות לכל החיים';

  @override
  String get planLifetimeSubtitle =>
      'תשלום חד־פעמי: ללא פרסומות, גיבוי; AI נשאר במסגרת המותר בחינם';

  @override
  String get plansRestore => 'שחזור רכישות';

  @override
  String get plansLegal =>
      'המנויים מתחדשים אוטומטית עד ביטול. ניתן לבטל בכל עת ב־Google Play › תשלומים ומנויים. המחירים כוללים את המיסים המוצגים על ידי Google Play.';

  @override
  String get planCurrent => 'נוכחי';

  @override
  String get planStartTrial => 'התחל ניסיון חינם של 7 ימים';

  @override
  String get planChoose => 'בחר';

  @override
  String get plansAction => 'תוכניות: Pro ו־Max';

  @override
  String get assistantTitle => 'עוזר';

  @override
  String get assistantGreeting => 'היי! מה תרצה לעשות?';

  @override
  String get assistantNewList => 'רשימה חדשה';

  @override
  String get assistantVoiceList => 'רשימה לפי קול';

  @override
  String get assistantTextList => 'רשימה מפסקה';

  @override
  String get assistantScanReceipt => 'סריקת קבלה';

  @override
  String get assistantSpending => 'ההוצאות שלי';

  @override
  String get assistantReceiptHint =>
      'פתח את הרשימה שלך ולחץ על סמל הקבלה כדי לסרוק אותה.';

  @override
  String get assistantToggleTitle => 'הצג עוזר';

  @override
  String get assistantToggleSubtitle => 'העוזר הקטן בפינה הימנית התחתונה';

  @override
  String get scanPriceLabel => 'סרוק תווית מחיר';

  @override
  String get saveFailed => 'לא הצליח לשמור. השינויים עדיין כאן. נסה שוב.';

  @override
  String get deleteItemConfirm => 'למחוק פריט זה ואת רכישותיו הרשומות?';

  @override
  String get clearPurchaseConfirm =>
      'לבטל את סימון הפריט ולהסיר את רכישותיו הרשומות?';

  @override
  String get reportPdfAction => 'שמירת דוח PDF';

  @override
  String get reportNotInvoice =>
      'סיכום קניות, לא חשבון מס. שיעורי המס אינם ידועים.';

  @override
  String get purchaseVisits => 'ביקורי קניות';

  @override
  String get purchaseInterval => 'ימים ממוצעים בין רכישות';

  @override
  String get purchasedQuantity => 'כמות שנרכשה';

  @override
  String get purchaseAnalyticsHint =>
      'רכישות אינן מודדות צריכה. מטבעות ויחידות מוצגים בנפרד.';

  @override
  String get receiptReplaces =>
      'שורות קבלה מקושרות מחליפות רכישות קיימות; שורות שאינן מקושרות מתווספות.';

  @override
  String get voiceUnsupportedLanguage =>
      'שפה זו אינה זמינה לקלט קולי במכשיר זה. ניתן להקליד במקום זאת.';

  @override
  String get voiceStopListening => 'הפסק להקשיב';

  @override
  String get keepAwakeFailed => 'לא הצלחנו לשמור על התצוגה דלוקה. נסה שוב.';

  @override
  String get purchaseHistoryHint =>
      'כל הקניות שהושלמו. החזרים מפחיתים את הסכומים הכוללים. התאריכים מתייחסים להשלמת הקניות. ביקור אחד אינו מספיק לחישוב מרווח ממוצע.';
}
