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
}
