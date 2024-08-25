import 'package:union/features/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.userId,
    required super.fixedIncome,
    required super.type,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['userId'],
      fixedIncome: json['fixedIncome'],
      type: json['type'],
    );
  }

  factory ProfileModel.fromFirebase(ProfileModel profile) {
    return ProfileModel(
      userId: profile.userId,
      fixedIncome: profile.fixedIncome,
      type: profile.type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fixedIncome': fixedIncome,
      'type': type,
    };
  }
}
