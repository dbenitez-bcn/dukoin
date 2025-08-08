// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navTab1 => 'Home';

  @override
  String get navTab2 => 'Settings';

  @override
  String get homeTitle => 'Daily Expenses';

  @override
  String homeSubtitle(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMEEEEd(
      localeName,
    );
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String get homeTodayTotalTitle => 'Today\'s Total';

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
  String get categoryHealth => 'Health';

  @override
  String get categoryEducation => 'Education';

  @override
  String get categoryOthers => 'Others';

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
}
