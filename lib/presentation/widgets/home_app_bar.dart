import 'package:dukoin/extensions/string_extension.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.homeTitle,
          style: TextTheme.of(context).displayLarge,
        ),
        Text(
          AppLocalizations.of(
            context,
          )!.homeSubtitle(DateTime.now()).capitalize(),
          style: TextTheme.of(context).bodyMedium,
        ),
      ],
    );
  }
}
