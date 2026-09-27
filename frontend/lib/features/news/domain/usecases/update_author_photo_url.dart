import 'package:injectable/injectable.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/news/domain/repository/user_article_repository.dart';

class UpdateAuthorPhotoUrlParams {
  final String userId;
  final String? photoUrl;

  const UpdateAuthorPhotoUrlParams({
    required this.userId,
    this.photoUrl,
  });
}

@lazySingleton
class UpdateAuthorPhotoUrl
    implements UseCase<DataState<int>, UpdateAuthorPhotoUrlParams> {
  final UserArticleRepository _userArticleRepository;

  UpdateAuthorPhotoUrl(this._userArticleRepository);

  @override
  Future<DataState<int>> call(
      {UpdateAuthorPhotoUrlParams? params}) async {
    if (params == null) return const DataSuccess(0);
    return await _userArticleRepository.updateAuthorPhotoUrl(
      params.userId,
      params.photoUrl,
    );
  }
}
