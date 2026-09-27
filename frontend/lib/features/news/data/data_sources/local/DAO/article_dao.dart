import 'package:drift/drift.dart';

import '../app_database.dart';

part 'article_dao.g.dart';

@DriftAccessor(tables: [ArticlesTable])
class ArticleDao extends DatabaseAccessor<AppDatabase>
    with _$ArticleDaoMixin {
  ArticleDao(super.db);

  Future<List<ArticlesTableData>> getArticles() => select(articlesTable).get();

  Future<void> insertArticle(ArticlesTableCompanion article) =>
      into(articlesTable).insert(article, mode: InsertMode.insertOrReplace);

  Future<void> deleteArticle(ArticlesTableData article) =>
      (delete(articlesTable)..where((t) => t.id.equals(article.id!))).go();
}
