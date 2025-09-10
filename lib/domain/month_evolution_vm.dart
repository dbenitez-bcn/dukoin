import 'package:fl_chart/fl_chart.dart';

class MonthEvolutionVM {
  final List<MonthEvolutionData> data;
  MonthEvolutionVM(this.data);
  bool get hasData {
    if (data.isEmpty) {
      return false;
    } else {
      return data.any((row) => row.hasData);
    }
  }
}

class MonthEvolutionData {
  final DateTime month;
  final List<FlSpot> spots;
  MonthEvolutionData(this.month, this.spots);
  bool get hasData => spots.isNotEmpty;
}
