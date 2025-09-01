// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navTabHome => 'Home';

  @override
  String get navTabSettings => 'Settings';

  @override
  String get navTabHistory => 'History';

  @override
  String get navTabStats => 'Stats';

  @override
  String get homeTitle => 'Dukoin';

  @override
  String homeSubtitle(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMEEEEd(
      localeName,
    );
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String get homeTimePeriodDay => 'Day';

  @override
  String get homeTimePeriodWeek => 'Week';

  @override
  String get homeTimePeriodMonth => 'Month';

  @override
  String get homeTimePeriodAll => 'All';

  @override
  String get homeTodayTotalTitle => 'Today\'s Total';

  @override
  String get homeWeekTotalTitle => 'This Week\'s Total';

  @override
  String get homeMonthTotalTitle => 'This Month\'s Total';

  @override
  String get homeAllTotalTitle => 'All Time Total';

  @override
  String homeTransactionsCounterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transactions',
      one: '$count transaction',
      zero: 'No transactions',
    );
    return '$_temp0';
  }

  @override
  String get homeLastExpensesTitle => 'Last Expenses';

  @override
  String get homeNoExpensesTitle => 'You have no expenses yet';

  @override
  String get homeNoExpensesSubtitle =>
      'Tap the + button to add your first expense';

  @override
  String get homeLastExpensesSeeAll => 'See all';

  @override
  String get historyTitle => 'My Expenses';

  @override
  String get statsPageTitle => 'Statistics';

  @override
  String get statsPageSubtitle => 'Your spending insights and analytics';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSubtitle => 'Manage your preferences';

  @override
  String get settingsDarkThemeTitle => 'Dark Theme';

  @override
  String get settingsDarkThemeSubtitle =>
      'Switch between light and dark appearance';

  @override
  String get settingsDefaultCurrencyTitle => 'Default Currency';

  @override
  String get settingsDefaultCurrencySubtitle =>
      'Choose your preferred currency';

  @override
  String get settingsDailyReminderTitle => 'Daily Reminder';

  @override
  String get settingsDailyReminderSubtitle => 'Get remainded to track expenses';

  @override
  String get settingsDataManagementTitle => 'Data Management';

  @override
  String get settingsDataManagementSubtitle => 'Manage your expense data';

  @override
  String get settingsDataManagementButton => 'Clear All Data';

  @override
  String settingsApplicationInfoVersion(String version) {
    return 'Version $version';
  }

  @override
  String get settingsApplicationInfoMessage =>
      'Made with ❤️ for simple expense tracking';

  @override
  String get addExpenseTitle => 'Add Expense';

  @override
  String addExpenseAmountTitle(String currency) {
    return 'Amount ($currency)';
  }

  @override
  String addExpenseAmountHint(double value) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 2,
        );
    final String valueString = valueNumberFormat.format(value);

    return '$valueString';
  }

  @override
  String get addExpenseDescriptionTitle => 'Description';

  @override
  String get addExpenseDescriptionHint => 'What did you spend on?';

  @override
  String get addExpenseCategoryTitle => 'Category';

  @override
  String get addExpenseCategoryHint => 'Select a category';

  @override
  String get addExpenseDateTitle => 'Date';

  @override
  String addExpenseDateValue(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String get addExpenseSubmitButtonTitle => 'Save Expense';

  @override
  String get categoryFood => 'Food';

  @override
  String get categoryTransport => 'Transport';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categoryEntertainment => 'Entertainment';

  @override
  String get categoryBills => 'Bills';

  @override
  String get categoryHealth => 'Health & Wellness';

  @override
  String get categoryEducation => 'Education';

  @override
  String get categoryOthers => 'Others';

  @override
  String get categoryTravel => 'Travel';

  @override
  String get categoryInvestments => 'Investments';

  @override
  String get categoryHouse => 'House';

  @override
  String get currencyUSD => 'US Dollar';

  @override
  String get currencyEUR => 'Euro';

  @override
  String get currencyGBP => 'British Pound';

  @override
  String get currencyJPY => 'Japanese Yen';

  @override
  String get currencyCAD => 'Canadian Dollar';

  @override
  String get currencyAUD => 'Australian Dollar';

  @override
  String get clearAllDataDialogTitle => 'Clear All Data';

  @override
  String get clearAllDataDialogMessage =>
      'This action cannot be undone. This will permanently delete all your expense data.';

  @override
  String get clearAllDataDialogButtonTitle => 'Clear All Data';

  @override
  String get clearAllDataDialogCancelButton => 'Cancel';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get categoryFilterTitle => 'Filter Categories';

  @override
  String get categoryFilterSubtitle =>
      'Select categories to include in your statistics';

  @override
  String get categoryFilterButtonTitle => 'Apply Filters';

  @override
  String categoryFilterCounter(int min, int max) {
    return '$min of $max';
  }

  @override
  String get clearAll => 'Clear all';

  @override
  String get selectAll => 'Select all';

  @override
  String get statsMonthOverViewTotal => 'Total Expenses';

  @override
  String get statsMonthOverViewDailyAvg => 'Daily average';

  @override
  String get statsMonthOverViewWeeklyAvg => 'Weekly average';
}
