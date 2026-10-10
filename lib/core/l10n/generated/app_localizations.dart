import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_af.dart';
import 'app_localizations_ar.dart';
import 'app_localizations_az.dart';
import 'app_localizations_be.dart';
import 'app_localizations_bg.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_bs.dart';
import 'app_localizations_ca.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_et.dart';
import 'app_localizations_eu.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fil.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_gl.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_hr.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_hy.dart';
import 'app_localizations_id.dart';
import 'app_localizations_is.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ka.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ky.dart';
import 'app_localizations_lo.dart';
import 'app_localizations_lt.dart';
import 'app_localizations_lv.dart';
import 'app_localizations_mk.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_mn.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_my.dart';
import 'app_localizations_ne.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_ps.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_si.dart';
import 'app_localizations_sk.dart';
import 'app_localizations_sl.dart';
import 'app_localizations_sq.dart';
import 'app_localizations_sr.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_sw.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tl.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_uz.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';
import 'app_localizations_zu.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('af'),
    Locale('ar'),
    Locale('az'),
    Locale('be'),
    Locale('bg'),
    Locale('bn'),
    Locale('bs'),
    Locale('ca'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('et'),
    Locale('eu'),
    Locale('fa'),
    Locale('fi'),
    Locale('fil'),
    Locale('fr'),
    Locale('gl'),
    Locale('gu'),
    Locale('he'),
    Locale('hi'),
    Locale('hr'),
    Locale('hu'),
    Locale('hy'),
    Locale('id'),
    Locale('is'),
    Locale('it'),
    Locale('ja'),
    Locale('ka'),
    Locale('kk'),
    Locale('kn'),
    Locale('ko'),
    Locale('ky'),
    Locale('lo'),
    Locale('lt'),
    Locale('lv'),
    Locale('mk'),
    Locale('ml'),
    Locale('mn'),
    Locale('mr'),
    Locale('ms'),
    Locale('my'),
    Locale('ne'),
    Locale('nl'),
    Locale('pa'),
    Locale('pl'),
    Locale('ps'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('si'),
    Locale('sk'),
    Locale('sl'),
    Locale('sq'),
    Locale('sr'),
    Locale('sv'),
    Locale('sw'),
    Locale('ta'),
    Locale('te'),
    Locale('th'),
    Locale('tl'),
    Locale('tr'),
    Locale('uk'),
    Locale('ur'),
    Locale('uz'),
    Locale('vi'),
    Locale('zh'),
    Locale('zu'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'NShoptor'**
  String get appTitle;

  /// No description provided for @slogan.
  ///
  /// In en, this message translates to:
  /// **'Plan at home. Shop as planned.'**
  String get slogan;

  /// No description provided for @listsTitle.
  ///
  /// In en, this message translates to:
  /// **'Lists'**
  String get listsTitle;

  /// No description provided for @listsTabActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get listsTabActive;

  /// No description provided for @listsTabCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get listsTabCompleted;

  /// No description provided for @listsTabArchived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get listsTabArchived;

  /// No description provided for @newListButton.
  ///
  /// In en, this message translates to:
  /// **'New list'**
  String get newListButton;

  /// No description provided for @listTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Title (optional)'**
  String get listTitleHint;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @editAction.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editAction;

  /// No description provided for @listDeleted.
  ///
  /// In en, this message translates to:
  /// **'List deleted'**
  String get listDeleted;

  /// No description provided for @invalidAmountError.
  ///
  /// In en, this message translates to:
  /// **'Invalid amount'**
  String get invalidAmountError;

  /// No description provided for @duplicateAction.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get duplicateAction;

  /// No description provided for @archiveAction.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archiveAction;

  /// No description provided for @unarchiveAction.
  ///
  /// In en, this message translates to:
  /// **'Unarchive'**
  String get unarchiveAction;

  /// No description provided for @deleteListConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this list? Its planned items will also be removed.'**
  String get deleteListConfirm;

  /// No description provided for @undoButton.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undoButton;

  /// No description provided for @searchListHint.
  ///
  /// In en, this message translates to:
  /// **'Search lists'**
  String get searchListHint;

  /// No description provided for @currencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currencyLabel;

  /// No description provided for @budgetLabel.
  ///
  /// In en, this message translates to:
  /// **'Budget (optional)'**
  String get budgetLabel;

  /// No description provided for @noteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get noteLabel;

  /// No description provided for @storeLabel.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get storeLabel;

  /// No description provided for @keepAmountsAction.
  ///
  /// In en, this message translates to:
  /// **'Keep amounts'**
  String get keepAmountsAction;

  /// No description provided for @resetAmountsAction.
  ///
  /// In en, this message translates to:
  /// **'Reset amounts'**
  String get resetAmountsAction;

  /// No description provided for @currencyChangeWarning.
  ///
  /// In en, this message translates to:
  /// **'The currency is changing. What should happen to the existing amounts?'**
  String get currencyChangeWarning;

  /// No description provided for @listsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No lists yet. Create your first shopping plan.'**
  String get listsEmpty;

  /// No description provided for @statusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get statusDraft;

  /// No description provided for @statusPlanned.
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get statusPlanned;

  /// No description provided for @statusShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get statusShopping;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @statusArchived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get statusArchived;

  /// No description provided for @autoListTitle.
  ///
  /// In en, this message translates to:
  /// **'{date} shopping'**
  String autoListTitle(String date);

  /// No description provided for @itemFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Add item'**
  String get itemFormTitle;

  /// No description provided for @itemNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Item name'**
  String get itemNameLabel;

  /// No description provided for @brandLabel.
  ///
  /// In en, this message translates to:
  /// **'Brand / variant (optional)'**
  String get brandLabel;

  /// No description provided for @categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLabel;

  /// No description provided for @quantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantityLabel;

  /// No description provided for @unitLabel.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unitLabel;

  /// No description provided for @pricingModeLabel.
  ///
  /// In en, this message translates to:
  /// **'Price entry'**
  String get pricingModeLabel;

  /// No description provided for @pricingModeUnitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit price'**
  String get pricingModeUnitPrice;

  /// No description provided for @pricingModeLineTotal.
  ///
  /// In en, this message translates to:
  /// **'Line total'**
  String get pricingModeLineTotal;

  /// No description provided for @plannedPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Planned price'**
  String get plannedPriceLabel;

  /// No description provided for @lineTotalCalculated.
  ///
  /// In en, this message translates to:
  /// **'Line total: {value}'**
  String lineTotalCalculated(String value);

  /// No description provided for @requiredItemToggle.
  ///
  /// In en, this message translates to:
  /// **'Required item'**
  String get requiredItemToggle;

  /// No description provided for @maxPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Maximum acceptable price (optional)'**
  String get maxPriceLabel;

  /// No description provided for @itemNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get itemNoteLabel;

  /// No description provided for @categoryProduce.
  ///
  /// In en, this message translates to:
  /// **'Fruit & vegetables'**
  String get categoryProduce;

  /// No description provided for @categoryDairy.
  ///
  /// In en, this message translates to:
  /// **'Dairy'**
  String get categoryDairy;

  /// No description provided for @categoryMeat.
  ///
  /// In en, this message translates to:
  /// **'Meat'**
  String get categoryMeat;

  /// No description provided for @categoryBakery.
  ///
  /// In en, this message translates to:
  /// **'Bakery'**
  String get categoryBakery;

  /// No description provided for @categoryDrinks.
  ///
  /// In en, this message translates to:
  /// **'Drinks'**
  String get categoryDrinks;

  /// No description provided for @categoryCleaning.
  ///
  /// In en, this message translates to:
  /// **'Cleaning'**
  String get categoryCleaning;

  /// No description provided for @categoryPersonalCare.
  ///
  /// In en, this message translates to:
  /// **'Personal care'**
  String get categoryPersonalCare;

  /// No description provided for @categoryHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get categoryHome;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @invalidQuantityError.
  ///
  /// In en, this message translates to:
  /// **'Invalid quantity'**
  String get invalidQuantityError;

  /// No description provided for @invalidPriceError.
  ///
  /// In en, this message translates to:
  /// **'Invalid price'**
  String get invalidPriceError;

  /// No description provided for @invalidNameError.
  ///
  /// In en, this message translates to:
  /// **'Enter a name'**
  String get invalidNameError;

  /// No description provided for @unitPriceCalculated.
  ///
  /// In en, this message translates to:
  /// **'Unit price: {value}'**
  String unitPriceCalculated(String value);

  /// No description provided for @shoppingTitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping mode'**
  String get shoppingTitle;

  /// No description provided for @summaryPlannedTotal.
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get summaryPlannedTotal;

  /// No description provided for @summaryInCart.
  ///
  /// In en, this message translates to:
  /// **'In cart'**
  String get summaryInCart;

  /// No description provided for @summaryRemainingPlan.
  ///
  /// In en, this message translates to:
  /// **'Remaining plan'**
  String get summaryRemainingPlan;

  /// No description provided for @summaryProjected.
  ///
  /// In en, this message translates to:
  /// **'Estimated checkout'**
  String get summaryProjected;

  /// No description provided for @summaryBudgetRemaining.
  ///
  /// In en, this message translates to:
  /// **'Budget left'**
  String get summaryBudgetRemaining;

  /// No description provided for @summaryBudgetOver.
  ///
  /// In en, this message translates to:
  /// **'Over budget'**
  String get summaryBudgetOver;

  /// No description provided for @itemsProgress.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} items'**
  String itemsProgress(String done, String total);

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterToBuy.
  ///
  /// In en, this message translates to:
  /// **'To buy'**
  String get filterToBuy;

  /// No description provided for @filterInCart.
  ///
  /// In en, this message translates to:
  /// **'In cart'**
  String get filterInCart;

  /// No description provided for @filterNotFound.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get filterNotFound;

  /// No description provided for @filterRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get filterRequired;

  /// No description provided for @quickEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Actual price'**
  String get quickEntryTitle;

  /// No description provided for @actualQuantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Actual quantity'**
  String get actualQuantityLabel;

  /// No description provided for @actualPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Actual price'**
  String get actualPriceLabel;

  /// No description provided for @discountLabel.
  ///
  /// In en, this message translates to:
  /// **'Discount (optional)'**
  String get discountLabel;

  /// No description provided for @alternativeNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Alternative product name (optional)'**
  String get alternativeNameLabel;

  /// No description provided for @savePurchaseButton.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get savePurchaseButton;

  /// No description provided for @unplannedAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add unplanned item'**
  String get unplannedAddButton;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Not taken'**
  String get statusPending;

  /// No description provided for @statusInCart.
  ///
  /// In en, this message translates to:
  /// **'In cart'**
  String get statusInCart;

  /// No description provided for @statusNotFound.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get statusNotFound;

  /// No description provided for @statusGaveUp.
  ///
  /// In en, this message translates to:
  /// **'Gave up'**
  String get statusGaveUp;

  /// No description provided for @statusAlternative.
  ///
  /// In en, this message translates to:
  /// **'Alternative bought'**
  String get statusAlternative;

  /// No description provided for @keepScreenAwake.
  ///
  /// In en, this message translates to:
  /// **'Keep screen on'**
  String get keepScreenAwake;

  /// No description provided for @finishShopping.
  ///
  /// In en, this message translates to:
  /// **'Finish shopping'**
  String get finishShopping;

  /// No description provided for @completionWarning.
  ///
  /// In en, this message translates to:
  /// **'There are missing or unverified records. You can still finish; the result will note them.'**
  String get completionWarning;

  /// No description provided for @continueShoppingButton.
  ///
  /// In en, this message translates to:
  /// **'Keep shopping'**
  String get continueShoppingButton;

  /// No description provided for @resultTitle.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get resultTitle;

  /// No description provided for @summarySection.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summarySection;

  /// No description provided for @plannedTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Planned total'**
  String get plannedTotalLabel;

  /// No description provided for @actualTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Actual total'**
  String get actualTotalLabel;

  /// No description provided for @varianceLabel.
  ///
  /// In en, this message translates to:
  /// **'Difference'**
  String get varianceLabel;

  /// No description provided for @varianceNotComputable.
  ///
  /// In en, this message translates to:
  /// **'Cannot be computed'**
  String get varianceNotComputable;

  /// No description provided for @budgetStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get budgetStatusLabel;

  /// No description provided for @savingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Under plan'**
  String get savingsLabel;

  /// No description provided for @overspendLabel.
  ///
  /// In en, this message translates to:
  /// **'Over plan'**
  String get overspendLabel;

  /// No description provided for @unplannedTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Unplanned total'**
  String get unplannedTotalLabel;

  /// No description provided for @unpurchasedLabel.
  ///
  /// In en, this message translates to:
  /// **'Planned but not bought'**
  String get unpurchasedLabel;

  /// No description provided for @totalDiscountLabel.
  ///
  /// In en, this message translates to:
  /// **'Total discounts'**
  String get totalDiscountLabel;

  /// No description provided for @accuracyLabel.
  ///
  /// In en, this message translates to:
  /// **'Estimate accuracy'**
  String get accuracyLabel;

  /// No description provided for @groupsSection.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get groupsSection;

  /// No description provided for @groupPricier.
  ///
  /// In en, this message translates to:
  /// **'Pricier than planned'**
  String get groupPricier;

  /// No description provided for @groupCheaper.
  ///
  /// In en, this message translates to:
  /// **'Cheaper than planned'**
  String get groupCheaper;

  /// No description provided for @groupClose.
  ///
  /// In en, this message translates to:
  /// **'Close to estimate'**
  String get groupClose;

  /// No description provided for @groupNotTaken.
  ///
  /// In en, this message translates to:
  /// **'Planned, not bought'**
  String get groupNotTaken;

  /// No description provided for @groupUnplanned.
  ///
  /// In en, this message translates to:
  /// **'Bought without plan'**
  String get groupUnplanned;

  /// No description provided for @groupQuantityChanged.
  ///
  /// In en, this message translates to:
  /// **'Quantity changed'**
  String get groupQuantityChanged;

  /// No description provided for @groupUnverified.
  ///
  /// In en, this message translates to:
  /// **'Not verified'**
  String get groupUnverified;

  /// No description provided for @plannedQtyLabel.
  ///
  /// In en, this message translates to:
  /// **'Planned quantity'**
  String get plannedQtyLabel;

  /// No description provided for @actualQtyLabel.
  ///
  /// In en, this message translates to:
  /// **'Actual quantity'**
  String get actualQtyLabel;

  /// No description provided for @plannedUnitPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Planned unit price'**
  String get plannedUnitPriceLabel;

  /// No description provided for @actualUnitPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Actual unit price'**
  String get actualUnitPriceLabel;

  /// No description provided for @lineVarianceLabel.
  ///
  /// In en, this message translates to:
  /// **'Line difference'**
  String get lineVarianceLabel;

  /// No description provided for @discountEffectLabel.
  ///
  /// In en, this message translates to:
  /// **'Discount effect'**
  String get discountEffectLabel;

  /// No description provided for @notBoughtMark.
  ///
  /// In en, this message translates to:
  /// **'not bought'**
  String get notBoughtMark;

  /// No description provided for @noPurchasesNote.
  ///
  /// In en, this message translates to:
  /// **'No purchases were recorded.'**
  String get noPurchasesNote;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navLists.
  ///
  /// In en, this message translates to:
  /// **'Lists'**
  String get navLists;

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @homeEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan your shopping'**
  String get homeEmptyTitle;

  /// No description provided for @homeEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Create your first list and compare planned vs actual costs.'**
  String get homeEmptyBody;

  /// No description provided for @homeActiveSection.
  ///
  /// In en, this message translates to:
  /// **'Active lists'**
  String get homeActiveSection;

  /// No description provided for @homeCompletedSection.
  ///
  /// In en, this message translates to:
  /// **'Recently completed'**
  String get homeCompletedSection;

  /// No description provided for @homeMonthlySection.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get homeMonthlySection;

  /// No description provided for @monthPlannedLabel.
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get monthPlannedLabel;

  /// No description provided for @monthActualLabel.
  ///
  /// In en, this message translates to:
  /// **'Actual'**
  String get monthActualLabel;

  /// No description provided for @monthVarianceLabel.
  ///
  /// In en, this message translates to:
  /// **'Difference'**
  String get monthVarianceLabel;

  /// No description provided for @continueShoppingLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue shopping'**
  String get continueShoppingLabel;

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No completed shopping yet. Your history and insights will appear here.'**
  String get historyEmpty;

  /// No description provided for @aboutTabTitle.
  ///
  /// In en, this message translates to:
  /// **'About NShoptor'**
  String get aboutTabTitle;

  /// No description provided for @aboutBody.
  ///
  /// In en, this message translates to:
  /// **'NShoptor by Crazy Penguin. Offline-first shopping planner. Licensed under GPL-3.0.'**
  String get aboutBody;

  /// No description provided for @startShoppingLabel.
  ///
  /// In en, this message translates to:
  /// **'Start shopping'**
  String get startShoppingLabel;

  /// No description provided for @finishAndSeeResult.
  ///
  /// In en, this message translates to:
  /// **'Finish & see result'**
  String get finishAndSeeResult;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get languageSystem;

  /// No description provided for @languageTr.
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get languageTr;

  /// No description provided for @languageEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEn;

  /// No description provided for @themeLabel.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeLabel;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @defaultCurrencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Default currency'**
  String get defaultCurrencyLabel;

  /// No description provided for @defaultUnitLabel.
  ///
  /// In en, this message translates to:
  /// **'Default unit'**
  String get defaultUnitLabel;

  /// No description provided for @keepAwakeLabel.
  ///
  /// In en, this message translates to:
  /// **'Keep screen on while shopping'**
  String get keepAwakeLabel;

  /// No description provided for @backupSection.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backupSection;

  /// No description provided for @exportBackupLabel.
  ///
  /// In en, this message translates to:
  /// **'Export backup'**
  String get exportBackupLabel;

  /// No description provided for @importBackupLabel.
  ///
  /// In en, this message translates to:
  /// **'Import backup'**
  String get importBackupLabel;

  /// No description provided for @mergeImportLabel.
  ///
  /// In en, this message translates to:
  /// **'Merge into current data'**
  String get mergeImportLabel;

  /// No description provided for @separateImportLabel.
  ///
  /// In en, this message translates to:
  /// **'Import as a separate copy'**
  String get separateImportLabel;

  /// No description provided for @importCancelled.
  ///
  /// In en, this message translates to:
  /// **'Import cancelled.'**
  String get importCancelled;

  /// No description provided for @backupExported.
  ///
  /// In en, this message translates to:
  /// **'Backup exported successfully.'**
  String get backupExported;

  /// No description provided for @deleteAllSection.
  ///
  /// In en, this message translates to:
  /// **'Danger zone'**
  String get deleteAllSection;

  /// No description provided for @deleteAllLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get deleteAllLabel;

  /// No description provided for @deleteAllConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will remove all lists, history, receipt photos and prices. Files exported by you stay on your drive. Continue?'**
  String get deleteAllConfirm;

  /// No description provided for @deleteAllConfirm2.
  ///
  /// In en, this message translates to:
  /// **'Are you completely sure? This action cannot be undone.'**
  String get deleteAllConfirm2;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete permanently'**
  String get confirmDelete;

  /// No description provided for @dataDeleted.
  ///
  /// In en, this message translates to:
  /// **'All local data was deleted.'**
  String get dataDeleted;

  /// No description provided for @privacyInfoLabel.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacyInfoLabel;

  /// No description provided for @privacyInfoBody.
  ///
  /// In en, this message translates to:
  /// **'Your lists, prices, receipts and photos stay on your device. Photos and voice never leave it. When AI help is on, only text (for example receipt lines or what you dictated) is sent to our server to be processed and is not stored.'**
  String get privacyInfoBody;

  /// No description provided for @aboutSection.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutSection;

  /// No description provided for @aboutPublisher.
  ///
  /// In en, this message translates to:
  /// **'Publisher: Crazy Penguin'**
  String get aboutPublisher;

  /// No description provided for @aboutLicenses.
  ///
  /// In en, this message translates to:
  /// **'Licenses (GPL-3.0)'**
  String get aboutLicenses;

  /// No description provided for @voiceSettingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Voice input'**
  String get voiceSettingsLabel;

  /// No description provided for @voiceStatusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Service: not checked'**
  String get voiceStatusUnknown;

  /// No description provided for @permissionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get permissionsLabel;

  /// No description provided for @permissionsBody.
  ///
  /// In en, this message translates to:
  /// **'Camera, microphone and notifications are requested only when you actually use those features.'**
  String get permissionsBody;

  /// No description provided for @unitsSection.
  ///
  /// In en, this message translates to:
  /// **'Defaults'**
  String get unitsSection;

  /// No description provided for @roundingNote.
  ///
  /// In en, this message translates to:
  /// **'Money rounding follows one rule: halves round away from zero, applied once at Money conversion.'**
  String get roundingNote;

  /// No description provided for @voiceInputTitle.
  ///
  /// In en, this message translates to:
  /// **'Voice input'**
  String get voiceInputTitle;

  /// No description provided for @voiceStartListening.
  ///
  /// In en, this message translates to:
  /// **'Start listening'**
  String get voiceStartListening;

  /// No description provided for @voiceTranscriptLabel.
  ///
  /// In en, this message translates to:
  /// **'Transcript'**
  String get voiceTranscriptLabel;

  /// No description provided for @parseAction.
  ///
  /// In en, this message translates to:
  /// **'Parse'**
  String get parseAction;

  /// No description provided for @receiptReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review receipt'**
  String get receiptReviewTitle;

  /// No description provided for @receiptTotal.
  ///
  /// In en, this message translates to:
  /// **'Receipt total'**
  String get receiptTotal;

  /// No description provided for @receiptTotalUnknown.
  ///
  /// In en, this message translates to:
  /// **'Total not detected'**
  String get receiptTotalUnknown;

  /// No description provided for @receiptDiff.
  ///
  /// In en, this message translates to:
  /// **'Difference'**
  String get receiptDiff;

  /// No description provided for @acceptLine.
  ///
  /// In en, this message translates to:
  /// **'Accept line'**
  String get acceptLine;

  /// No description provided for @ignoreLine.
  ///
  /// In en, this message translates to:
  /// **'Ignore line'**
  String get ignoreLine;

  /// No description provided for @receiptLineActions.
  ///
  /// In en, this message translates to:
  /// **'Link to item, split or ignore'**
  String get receiptLineActions;

  /// No description provided for @receiptCommit.
  ///
  /// In en, this message translates to:
  /// **'Accept all'**
  String get receiptCommit;

  /// No description provided for @receiptCommitted.
  ///
  /// In en, this message translates to:
  /// **'Receipt applied.'**
  String get receiptCommitted;

  /// No description provided for @priceHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Price history'**
  String get priceHistoryTitle;

  /// No description provided for @noObservations.
  ///
  /// In en, this message translates to:
  /// **'No price observations yet'**
  String get noObservations;

  /// No description provided for @templatesSection.
  ///
  /// In en, this message translates to:
  /// **'Templates'**
  String get templatesSection;

  /// No description provided for @templateHint.
  ///
  /// In en, this message translates to:
  /// **'Create a new plan from a previous shopping trip'**
  String get templateHint;

  /// No description provided for @scanReceiptAction.
  ///
  /// In en, this message translates to:
  /// **'Scan receipt'**
  String get scanReceiptAction;

  /// No description provided for @shelfLabelAction.
  ///
  /// In en, this message translates to:
  /// **'Price from shelf label'**
  String get shelfLabelAction;

  /// No description provided for @priceCandidatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Price candidates'**
  String get priceCandidatesTitle;

  /// No description provided for @noPriceCandidates.
  ///
  /// In en, this message translates to:
  /// **'No price found; enter it manually.'**
  String get noPriceCandidates;

  /// No description provided for @voiceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Speech recognition unavailable; enter manually.'**
  String get voiceUnavailable;

  /// No description provided for @linkToItem.
  ///
  /// In en, this message translates to:
  /// **'Link to item'**
  String get linkToItem;

  /// No description provided for @splitLine.
  ///
  /// In en, this message translates to:
  /// **'Split in two'**
  String get splitLine;

  /// No description provided for @mergeWithNext.
  ///
  /// In en, this message translates to:
  /// **'Merge with next'**
  String get mergeWithNext;

  /// No description provided for @ocrNoText.
  ///
  /// In en, this message translates to:
  /// **'No text read; try again.'**
  String get ocrNoText;

  /// No description provided for @priceHistoryAction.
  ///
  /// In en, this message translates to:
  /// **'Price history'**
  String get priceHistoryAction;

  /// No description provided for @itemsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No items yet'**
  String get itemsEmptyTitle;

  /// No description provided for @itemsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add your first item — you\'ll enter real prices here in the store.'**
  String get itemsEmptyBody;

  /// No description provided for @addItemTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add item'**
  String get addItemTooltip;

  /// No description provided for @unitAdet.
  ///
  /// In en, this message translates to:
  /// **'pc'**
  String get unitAdet;

  /// No description provided for @unitKilogram.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get unitKilogram;

  /// No description provided for @unitGram.
  ///
  /// In en, this message translates to:
  /// **'g'**
  String get unitGram;

  /// No description provided for @unitLitre.
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get unitLitre;

  /// No description provided for @unitMililitre.
  ///
  /// In en, this message translates to:
  /// **'ml'**
  String get unitMililitre;

  /// No description provided for @unitPaket.
  ///
  /// In en, this message translates to:
  /// **'pack'**
  String get unitPaket;

  /// No description provided for @unitKutu.
  ///
  /// In en, this message translates to:
  /// **'box'**
  String get unitKutu;

  /// No description provided for @unitSise.
  ///
  /// In en, this message translates to:
  /// **'bottle'**
  String get unitSise;

  /// No description provided for @unitKavanoz.
  ///
  /// In en, this message translates to:
  /// **'jar'**
  String get unitKavanoz;

  /// No description provided for @unitDemet.
  ///
  /// In en, this message translates to:
  /// **'bunch'**
  String get unitDemet;

  /// No description provided for @unitDuzine.
  ///
  /// In en, this message translates to:
  /// **'dozen'**
  String get unitDuzine;

  /// No description provided for @unitMetre.
  ///
  /// In en, this message translates to:
  /// **'m'**
  String get unitMetre;

  /// No description provided for @unitCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get unitCustom;

  /// No description provided for @setReminderAction.
  ///
  /// In en, this message translates to:
  /// **'Set reminder'**
  String get setReminderAction;

  /// No description provided for @reminderPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Notification permission is needed for reminders. You can enable it in system settings.'**
  String get reminderPermissionDenied;

  /// No description provided for @reminderScheduled.
  ///
  /// In en, this message translates to:
  /// **'Reminder set.'**
  String get reminderScheduled;

  /// No description provided for @reminderCancelled.
  ///
  /// In en, this message translates to:
  /// **'Reminder removed.'**
  String get reminderCancelled;

  /// No description provided for @reminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping reminder'**
  String get reminderTitle;

  /// No description provided for @reminderBody.
  ///
  /// In en, this message translates to:
  /// **'Time to check your list: {title}'**
  String reminderBody(Object title);

  /// No description provided for @reminderPickDate.
  ///
  /// In en, this message translates to:
  /// **'Pick a date'**
  String get reminderPickDate;

  /// No description provided for @reminderPickTime.
  ///
  /// In en, this message translates to:
  /// **'Pick a time'**
  String get reminderPickTime;

  /// No description provided for @itemDetailsSection.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get itemDetailsSection;

  /// No description provided for @priceOptionalHint.
  ///
  /// In en, this message translates to:
  /// **'Optional — you\'ll enter the real price in the store'**
  String get priceOptionalHint;

  /// No description provided for @plannedTotalSummary.
  ///
  /// In en, this message translates to:
  /// **'Planned: {total} · {count} items'**
  String plannedTotalSummary(Object count, Object total);

  /// No description provided for @proActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Pro active — thank you!'**
  String get proActiveLabel;

  /// No description provided for @proBuyLabel.
  ///
  /// In en, this message translates to:
  /// **'NShoptor Pro'**
  String get proBuyLabel;

  /// No description provided for @proBenefitsLine.
  ///
  /// In en, this message translates to:
  /// **'No ads, more AI, backup · from a small monthly price'**
  String get proBenefitsLine;

  /// No description provided for @proBenefitNoAds.
  ///
  /// In en, this message translates to:
  /// **'Ad-free experience'**
  String get proBenefitNoAds;

  /// No description provided for @proBenefitBackup.
  ///
  /// In en, this message translates to:
  /// **'Backup (export/import)'**
  String get proBenefitBackup;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String aboutVersion(Object version);

  /// No description provided for @navDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get navDiscover;

  /// No description provided for @shareAction.
  ///
  /// In en, this message translates to:
  /// **'Share the app'**
  String get shareAction;

  /// No description provided for @rateAction.
  ///
  /// In en, this message translates to:
  /// **'Rate us'**
  String get rateAction;

  /// No description provided for @aboutOpenRow.
  ///
  /// In en, this message translates to:
  /// **'About & open source'**
  String get aboutOpenRow;

  /// No description provided for @voiceAddItemAction.
  ///
  /// In en, this message translates to:
  /// **'Add by voice'**
  String get voiceAddItemAction;

  /// No description provided for @formatLocaleLabel.
  ///
  /// In en, this message translates to:
  /// **'Number & currency format'**
  String get formatLocaleLabel;

  /// No description provided for @formatLocaleSystem.
  ///
  /// In en, this message translates to:
  /// **'Device format (Latin digits; otherwise English)'**
  String get formatLocaleSystem;

  /// No description provided for @formatLocaleTr.
  ///
  /// In en, this message translates to:
  /// **'Turkish (1.234,56)'**
  String get formatLocaleTr;

  /// No description provided for @formatLocaleEn.
  ///
  /// In en, this message translates to:
  /// **'English (1,234.56)'**
  String get formatLocaleEn;

  /// No description provided for @aiToggleTitle.
  ///
  /// In en, this message translates to:
  /// **'AI help'**
  String get aiToggleTitle;

  /// No description provided for @aiToggleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Matches receipts, reads price labels and turns sentences into lists. Photos and voice stay on your device; only text is processed.'**
  String get aiToggleSubtitle;

  /// No description provided for @aiQuotaReached.
  ///
  /// In en, this message translates to:
  /// **'You have used this month\'s AI requests ({used}/{limit}). Upgrade for more, or continue without AI.'**
  String aiQuotaReached(int used, int limit);

  /// No description provided for @aiOffline.
  ///
  /// In en, this message translates to:
  /// **'No connection — continuing without AI.'**
  String get aiOffline;

  /// No description provided for @aiFailed.
  ///
  /// In en, this message translates to:
  /// **'AI is unavailable right now — continuing without it.'**
  String get aiFailed;

  /// No description provided for @aiSourceLabel.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get aiSourceLabel;

  /// No description provided for @deviceSourceLabel.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get deviceSourceLabel;

  /// No description provided for @quickListAction.
  ///
  /// In en, this message translates to:
  /// **'Add from a sentence'**
  String get quickListAction;

  /// No description provided for @quickListTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick list'**
  String get quickListTitle;

  /// No description provided for @quickListHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 1 kg apples 20, 2 breads, half a kilo of cheese'**
  String get quickListHint;

  /// No description provided for @quickListConvert.
  ///
  /// In en, this message translates to:
  /// **'Turn into a list'**
  String get quickListConvert;

  /// No description provided for @quickListAdd.
  ///
  /// In en, this message translates to:
  /// **'Add {count} items'**
  String quickListAdd(int count);

  /// No description provided for @quickListEmpty.
  ///
  /// In en, this message translates to:
  /// **'No items found. Try listing them separated by commas.'**
  String get quickListEmpty;

  /// No description provided for @receiptAiMatched.
  ///
  /// In en, this message translates to:
  /// **'AI matched the receipt to your list. Check the links and confirm.'**
  String get receiptAiMatched;

  /// No description provided for @receiptNeedsCheck.
  ///
  /// In en, this message translates to:
  /// **'Check this match'**
  String get receiptNeedsCheck;

  /// No description provided for @receiptDiscountLine.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get receiptDiscountLine;

  /// No description provided for @compareItem.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get compareItem;

  /// No description provided for @compareEstimated.
  ///
  /// In en, this message translates to:
  /// **'Estimate'**
  String get compareEstimated;

  /// No description provided for @compareActual.
  ///
  /// In en, this message translates to:
  /// **'Actual'**
  String get compareActual;

  /// No description provided for @compareDiff.
  ///
  /// In en, this message translates to:
  /// **'Difference'**
  String get compareDiff;

  /// No description provided for @compareTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get compareTotal;

  /// No description provided for @compareBudget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get compareBudget;

  /// No description provided for @compareNotBought.
  ///
  /// In en, this message translates to:
  /// **'not bought'**
  String get compareNotBought;

  /// No description provided for @compareUnplanned.
  ///
  /// In en, this message translates to:
  /// **'not planned'**
  String get compareUnplanned;

  /// No description provided for @pricierItems.
  ///
  /// In en, this message translates to:
  /// **'Cost more'**
  String get pricierItems;

  /// No description provided for @cheaperItems.
  ///
  /// In en, this message translates to:
  /// **'Cost less'**
  String get cheaperItems;

  /// No description provided for @compareAction.
  ///
  /// In en, this message translates to:
  /// **'Compare'**
  String get compareAction;

  /// No description provided for @detailsSection.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get detailsSection;

  /// No description provided for @spendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Spending'**
  String get spendingTitle;

  /// No description provided for @spendingAction.
  ///
  /// In en, this message translates to:
  /// **'Spending'**
  String get spendingAction;

  /// No description provided for @spendingMonthTotal.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get spendingMonthTotal;

  /// No description provided for @spendingWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly spending'**
  String get spendingWeekly;

  /// No description provided for @spendingMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly spending'**
  String get spendingMonthly;

  /// No description provided for @monthlyLimitTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly limit'**
  String get monthlyLimitTitle;

  /// No description provided for @monthlyLimitHelp.
  ///
  /// In en, this message translates to:
  /// **'How much do you want to spend on shopping per month?'**
  String get monthlyLimitHelp;

  /// No description provided for @monthlyLimitRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get monthlyLimitRemove;

  /// No description provided for @monthlyLimitSet.
  ///
  /// In en, this message translates to:
  /// **'Set'**
  String get monthlyLimitSet;

  /// No description provided for @monthlyLimitChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get monthlyLimitChange;

  /// No description provided for @monthlyLimitNone.
  ///
  /// In en, this message translates to:
  /// **'Set a monthly limit to see how much you have left.'**
  String get monthlyLimitNone;

  /// No description provided for @monthlyLimitOver.
  ///
  /// In en, this message translates to:
  /// **'{amount} over the limit'**
  String monthlyLimitOver(String amount);

  /// No description provided for @monthlyLimitLeft.
  ///
  /// In en, this message translates to:
  /// **'{amount} left this month'**
  String monthlyLimitLeft(String amount);

  /// No description provided for @plansTitle.
  ///
  /// In en, this message translates to:
  /// **'Plans'**
  String get plansTitle;

  /// No description provided for @plansHeadline.
  ///
  /// In en, this message translates to:
  /// **'Shop smarter with AI'**
  String get plansHeadline;

  /// No description provided for @plansSubhead.
  ///
  /// In en, this message translates to:
  /// **'Receipt matching, price labels and lists from a sentence. Cancel any time.'**
  String get plansSubhead;

  /// No description provided for @plansMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get plansMonthly;

  /// No description provided for @plansYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get plansYearly;

  /// No description provided for @planFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get planFree;

  /// No description provided for @planFreePrice.
  ///
  /// In en, this message translates to:
  /// **'Free forever'**
  String get planFreePrice;

  /// No description provided for @planFreeAi.
  ///
  /// In en, this message translates to:
  /// **'10 AI requests a month'**
  String get planFreeAi;

  /// No description provided for @planFreeAds.
  ///
  /// In en, this message translates to:
  /// **'Small banner ads (none in your first 7 days)'**
  String get planFreeAds;

  /// No description provided for @planCoreFeatures.
  ///
  /// In en, this message translates to:
  /// **'Lists, prices, receipts, spending charts'**
  String get planCoreFeatures;

  /// No description provided for @plansPerYear.
  ///
  /// In en, this message translates to:
  /// **'/ year'**
  String get plansPerYear;

  /// No description provided for @plansPerMonth.
  ///
  /// In en, this message translates to:
  /// **'/ month'**
  String get plansPerMonth;

  /// No description provided for @planTrial.
  ///
  /// In en, this message translates to:
  /// **'7 days free'**
  String get planTrial;

  /// No description provided for @planProAi.
  ///
  /// In en, this message translates to:
  /// **'100 AI requests a month'**
  String get planProAi;

  /// No description provided for @planNoAds.
  ///
  /// In en, this message translates to:
  /// **'No ads'**
  String get planNoAds;

  /// No description provided for @planBackup.
  ///
  /// In en, this message translates to:
  /// **'Backup export and import'**
  String get planBackup;

  /// No description provided for @planMaxAi.
  ///
  /// In en, this message translates to:
  /// **'300 AI requests a month'**
  String get planMaxAi;

  /// No description provided for @planMaxFamily.
  ///
  /// In en, this message translates to:
  /// **'For big family shopping'**
  String get planMaxFamily;

  /// No description provided for @plansStoreUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The store is not reachable right now.'**
  String get plansStoreUnavailable;

  /// No description provided for @retryAction.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryAction;

  /// No description provided for @plansPurchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'The purchase did not go through. Please try again.'**
  String get plansPurchaseFailed;

  /// No description provided for @planLifetimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Ad-free for life'**
  String get planLifetimeTitle;

  /// No description provided for @planLifetimeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'One-time payment: no ads, backup; AI stays on the free allowance'**
  String get planLifetimeSubtitle;

  /// No description provided for @plansRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get plansRestore;

  /// No description provided for @plansLegal.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions renew automatically until cancelled. Cancel any time in Google Play › Payments & subscriptions. Prices include the taxes shown by Google Play.'**
  String get plansLegal;

  /// No description provided for @planCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get planCurrent;

  /// No description provided for @planStartTrial.
  ///
  /// In en, this message translates to:
  /// **'Start 7-day free trial'**
  String get planStartTrial;

  /// No description provided for @planChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get planChoose;

  /// No description provided for @plansAction.
  ///
  /// In en, this message translates to:
  /// **'Plans: Pro and Max'**
  String get plansAction;

  /// No description provided for @assistantTitle.
  ///
  /// In en, this message translates to:
  /// **'Assistant'**
  String get assistantTitle;

  /// No description provided for @assistantGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi! What would you like to do?'**
  String get assistantGreeting;

  /// No description provided for @assistantNewList.
  ///
  /// In en, this message translates to:
  /// **'New list'**
  String get assistantNewList;

  /// No description provided for @assistantVoiceList.
  ///
  /// In en, this message translates to:
  /// **'List by voice'**
  String get assistantVoiceList;

  /// No description provided for @assistantTextList.
  ///
  /// In en, this message translates to:
  /// **'List from a sentence'**
  String get assistantTextList;

  /// No description provided for @assistantScanReceipt.
  ///
  /// In en, this message translates to:
  /// **'Scan a receipt'**
  String get assistantScanReceipt;

  /// No description provided for @assistantSpending.
  ///
  /// In en, this message translates to:
  /// **'My spending'**
  String get assistantSpending;

  /// No description provided for @assistantReceiptHint.
  ///
  /// In en, this message translates to:
  /// **'Open your list and tap the receipt icon to scan it.'**
  String get assistantReceiptHint;

  /// No description provided for @assistantToggleTitle.
  ///
  /// In en, this message translates to:
  /// **'Show assistant'**
  String get assistantToggleTitle;

  /// No description provided for @assistantToggleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The little helper at the bottom right'**
  String get assistantToggleSubtitle;

  /// No description provided for @scanPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Scan price label'**
  String get scanPriceLabel;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save. Your changes are still here. Please try again.'**
  String get saveFailed;

  /// No description provided for @deleteItemConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this item and its recorded purchases?'**
  String get deleteItemConfirm;

  /// No description provided for @clearPurchaseConfirm.
  ///
  /// In en, this message translates to:
  /// **'Uncheck this item and remove its recorded purchases?'**
  String get clearPurchaseConfirm;

  /// No description provided for @reportPdfAction.
  ///
  /// In en, this message translates to:
  /// **'Save PDF report'**
  String get reportPdfAction;

  /// No description provided for @reportNotInvoice.
  ///
  /// In en, this message translates to:
  /// **'Shopping summary, not a tax invoice. Tax rates are unknown.'**
  String get reportNotInvoice;

  /// No description provided for @purchaseVisits.
  ///
  /// In en, this message translates to:
  /// **'Shopping visits'**
  String get purchaseVisits;

  /// No description provided for @purchaseInterval.
  ///
  /// In en, this message translates to:
  /// **'Average days between purchases'**
  String get purchaseInterval;

  /// No description provided for @purchasedQuantity.
  ///
  /// In en, this message translates to:
  /// **'Purchased quantity'**
  String get purchasedQuantity;

  /// No description provided for @purchaseAnalyticsHint.
  ///
  /// In en, this message translates to:
  /// **'Purchases do not measure consumption. Currencies and units are shown separately.'**
  String get purchaseAnalyticsHint;

  /// No description provided for @receiptReplaces.
  ///
  /// In en, this message translates to:
  /// **'Linked receipt lines replace existing purchases; unlinked lines are added.'**
  String get receiptReplaces;

  /// No description provided for @voiceUnsupportedLanguage.
  ///
  /// In en, this message translates to:
  /// **'This language is not available for voice input on this device. You can type instead.'**
  String get voiceUnsupportedLanguage;

  /// No description provided for @voiceStopListening.
  ///
  /// In en, this message translates to:
  /// **'Stop listening'**
  String get voiceStopListening;

  /// No description provided for @keepAwakeFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not keep the screen awake. Please try again.'**
  String get keepAwakeFailed;

  /// No description provided for @purchaseHistoryHint.
  ///
  /// In en, this message translates to:
  /// **'All completed shopping. Returns reduce totals. Dates refer to shopping completion. One visit is not enough to calculate an average interval.'**
  String get purchaseHistoryHint;

  /// No description provided for @planLegacyRights.
  ///
  /// In en, this message translates to:
  /// **'Existing Pro and Max subscriptions keep their original monthly AI allowance. New offers have 100 and 300 requests.'**
  String get planLegacyRights;

  /// No description provided for @csvExportAction.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get csvExportAction;

  /// No description provided for @backupSizeWarning.
  ///
  /// In en, this message translates to:
  /// **'JSON includes records, not photo files. Import limit: 16 MB.'**
  String get backupSizeWarning;

  /// No description provided for @backupImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not import this backup. Your data was not changed.'**
  String get backupImportFailed;

  /// No description provided for @backupImported.
  ///
  /// In en, this message translates to:
  /// **'Backup imported successfully.'**
  String get backupImported;

  /// No description provided for @backupPreviewCounts.
  ///
  /// In en, this message translates to:
  /// **'{lists} lists · {items} items · {entries} purchases'**
  String backupPreviewCounts(Object entries, Object items, Object lists);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'af',
    'ar',
    'az',
    'be',
    'bg',
    'bn',
    'bs',
    'ca',
    'cs',
    'da',
    'de',
    'el',
    'en',
    'es',
    'et',
    'eu',
    'fa',
    'fi',
    'fil',
    'fr',
    'gl',
    'gu',
    'he',
    'hi',
    'hr',
    'hu',
    'hy',
    'id',
    'is',
    'it',
    'ja',
    'ka',
    'kk',
    'kn',
    'ko',
    'ky',
    'lo',
    'lt',
    'lv',
    'mk',
    'ml',
    'mn',
    'mr',
    'ms',
    'my',
    'ne',
    'nl',
    'pa',
    'pl',
    'ps',
    'pt',
    'ro',
    'ru',
    'si',
    'sk',
    'sl',
    'sq',
    'sr',
    'sv',
    'sw',
    'ta',
    'te',
    'th',
    'tl',
    'tr',
    'uk',
    'ur',
    'uz',
    'vi',
    'zh',
    'zu',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return AppLocalizationsAf();
    case 'ar':
      return AppLocalizationsAr();
    case 'az':
      return AppLocalizationsAz();
    case 'be':
      return AppLocalizationsBe();
    case 'bg':
      return AppLocalizationsBg();
    case 'bn':
      return AppLocalizationsBn();
    case 'bs':
      return AppLocalizationsBs();
    case 'ca':
      return AppLocalizationsCa();
    case 'cs':
      return AppLocalizationsCs();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'et':
      return AppLocalizationsEt();
    case 'eu':
      return AppLocalizationsEu();
    case 'fa':
      return AppLocalizationsFa();
    case 'fi':
      return AppLocalizationsFi();
    case 'fil':
      return AppLocalizationsFil();
    case 'fr':
      return AppLocalizationsFr();
    case 'gl':
      return AppLocalizationsGl();
    case 'gu':
      return AppLocalizationsGu();
    case 'he':
      return AppLocalizationsHe();
    case 'hi':
      return AppLocalizationsHi();
    case 'hr':
      return AppLocalizationsHr();
    case 'hu':
      return AppLocalizationsHu();
    case 'hy':
      return AppLocalizationsHy();
    case 'id':
      return AppLocalizationsId();
    case 'is':
      return AppLocalizationsIs();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ka':
      return AppLocalizationsKa();
    case 'kk':
      return AppLocalizationsKk();
    case 'kn':
      return AppLocalizationsKn();
    case 'ko':
      return AppLocalizationsKo();
    case 'ky':
      return AppLocalizationsKy();
    case 'lo':
      return AppLocalizationsLo();
    case 'lt':
      return AppLocalizationsLt();
    case 'lv':
      return AppLocalizationsLv();
    case 'mk':
      return AppLocalizationsMk();
    case 'ml':
      return AppLocalizationsMl();
    case 'mn':
      return AppLocalizationsMn();
    case 'mr':
      return AppLocalizationsMr();
    case 'ms':
      return AppLocalizationsMs();
    case 'my':
      return AppLocalizationsMy();
    case 'ne':
      return AppLocalizationsNe();
    case 'nl':
      return AppLocalizationsNl();
    case 'pa':
      return AppLocalizationsPa();
    case 'pl':
      return AppLocalizationsPl();
    case 'ps':
      return AppLocalizationsPs();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'si':
      return AppLocalizationsSi();
    case 'sk':
      return AppLocalizationsSk();
    case 'sl':
      return AppLocalizationsSl();
    case 'sq':
      return AppLocalizationsSq();
    case 'sr':
      return AppLocalizationsSr();
    case 'sv':
      return AppLocalizationsSv();
    case 'sw':
      return AppLocalizationsSw();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
    case 'th':
      return AppLocalizationsTh();
    case 'tl':
      return AppLocalizationsTl();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'ur':
      return AppLocalizationsUr();
    case 'uz':
      return AppLocalizationsUz();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
    case 'zu':
      return AppLocalizationsZu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
