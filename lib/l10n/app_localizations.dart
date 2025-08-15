import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('es'),
  ];

  /// Label for the Home tab in the bottom navigation bar
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navTabHome;

  /// Label for the Settings tab in the bottom navigation bar
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navTabSettings;

  /// Label for the History tab in the bottom navigation bar
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navTabHistory;

  /// Title displayed on the Home screen
  ///
  /// In en, this message translates to:
  /// **'Weekly Expenses'**
  String get homeTitle;

  /// Displays today's date
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String homeSubtitle(DateTime date);

  /// Title for Time Period day
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get homeTimePeriodDay;

  /// Title for Time Period week
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get homeTimePeriodWeek;

  /// Title for Time Period month
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get homeTimePeriodMonth;

  /// Title for Time Period all
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get homeTimePeriodAll;

  /// Title displayed on today's total amount
  ///
  /// In en, this message translates to:
  /// **'Today\'s Total'**
  String get homeTodayTotalTitle;

  /// Title displayed on week's total amount
  ///
  /// In en, this message translates to:
  /// **'This Week\'s Total'**
  String get homeWeekTotalTitle;

  /// Title displayed on month's total amount
  ///
  /// In en, this message translates to:
  /// **'This Month\'s Total'**
  String get homeMonthTotalTitle;

  /// Title displayed on all's total amount
  ///
  /// In en, this message translates to:
  /// **'All Time Total'**
  String get homeAllTotalTitle;

  /// Title showing number of transactions on Home screen (zero, singular, plural)
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0 {No transactions} one {{count} transaction} other {{count} transactions}}'**
  String homeTransactionsCounterTitle(int count);

  /// Title displayed on last expenses
  ///
  /// In en, this message translates to:
  /// **'Last Expenses'**
  String get homeLastExpensesTitle;

  /// Title displayed when no expenses are found
  ///
  /// In en, this message translates to:
  /// **'You have no expenses yet'**
  String get homeNoExpensesTitle;

  /// Subtitle displayed when no expenses are found
  ///
  /// In en, this message translates to:
  /// **'Tap the + button to add your first expense'**
  String get homeNoExpensesSubtitle;

  /// Title displayed on see all button
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get homeLastExpensesSeeAll;

  /// Title displayed on the Settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Subtitle displayed on the Settings screen
  ///
  /// In en, this message translates to:
  /// **'Manage your preferences'**
  String get settingsSubtitle;

  /// Title for theme toggle card
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get settingsDarkThemeTitle;

  /// Subtitle for theme toggle card
  ///
  /// In en, this message translates to:
  /// **'Switch between light and dark appearance'**
  String get settingsDarkThemeSubtitle;

  /// Title for currency selector card
  ///
  /// In en, this message translates to:
  /// **'Default Currency'**
  String get settingsDefaultCurrencyTitle;

  /// Subtitle for currency selector card
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred currency'**
  String get settingsDefaultCurrencySubtitle;

  /// Title for daily reminder setting
  ///
  /// In en, this message translates to:
  /// **'Daily Reminder'**
  String get settingsDailyReminderTitle;

  /// Subtitle for daily reminder setting
  ///
  /// In en, this message translates to:
  /// **'Get remainded to track expenses'**
  String get settingsDailyReminderSubtitle;

  /// Title for data management setting
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get settingsDataManagementTitle;

  /// Subtitle for data management setting
  ///
  /// In en, this message translates to:
  /// **'Manage your expense data'**
  String get settingsDataManagementSubtitle;

  /// Button title to clear all expense data
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get settingsDataManagementButton;

  /// Displays application version number
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String settingsApplicationInfoVersion(String version);

  /// Displays application message
  ///
  /// In en, this message translates to:
  /// **'Made with ❤️ for simple expense tracking'**
  String get settingsApplicationInfoMessage;

  /// Title for the screen where the user adds a new expense
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get addExpenseTitle;

  /// Label for the amount input field, showing the currency as a placeholder
  ///
  /// In en, this message translates to:
  /// **'Amount ({currency})'**
  String addExpenseAmountTitle(String currency);

  /// Hint text shown inside the amount input field
  ///
  /// In en, this message translates to:
  /// **'{value}'**
  String addExpenseAmountHint(double value);

  /// Label for the description input field when adding a new expense
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get addExpenseDescriptionTitle;

  /// Hint text shown inside the description input field
  ///
  /// In en, this message translates to:
  /// **'What did you spend on?'**
  String get addExpenseDescriptionHint;

  /// Label for the category selection when adding a new expense
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get addExpenseCategoryTitle;

  /// Hint text prompting the user to select a category
  ///
  /// In en, this message translates to:
  /// **'Select a category'**
  String get addExpenseCategoryHint;

  /// Label for the date picker when adding a new expense
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get addExpenseDateTitle;

  /// Displays date's value
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String addExpenseDateValue(DateTime date);

  /// Text for the button that saves the new expense
  ///
  /// In en, this message translates to:
  /// **'Save Expense'**
  String get addExpenseSubmitButtonTitle;

  /// Category for food-related expenses
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get categoryFood;

  /// Category for transportation expenses
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get categoryTransport;

  /// Category for general shopping expenses
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get categoryShopping;

  /// Category for entertainment or leisure expenses
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get categoryEntertainment;

  /// Category for utility or service bills
  ///
  /// In en, this message translates to:
  /// **'Bills'**
  String get categoryBills;

  /// Category for health-related expenses
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get categoryHealth;

  /// Category for educational expenses
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get categoryEducation;

  /// Category for miscellaneous or uncategorized expenses
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get categoryOthers;

  /// Category for travel expenses
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get categoryTravel;

  /// Category for investments expenses
  ///
  /// In en, this message translates to:
  /// **'Investments'**
  String get categoryInvestments;

  /// Category for insurance expenses
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get categoryInsurance;

  /// Category for subscriptions expenses
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get categorySubscriptions;

  /// Category for pets expenses
  ///
  /// In en, this message translates to:
  /// **'Pets'**
  String get categoryPets;

  /// Category for personal care expenses
  ///
  /// In en, this message translates to:
  /// **'Personal care'**
  String get categoryPersonalCare;

  /// Category for house expenses
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get categoryHouse;

  /// US Dollar currency
  ///
  /// In en, this message translates to:
  /// **'US Dollar'**
  String get currencyUSD;

  /// Euro currency
  ///
  /// In en, this message translates to:
  /// **'Euro'**
  String get currencyEUR;

  /// British Pound currency
  ///
  /// In en, this message translates to:
  /// **'British Pound'**
  String get currencyGBP;

  /// Japanese Yen currency
  ///
  /// In en, this message translates to:
  /// **'Japanese Yen'**
  String get currencyJPY;

  /// Canadian Dollar currency
  ///
  /// In en, this message translates to:
  /// **'Canadian Dollar'**
  String get currencyCAD;

  /// Australian Dollar currency
  ///
  /// In en, this message translates to:
  /// **'Australian Dollar'**
  String get currencyAUD;

  /// Title for clear all data dialog
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get clearAllDataDialogTitle;

  /// Message for clear all data dialog
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone. This will permanently delete all your expense data.'**
  String get clearAllDataDialogMessage;

  /// ButtonTitle for clear all data dialog
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get clearAllDataDialogButtonTitle;

  /// CancelButton title for clear all data dialog
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get clearAllDataDialogCancelButton;
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
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
