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
