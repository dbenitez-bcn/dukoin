import 'package:dukoin/domain/expense.dart';

class TotalPerCategoryDTO {
  final ExpenseCategory category;
  final double value;

  TotalPerCategoryDTO(this.category, this.value);

  factory TotalPerCategoryDTO.fromMap(Map<String, dynamic> map) {
    return TotalPerCategoryDTO(
      getCategoryFromString(map['category']),
      map['value'],
    );
  }
}
