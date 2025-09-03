import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/currency_provider.dart';
import 'package:dukoin/utils/utils.dart';
import 'package:flutter/material.dart';

class CurrencyText extends StatelessWidget {
  final double amount;
  final TextStyle? style;
  final bool isAnimated;
  final int durationInMilliseconds;

  const CurrencyText(this.amount, {super.key, this.style})
    : isAnimated = false,
      durationInMilliseconds = 0;

  const CurrencyText.animated(
    this.amount, {
    super.key,
    this.durationInMilliseconds = 250,
    this.style,
  }) : isAnimated = true;

  @override
  Widget build(BuildContext context) {
    return isAnimated ? _buildAnimated() : _buildText(context, amount);
  }

  TweenAnimationBuilder<double> _buildAnimated() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: amount, end: amount),
      duration: Duration(milliseconds: durationInMilliseconds),
      curve: Curves.easeInCubic,
      builder: (context, value, child) {
        return _buildText(context, value);
      },
    );
  }

  Text _buildText(BuildContext context, double value) {
    return Text(
      formatCurrency(
        CurrencyProvider.of(context).currency,
        value,
        AppLocalizations.of(context)!.localeName,
      ),
      style:
          style ??
          TextTheme.of(context).displaySmall!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }
}
