import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app_clean_architecture/core/constants/constants.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/local/DAO/article_dao.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/models/article.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:retrofit/retrofit.dart';

import 'article_repository_impl_test.mocks.dart';

@GenerateMocks([NewsApiService, AppDatabase, ArticleDao])
void main() {
  late MockNewsApiService mockApiService;
  late MockAppDatabase mockAppDatabase;
  late MockArticleDao mockArticleDao;
  late ArticleRepositoryImpl repository;

  // Shared fixtures
  const tArticleModel = ArticleModel(
    id: 1,
    author: 'John Doe',
    title: 'Test Title',
    description: 'Test Description',
    url: 'https://example.com',
    urlToImage: 'https://example.com/image.jpg',
    publishedAt: '2024-01-01T00:00:00Z',
    content: 'Test Content',
  );
  final tArticleList = [tArticleModel];

  const tArticleEntity = ArticleEntity(
    id: 1,
    author: 'John Doe',
    title: 'Test Title',
    description: 'Test Description',
    url: 'https://example.com',
    urlToImage: 'https://example.com/image.jpg',
    publishedAt: '2024-01-01T00:00:00Z',
    content: 'Test Content',
  );

  setUp(() {
    mockApiService = MockNewsApiService();
    mockAppDatabase = MockAppDatabase();
    mockArticleDao = MockArticleDao();

    // Wire up database mock so articleDAO getter returns the DAO mock
    when(mockAppDatabase.articleDAO).thenReturn(mockArticleDao);

    repository = ArticleRepositoryImpl(mockApiService, mockAppDatabase);
  });

  // ---------------------------------------------------------------------------
  group('getNewsArticles', () {
    test('should return DataSuccess with article list on HTTP 200', () async {
      final requestOptions = RequestOptions(path: '/top-headlines');
      final response = Response<List<ArticleModel>>(
        data: tArticleList,
        statusCode: HttpStatus.ok,
        requestOptions: requestOptions,
      );
      final httpResponse = HttpResponse(tArticleList, response);

      when(mockApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      )).thenAnswer((_) async => httpResponse);

      final result = await repository.getNewsArticles();

      expect(result, isA<DataSuccess<List<ArticleModel>>>());
      expect(result.data, tArticleList);
    });

    test('should return DataFailed on non-200 HTTP status', () async {
      final requestOptions = RequestOptions(path: '/top-headlines');
      final response = Response<List<ArticleModel>>(
        data: null,
        statusCode: HttpStatus.unauthorized,
        statusMessage: 'Unauthorized',
        requestOptions: requestOptions,
      );
      final httpResponse = HttpResponse<List<ArticleModel>>([], response);

      when(mockApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      )).thenAnswer((_) async => httpResponse);

      final result = await repository.getNewsArticles();

      expect(result, isA<DataFailed<List<ArticleModel>>>());
      expect(result.error?.type, DioExceptionType.badResponse);
    });

    test('should return DataFailed when a DioException is thrown', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/top-headlines'),
        type: DioExceptionType.connectionTimeout,
      );

      when(mockApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      )).thenThrow(dioException);

      final result = await repository.getNewsArticles();

      expect(result, isA<DataFailed<List<ArticleModel>>>());
      expect(result.error, dioException);
    });
  });

  // ---------------------------------------------------------------------------
  group('getSavedArticles', () {
    test('should return saved articles from the local database', () async {
      when(mockArticleDao.getArticles()).thenAnswer((_) async => tArticleList);

      final result = await repository.getSavedArticles();

      expect(result, tArticleList);
      verify(mockArticleDao.getArticles()).called(1);
    });

    test('should return empty list when no articles are saved', () async {
      when(mockArticleDao.getArticles()).thenAnswer((_) async => []);

      final result = await repository.getSavedArticles();

      expect(result, isEmpty);
    });
  });

  // ---------------------------------------------------------------------------
  group('saveArticle', () {
    test('should call insertArticle on the DAO with an ArticleModel', () async {
      when(mockArticleDao.insertArticle(any)).thenAnswer((_) async {});

      await repository.saveArticle(tArticleEntity);

      final captured =
          verify(mockArticleDao.insertArticle(captureAny)).captured.single
              as ArticleModel;
      expect(captured.id, tArticleEntity.id);
      expect(captured.title, tArticleEntity.title);
    });
  });

  // ---------------------------------------------------------------------------
  group('removeArticle', () {
    test('should call deleteArticle on the DAO with an ArticleModel', () async {
      when(mockArticleDao.deleteArticle(any)).thenAnswer((_) async {});

      await repository.removeArticle(tArticleEntity);

      final captured =
          verify(mockArticleDao.deleteArticle(captureAny)).captured.single
              as ArticleModel;
      expect(captured.id, tArticleEntity.id);
      expect(captured.title, tArticleEntity.title);
    });
  });
}
