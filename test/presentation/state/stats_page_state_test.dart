import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/presentation/state/stats_page_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Stats page state", () {
    test("Current month should be initial date value", () {
      final now = DateTime.now();
      final initialDate = DateTime(now.year, now.month, 1);

      final sut = StatsBloc();

      expect(sut.selectedDate, initialDate);
    });
    test("Given a new date then it should update the state", () {
      final newDate = DateTime(2023, 1, 1);
      final sut = StatsBloc();

      sut.onDateSelected(newDate);

      expect(sut.selectedDate, newDate);
    });

    test("Should load all the months that have data", () {
      // TODO: implement
      //throw UnimplementedError();
    });

    test("Should load no categories as default value", () {
      final sut = StatsBloc();

      expect(sut.selectedCategories, isEmpty);
    });

    test("Given a new category list then it should update the state", () {
      final sut = StatsBloc();
      var expected = [ExpenseCategory.food, ExpenseCategory.travel];

      sut.onCategoriesUpdated(expected);

      expect(sut.selectedCategories, expected);

    });
  });
}
