import 'package:dukoin/presentation/state/stats_page_state.dart';
import 'package:dukoin/presentation/widgets/category_filter_bottom_sheet.dart';
import 'package:dukoin/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FunnelButton extends StatefulWidget {
  FunnelButton({super.key});

  @override
  State<FunnelButton> createState() => _FunnelButtonState();
}

class _FunnelButtonState extends State<FunnelButton> {
  void _openBottomSheetModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CategoryFilterBottomSheet(
          onSubmit: () {
            setState(() {});
          },
          selectedCategories: StatsProvider.of(context).selectedCategories,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    StatsBloc bloc = StatsProvider.of(context);
    int count = bloc.selectedCategories.length;
    bool isClear = count == 0;
    return GestureDetector(
      onTap: () => _openBottomSheetModal(context),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card.outlined(
            shape: isClear
                ? null
                : const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(appBorderRadius),
                    ),
                    side: BorderSide.none,
                  ),
            color: isClear ? null : Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                LucideIcons.funnel,
                size: 16,
                color: isClear
                    ? Colors.grey
                    : Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          Positioned(
            right: -6,
            top: 2,
            child: RedBadge(text: count.toString(), size: isClear ? 0 : 20),
          ),
        ],
      ),
    );
  }
}

class RedBadge extends StatelessWidget {
  final String text; // e.g. "3"
  final double size; // diameter

  const RedBadge({super.key, required this.text, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onError,
          fontSize: size * 0.55,
          fontWeight: FontWeight.w700,
          height: 1, // keeps text vertically centered
        ),
      ),
    );
  }
}
