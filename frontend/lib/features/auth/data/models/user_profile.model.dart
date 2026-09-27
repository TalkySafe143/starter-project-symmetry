import 'package:news_app_clean_architecture/features/auth/domain/entities/user_profile.entity.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    required super.id,
    super.displayName,
    super.photoUrl,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String? ?? '',
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }

  factory UserProfileModel.fromEntity(UserProfileEntity entity) {
    return UserProfileModel(
      id: entity.id,
      displayName: entity.displayName,
      photoUrl: entity.photoUrl,
    );
  }

  factory UserProfileModel.fromRawData(Map<String, dynamic> raw) =>
      UserProfileModel.fromJson(raw);

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      id: id,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }
}
