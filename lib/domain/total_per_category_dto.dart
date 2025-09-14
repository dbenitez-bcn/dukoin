import 'package:dukoin/domain/category.dart';
import 'package:dukoin/domain/transaction.dart';

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
