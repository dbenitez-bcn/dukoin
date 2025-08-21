import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/widgets/dukoin_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class StatisticsAppBar extends StatelessWidget {
  const StatisticsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DukoinAppBar(
          title: AppLocalizations.of(context)!.statsPageTitle,
          subtitle: AppLocalizations.of(context)!.statsPageSubtitle,
          icon: LucideIcons.chartArea,
        ),
        Row(
          children: [
            Expanded(child: MonthSelector(initialMonth: DateTime.now())),
            SizedBox(width: 8),
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(LucideIcons.funnel, size: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MonthSelector extends StatefulWidget {
  final DateTime initialMonth;
  final ValueChanged<DateTime>? onChanged;

  const MonthSelector({super.key, required this.initialMonth, this.onChanged});

  @override
  State<MonthSelector> createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  late DateTime selectedMonth;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.initialMonth;
  }

  void _openDropdown(BuildContext context) async {
    final renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    print("Size of renderBox: ${renderBox.size}");

    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        renderBox.localToGlobal(Offset(0,renderBox.size.height), ancestor: overlay),
        renderBox.localToGlobal(
          renderBox.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    final months = List.generate(
      12,
      (i) => DateTime(DateTime.now().year, i + 1),
    );

    final picked = await showMenu<DateTime>(
      context: context,
      position: position,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: 1.0,
        ),
      ),
      items: [
        PopupMenuItem(
          child: SizedBox(
            height: 200,
            width: renderBox.size.width,
            child: ListView.builder(
              itemCount: months.length,
              itemBuilder: (context, index) {
                final m = months[index];
                final label = DateFormat(
                  'yMMMM',
                  Localizations.localeOf(context).languageCode,
                ).format(m);

                final isSelected =
                    m.month == selectedMonth.month &&
                    m.year == selectedMonth.year;

                return PopupMenuItem<DateTime>(
                  value: m,
                  child: Row(
                    children: [
                      Expanded(child: Text(label)),
                      if (isSelected)
                        Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.primary,
                          size: 16,
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );

    if (picked != null && picked != selectedMonth) {
      setState(() => selectedMonth = picked);
      widget.onChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = DateFormat(
      'yMMMM',
      Localizations.localeOf(context).languageCode,
    ).format(selectedMonth);

    return Card.outlined(
      child: InkWell(
        key: _key,
        borderRadius: BorderRadius.circular(8),
        onTap: () => _openDropdown(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(LucideIcons.calendar, size: 16, color: Colors.grey),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const SizedBox(width: 6),
              Icon(LucideIcons.chevronDown, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
