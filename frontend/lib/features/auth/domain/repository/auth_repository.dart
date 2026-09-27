import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/auth/domain/entities/user.entity.dart';

abstract interface class AuthRepository {
  Future<DataState<UserEntity>> login({
    required String email,
    required String password,
  });

  Future<DataState<UserEntity>> register({
    required String email,
    required String password,
    String? displayName,
  });

  Future<DataState<void>> logout();

  Future<DataState<UserEntity?>> getCurrentUser();

  Stream<UserEntity?> get authStateChanges;
}
