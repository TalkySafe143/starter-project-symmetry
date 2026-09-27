import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/auth/domain/entities/user_profile.entity.dart';
import 'package:news_app_clean_architecture/features/auth/domain/repository/user_profile_repository.dart';

class GetAuthorProfileParams {
  final String authorId;

  const GetAuthorProfileParams({required this.authorId});
}

class GetAuthorProfile
    implements UseCase<DataState<UserProfileEntity?>, GetAuthorProfileParams> {
  final UserProfileRepository _userProfileRepository;

  GetAuthorProfile(this._userProfileRepository);

  @override
  Future<DataState<UserProfileEntity?>> call(
      {GetAuthorProfileParams? params}) async {
    if (params == null) return const DataSuccess(null);
    return await _userProfileRepository.getAuthorProfile(params.authorId);
  }
}
