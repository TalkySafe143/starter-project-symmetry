import 'package:injectable/injectable.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.entity.dart';
import 'package:news_app_clean_architecture/features/news/domain/repository/user_article_repository.dart';

class GetUserArticlesParams {
  final String userId;

  const GetUserArticlesParams({required this.userId});
}

@lazySingleton
class GetUserArticles
    implements UseCase<DataState<List<ArticleEntity>>, GetUserArticlesParams> {
  final UserArticleRepository _userArticleRepository;

  GetUserArticles(this._userArticleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call(
      {GetUserArticlesParams? params}) async {
    if (params == null) return const DataSuccess([]);
    return await _userArticleRepository.getUserArticles(params.userId);
  }
}
