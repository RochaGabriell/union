/* Package Imports */
import 'package:firebase_auth/firebase_auth.dart';

/* Project Imports */
import 'package:union/features/profile/data/models/profile.dart';
import 'package:union/core/network/firebase/db_firestore.dart';
import 'package:union/core/errors/exceptions.dart';

abstract interface class ProfileRemoteDataSource {
  Future<ProfileModel> getCurrentProfile();

  Future<ProfileModel> updateProfile({
    required double fixedIncome,
    required int type,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseAuth _auth;
  final BDFirestore _firestore;

  ProfileRemoteDataSourceImpl(this._auth, this._firestore);

  @override
  Future<ProfileModel> getCurrentProfile() async {
    final user = _auth.currentUser;

    if (user != null) {
      try {
        final snapshot = await _firestore.getData('profiles', user.uid);

        return ProfileModel.fromFirebase(snapshot.data() as ProfileModel);
      } on FirebaseException catch (e) {
        throw ServerException(e.message as String);
      } catch (e) {
        throw ServerException(e.toString());
      }
    } else {
      throw ServerException('Usuário não autenticado');
    }
  }

  @override
  Future<ProfileModel> updateProfile({
    required double fixedIncome,
    required int type,
  }) async {
    final user = _auth.currentUser;

    if (user != null) {
      try {
        final profile = ProfileModel(
          userId: user.uid,
          fixedIncome: fixedIncome,
          type: type,
        );

        await _firestore.updateData('profiles', user.uid, profile.toJson());

        return profile;
      } on FirebaseException catch (e) {
        throw ServerException(e.message as String);
      } catch (e) {
        throw ServerException(e.toString());
      }
    } else {
      throw ServerException('Usuário não autenticado');
    }
  }
}
