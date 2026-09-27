import 'package:injectable/injectable.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.entity.dart';
import 'package:news_app_clean_architecture/features/news/domain/repository/user_article_repository.dart';

@lazySingleton
class CreateUserArticle implements UseCase<DataState<void>, ArticleEntity> {
  final UserArticleRepository _userArticleRepository;

  CreateUserArticle(this._userArticleRepository);

  @override
  Future<DataState<void>> call({ArticleEntity? params}) {
      if (params == null) return Future.value(DataSuccess(null));
      return _userArticleRepository.createUserArticle(params);
  }
}
