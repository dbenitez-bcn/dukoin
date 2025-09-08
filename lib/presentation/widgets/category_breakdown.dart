import 'package:dukoin/domain/category_breakdown_vm.dart';
import 'package:dukoin/domain/state_status.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/stats_page_state.dart';
import 'package:dukoin/presentation/widgets/currency_text.dart';
import 'package:dukoin/presentation/widgets/dukoin_shimmer.dart';
import 'package:dukoin/styles/dukoin_colors.dart';
import 'package:dukoin/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart' show LucideIcons;

class CategoryBreakdown extends StatelessWidget {
  const CategoryBreakdown({super.key});

  @override
  Widget build(BuildContext context) {
    final statsBloc = StatsProvider.of(context);
    final shimmer = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DukoinShimmer(height: 216.5, width: double.infinity),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.chartPie,
                color: Theme.of(
                  context,
                ).extension<DukoinColors>()!.relaxingTurquoise,
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.statsCategoryBreakdownTitle,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
          FutureBuilder(
            future: statsBloc.loadCategoryBreakdown(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return shimmer;
              }
              return StreamBuilder<StateStatus>(
                stream: statsBloc.statusStream.where(
                  (value) => value == StateStatus.done,
                ),
                initialData: statsBloc.initialStatus,
                builder: (context, asyncSnapshot) {
                  if (!statsBloc.categoryBreakdown.data.isEmpty) {
                    return NoDataChart();
                  }
                  return CategoryBreakdownCard(vm: statsBloc.categoryBreakdown);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class NoDataChart extends StatelessWidget {
  const NoDataChart({super.key});

  Widget _buildChart(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.40;
    return SizedBox(
      width: size,
      height: size,
      child: AspectRatio(
        aspectRatio: 1,
        child: Opacity(
          opacity: 0.35,
          child: PieChart(
            PieChartData(
              sections: [PieChartSectionData(color: Colors.grey)],
              sectionsSpace: 3,
              startDegreeOffset: 100,
            ),
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInQuart,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card.outlined(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              _buildChart(context),
              Text(
                AppLocalizations.of(context)!.statsNoData,
                style: TextTheme.of(context).labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryBreakdownCard extends StatelessWidget {
  final CategoryBreakdownVM vm;

  const CategoryBreakdownCard({super.key, required this.vm});

  Widget _buildBreakdownListItem(
    BuildContext context,
    CategoryBreakdownData data,
    Color color,
  ) {
    return Row(
      children: [
        CircleAvatar(radius: 8, backgroundColor: color),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            "${CategoryUtils.getIconFromCategory(data.category)} ${CategoryUtils.getCategoryTitle(context, data.category)}",
            style: TextTheme.of(context).titleSmall,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CurrencyText(
              data.value,
              style: TextTheme.of(context).bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              FormatUtils.formatPercentage(
                data.percentage,
                AppLocalizations.of(context)!.localeName,
              ),
              style: TextTheme.of(context).bodyMedium,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    DukoinColors colors = Theme.of(context).extension<DukoinColors>()!;
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CategoryBreakdownChart(vm: vm),
            ...vm.data.asMap().entries.map(
              (e) => _buildBreakdownListItem(
                context,
                e.value,
                colors.chartColor(e.key),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryBreakdownChart extends StatelessWidget {
  final CategoryBreakdownVM vm;

  const CategoryBreakdownChart({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.40;
    DukoinColors colors = Theme.of(context).extension<DukoinColors>()!;
    return SizedBox(
      width: size,
      height: size,
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            sections: vm.data
                .asMap()
                .entries
                .map(
                  (e) => PieChartSectionData(
                    value: e.value.value,
                    color: colors.chartColor(e.key),
                    showTitle: false,
                  ),
                )
                .toList(),
            sectionsSpace: 3,
            startDegreeOffset: 100,
          ),
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeInQuart,
        ),
      ),
    );
  }
}
