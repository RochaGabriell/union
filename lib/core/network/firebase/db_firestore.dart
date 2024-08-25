import 'package:cloud_firestore/cloud_firestore.dart';

class BDFirestore {
  final FirebaseFirestore _firestore;

  BDFirestore(this._firestore);

  Future<void> addData(String collection, Map<String, dynamic> data) async {
    await _firestore.collection(collection).add(data);
  }

  Future<void>  setData(
    String collection,
    String doc,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collection).doc(doc).set(data);
  }

  Future<void> updateData(
    String collection,
    String doc,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collection).doc(doc).update(data);
  }

  Future<void> deleteData(String collection, String doc) async {
    await _firestore.collection(collection).doc(doc).delete();
  }

  Future<DocumentSnapshot> getData(String collection, String doc) async {
    return await _firestore.collection(collection).doc(doc).get();
  }

  Stream<QuerySnapshot> getCollection(String collection) {
    return _firestore.collection(collection).snapshots();
  }
}
