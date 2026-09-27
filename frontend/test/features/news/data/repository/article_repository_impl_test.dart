import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app_clean_architecture/core/constants/constants.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/news/data/data_sources/local/DAO/article_dao.dart';
import 'package:news_app_clean_architecture/features/news/data/data_sources/local/app_database.dart';
import 'package:news_app_clean_architecture/features/news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app_clean_architecture/features/news/data/models/article.dart';
import 'package:news_app_clean_architecture/features/news/data/models/news_api_response.dart';
import 'package:news_app_clean_architecture/features/news/data/repository/article_repository_impl.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.entity.dart';
import 'package:retrofit/retrofit.dart';

import 'article_repository_impl_test.mocks.dart';

@GenerateMocks([NewsApiService, AppDatabase, ArticleDao])
void main() {
  late MockNewsApiService mockApiService;
  late MockAppDatabase mockAppDatabase;
  late MockArticleDao mockArticleDao;
  late ArticleRepositoryImpl repository;

  // Drift-generated ArticlesTableData row fixture
  final tArticleRow = ArticlesTableData(
    id: 1,
    authorDisplayName: 'John Doe',
    title: 'Test Title',
    description: 'Test Description',
    url: 'https://example.com',
    urlToImage: 'https://example.com/image.jpg',
    publishedAt: '2024-01-01T00:00:00Z',
    content: 'Test Content',
    authorId: null,
  );
  final tArticleRows = [tArticleRow];

  // ArticleModel equivalent (what the repository returns after mapping)
  final tArticleModel = ArticleModel.fromArticle(tArticleRow);
  final tArticleModelList = [tArticleModel];

  const tArticleEntity = ArticleEntity(
    id: 1,
    authorDisplayName: 'John Doe',
    title: 'Test Title',
    description: 'Test Description',
    urlToImage: 'https://example.com/image.jpg',
    publishedAt: '2024-01-01T00:00:00Z',
    content: 'Test Content',
  );

  setUp(() {
    mockApiService = MockNewsApiService();
    mockAppDatabase = MockAppDatabase();
    mockArticleDao = MockArticleDao();

    // Wire up database mock so articleDao getter returns the DAO mock
    when(mockAppDatabase.articleDao).thenReturn(mockArticleDao);

    repository = ArticleRepositoryImpl(mockApiService, mockAppDatabase);
  });

  // ---------------------------------------------------------------------------
  group('getNewsArticles', () {
    test('should return DataSuccess with article list on HTTP 200', () async {
      final requestOptions = RequestOptions(path: '/top-headlines');
      final apiResponse = NewsApiResponse(status: 'ok', articles: tArticleModelList);
      final response = Response<NewsApiResponse>(
        data: apiResponse,
        statusCode: HttpStatus.ok,
        requestOptions: requestOptions,
      );
      final httpResponse = HttpResponse(apiResponse, response);

      when(mockApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      )).thenAnswer((_) async => httpResponse);

      final result = await repository.getNewsArticles();

      expect(result, isA<DataSuccess<List<ArticleModel>>>());
      expect(result.data, tArticleModelList);
    });

    test('should return DataFailed on non-200 HTTP status', () async {
      final requestOptions = RequestOptions(path: '/top-headlines');
      final apiResponse = NewsApiResponse(status: 'error', articles: []);
      final response = Response<NewsApiResponse>(
        data: null,
        statusCode: HttpStatus.unauthorized,
        statusMessage: 'Unauthorized',
        requestOptions: requestOptions,
      );
      final httpResponse = HttpResponse<NewsApiResponse>(apiResponse, response);

      when(mockApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      )).thenAnswer((_) async => httpResponse);

      final result = await repository.getNewsArticles();

      expect(result, isA<DataDioFailed<List<ArticleModel>>>());
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

      expect(result, isA<DataDioFailed<List<ArticleModel>>>());
      expect(result.error, dioException);
    });
  });

  // ---------------------------------------------------------------------------
  group('getSavedArticles', () {
    test('should return mapped ArticleModels from the local database', () async {
      when(mockArticleDao.getArticles()).thenAnswer((_) async => tArticleRows);

      final result = await repository.getSavedArticles();

      expect(result.length, 1);
      expect(result.first.id, tArticleRow.id);
      expect(result.first.title, tArticleRow.title);
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
    test('should call insertArticle on the DAO with an ArticlesCompanion',
        () async {
      when(mockArticleDao.insertArticle(any)).thenAnswer((_) async {});

      await repository.saveArticle(tArticleEntity);

      final captured =
          verify(mockArticleDao.insertArticle(captureAny)).captured.single
              as ArticlesTableCompanion;
      expect(captured.id, const Value(1));
      expect(captured.title, const Value('Test Title'));
    });
  });

  // ---------------------------------------------------------------------------
  group('removeArticle', () {
    test('should call deleteArticle on the DAO after finding the matching row',
        () async {
      when(mockArticleDao.getArticles()).thenAnswer((_) async => tArticleRows);
      when(mockArticleDao.deleteArticle(any)).thenAnswer((_) async {});

      await repository.removeArticle(tArticleEntity);

      final captured =
          verify(mockArticleDao.deleteArticle(captureAny)).captured.single
              as ArticlesTableData;
      expect(captured.id, tArticleEntity.id);
    });

    test('should throw when the article is not found in the database', () async {
      when(mockArticleDao.getArticles()).thenAnswer((_) async => []);

      expect(
        () => repository.removeArticle(tArticleEntity),
        throwsException,
      );
    });
  });
}
