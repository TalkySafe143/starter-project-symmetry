import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'DAO/article_dao.dart';

part 'app_database.g.dart';

/// Drift table definition — mirrors the old Floor 'article' table.
/// Named ArticlesTable to avoid collision with the ArticleEntity domain class.
class ArticlesTable extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get authorDisplayName => text().nullable()();
  TextColumn get title => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get url => text().nullable()();
  TextColumn get urlToImage => text().nullable()();
  TextColumn get publishedAt => text().nullable()();
  TextColumn get content => text().nullable()();
  TextColumn get authorId => text().nullable()();
}

@DriftDatabase(tables: [ArticlesTable], daos: [ArticleDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // For testing — accepts a QueryExecutor directly.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'app_database.db'));
    return NativeDatabase.createInBackground(file);
  });
}
