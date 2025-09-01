import 'package:dukoin/extensions/string_extension.dart';
import 'package:dukoin/presentation/state/stats_page_state.dart';
import 'package:dukoin/presentation/widgets/dukoin_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dukoin_dropdown_menu.dart';

class MonthDropdownMenu extends StatelessWidget {
  const MonthDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = StatsProvider.of(context);
    return FutureBuilder(
      future: bloc.loadAvailableMonths(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return DukoinShimmer(height: 36);
        }
        final List<String> months = bloc.availableMonths
            .map(
              (e) => DateFormat(
                'yMMMM',
                Localizations.localeOf(context).languageCode,
              ).format(e).capitalize(),
            )
            .toList();

        return DukoinDropdownMenu(
          items: months,
          initialValue: 0,
          onSelected: (index) {
            bloc.onMonthSelected(bloc.availableMonths[index]);
          },
        );
      },
    );
  }
}
