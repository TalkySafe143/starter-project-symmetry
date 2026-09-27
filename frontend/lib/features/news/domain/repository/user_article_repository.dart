import 'dart:io';

import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.entity.dart';

abstract interface class UserArticleRepository {
  Future<DataState<List<ArticleEntity>>> getAllUserArticles();

  Future<DataState<List<ArticleEntity>>> getUserArticles(String userId);

  /// Refreshes the stored author photo on every article by [userId].
  /// Returns the number of articles updated.
  Future<DataState<int>> updateAuthorPhotoUrl(String userId, String? photoUrl);

  Future<DataState<void>> createUserArticle(
    ArticleEntity article, {
    File? imageFile,
  });
}
