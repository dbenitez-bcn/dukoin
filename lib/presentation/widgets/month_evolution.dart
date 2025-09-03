import 'package:dukoin/domain/month_evolution_vm.dart';
import 'package:dukoin/domain/state_status.dart';
import 'package:dukoin/extensions/string_extension.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/currency_provider.dart';
import 'package:dukoin/presentation/state/stats_page_state.dart';
import 'package:dukoin/presentation/widgets/currency_text.dart';
import 'package:dukoin/presentation/widgets/dukoin_shimmer.dart';
import 'package:dukoin/styles/dukoin_colors.dart';
import 'package:dukoin/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthEvolution extends StatelessWidget {
  const MonthEvolution({super.key});

  @override
  Widget build(BuildContext context) {
    final statsBloc = StatsProvider.of(context);
    final shimmer = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DukoinShimmer(height: 216.5, width: double.infinity),
    );
    return FutureBuilder(
      future: statsBloc.loadMonthEvolution(),
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
            return MonthEvolutionCard(vm: statsBloc.monthEvolution);
          },
        );
      },
    );
  }
}

class MonthEvolutionCard extends StatelessWidget {
  final MonthEvolutionVM vm;

  const MonthEvolutionCard({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).extension<DukoinColors>()!.relaxingTurquoise,
    ];
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                vm.data.length,
                (index) => Row(
                  children: [
                    if (index != 0) SizedBox(width: 16),
                    CircleAvatar(
                      radius: 8,
                      backgroundColor: colors[index % colors.length],
                    ),
                    SizedBox(width: 4),
                    Text(
                      DateFormat(
                        'MMMM',
                        Localizations.localeOf(context).languageCode,
                      ).format(vm.data[index].month).capitalize(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragStart: (_) {},
              child: MonthEvolutionChart(data: vm.data, colors: colors),
            ),
          ],
        ),
      ),
    );
  }
}

class MonthEvolutionChart extends StatefulWidget {
  final List<MonthEvolutionData> data;
  final List<Color> colors;

  const MonthEvolutionChart({
    super.key,
    required this.data,
    required this.colors,
  });

  @override
  State<MonthEvolutionChart> createState() => _MonthEvolutionChartState();
}

class _MonthEvolutionChartState extends State<MonthEvolutionChart> {
  @override
  Widget build(BuildContext context) {
    final maxY =
        (widget.data
                    .map((s) => s.spots.isEmpty ? 0 : s.spots.last.y)
                    .reduce((a, b) => a > b ? a : b) *
                1.05)
            .ceilToDouble();
    var maxX = 31.0;
    List<LineChartBarData> lines = widget.data
        .map(
          (e) => LineChartBarData(
            spots: e.spots.isEmpty
                ? []
                : [FlSpot(e.spots[0].x - 1, 0), ...e.spots],
            isCurved: true,
            dotData: FlDotData(show: false),
            color: widget.colors[widget.data.indexOf(e)],
          ),
        )
        .toList();
    return AspectRatio(
      aspectRatio: 2.0,
      child: LineChart(
        LineChartData(
          clipData: FlClipData.all(),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                interval: maxY / 4,
                getTitlesWidget: (value, meta) {
                  return CurrencyText(
                    value,
                    style: TextTheme.of(context).bodySmall,
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: maxX / 3,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.ceil().toString(),
                    style: TextTheme.of(context).bodySmall,
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          minX: 1,
          maxX: maxX,
          minY: 0,
          maxY: maxY,
          lineBarsData: lines,
          lineTouchData: LineTouchData(
            getTouchedSpotIndicator: (barData, spotIndexes) {
              return spotIndexes.map((index) {
                return TouchedSpotIndicatorData(
                  FlLine(color: Colors.transparent), // optional vertical line
                  FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, bar, index) =>
                        FlDotCirclePainter(
                          radius: 6,
                          color: bar.color!,
                          strokeWidth: 2,
                          strokeColor: Theme.of(
                            context,
                          ).colorScheme.onSurfaceVariant,
                        ),
                  ),
                );
              }).toList();
            },
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => Colors.transparent,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((e) {
                  return LineTooltipItem(
                    formatCurrency(
                      CurrencyProvider.of(context).currency,
                      e.y,
                      AppLocalizations.of(context)!.localeName,
                    ),
                    TextStyle(color: e.bar.color),
                  );
                }).toList();
              },
            ),
          ),
        ),
        duration: Duration(milliseconds: 1000), // Optional
        curve: Curves.easeInQuart, // Optional
      ),
    );
  }
}
