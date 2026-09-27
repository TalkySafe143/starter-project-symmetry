import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:news_app_clean_architecture/features/auth/domain/entities/user.entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.displayName,
    super.photoUrl,
    super.isAnonymous,
  });

  factory UserModel.fromFirebase(fb.User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      isAnonymous: user.isAnonymous,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      isAnonymous: json['isAnonymous'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'isAnonymous': isAnonymous,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      displayName: entity.displayName,
      photoUrl: entity.photoUrl,
      isAnonymous: entity.isAnonymous,
    );
  }
}
