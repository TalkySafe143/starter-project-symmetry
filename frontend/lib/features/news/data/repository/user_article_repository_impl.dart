import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/news/data/data_sources/remote/user_articles_firebase_service.dart';
import 'package:news_app_clean_architecture/features/news/data/models/article.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.entity.dart';
import 'package:news_app_clean_architecture/features/news/domain/repository/user_article_repository.dart';

@LazySingleton(as: UserArticleRepository)
class UserArticleRepositoryImpl implements UserArticleRepository {
  static final _log = Logger('UserArticleRepositoryImpl');

  final UserArticlesFirebaseService _firebaseService;

  UserArticleRepositoryImpl(this._firebaseService);

  /// [imageFile] is optional — pass it alongside the [article] when the user
  /// has picked a thumbnail. The upload happens before the Firestore write so
  /// the article is never saved with a missing image reference.
  @override
  Future<DataState<void>> createUserArticle(
    ArticleEntity article, {
    File? imageFile,
  }) async {
    try {
      final thumbnailUrl = await _firebaseService.uploadThumbnail(imageFile);
      _log.info('createUserArticle → thumbnailUrl=$thumbnailUrl');

      final model = ArticleModel.fromEntity(article).copyWith(
        urlToImage: thumbnailUrl ?? article.urlToImage,
      );

      await _firebaseService.createUserArticle(model);

      return DataSuccess(null);
    } catch (e, st) {
      _log.severe('createUserArticle → failed', e, st);
      return DataGenericFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> getAllUserArticles() async {
    try {
      final articles = await _firebaseService.getAllUserArticles();
      return DataSuccess(articles.map((m) => m.toEntity()).toList());
    } catch (e, st) {
      _log.severe('getAllUserArticles → failed', e, st);
      return DataGenericFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> getUserArticles(String userId) async {
    try {
      final articles = await _firebaseService.getUserArticles(userId);
      return DataSuccess(articles.map((m) => m.toEntity()).toList());
    } catch (e, st) {
      _log.severe('getUserArticles → failed', e, st);
      return DataGenericFailed(e.toString());
    }
  }
}
