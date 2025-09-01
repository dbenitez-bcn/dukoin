import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/domain/expense_repository.dart';
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
    test("Given a new date then it should update the state", () {
      final newDate = DateTime(2023, 1, 1);
      final sut = StatsBloc(mockrepo);

      sut.onMonthSelected(newDate);

      expect(sut.selectedMonth, newDate);
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

      sut.onCategoriesUpdated(expected);

      expect(sut.selectedCategories, expected);
    });
  });
}
