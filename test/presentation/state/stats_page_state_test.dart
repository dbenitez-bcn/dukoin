import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/domain/state_status.dart';
import 'package:dukoin/domain/total_amount_vm.dart';
import 'package:dukoin/presentation/state/stats_page_state.dart';
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
    test("Given a new date then it should update the state", () {
      final newDate = DateTime(2023, 1, 1);
      final endOfMonth = DateTime(2023, 1, 31);
      when(mockrepo.getTotalAmount(start: newDate, end: endOfMonth)).thenAnswer((_) async => TotalAmountVM(23, 23));
      final sut = StatsBloc(mockrepo);
      expectLater(
        sut.statusStream,
        emitsInOrder([StateStatus.loading, StateStatus.done]),
      );

      sut.onMonthSelected(newDate);

      expect(sut.selectedMonth, equals(newDate));
      verify(mockrepo.getTotalAmount(start: newDate, end: endOfMonth)).called(1);
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

    test("Given a new category list then it should update the state", () {
      final sut = StatsBloc(mockrepo);
      var expected = [ExpenseCategory.food, ExpenseCategory.travel];
      expectLater(
        sut.statusStream,
        emitsInOrder([StateStatus.loading, StateStatus.done]),
      );

      sut.onCategoriesUpdated(expected);

      expect(sut.selectedCategories, expected);
    });
    test("Should close the stream controller on dispose", () async {
      final sut = StatsBloc(mockrepo);
      final doneFuture = expectLater(sut.statusStream, emitsDone);

      sut.dispose();

      await doneFuture;
    });

    group("loadMonthOverview", () {
      test("It should load the month overview data", () async {
        final sut = StatsBloc(mockrepo);
        final start = DateTime(2025, 1, 1);
        final end = DateTime(2025, 1, 31);
        when(
          mockrepo.getTotalAmount(start: start, end: end),
        ).thenAnswer((_) async => TotalAmountVM(12.34, 10));

        sut.onMonthSelected(start);
        await sut.loadMonthOverview();

        expect(sut.monthOverview.dailyAverage, 12.34 / 31);
        expect(sut.monthOverview.weeklyAverage, 12.34 / 4);
        expect(sut.monthOverview.numOfTransactions, 10);
        expect(sut.monthOverview.totalAmount, 12.34);
      });
      test("Given the current month selected should calculate the data correctly", () async {
        final sut = StatsBloc(mockrepo);
        final start = DateTime(DateTime.now().year, DateTime.now().month, 1);
        when(
          mockrepo.getTotalAmount(start: start, end: anyNamed("end")),
        ).thenAnswer((_) async => TotalAmountVM(12.34, 10));

        sut.onMonthSelected(start);
        await sut.loadMonthOverview();

        expect(sut.monthOverview.numOfTransactions, 10);
        expect(sut.monthOverview.totalAmount, 12.34);
      });
    });
  });
}
