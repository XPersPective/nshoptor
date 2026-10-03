import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

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
    Locale('en'),
    Locale('tr'),
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

  /// No description provided for @backupSizeWarning.
  ///
  /// In en, this message translates to:
  /// **'Large backup: the file may be big. Do you want to include photos too?'**
  String get backupSizeWarning;

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
  /// **'NShoptor runs offline-first. Receipts and photos stay on your device by default and are never sent to the internet.'**
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
  /// **'Ad-free + backup · one-time payment, no subscription'**
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
  /// **'System (follows app language)'**
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
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
