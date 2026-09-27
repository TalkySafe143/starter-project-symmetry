import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.entity.dart';

abstract interface class UserArticleRepository {
  Future<DataState<ArticleEntity>> getUserArticles(String userId);

  Future<DataState<void>> createUserArticle(ArticleEntity article);
}
