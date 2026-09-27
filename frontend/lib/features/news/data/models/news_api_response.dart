import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/news_api_response.entity.dart';
import 'article.dart';

part 'news_api_response.g.dart';

/// Wraps the actual NewsAPI response shape:
/// {
///   "status": "ok",
///   "totalResults": 38,
///   "articles": [ { ... } ]
/// }
@JsonSerializable()
class NewsApiResponse extends NewsApiResponseEntity {
  @override
  final List<ArticleModel>? articles;

  const NewsApiResponse({
    super.status,
    super.totalResults,
    this.articles,
  }) : super(articles: articles);

  factory NewsApiResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsApiResponseFromJson(json);

  factory NewsApiResponse.fromRawData(Map<String, dynamic> raw) =>
      NewsApiResponse.fromJson(raw);

  Map<String, dynamic> toJson() => _$NewsApiResponseToJson(this);

  NewsApiResponseEntity toEntity() {
    return NewsApiResponseEntity(
      status: status,
      totalResults: totalResults,
      articles: articles?.map((m) => m.toEntity()).toList(),
    );
  }
}
