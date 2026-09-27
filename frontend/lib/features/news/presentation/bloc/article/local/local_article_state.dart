import 'package:equatable/equatable.dart';

import '../../../../domain/entities/article.entity.dart';

abstract class LocalArticlesState extends Equatable {
  final List<ArticleEntity> ? articles;

  const LocalArticlesState({this.articles});

  @override
  List<Object> get props => [if (articles != null) articles!];
}

class LocalArticlesLoading extends LocalArticlesState {
  const LocalArticlesLoading();
}

class LocalArticlesDone extends LocalArticlesState {
  const LocalArticlesDone(List<ArticleEntity> articles) : super(articles: articles);
}

class LocalArticlesError extends LocalArticlesState {
  final String message;

  const LocalArticlesError(this.message);

  @override
  List<Object> get props => [message];
}