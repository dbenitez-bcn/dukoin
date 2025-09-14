import 'package:dukoin/domain/category_frequency.dart';
import 'package:dukoin/domain/state_status.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/stats_page_state.dart';
import 'package:dukoin/presentation/widgets/currency_text.dart';
import 'package:dukoin/presentation/widgets/dukoin_shimmer.dart';
import 'package:dukoin/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MostFrequent extends StatelessWidget {
  const MostFrequent({super.key});

  @override
  Widget build(BuildContext context) {
    final shimmer = DukoinShimmer(height: 100);
    final statsBloc = StatsProvider.of(context);
    return FutureBuilder(
      future: statsBloc.loadCategoryFrequency(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return shimmer;
        }
        return StreamBuilder<StateStatus>(
          stream: statsBloc.statusStream,
          initialData: statsBloc.initialStatus,
          builder: (context, asyncSnapshot) {
            if (statsBloc.topFiveExpenses.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.repeat,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(
                          context,
                        )!.statsMostFrequentCategoriesTitle,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ),
                CategoryFrequenciesListCard(
                  frequencies: statsBloc.categoryFrequency.data,
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class CategoryFrequenciesListCard extends StatelessWidget {
  final List<CategoryFrequency> frequencies;

  const CategoryFrequenciesListCard({super.key, required this.frequencies});

  Widget _buildFrequencyItem(
    BuildContext context,
    CategoryFrequency frequency,
    int index,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                frequency.category.icon,
                style: TextTheme.of(context).displayMedium,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            frequency.category.localized(context),
                            style: TextTheme.of(context).displaySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        CurrencyText(
                          frequency.average,
                          style: TextTheme.of(context).displaySmall,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.outline,
                            borderRadius: BorderRadius.circular(
                              appBorderRadius - 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "x${frequency.count}",
                              style: TextTheme.of(context).bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.statsAverageText,
                          style: TextTheme.of(context).bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (index < frequencies.length - 1) Divider(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: List.generate(
            frequencies.length,
            (i) => _buildFrequencyItem(context, frequencies[i], i),
          ),
        ),
      ),
    );
  }
}
