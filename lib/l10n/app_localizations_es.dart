// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get navTabHome => 'Home';

  @override
  String get navTabSettings => 'Settings';

  @override
  String get navTabHistory => 'History';

  @override
  String get navTabStats => 'Stats';

  @override
  String get homeTitle => 'Gastos diarios';

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
  String get settingsTitle => 'Ajustes';

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
  String get addExpenseTitle => 'Añadir gasto';

  @override
  String addExpenseAmountTitle(String currency) {
    return 'Importe ($currency)';
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
  String get addExpenseDescriptionTitle => 'Descripción';

  @override
  String get addExpenseDescriptionHint => '¿En qué has gastado?';

  @override
  String get addExpenseCategoryTitle => 'Categoría';

  @override
  String get addExpenseCategoryHint => 'Selecciona una categoría';

  @override
  String get addExpenseDateTitle => 'Fecha';

  @override
  String addExpenseDateValue(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String get addExpenseSubmitButtonTitle => 'Guardar gasto';

  @override
  String get categoryFood => 'Comida';

  @override
  String get categoryTransport => 'Transporte';

  @override
  String get categoryShopping => 'Compras';

  @override
  String get categoryEntertainment => 'Entretenimiento';

  @override
  String get categoryBills => 'Facturas';

  @override
  String get categoryHealth => 'Salud';

  @override
  String get categoryEducation => 'Educación';

  @override
  String get categoryOthers => 'Otros';

  @override
  String get categoryTravel => 'Travel';

  @override
  String get categoryInvestments => 'Investments';

  @override
  String get categoryInsurance => 'Insurance';

  @override
  String get categorySubscriptions => 'Subscriptions';

  @override
  String get categoryPets => 'Pets';

  @override
  String get categoryPersonalCare => 'Personal care';

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
}
