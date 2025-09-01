import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/expense_provider.dart';
import 'package:flutter/material.dart';

class ClearAllDataDialog extends StatelessWidget {
  const ClearAllDataDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.clearAllDataDialogTitle,
                style: TextTheme.of(context).displayMedium,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0, top: 8),
                child: Text(
                  AppLocalizations.of(context)!.clearAllDataDialogMessage,
                  style: TextTheme.of(context).bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ExpensesProvider.of(context).clearAllData();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.clearAllDataDialogButtonTitle,
                  ),
                ),
              ),
              //SizedBox(height: 2.0),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: 1,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    AppLocalizations.of(
                      context,
                    )!.clearAllDataDialogCancelButton,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
