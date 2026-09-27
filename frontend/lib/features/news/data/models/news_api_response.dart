import 'package:json_annotation/json_annotation.dart';
import 'article.dart';

part 'news_api_response.g.dart';

/// Wraps the actual NewsAPI response shape:
/// {
///   "status": "ok",
///   "totalResults": 38,
///   "articles": [ { ... } ]
/// }
@JsonSerializable()
class NewsApiResponse {
  final String? status;
  final int? totalResults;
  final List<ArticleModel>? articles;

  const NewsApiResponse({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory NewsApiResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsApiResponseToJson(this);
}
