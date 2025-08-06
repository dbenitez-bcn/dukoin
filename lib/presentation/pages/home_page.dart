import 'package:dukoin/extensions/string_extension.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/pages/add_expense_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SafeArea(
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.homeTitle,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                AppLocalizations.of(context)!.homeSubtitle(DateTime.now()).capitalize(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => AddExpensePage()));
        },
      ),
    );
  }
}
