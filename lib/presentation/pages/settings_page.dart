import 'package:dukoin/presentation/widgets/app_info_card.dart';
import 'package:dukoin/presentation/widgets/daily_reminder_setting.dart';
import 'package:dukoin/presentation/widgets/data_management_setting.dart';
import 'package:dukoin/presentation/widgets/default_currency_selector.dart';
import 'package:dukoin/presentation/widgets/settings_app_bar.dart';
import 'package:dukoin/presentation/widgets/theme_card_switch.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              SettingsAppBar(),
              SizedBox(height: 16.0),
              ThemeCardSwitch(),
              DefaultCurrencySelector(),
              DailyReminderSetting(),
              DataManagementSetting(),
              AppInfoCard(),
            ],
          ),
        ),
      ),
    );
  }
}
