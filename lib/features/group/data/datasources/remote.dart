/* Package Imports */
import 'package:cloud_firestore/cloud_firestore.dart';

/* Project Imports */
import 'package:union/features/group/data/models/group.dart';
import 'package:union/core/errors/exceptions.dart';

abstract interface class GroupRemoteDataSource {
  Future<String> createGroup({required GroupModel group});

  Future<void> updateGroup({required GroupModel group});

  Future<void> deleteGroup({required String groupId});

  Future<GroupModel> getGroup({required String groupId});

  Future<List<GroupModel>> getGroups({required String userId});

  Future<void> addMember({required String groupId, required String userId});
}

class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {
  final FirebaseFirestore _firestore;

  GroupRemoteDataSourceImpl(this._firestore);

  @override
  Future<String> createGroup({required GroupModel group}) async {
    try {
      final groupId = group.id;
      await _firestore.collection('groups').doc(groupId).set(group.toJson());
      return groupId ?? '';
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateGroup({required GroupModel group}) async {
    try {
      await _firestore
          .collection('groups')
          .doc(group.id)
          .update(group.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteGroup({required String groupId}) async {
    try {
      await _firestore.collection('groups').doc(groupId).delete();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<GroupModel> getGroup({required String groupId}) async {
    try {
      final group = await _firestore.collection('groups').doc(groupId).get();

      return GroupModel.fromJson(group.data() as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<GroupModel>> getGroups({required String userId}) async {
    try {
      final queryCreator = _firestore
          .collection('groups')
          .where('creatorId', isEqualTo: userId)
          .get();

      final queryMember = _firestore
          .collection('groups')
          .where('members', arrayContains: userId)
          .get();

      final results = await Future.wait([queryCreator, queryMember]);

      final allGroups = results.expand((result) => result.docs).toList();

      return allGroups.map((group) {
        return GroupModel.fromJson(group.data());
      }).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> addMember({required String groupId, required String userId}) {
    try {
      final group = _firestore.collection('groups').doc(groupId).get();

      group.then((value) {
        final data = value.data() as Map<String, dynamic>;
        final members = data['members'] as List<dynamic>;
        final creatorId = data['creatorId'] as String;

        if (members.contains(userId) || creatorId == userId) {
          throw ServerException('Usuário já é membro do grupo.');
        }

        members.add(userId);

        _firestore
            .collection('groups')
            .doc(groupId)
            .update({'members': members});
      });

      return Future.value();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
