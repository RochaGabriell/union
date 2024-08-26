/* Package Imports */
import 'package:cloud_firestore/cloud_firestore.dart';

/* Project Imports */
import 'package:union/features/transaction/data/models/transaction.dart';
import 'package:union/core/errors/exceptions.dart';

abstract interface class TransactionRemoteDataSource {
  Future<String> createTransaction({required TransactionModel transaction});

  Future<void> updateTransaction({required TransactionModel transaction});

  Future<void> deleteTransaction({required String transactionId});

  Future<TransactionModel> getTransaction({required String transactionId});

  Future<List<TransactionModel>> getTransactions({required String userId});

  Future<List<TransactionModel>> getTransactionsByGroup({
    required String groupId,
  });
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final FirebaseFirestore _firestore;

  TransactionRemoteDataSourceImpl(this._firestore);

  @override
  Future<String> createTransaction(
      {required TransactionModel transaction}) async {
    try {
      final transactionId = transaction.id;
      await _firestore.collection('transactions').doc(transactionId).set(
            transaction.toJson(),
          );
      return transactionId ?? '';
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateTransaction({required TransactionModel transaction}) {
    try {
      return _firestore
          .collection('transactions')
          .doc(transaction.id)
          .update(transaction.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteTransaction({required String transactionId}) {
    try {
      return _firestore.collection('transactions').doc(transactionId).delete();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<TransactionModel> getTransaction({required String transactionId}) {
    try {
      return _firestore
          .collection('transactions')
          .doc(transactionId)
          .get()
          .then((transaction) => TransactionModel.fromJson(
                transaction.data() as Map<String, dynamic>,
              ));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions({required String userId}) {
    try {
      return _firestore
          .collection('transactions')
          .where('userId', isEqualTo: userId)
          .get()
          .then(
        (transactions) {
          return transactions.docs.map((transaction) {
            return TransactionModel.fromJson(transaction.data());
          }).toList();
        },
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<TransactionModel>> getTransactionsByGroup({
    required String groupId,
  }) {
    try {
      return _firestore
          .collection('transactions')
          .where('groupId', isEqualTo: groupId)
          .get()
          .then((transactions) {
        return transactions.docs
            .map((transaction) => TransactionModel.fromJson(transaction.data()))
            .toList();
      });
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
