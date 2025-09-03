import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/domain/state_status.dart';
import 'package:dukoin/domain/total_amount_vm.dart';
import 'package:dukoin/domain/total_per_day_dto.dart';
import 'package:dukoin/presentation/state/stats_page_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'expenses_bloc_test.mocks.dart';

@GenerateMocks([ExpenseRepository])
void main() {
  group("Stats page state", () {
    final mockrepo = MockExpenseRepository();
    test("Current month should be initial date value", () {
      final now = DateTime.now();
      final initialDate = DateTime(now.year, now.month, 1);

      final sut = StatsBloc(mockrepo);

      expect(sut.selectedMonth, initialDate);
    });
    test("Inicial status should be done", () {
      final sut = StatsBloc(mockrepo);

      expect(sut.initialStatus, StateStatus.done);
    });

    group("onMonthSelected", () {
      final newDate = DateTime(2023, 1, 1);
      final endOfMonth = DateTime(2023, 1, 31);
      setUp(() {
        reset(mockrepo);
        when(
          mockrepo.getTotalAmount(
            start: newDate,
            end: endOfMonth,
            categories: anyNamed("categories"),
          ),
        ).thenAnswer((_) async => TotalAmountVM(23, 23));
        when(
          mockrepo.getTopFiveExpenses(start: newDate, end: endOfMonth),
        ).thenAnswer((_) async => []);
        when(
          mockrepo.getTotalPerDay(
            start: anyNamed("start"),
            end: anyNamed("end"),
            categories: anyNamed("categories"),
          ),
        ).thenAnswer((_) async => []);
      });
      test("Given a new date then it should update the state", () async {
        final sut = StatsBloc(mockrepo);
        expectLater(
          sut.statusStream,
          emitsInOrder([StateStatus.loading, StateStatus.done]),
        );

        await sut.onMonthSelected(newDate);

        expect(sut.selectedMonth, equals(newDate));
      });

      test("it should update top five expenses", () async {
        final sut = StatsBloc(mockrepo);

        await sut.onMonthSelected(newDate);

        verify(
          mockrepo.getTopFiveExpenses(start: newDate, end: endOfMonth),
        ).called(1);
      });

      test("it should update month overview", () async {
        final sut = StatsBloc(mockrepo);

        await sut.onMonthSelected(newDate);

        verify(
          mockrepo.getTotalAmount(
            start: newDate,
            end: endOfMonth,
            categories: anyNamed("categories"),
          ),
        ).called(1);
      });

      test("it should update month evolution", () async {
        final sut = StatsBloc(mockrepo);

        await sut.onMonthSelected(newDate);

        verify(
          mockrepo.getTotalPerDay(
            start: newDate,
            end: endOfMonth,
            categories: anyNamed("categories"),
          ),
        ).called(1);
      });
    });

    group("loadAvailableMonths", () {
      var now = DateTime.now();
      final currentMonth = DateTime(now.year, now.month, 1);
      final lastMonth = DateTime(now.year, now.month - 1, 1);
      final twoMonthsAgo = DateTime(now.year, now.month - 2, 1);

      test(
        "Given an oldest date should load all the months that have data",
        () async {
          final sut = StatsBloc(mockrepo);
          when(
            mockrepo.getOldestExpenseDate(),
          ).thenAnswer((_) async => twoMonthsAgo);

          await sut.loadAvailableMonths();

          expect(sut.availableMonths, [currentMonth, lastMonth, twoMonthsAgo]);
        },
      );

      test("Given no oldest date should load only the current month", () async {
        final sut = StatsBloc(mockrepo);
        when(mockrepo.getOldestExpenseDate()).thenAnswer((_) async => null);

        await sut.loadAvailableMonths();

        expect(sut.availableMonths, [currentMonth]);
      });

      test(
        "Given the current month as oldest date should load only the current month",
        () async {
          final sut = StatsBloc(mockrepo);
          when(
            mockrepo.getOldestExpenseDate(),
          ).thenAnswer((_) async => currentMonth);

          await sut.loadAvailableMonths();

          expect(sut.availableMonths, [currentMonth]);
        },
      );
    });

    test("Should load no categories as default value", () {
      final sut = StatsBloc(mockrepo);

      expect(sut.selectedCategories, isEmpty);
    });

    group("onCategoriesUpdated", () {
      setUp(() {
        reset(mockrepo);
        when(
          mockrepo.getTotalAmount(
            start: anyNamed("start"),
            end: anyNamed("end"),
            categories: anyNamed("categories"),
          ),
        ).thenAnswer((_) async => TotalAmountVM(23, 23));
        when(
          mockrepo.getTotalPerDay(
            start: anyNamed("start"),
            end: anyNamed("end"),
            categories: anyNamed("categories"),
          ),
        ).thenAnswer((_) async => []);
      });

      test(
        "Given a new category list then it should update the state",
        () async {
          final sut = StatsBloc(mockrepo);
          var expected = [ExpenseCategory.food, ExpenseCategory.travel];
          expectLater(
            sut.statusStream,
            emitsInOrder([StateStatus.loading, StateStatus.done]),
          );

          await sut.onCategoriesUpdated(expected);

          expect(sut.selectedCategories, expected);
        },
      );
      test(
        "Given a new category list then it should update the mont overview",
        () async {
          final sut = StatsBloc(mockrepo);
          var expected = [ExpenseCategory.food, ExpenseCategory.travel];

          await sut.onCategoriesUpdated(expected);

          verify(
            mockrepo.getTotalAmount(
              start: anyNamed("start"),
              end: anyNamed("end"),
              categories: expected,
            ),
          );
        },
      );
      test(
        "Given a new category list then it should update the mont evolution",
        () async {
          final sut = StatsBloc(mockrepo);
          var expected = [ExpenseCategory.food, ExpenseCategory.travel];

          await sut.onCategoriesUpdated(expected);

          verify(
            mockrepo.getTotalPerDay(
              start: anyNamed("start"),
              end: anyNamed("end"),
              categories: expected,
            ),
          );
        },
      );
    });

    test("Should close the stream controller on dispose", () async {
      final sut = StatsBloc(mockrepo);
      final doneFuture = expectLater(sut.statusStream, emitsDone);

      sut.dispose();

      await doneFuture;
    });

    group("loadMonthOverview", () {
      setUp(() {
        reset(mockrepo);
        when(
          mockrepo.getTopFiveExpenses(
            start: anyNamed("start"),
            end: anyNamed("end"),
          ),
        ).thenAnswer((_) async => []);
        when(
          mockrepo.getTotalPerDay(
            start: anyNamed("start"),
            end: anyNamed("end"),
            categories: anyNamed("categories"),
          ),
        ).thenAnswer((_) async => []);
      });
      test("It should load the month overview data", () async {
        final sut = StatsBloc(mockrepo);
        final start = DateTime(2025, 1, 1);
        final end = DateTime(2025, 1, 31);
        when(
          mockrepo.getTotalAmount(
            start: start,
            end: end,
            categories: anyNamed("categories"),
          ),
        ).thenAnswer((_) async => TotalAmountVM(12.34, 10));

        sut.onMonthSelected(start);
        await sut.loadMonthOverview();

        expect(sut.monthOverview.dailyAverage, 12.34 / 31);
        expect(sut.monthOverview.weeklyAverage, 12.34 / 4);
        expect(sut.monthOverview.numOfTransactions, 10);
        expect(sut.monthOverview.totalAmount, 12.34);
      });
      test(
        "Given the current month selected should calculate the data correctly",
        () async {
          final sut = StatsBloc(mockrepo);
          final start = DateTime(DateTime.now().year, DateTime.now().month, 1);
          when(
            mockrepo.getTotalAmount(
              start: start,
              end: anyNamed("end"),
              categories: anyNamed("categories"),
            ),
          ).thenAnswer((_) async => TotalAmountVM(12.34, 10));

          sut.onMonthSelected(start);
          await sut.loadMonthOverview();

          expect(sut.monthOverview.numOfTransactions, 10);
          expect(sut.monthOverview.totalAmount, 12.34);
        },
      );
    });

    group("loadTopFive", () {
      setUp(() {
        reset(mockrepo);
      });
      test("Default top five expenses should be empty", () {
        final sut = StatsBloc(mockrepo);

        expect(sut.topFiveExpenses, isEmpty);
      });

      test("It should load the top five expenses", () async {
        final sut = StatsBloc(mockrepo);
        final end = DateTime(
          sut.selectedMonth.year,
          sut.selectedMonth.month + 1,
          0,
        );
        final List<Expense> expectedList = List.generate(
          5,
          (i) => Expense(
            id: i,
            amount: i * 10,
            category: ExpenseCategory.values[i],
            description: "Desc $i",
            createdAt: DateTime.now(),
          ),
        ).toList();
        when(
          mockrepo.getTopFiveExpenses(
            start: anyNamed("start"),
            end: anyNamed("end"),
          ),
        ).thenAnswer((_) async => expectedList);

        await sut.loadTopFive();

        expect(sut.topFiveExpenses.length, 5);
        expect(sut.topFiveExpenses, expectedList);
        verify(
          mockrepo.getTopFiveExpenses(start: sut.selectedMonth, end: end),
        ).called(1);
      });
    });

    group("loadMonthEvolution", () {
      setUp(() {
        reset(mockrepo);
        when(
          mockrepo.getTotalAmount(
            start: anyNamed("start"),
            end: anyNamed("end"),
            categories: anyNamed("categories"),
          ),
        ).thenAnswer((_) async => TotalAmountVM(12.34, 10));
        when(
          mockrepo.getTopFiveExpenses(
            start: anyNamed("start"),
            end: anyNamed("end"),
          ),
        ).thenAnswer((_) async => []);
      });
      test("Default month evolution should be empty", () {
        final sut = StatsBloc(mockrepo);

        expect(sut.monthEvolution.data, isEmpty);
      });

      test("It should load the month evolution data", () async {
        final sut = StatsBloc(mockrepo);
        final startJan = DateTime(2023, 1, 1);
        final endJan = DateTime(2023, 1, 31);
        final startDec = DateTime(2022, 12, 1);
        final endDec = DateTime(2022, 12, 31);
        when(
          mockrepo.getTotalPerDay(
            start: startJan,
            end: endJan,
            categories: anyNamed("categories"),
          ),
        ).thenAnswer(
          (_) async => List.generate(
            31,
            (i) => TotalPerDayDTO(date: DateTime(2023, 1, i + 1), total: 1.0),
          ),
        );
        when(
          mockrepo.getTotalPerDay(
            start: startDec,
            end: endDec,
            categories: anyNamed("categories"),
          ),
        ).thenAnswer(
          (_) async => List.generate(
            31,
            (i) => TotalPerDayDTO(date: DateTime(2022, 12, i + 1), total: 1.0),
          ),
        );

        await sut.onMonthSelected(startJan);
        await sut.loadMonthEvolution();

        expect(sut.monthEvolution.data.length, 2);
        expect(sut.monthEvolution.data[0].month, startJan);
        expect(sut.monthEvolution.data[0].spots.length, 31);
        expect(sut.monthEvolution.data[1].month, startDec);
        expect(sut.monthEvolution.data[1].spots.length, 31);
        verify(
          mockrepo.getTotalPerDay(
            start: anyNamed("start"),
            end: anyNamed("end"),
            categories: anyNamed("categories"),
          ),
        );
      });

      test("Given some days should accumulate the values", () async {
        final sut = StatsBloc(mockrepo);
        final startJan = DateTime(2023, 1, 1);
        final endJan = DateTime(2023, 1, 31);
        final startDec = DateTime(2022, 12, 1);
        final endDec = DateTime(2022, 12, 31);
        when(
          mockrepo.getTotalPerDay(
            start: startJan,
            end: endJan,
            categories: anyNamed("categories"),
          ),
        ).thenAnswer(
          (_) async => List.generate(
            3,
            (i) => TotalPerDayDTO(date: DateTime(2023, 1, i + 1), total: 1.0),
          ),
        );
        when(
          mockrepo.getTotalPerDay(
            start: startDec,
            end: endDec,
            categories: anyNamed("categories"),
          ),
        ).thenAnswer(
          (_) async => [
            TotalPerDayDTO(date: DateTime(2022, 12, 1), total: 1.0),
            TotalPerDayDTO(date: DateTime(2022, 12, 3), total: 3.0),
            TotalPerDayDTO(date: DateTime(2022, 12, 5), total: 1.0),
            TotalPerDayDTO(date: DateTime(2022, 12, 10), total: 2.0),
          ],
        );

        await sut.onMonthSelected(startJan);
        await sut.loadMonthEvolution();

        expect(sut.monthEvolution.data.length, 2);
        expect(sut.monthEvolution.data[0].month, startJan);
        expect(sut.monthEvolution.data[0].spots.length, 3);
        expect(sut.monthEvolution.data[0].spots, [
          FlSpot(1, 1),
          FlSpot(2, 2),
          FlSpot(3, 3),
        ]);
        expect(sut.monthEvolution.data[1].month, startDec);
        expect(sut.monthEvolution.data[1].spots.length, 4);
        expect(sut.monthEvolution.data[1].spots, [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 5),
          FlSpot(10, 7),
        ]);
      });

      test("Given no days should return empty values", () async {
        final sut = StatsBloc(mockrepo);
        when(
          mockrepo.getTotalPerDay(
            start: anyNamed("start"),
            end: anyNamed("end"),
            categories: anyNamed("categories"),
          ),
        ).thenAnswer((_) async => []);

        await sut.loadMonthEvolution();

        expect(sut.monthEvolution.data.length, 2);
        expect(sut.monthEvolution.data[0].spots, isEmpty);
        expect(sut.monthEvolution.data[1].spots, isEmpty);
      });
    });
  });
}
