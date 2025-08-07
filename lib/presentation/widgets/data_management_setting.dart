import 'package:dukoin/domain/currency.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/widgets/currency_dropdown_menu_item.dart';
import 'package:dukoin/presentation/widgets/dukoin_icon.dart';
import 'package:dukoin/styles/dukoin_colors.dart';
import 'package:flutter/material.dart';

class DataManagementSetting extends StatelessWidget {
  const DataManagementSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.error;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(bottom: 16.0),
              leading: DukoinIcon(
                icon: Icons.delete_outline,
                color: color
              ),
              title: Text(
                AppLocalizations.of(context)!.settingsDataManagementTitle,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              subtitle: Text(
                AppLocalizations.of(context)!.settingsDataManagementSubtitle,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => print("Implement clear data"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color
                ),
                child: Text(
                  AppLocalizations.of(context)!.settingsDataManagementButton,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
