import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:news_app_clean_architecture/core/constants/constants.dart';
import 'package:news_app_clean_architecture/features/news/data/data_sources/local/app_database.dart';
import 'package:news_app_clean_architecture/features/news/data/models/article.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.entity.dart';
import 'package:news_app_clean_architecture/features/news/domain/repository/article_repository.dart';

import '../data_sources/remote/news_api_service.dart';

@LazySingleton(as: ArticleRepository)
class ArticleRepositoryImpl implements ArticleRepository {
  static final _log = Logger('ArticleRepositoryImpl');

  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;

  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleEntity>>> getNewsArticles() async {
    _log.info('getNewsArticles → calling API '
        '[key=${newsAPIKey.substring(0, 6)}… country=$countryQuery category=$categoryQuery]');
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      );

      final statusCode = httpResponse.response.statusCode;
      _log.info('getNewsArticles → HTTP $statusCode');

      if (statusCode == HttpStatus.ok) {
        final articles = httpResponse.data.articles ?? [];
        _log.info('getNewsArticles → success, ${articles.length} articles received');
        return DataSuccess(articles.map((m) => m.toEntity()).toList());
      } else {
        _log.warning('getNewsArticles → non-200 response: '
            '$statusCode ${httpResponse.response.statusMessage}');
        return DataDioFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      _log.severe('getNewsArticles → DioException '
          '[type=${e.type} status=${e.response?.statusCode}]', e);
      return DataDioFailed(e);
    } catch (e, st) {
      _log.severe('getNewsArticles → unexpected error', e, st);
      return DataGenericFailed(e.toString());
    }
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() async {
    _log.fine('getSavedArticles → querying local DB');
    final rows = await _appDatabase.articleDao.getArticles();
    _log.fine('getSavedArticles → ${rows.length} rows returned');
    return rows
        .map((row) => ArticleModel.fromArticle(row).toEntity())
        .toList();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) async {
    _log.fine('removeArticle → id=${article.id} title="${article.title}"');
    final rows = await _appDatabase.articleDao.getArticles();
    final match = rows.firstWhere(
      (r) => r.id == article.id,
      orElse: () => throw Exception('Article not found: id=${article.id}'),
    );
    return _appDatabase.articleDao.deleteArticle(match);
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    _log.fine('saveArticle → id=${article.id} title="${article.title}"');
    return _appDatabase.articleDao
        .insertArticle(ArticleModel.fromEntity(article).toCompanion());
  }
}
