/* Project Imports */
import 'package:union/core/enums/category_transaction.dart';
import 'package:union/core/enums/type_transaction.dart';

class TransactionEntity {
  final String? id;
  final String description;
  final double value;
  final DateTime date;
  final CategoryTransaction category;
  final TypeTransaction type;
  final String? groupId;
  final String userId;

  TransactionEntity({
    this.id,
    required this.description,
    required this.value,
    required this.date,
    required this.category,
    required this.type,
    this.groupId,
    required this.userId,
  });
}
