import 'package:drift/drift.dart' show Value;
import 'package:json_annotation/json_annotation.dart';
import 'package:news_app_clean_architecture/features/news/data/data_sources/local/app_database.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.entity.dart';
import '../../../../core/constants/constants.dart';

part 'article.g.dart';

@JsonSerializable()
class ArticleModel extends ArticleEntity {
  @override
  @JsonKey(name: 'author')
  final String? authorDisplayName;

  const ArticleModel({
    super.id,
    this.authorDisplayName,
    super.title,
    super.urlToImage,
    super.publishedAt,
    super.content,
    super.authorId,
  }) : super(authorDisplayName: authorDisplayName);

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  /// Convert a Drift-generated [ArticlesTableData] row into an [ArticleModel].
  factory ArticleModel.fromArticle(ArticlesTableData article) {
    return ArticleModel(
      id: article.id,
      authorDisplayName: article.authorDisplayName,
      title: article.title,
      urlToImage: article.urlToImage ?? kDefaultImage,
      publishedAt: article.publishedAt,
      content: article.content,
      authorId: article.authorId,
    );
  }

  /// Convert to a Drift [ArticlesTableCompanion] for insert/update operations.
  ArticlesTableCompanion toCompanion() {
    return ArticlesTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      authorDisplayName: Value(authorDisplayName),
      title: Value(title),
      urlToImage: Value(urlToImage),
      publishedAt: Value(publishedAt),
      content: Value(content),
      authorId: Value(authorId),
    );
  }

  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
      id: entity.id,
      authorDisplayName: entity.authorDisplayName,
      title: entity.title,
      urlToImage: entity.urlToImage,
      publishedAt: entity.publishedAt,
      content: entity.content,
      authorId: entity.authorId,
    );
  }

  ArticleModel copyWith({
    String? id,
    String? authorDisplayName,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
    String? authorId,
  }) {
    return ArticleModel(
      id: id ?? this.id,
      authorDisplayName: authorDisplayName ?? this.authorDisplayName,
      title: title ?? this.title,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
      authorId: authorId ?? this.authorId,
    );
  }
}
