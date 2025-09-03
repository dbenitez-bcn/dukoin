import 'package:fl_chart/fl_chart.dart';

class MonthEvolutionVM {
  final List<MonthEvolutionData> data;
  MonthEvolutionVM(this.data);
}

class MonthEvolutionData {
  final DateTime month;
  final List<FlSpot> spots;
  MonthEvolutionData(this.month, this.spots);
}