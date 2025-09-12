import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/pages/add_expense_page.dart';
import 'package:dukoin/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class DukoinFab extends StatefulWidget {
  const DukoinFab({super.key});

  @override
  State<DukoinFab> createState() => _DukoinFabState();
}

class _DukoinFabState extends State<DukoinFab>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  final shortDuration = Duration(milliseconds: 250);
  final longDuration = Duration(milliseconds: 500);

  final curve = Curves.elasticOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildButton(
          context,
          () {},
          AppLocalizations.of(context)!.income,
          LucideIcons.plus,
          const Offset(0, 2.45),
        ),
        SizedBox(height: 16),
        _buildButton(
          context,
          () {
            _toggle();
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => AddExpensePage()));
          },
          AppLocalizations.of(context)!.expense,
          LucideIcons.minus,
          const Offset(0, 1.20),
        ),
        SizedBox(height: 8),
        AnimatedScale(
          scale: _isOpen ? 0.9 : 1,
          duration: longDuration,
          curve: Curves.elasticOut,
          child: FloatingActionButton(
            onPressed: _toggle,
            backgroundColor: _isOpen
                ? Colors.black
                : Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                appBorderRadius * 1.5,
              ), // border
            ),
            child: AnimatedRotation(
              duration: shortDuration,
              turns: _isOpen ? 0.375 : 0,
              child: const Icon(LucideIcons.plus),
            ),
          ),
        ),
      ],
    );
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  AnimatedSlide _buildButton(
    BuildContext context,
    VoidCallback onPressed,
    String title,
    IconData icon,
    Offset offset,
  ) {
    return AnimatedSlide(
      offset: _isOpen ? const Offset(0, 0) : offset,
      duration: longDuration,
      curve: curve,
      child: AnimatedOpacity(
        opacity: _isOpen ? 1 : 0,
        duration: shortDuration,
        curve: Curves.easeOut,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(title), SizedBox(width: 8), Icon(icon)],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
