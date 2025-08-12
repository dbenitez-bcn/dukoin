import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/styles/dukoin_colors.dart';
import 'package:flutter/material.dart';

class NoExpensesWidget extends StatelessWidget {
  const NoExpensesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isDark = theme.brightness == Brightness.dark;
    var textTheme = TextTheme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circle with gradient background
          Container(
            width: 80,
            // w-20
            height: 80,
            // h-20
            margin: const EdgeInsets.only(bottom: 16),
            // mb-4
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary, //.withAlpha(50),
                  theme.extension<DukoinColors>()!.accent.withAlpha(
                    isDark ? 50 : 255,
                  ),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(50),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(child: Text('💰', style: textTheme.headlineLarge)),
          ),
          Text(
            AppLocalizations.of(context)!.homeNoExpensesTitle,
            style: textTheme.displaySmall,
          ),
          const SizedBox(height: 4),
          Text(
            AppLocalizations.of(context)!.homeNoExpensesSubtitle,
            style: textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
