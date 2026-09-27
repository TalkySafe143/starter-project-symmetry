import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.entity.dart';
import 'package:news_app_clean_architecture/features/news/presentation/widgets/article_tile.dart';

void main() {
  const tArticle = ArticleEntity(
    id: 'user-article-1',
    authorDisplayName: 'Camilo',
    title: 'Test de un articulo',
    urlToImage: 'https://example.com/large-photo.jpg',
    publishedAt: '2026-09-27T12:11:50.732200',
    content: 'offline copy',
  );

  testWidgets(
      'tile bounds image decode size (regression: full-res camera uploads '
      'must not decode at native resolution in ~130px tiles)', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ArticleWidget(article: tArticle)),
      ),
    );

    final image = tester.widget<CachedNetworkImage>(
      find.byType(CachedNetworkImage),
    );
    expect(image.memCacheWidth, 400);
  });
}
