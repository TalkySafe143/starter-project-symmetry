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
      // 1. Upload image (if any) and get the download URL.
      final thumbnailUrl = await _firebaseService.uploadThumbnail(imageFile);
      _log.info('createUserArticle → thumbnailUrl=$thumbnailUrl');

      // 2. Build the model — override urlToImage with the Storage URL when
      //    an image was uploaded.
      final model = ArticleModel.fromEntity(article).copyWith(
        urlToImage: thumbnailUrl ?? article.urlToImage,
      );

      // 3. Save to Firestore.
      await _firebaseService.createUserArticle(model);

      return DataSuccess(null);
    } catch (e, st) {
      _log.severe('createUserArticle → failed', e, st);
      return DataGenericFailed(e.toString());
    }
  }

  @override
  Future<DataState<ArticleEntity>> getUserArticles(String userId) {
    // TODO: implement getUserArticles
    throw UnimplementedError();
  }
}
