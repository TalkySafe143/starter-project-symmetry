import 'package:injectable/injectable.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/news/data/data_sources/remote/user_articles_firebase_service.dart';
import 'package:news_app_clean_architecture/features/news/data/models/article.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.entity.dart';
import 'package:news_app_clean_architecture/features/news/domain/repository/user_article_repository.dart';

@LazySingleton(as: UserArticleRepository)
class UserArticleRepositoryImpl implements UserArticleRepository {
  final UserArticlesFirebaseService _userArticlesFirebaseService;

  UserArticleRepositoryImpl(this._userArticlesFirebaseService);

  @override
  Future<DataState<void>> createUserArticle(ArticleEntity article) async {
    try {
      await _userArticlesFirebaseService
          .createUserArticle(ArticleModel.fromEntity(article));

      return DataSuccess(null);
    } catch (e) {
      return DataGenericFailed(e.toString());
    }
  }

  @override
  Future<DataState<ArticleEntity>> getUserArticles(String userId) {
    // TODO: implement getUserArticles
    throw UnimplementedError();
  }
}
