import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import '../../../../domain/entities/article.entity.dart';

abstract class RemoteArticlesState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioException? error;

  const RemoteArticlesState({this.articles, this.error});

  @override
  List<Object> get props => [
        if (articles != null) articles!,
        if (error != null) error!,
      ];
}

class RemoteArticlesLoading extends RemoteArticlesState {
  const RemoteArticlesLoading();
}

class RemoteArticlesDone extends RemoteArticlesState {
  const RemoteArticlesDone(List<ArticleEntity> article) : super(articles: article);
}

class RemoteArticlesError extends RemoteArticlesState {
  const RemoteArticlesError(DioException error) : super(error: error);
}
