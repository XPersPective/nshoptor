// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Plan at home. Shop as planned.';

  @override
  String get listsTitle => 'Lists';

  @override
  String get listsTabActive => 'Active';

  @override
  String get listsTabCompleted => 'Completed';

  @override
  String get listsTabArchived => 'Archived';

  @override
  String get newListButton => 'New list';

  @override
  String get listTitleHint => 'Title (optional)';

  @override
  String get saveButton => 'Save';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get deleteButton => 'Delete';

  @override
  String get editAction => 'Edit';

  @override
  String get listDeleted => 'List deleted';

  @override
  String get invalidAmountError => 'Invalid amount';

  @override
  String get duplicateAction => 'Duplicate';

  @override
  String get archiveAction => 'Archive';

  @override
  String get unarchiveAction => 'Unarchive';

  @override
  String get deleteListConfirm =>
      'Delete this list? Its planned items will also be removed.';

  @override
  String get undoButton => 'Undo';

  @override
  String get searchListHint => 'Search lists';

  @override
  String get currencyLabel => 'Currency';

  @override
  String get budgetLabel => 'Budget (optional)';

  @override
  String get noteLabel => 'Note (optional)';

  @override
  String get storeLabel => 'Store';

  @override
  String get keepAmountsAction => 'Keep amounts';

  @override
  String get resetAmountsAction => 'Reset amounts';

  @override
  String get currencyChangeWarning =>
      'The currency is changing. What should happen to the existing amounts?';

  @override
  String get listsEmpty => 'No lists yet. Create your first shopping plan.';

  @override
  String get statusDraft => 'Draft';

  @override
  String get statusPlanned => 'Planned';

  @override
  String get statusShopping => 'Shopping';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusArchived => 'Archived';

  @override
  String autoListTitle(String date) {
    return '$date shopping';
  }

  @override
  String get itemFormTitle => 'Add item';

  @override
  String get itemNameLabel => 'Item name';

  @override
  String get brandLabel => 'Brand / variant (optional)';

  @override
  String get categoryLabel => 'Category';

  @override
  String get quantityLabel => 'Quantity';

  @override
  String get unitLabel => 'Unit';

  @override
  String get pricingModeLabel => 'Price entry';

  @override
  String get pricingModeUnitPrice => 'Unit price';

  @override
  String get pricingModeLineTotal => 'Line total';

  @override
  String get plannedPriceLabel => 'Planned price';

  @override
  String lineTotalCalculated(String value) {
    return 'Line total: $value';
  }

  @override
  String get requiredItemToggle => 'Required item';

  @override
  String get maxPriceLabel => 'Maximum acceptable price (optional)';

  @override
  String get itemNoteLabel => 'Note (optional)';

  @override
  String get categoryProduce => 'Fruit & vegetables';

  @override
  String get categoryDairy => 'Dairy';

  @override
  String get categoryMeat => 'Meat';

  @override
  String get categoryBakery => 'Bakery';

  @override
  String get categoryDrinks => 'Drinks';

  @override
  String get categoryCleaning => 'Cleaning';

  @override
  String get categoryPersonalCare => 'Personal care';

  @override
  String get categoryHome => 'Home';

  @override
  String get categoryOther => 'Other';

  @override
  String get invalidQuantityError => 'Invalid quantity';

  @override
  String get invalidPriceError => 'Invalid price';

  @override
  String get invalidNameError => 'Enter a name';

  @override
  String unitPriceCalculated(String value) {
    return 'Unit price: $value';
  }

  @override
  String get shoppingTitle => 'Shopping mode';

  @override
  String get summaryPlannedTotal => 'Planned';

  @override
  String get summaryInCart => 'In cart';

  @override
  String get summaryRemainingPlan => 'Remaining plan';

  @override
  String get summaryProjected => 'Estimated checkout';

  @override
  String get summaryBudgetRemaining => 'Budget left';

  @override
  String get summaryBudgetOver => 'Over budget';

  @override
  String itemsProgress(String done, String total) {
    return '$done of $total items';
  }

  @override
  String get filterAll => 'All';

  @override
  String get filterToBuy => 'To buy';

  @override
  String get filterInCart => 'In cart';

  @override
  String get filterNotFound => 'Not found';

  @override
  String get filterRequired => 'Required';

  @override
  String get quickEntryTitle => 'Actual price';

  @override
  String get actualQuantityLabel => 'Actual quantity';

  @override
  String get actualPriceLabel => 'Actual price';

  @override
  String get discountLabel => 'Discount (optional)';

  @override
  String get alternativeNameLabel => 'Alternative product name (optional)';

  @override
  String get savePurchaseButton => 'Add to cart';

  @override
  String get unplannedAddButton => 'Add unplanned item';

  @override
  String get statusPending => 'Not taken';

  @override
  String get statusInCart => 'In cart';

  @override
  String get statusNotFound => 'Not found';

  @override
  String get statusGaveUp => 'Gave up';

  @override
  String get statusAlternative => 'Alternative bought';

  @override
  String get keepScreenAwake => 'Keep screen on';

  @override
  String get finishShopping => 'Finish shopping';

  @override
  String get completionWarning =>
      'There are missing or unverified records. You can still finish; the result will note them.';

  @override
  String get continueShoppingButton => 'Keep shopping';

  @override
  String get resultTitle => 'Result';

  @override
  String get summarySection => 'Summary';

  @override
  String get plannedTotalLabel => 'Planned total';

  @override
  String get actualTotalLabel => 'Actual total';

  @override
  String get varianceLabel => 'Difference';

  @override
  String get varianceNotComputable => 'Cannot be computed';

  @override
  String get budgetStatusLabel => 'Budget';

  @override
  String get savingsLabel => 'Under plan';

  @override
  String get overspendLabel => 'Over plan';

  @override
  String get unplannedTotalLabel => 'Unplanned total';

  @override
  String get unpurchasedLabel => 'Planned but not bought';

  @override
  String get totalDiscountLabel => 'Total discounts';

  @override
  String get accuracyLabel => 'Estimate accuracy';

  @override
  String get groupsSection => 'Items';

  @override
  String get groupPricier => 'Pricier than planned';

  @override
  String get groupCheaper => 'Cheaper than planned';

  @override
  String get groupClose => 'Close to estimate';

  @override
  String get groupNotTaken => 'Planned, not bought';

  @override
  String get groupUnplanned => 'Bought without plan';

  @override
  String get groupQuantityChanged => 'Quantity changed';

  @override
  String get groupUnverified => 'Not verified';

  @override
  String get plannedQtyLabel => 'Planned quantity';

  @override
  String get actualQtyLabel => 'Actual quantity';

  @override
  String get plannedUnitPriceLabel => 'Planned unit price';

  @override
  String get actualUnitPriceLabel => 'Actual unit price';

  @override
  String get lineVarianceLabel => 'Line difference';

  @override
  String get discountEffectLabel => 'Discount effect';

  @override
  String get notBoughtMark => 'not bought';

  @override
  String get noPurchasesNote => 'No purchases were recorded.';

  @override
  String get navHome => 'Home';

  @override
  String get navLists => 'Lists';

  @override
  String get navHistory => 'History';

  @override
  String get navSettings => 'Settings';

  @override
  String get homeEmptyTitle => 'Plan your shopping';

  @override
  String get homeEmptyBody =>
      'Create your first list and compare planned vs actual costs.';

  @override
  String get homeActiveSection => 'Active lists';

  @override
  String get homeCompletedSection => 'Recently completed';

  @override
  String get homeMonthlySection => 'This month';

  @override
  String get monthPlannedLabel => 'Planned';

  @override
  String get monthActualLabel => 'Actual';

  @override
  String get monthVarianceLabel => 'Difference';

  @override
  String get continueShoppingLabel => 'Continue shopping';

  @override
  String get historyEmpty =>
      'No completed shopping yet. Your history and insights will appear here.';

  @override
  String get aboutTabTitle => 'About NShoptor';

  @override
  String get aboutBody =>
      'NShoptor by Crazy Penguin. Offline-first shopping planner. Licensed under GPL-3.0.';

  @override
  String get startShoppingLabel => 'Start shopping';

  @override
  String get finishAndSeeResult => 'Finish & see result';
}
