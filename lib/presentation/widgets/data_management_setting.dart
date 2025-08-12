import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/widgets/clear_all_data_dialog.dart';
import 'package:dukoin/presentation/widgets/dukoin_icon.dart';
import 'package:flutter/material.dart';

class DataManagementSetting extends StatelessWidget {
  const DataManagementSetting({super.key});

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return ClearAllDataDialog();
      },
    );
  }

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
              leading: DukoinIcon(icon: Icons.delete_outline, color: color),
              title: Text(
                AppLocalizations.of(context)!.settingsDataManagementTitle,
                style: TextTheme.of(context).displaySmall,
              ),
              subtitle: Text(
                AppLocalizations.of(context)!.settingsDataManagementSubtitle,
                style: TextTheme.of(context).bodyMedium,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showDeleteConfirmationDialog(context),
                style: ElevatedButton.styleFrom(backgroundColor: color),
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
