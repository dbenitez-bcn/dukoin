// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get navTab1 => 'Inicio';

  @override
  String get navTab2 => 'Ajustes';

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
  String get homeTodayTotalTitle => 'Today\'s Total';

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
}
