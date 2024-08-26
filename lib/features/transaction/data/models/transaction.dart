/* Project Imports */
import 'package:union/features/transaction/domain/entities/transaction_entity.dart';
import 'package:union/core/enums/category_transaction.dart';
import 'package:union/core/enums/type_transaction.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    super.id,
    required super.description,
    required super.value,
    required super.date,
    required super.category,
    required super.type,
    required super.groupId,
    required super.userId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      description: json['description'],
      value: json['value'],
      date: DateTime.parse(json['date']),
      category: CategoryTransaction.values[json['category']],
      type: TypeTransaction.values[json['type']],
      groupId: json['groupId'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'value': value,
      'date': date.toIso8601String(),
      'category': category.index,
      'type': type.index,
      'groupId': groupId,
      'userId': userId,
    };
  }
}
