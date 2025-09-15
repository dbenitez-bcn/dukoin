import 'package:dukoin/domain/category.dart';

class TotalPerCategoryDTO {
  final ExpenseCategory category;
  final double value;

  TotalPerCategoryDTO(this.category, this.value);

  factory TotalPerCategoryDTO.fromMap(Map<String, dynamic> map) {
    return TotalPerCategoryDTO(
      Category.fromString(map['category']) as ExpenseCategory,
      map['value'],
    );
  }
}
