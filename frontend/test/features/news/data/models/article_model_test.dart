import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_clean_architecture/core/constants/constants.dart';
import 'package:news_app_clean_architecture/features/news/data/models/article.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.entity.dart';

void main() {
  group('ArticleModel', () {

    group('fromJson', () {
      test('should map all fields correctly from a full JSON map', () {
        final json = {
          'author': 'John Doe',
          'title': 'Test Title',
          'description': 'Test Description',
          'url': 'https://example.com',
          'urlToImage': 'https://example.com/image.jpg',
          'publishedAt': '2024-01-01T00:00:00Z',
          'content': 'Test Content',
        };

        final result = ArticleModel.fromJson(json);

        expect(result.author, 'John Doe');
        expect(result.title, 'Test Title');
        expect(result.description, 'Test Description');
        expect(result.url, 'https://example.com');
        expect(result.urlToImage, 'https://example.com/image.jpg');
        expect(result.publishedAt, '2024-01-01T00:00:00Z');
        expect(result.content, 'Test Content');
      });

      test('should use kDefaultImage when urlToImage is null', () {
        final json = {
          'author': 'John Doe',
          'title': 'Test Title',
          'description': 'Test Description',
          'url': 'https://example.com',
          'urlToImage': null,
          'publishedAt': '2024-01-01T00:00:00Z',
          'content': 'Test Content',
        };

        final result = ArticleModel.fromJson(json);

        expect(result.urlToImage, kDefaultImage);
      });

      test('should use kDefaultImage when urlToImage is empty string', () {
        final json = {
          'author': 'John Doe',
          'title': 'Test Title',
          'description': 'Test Description',
          'url': 'https://example.com',
          'urlToImage': '',
          'publishedAt': '2024-01-01T00:00:00Z',
          'content': 'Test Content',
        };

        final result = ArticleModel.fromJson(json);

        expect(result.urlToImage, kDefaultImage);
      });

      test('should fall back to empty string for null text fields', () {
        final json = <String, dynamic>{};

        final result = ArticleModel.fromJson(json);

        expect(result.author, '');
        expect(result.title, '');
        expect(result.description, '');
        expect(result.url, '');
        expect(result.publishedAt, '');
        expect(result.content, '');
        expect(result.urlToImage, kDefaultImage);
      });
    });

    group('fromEntity', () {
      test('should copy all fields from an ArticleEntity', () {
        const entity = ArticleEntity(
          id: 1,
          author: 'John Doe',
          title: 'Test Title',
          description: 'Test Description',
          url: 'https://example.com', urlToImage: 'https://example.com/image.jpg',
          publishedAt: '2024-01-01T00:00:00Z',
          content: 'Test Content',
        );

        final result = ArticleModel.fromEntity(entity);

        expect(result.id, entity.id);
        expect(result.author, entity.author);
        expect(result.title, entity.title);
        expect(result.description, entity.description);
        expect(result.url, entity.url);
        expect(result.urlToImage, entity.urlToImage);
        expect(result.publishedAt, entity.publishedAt);
        expect(result.content, entity.content);
      });

      test('should preserve null fields from entity', () {
        const entity = ArticleEntity();

        final result = ArticleModel.fromEntity(entity);

        expect(result.id, isNull);
        expect(result.author, isNull);
        expect(result.title, isNull);
        expect(result.urlToImage, isNull);
      });
    });

    group('equality (Equatable)', () {
      test('two models with identical fields should be equal', () {
        const model1 = ArticleModel(
          id: 1,
          author: 'John Doe',
          title: 'Test Title',
          description: 'Test Description',
          url: 'https://example.com',
          urlToImage: 'https://example.com/image.jpg',
          publishedAt: '2024-01-01T00:00:00Z',
          content: 'Test Content',
        );
        const model2 = ArticleModel(
          id: 1,
          author: 'John Doe',
          title: 'Test Title',
          description: 'Test Description',
          url: 'https://example.com',
          urlToImage: 'https://example.com/image.jpg',
          publishedAt: '2024-01-01T00:00:00Z',
          content: 'Test Content',
        );

        expect(model1, equals(model2));
      });

      test('two models with different fields should not be equal', () {
        const model1 = ArticleModel(id: 1, title: 'Title A');
        const model2 = ArticleModel(id: 2, title: 'Title B');

        expect(model1, isNot(equals(model2)));
      });
    });
  });
}
