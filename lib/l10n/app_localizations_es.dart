// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get navTabHome => 'Inicio';

  @override
  String get navTabSettings => 'Ajustes';

  @override
  String get navTabHistory => 'Historial';

  @override
  String get navTabStats => 'Gráficos';

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
  String get homeTimePeriodDay => 'Día';

  @override
  String get homeTimePeriodWeek => 'Semana';

  @override
  String get homeTimePeriodMonth => 'Mes';

  @override
  String get homeTimePeriodAll => 'Todo';

  @override
  String get homeTodayTotalTitle => 'Total de hoy';

  @override
  String get homeWeekTotalTitle => 'Total de la semana';

  @override
  String get homeMonthTotalTitle => 'Total del mes';

  @override
  String get homeAllTotalTitle => 'Total acumulado';

  @override
  String homeTransactionsCounterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transacciones',
      one: '$count transacción',
      zero: 'Sin transacciones',
    );
    return '$_temp0';
  }

  @override
  String get homeLastExpensesTitle => 'Últimos gastos';

  @override
  String get homeNoExpensesTitle => 'Aún no tienes gastos';

  @override
  String get homeNoExpensesSubtitle =>
      'Pulsa el botón + para añadir tu primer gasto';

  @override
  String get homeLastExpensesSeeAll => 'Ver todos';

  @override
  String get historyTitle => 'Mis gastos';

  @override
  String get statsPageTitle => 'Estadísticas';

  @override
  String get statsPageSubtitle => 'Tus análisis y visión de gastos';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsSubtitle => 'Gestiona tus preferencias';

  @override
  String get settingsDarkThemeTitle => 'Tema oscuro';

  @override
  String get settingsDarkThemeSubtitle =>
      'Alterna entre apariencia clara y oscura';

  @override
  String get settingsDefaultCurrencyTitle => 'Moneda predeterminada';

  @override
  String get settingsDefaultCurrencySubtitle => 'Elige tu moneda preferida';

  @override
  String get settingsDailyReminderTitle => 'Recordatorio diario';

  @override
  String get settingsDailyReminderSubtitle =>
      'Recibe un aviso para registrar tus gastos';

  @override
  String get settingsDataManagementTitle => 'Gestión de datos';

  @override
  String get settingsDataManagementSubtitle => 'Gestiona tus datos de gastos';

  @override
  String get settingsDataManagementButton => 'Borrar todos los datos';

  @override
  String settingsApplicationInfoVersion(String version) {
    return 'Versión $version';
  }

  @override
  String get settingsApplicationInfoMessage =>
      'Hecho con ❤️ para un seguimiento sencillo de gastos';

  @override
  String get addExpenseTitle => 'Añadir gasto';

  @override
  String addExpenseAmountTitle(String currency) {
    return 'Cantidad ($currency)';
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
  String get addExpenseDescriptionHint => '¿En qué gastaste?';

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
  String get categoryTravel => 'Viajes';

  @override
  String get categoryInvestments => 'Inversiones';

  @override
  String get categoryHouse => 'Hogar';

  @override
  String get currencyUSD => 'Dólar estadounidense';

  @override
  String get currencyEUR => 'Euro';

  @override
  String get currencyGBP => 'Libra esterlina';

  @override
  String get currencyJPY => 'Yen japonés';

  @override
  String get currencyCAD => 'Dólar canadiense';

  @override
  String get currencyAUD => 'Dólar australiano';

  @override
  String get clearAllDataDialogTitle => 'Borrar todos los datos';

  @override
  String get clearAllDataDialogMessage =>
      'Esta acción no se puede deshacer. Esto eliminará permanentemente todos tus datos de gastos.';

  @override
  String get clearAllDataDialogButtonTitle => 'Borrar todos los datos';

  @override
  String get clearAllDataDialogCancelButton => 'Cancelar';

  @override
  String get today => 'Hoy';

  @override
  String get yesterday => 'Ayer';

  @override
  String get categoryFilterTitle => 'Filtrar categorías';

  @override
  String get categoryFilterSubtitle =>
      'Selecciona categorías para incluir en tus estadísticas';

  @override
  String get categoryFilterButtonTitle => 'Aplicar filtros';

  @override
  String categoryFilterCounter(int min, int max) {
    return '$min de $max';
  }

  @override
  String get clearAll => 'Borrar todo';

  @override
  String get selectAll => 'Seleccionar todo';

  @override
  String get statsMonthOverViewTotal => 'Gastos totales';

  @override
  String get statsMonthOverViewDailyAvg => 'Media diaria';

  @override
  String get statsMonthOverViewWeeklyAvg => 'Media semanal';

  @override
  String get statsCategoryBreakdownTitle => 'Desglose por categoría';

  @override
  String get statsMonthEvolutionTitle => 'Evolución mensual';

  @override
  String statsTopFiveTitle(int count) {
    return 'Top $count este mes';
  }

  @override
  String get statsMostFrequentCategoriesTitle => 'Más frecuentes';

  @override
  String get statsAverageText => 'Promedio';

  @override
  String get statsNoData => 'No hay datos disponibles';

  @override
  String get expense => 'Expense';

  @override
  String get income => 'Income';
}
