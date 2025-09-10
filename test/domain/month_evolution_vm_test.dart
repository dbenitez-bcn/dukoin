import 'package:dukoin/domain/month_evolution_vm.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("MonthEvolutionVM", () {
    group("hasData", () {
      test("Given no elements should return false", () {
        var sut = MonthEvolutionVM([]);

        expect(sut.hasData, false);
      });
      test("Given one element with data should return true", () {
        var sut = MonthEvolutionVM([
          MonthEvolutionData(DateTime.now(), [FlSpot(0, 0)]),
          MonthEvolutionData(DateTime.now(), []),
        ]);

        expect(sut.hasData, true);
      });
      test("Given the second element with data should return true", () {
        var sut = MonthEvolutionVM([
          MonthEvolutionData(DateTime.now(), []),
          MonthEvolutionData(DateTime.now(), [FlSpot(0, 0)]),
        ]);

        expect(sut.hasData, true);
      });
      test("Given elements with data should return true", () {
        var sut = MonthEvolutionVM([
          MonthEvolutionData(DateTime.now(), [FlSpot(0, 0)]),
          MonthEvolutionData(DateTime.now(), [FlSpot(0, 2)]),
        ]);

        expect(sut.hasData, true);
      });
      test("Given elements with no data should return false", () {
        var sut = MonthEvolutionVM([
          MonthEvolutionData(DateTime.now(), []),
          MonthEvolutionData(DateTime.now(), []),
        ]);

        expect(sut.hasData, false);
      });
    });
  });
}
