// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ArticlesTableTable extends ArticlesTable
    with TableInfo<$ArticlesTableTable, ArticlesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticlesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _authorDisplayNameMeta =
      const VerificationMeta('authorDisplayName');
  @override
  late final GeneratedColumn<String> authorDisplayName =
      GeneratedColumn<String>('author_display_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _urlToImageMeta =
      const VerificationMeta('urlToImage');
  @override
  late final GeneratedColumn<String> urlToImage = GeneratedColumn<String>(
      'url_to_image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _publishedAtMeta =
      const VerificationMeta('publishedAt');
  @override
  late final GeneratedColumn<String> publishedAt = GeneratedColumn<String>(
      'published_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _authorIdMeta =
      const VerificationMeta('authorId');
  @override
  late final GeneratedColumn<String> authorId = GeneratedColumn<String>(
      'author_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        authorDisplayName,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
        authorId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'articles_table';
  @override
  VerificationContext validateIntegrity(Insertable<ArticlesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('author_display_name')) {
      context.handle(
          _authorDisplayNameMeta,
          authorDisplayName.isAcceptableOrUnknown(
              data['author_display_name']!, _authorDisplayNameMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    }
    if (data.containsKey('url_to_image')) {
      context.handle(
          _urlToImageMeta,
          urlToImage.isAcceptableOrUnknown(
              data['url_to_image']!, _urlToImageMeta));
    }
    if (data.containsKey('published_at')) {
      context.handle(
          _publishedAtMeta,
          publishedAt.isAcceptableOrUnknown(
              data['published_at']!, _publishedAtMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('author_id')) {
      context.handle(_authorIdMeta,
          authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ArticlesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArticlesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      authorDisplayName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}author_display_name']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url']),
      urlToImage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url_to_image']),
      publishedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}published_at']),
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content']),
      authorId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author_id']),
    );
  }

  @override
  $ArticlesTableTable createAlias(String alias) {
    return $ArticlesTableTable(attachedDatabase, alias);
  }
}

class ArticlesTableData extends DataClass
    implements Insertable<ArticlesTableData> {
  final int? id;
  final String? authorDisplayName;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  final String? authorId;
  const ArticlesTableData(
      {this.id,
      this.authorDisplayName,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content,
      this.authorId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || authorDisplayName != null) {
      map['author_display_name'] = Variable<String>(authorDisplayName);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || urlToImage != null) {
      map['url_to_image'] = Variable<String>(urlToImage);
    }
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<String>(publishedAt);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || authorId != null) {
      map['author_id'] = Variable<String>(authorId);
    }
    return map;
  }

  ArticlesTableCompanion toCompanion(bool nullToAbsent) {
    return ArticlesTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      authorDisplayName: authorDisplayName == null && nullToAbsent
          ? const Value.absent()
          : Value(authorDisplayName),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      urlToImage: urlToImage == null && nullToAbsent
          ? const Value.absent()
          : Value(urlToImage),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      authorId: authorId == null && nullToAbsent
          ? const Value.absent()
          : Value(authorId),
    );
  }

  factory ArticlesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArticlesTableData(
      id: serializer.fromJson<int?>(json['id']),
      authorDisplayName:
          serializer.fromJson<String?>(json['authorDisplayName']),
      title: serializer.fromJson<String?>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      url: serializer.fromJson<String?>(json['url']),
      urlToImage: serializer.fromJson<String?>(json['urlToImage']),
      publishedAt: serializer.fromJson<String?>(json['publishedAt']),
      content: serializer.fromJson<String?>(json['content']),
      authorId: serializer.fromJson<String?>(json['authorId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'authorDisplayName': serializer.toJson<String?>(authorDisplayName),
      'title': serializer.toJson<String?>(title),
      'description': serializer.toJson<String?>(description),
      'url': serializer.toJson<String?>(url),
      'urlToImage': serializer.toJson<String?>(urlToImage),
      'publishedAt': serializer.toJson<String?>(publishedAt),
      'content': serializer.toJson<String?>(content),
      'authorId': serializer.toJson<String?>(authorId),
    };
  }

  ArticlesTableData copyWith(
          {Value<int?> id = const Value.absent(),
          Value<String?> authorDisplayName = const Value.absent(),
          Value<String?> title = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> url = const Value.absent(),
          Value<String?> urlToImage = const Value.absent(),
          Value<String?> publishedAt = const Value.absent(),
          Value<String?> content = const Value.absent(),
          Value<String?> authorId = const Value.absent()}) =>
      ArticlesTableData(
        id: id.present ? id.value : this.id,
        authorDisplayName: authorDisplayName.present
            ? authorDisplayName.value
            : this.authorDisplayName,
        title: title.present ? title.value : this.title,
        description: description.present ? description.value : this.description,
        url: url.present ? url.value : this.url,
        urlToImage: urlToImage.present ? urlToImage.value : this.urlToImage,
        publishedAt: publishedAt.present ? publishedAt.value : this.publishedAt,
        content: content.present ? content.value : this.content,
        authorId: authorId.present ? authorId.value : this.authorId,
      );
  ArticlesTableData copyWithCompanion(ArticlesTableCompanion data) {
    return ArticlesTableData(
      id: data.id.present ? data.id.value : this.id,
      authorDisplayName: data.authorDisplayName.present
          ? data.authorDisplayName.value
          : this.authorDisplayName,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      url: data.url.present ? data.url.value : this.url,
      urlToImage:
          data.urlToImage.present ? data.urlToImage.value : this.urlToImage,
      publishedAt:
          data.publishedAt.present ? data.publishedAt.value : this.publishedAt,
      content: data.content.present ? data.content.value : this.content,
      authorId: data.authorId.present ? data.authorId.value : this.authorId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesTableData(')
          ..write('id: $id, ')
          ..write('authorDisplayName: $authorDisplayName, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('url: $url, ')
          ..write('urlToImage: $urlToImage, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('content: $content, ')
          ..write('authorId: $authorId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, authorDisplayName, title, description,
      url, urlToImage, publishedAt, content, authorId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArticlesTableData &&
          other.id == this.id &&
          other.authorDisplayName == this.authorDisplayName &&
          other.title == this.title &&
          other.description == this.description &&
          other.url == this.url &&
          other.urlToImage == this.urlToImage &&
          other.publishedAt == this.publishedAt &&
          other.content == this.content &&
          other.authorId == this.authorId);
}

class ArticlesTableCompanion extends UpdateCompanion<ArticlesTableData> {
  final Value<int?> id;
  final Value<String?> authorDisplayName;
  final Value<String?> title;
  final Value<String?> description;
  final Value<String?> url;
  final Value<String?> urlToImage;
  final Value<String?> publishedAt;
  final Value<String?> content;
  final Value<String?> authorId;
  const ArticlesTableCompanion({
    this.id = const Value.absent(),
    this.authorDisplayName = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.url = const Value.absent(),
    this.urlToImage = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.content = const Value.absent(),
    this.authorId = const Value.absent(),
  });
  ArticlesTableCompanion.insert({
    this.id = const Value.absent(),
    this.authorDisplayName = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.url = const Value.absent(),
    this.urlToImage = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.content = const Value.absent(),
    this.authorId = const Value.absent(),
  });
  static Insertable<ArticlesTableData> custom({
    Expression<int>? id,
    Expression<String>? authorDisplayName,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? url,
    Expression<String>? urlToImage,
    Expression<String>? publishedAt,
    Expression<String>? content,
    Expression<String>? authorId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (authorDisplayName != null) 'author_display_name': authorDisplayName,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (url != null) 'url': url,
      if (urlToImage != null) 'url_to_image': urlToImage,
      if (publishedAt != null) 'published_at': publishedAt,
      if (content != null) 'content': content,
      if (authorId != null) 'author_id': authorId,
    });
  }

  ArticlesTableCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? authorDisplayName,
      Value<String?>? title,
      Value<String?>? description,
      Value<String?>? url,
      Value<String?>? urlToImage,
      Value<String?>? publishedAt,
      Value<String?>? content,
      Value<String?>? authorId}) {
    return ArticlesTableCompanion(
      id: id ?? this.id,
      authorDisplayName: authorDisplayName ?? this.authorDisplayName,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
      authorId: authorId ?? this.authorId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (authorDisplayName.present) {
      map['author_display_name'] = Variable<String>(authorDisplayName.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (urlToImage.present) {
      map['url_to_image'] = Variable<String>(urlToImage.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<String>(publishedAt.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<String>(authorId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesTableCompanion(')
          ..write('id: $id, ')
          ..write('authorDisplayName: $authorDisplayName, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('url: $url, ')
          ..write('urlToImage: $urlToImage, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('content: $content, ')
          ..write('authorId: $authorId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ArticlesTableTable articlesTable = $ArticlesTableTable(this);
  late final ArticleDao articleDao = ArticleDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [articlesTable];
}

typedef $$ArticlesTableTableCreateCompanionBuilder = ArticlesTableCompanion
    Function({
  Value<int?> id,
  Value<String?> authorDisplayName,
  Value<String?> title,
  Value<String?> description,
  Value<String?> url,
  Value<String?> urlToImage,
  Value<String?> publishedAt,
  Value<String?> content,
  Value<String?> authorId,
});
typedef $$ArticlesTableTableUpdateCompanionBuilder = ArticlesTableCompanion
    Function({
  Value<int?> id,
  Value<String?> authorDisplayName,
  Value<String?> title,
  Value<String?> description,
  Value<String?> url,
  Value<String?> urlToImage,
  Value<String?> publishedAt,
  Value<String?> content,
  Value<String?> authorId,
});

class $$ArticlesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ArticlesTableTable> {
  $$ArticlesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get authorDisplayName => $composableBuilder(
      column: $table.authorDisplayName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get urlToImage => $composableBuilder(
      column: $table.urlToImage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get authorId => $composableBuilder(
      column: $table.authorId, builder: (column) => ColumnFilters(column));
}

class $$ArticlesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ArticlesTableTable> {
  $$ArticlesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get authorDisplayName => $composableBuilder(
      column: $table.authorDisplayName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get urlToImage => $composableBuilder(
      column: $table.urlToImage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get authorId => $composableBuilder(
      column: $table.authorId, builder: (column) => ColumnOrderings(column));
}

class $$ArticlesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArticlesTableTable> {
  $$ArticlesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get authorDisplayName => $composableBuilder(
      column: $table.authorDisplayName, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get urlToImage => $composableBuilder(
      column: $table.urlToImage, builder: (column) => column);

  GeneratedColumn<String> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get authorId =>
      $composableBuilder(column: $table.authorId, builder: (column) => column);
}

class $$ArticlesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ArticlesTableTable,
    ArticlesTableData,
    $$ArticlesTableTableFilterComposer,
    $$ArticlesTableTableOrderingComposer,
    $$ArticlesTableTableAnnotationComposer,
    $$ArticlesTableTableCreateCompanionBuilder,
    $$ArticlesTableTableUpdateCompanionBuilder,
    (
      ArticlesTableData,
      BaseReferences<_$AppDatabase, $ArticlesTableTable, ArticlesTableData>
    ),
    ArticlesTableData,
    PrefetchHooks Function()> {
  $$ArticlesTableTableTableManager(_$AppDatabase db, $ArticlesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArticlesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArticlesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArticlesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> authorDisplayName = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> url = const Value.absent(),
            Value<String?> urlToImage = const Value.absent(),
            Value<String?> publishedAt = const Value.absent(),
            Value<String?> content = const Value.absent(),
            Value<String?> authorId = const Value.absent(),
          }) =>
              ArticlesTableCompanion(
            id: id,
            authorDisplayName: authorDisplayName,
            title: title,
            description: description,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            content: content,
            authorId: authorId,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> authorDisplayName = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> url = const Value.absent(),
            Value<String?> urlToImage = const Value.absent(),
            Value<String?> publishedAt = const Value.absent(),
            Value<String?> content = const Value.absent(),
            Value<String?> authorId = const Value.absent(),
          }) =>
              ArticlesTableCompanion.insert(
            id: id,
            authorDisplayName: authorDisplayName,
            title: title,
            description: description,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            content: content,
            authorId: authorId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ArticlesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ArticlesTableTable,
    ArticlesTableData,
    $$ArticlesTableTableFilterComposer,
    $$ArticlesTableTableOrderingComposer,
    $$ArticlesTableTableAnnotationComposer,
    $$ArticlesTableTableCreateCompanionBuilder,
    $$ArticlesTableTableUpdateCompanionBuilder,
    (
      ArticlesTableData,
      BaseReferences<_$AppDatabase, $ArticlesTableTable, ArticlesTableData>
    ),
    ArticlesTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ArticlesTableTableTableManager get articlesTable =>
      $$ArticlesTableTableTableManager(_db, _db.articlesTable);
}
