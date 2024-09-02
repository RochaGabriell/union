/* Package Imports */
import 'package:cloud_firestore/cloud_firestore.dart';

/* Project Imports */
import 'package:union/core/errors/exceptions.dart';

abstract interface class FinanceReportRemoteDataSource {
  Future<double> getFixedIncomeUser({required String userId});

  Future<double> addFixedIncome({
    required String userId,
    required double value,
  });

  Future<List<double>> getIncomeAndExpense({required String userId});

  Future<List<double>> getExpenseByMonth({required String userId});
}

class FinanceReportRemoteDataSourceImpl
    implements FinanceReportRemoteDataSource {
  final FirebaseFirestore _firestore;

  FinanceReportRemoteDataSourceImpl(this._firestore);

  @override
  Future<double> getFixedIncomeUser({required String userId}) async {
    try {
      final snapshot = await _firestore.collection('users').doc(userId).get();

      return snapshot.get('fixedIncome');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<double> addFixedIncome({
    required String userId,
    required double value,
  }) async {
    try {
      final snapshot = await _firestore.collection('users').doc(userId).get();

      await _firestore
          .collection('users')
          .doc(userId)
          .update({'fixedIncome': value});

      return snapshot.get('fixedIncome');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<double>> getIncomeAndExpense({required String userId}) async {
    try {
      final snapshot = await _firestore.collection('users').doc(userId).get();
      final income = snapshot.data()?['fixedIncome'] ?? 0.0;

      final expense = await _firestore
          .collection('transactions')
          .where('userId', isEqualTo: userId)
          .get()
          .then(
        (transactions) {
          return transactions.docs.fold(0.0, (previousValue, transaction) {
            return previousValue + transaction.get('value');
          });
        },
      );

      return [
        income.toDouble(),
        expense.toDouble(),
      ];
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<double>> getExpenseByMonth({required String userId}) async {
    try {
      final transactions = await _firestore
          .collection('transactions')
          .where('userId', isEqualTo: userId)
          .get();

      final expenses = List<double>.filled(12, 0.0);

      for (var transaction in transactions.docs) {
        final dateField = transaction.get('date');

        DateTime date;
        if (dateField is Timestamp) {
          date = dateField.toDate();
        } else if (dateField is String) {
          date = DateTime.parse(dateField);
        } else {
          throw ServerException('Formato de data desconhecido');
        }

        final month = date.month;

        expenses[month - 1] += transaction.get('value');
      }

      return expenses;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
