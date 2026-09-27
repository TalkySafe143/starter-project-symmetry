import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/news/data/data_sources/remote/user_articles_firebase_service.dart';
import 'package:news_app_clean_architecture/features/news/data/models/article.dart';
import 'package:news_app_clean_architecture/features/news/data/repository/user_article_repository_impl.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.entity.dart';

import 'user_article_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserArticlesFirebaseService>()])
void main() {
  late MockUserArticlesFirebaseService mockFirebaseService;
  late UserArticleRepositoryImpl repository;

  const tArticleEntity = ArticleEntity(
    id: '1',
    authorDisplayName: 'John Doe',
    title: 'Test Title',
    urlToImage: 'https://example.com/initial.jpg',
    publishedAt: '2026-09-27T00:00:00Z',
    content: 'Test Content',
  );

  setUp(() {
    mockFirebaseService = MockUserArticlesFirebaseService();
    repository = UserArticleRepositoryImpl(mockFirebaseService);
  });

  group('createUserArticle', () {
    test(
        'should upload thumbnail and create article with uploaded url when imageFile is provided',
        () async {
      final tImageFile = File('dummy/path/image.jpg');
      const uploadedUrl = 'https://firebasestorage.googleapis.com/test.jpg';

      when(mockFirebaseService.uploadThumbnail(tImageFile))
          .thenAnswer((_) async => uploadedUrl);

      final result = await repository.createUserArticle(
        tArticleEntity,
        imageFile: tImageFile,
      );

      expect(result, isA<DataSuccess<void>>());
      verify(mockFirebaseService.uploadThumbnail(tImageFile)).called(1);

      final captured = verify(mockFirebaseService.createUserArticle(captureAny))
          .captured
          .single as ArticleModel;
      expect(captured.urlToImage, uploadedUrl);
      expect(captured.title, tArticleEntity.title);
      expect(captured.content, tArticleEntity.content);
      expect(captured.authorDisplayName, tArticleEntity.authorDisplayName);
    });

    test(
        'should fallback to existing urlToImage when imageFile is null and uploadThumbnail returns null',
        () async {
      when(mockFirebaseService.uploadThumbnail(null))
          .thenAnswer((_) async => null);

      final result = await repository.createUserArticle(
        tArticleEntity,
        imageFile: null,
      );

      expect(result, isA<DataSuccess<void>>());
      verify(mockFirebaseService.uploadThumbnail(null)).called(1);

      final captured = verify(mockFirebaseService.createUserArticle(captureAny))
          .captured
          .single as ArticleModel;
      expect(captured.urlToImage, tArticleEntity.urlToImage);
    });

    test('should return DataGenericFailed when uploadThumbnail throws',
        () async {
      final tImageFile = File('dummy/path/image.jpg');
      when(mockFirebaseService.uploadThumbnail(tImageFile))
          .thenThrow(Exception('Upload failed'));

      final result = await repository.createUserArticle(
        tArticleEntity,
        imageFile: tImageFile,
      );

      expect(result, isA<DataGenericFailed<void>>());
      expect(result.errorMessage, contains('Upload failed'));
      verify(mockFirebaseService.uploadThumbnail(tImageFile)).called(1);
      verifyNever(mockFirebaseService.createUserArticle(any));
    });

    test('should return DataGenericFailed when createUserArticle throws',
        () async {
      when(mockFirebaseService.uploadThumbnail(null))
          .thenAnswer((_) async => null);
      when(mockFirebaseService.createUserArticle(any))
          .thenThrow(Exception('Firestore write failed'));

      final result = await repository.createUserArticle(
        tArticleEntity,
        imageFile: null,
      );

      expect(result, isA<DataGenericFailed<void>>());
      expect(result.errorMessage, contains('Firestore write failed'));
      verify(mockFirebaseService.uploadThumbnail(null)).called(1);
      verify(mockFirebaseService.createUserArticle(any)).called(1);
    });
  });

  group('getUserArticles', () {
    test('should throw UnimplementedError', () {
      expect(
        () => repository.getUserArticles('user-123'),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });
}
