part of 'create_article_bloc.dart';

abstract class CreateArticleState {
  const CreateArticleState();
}

class CreateArticleIdle extends CreateArticleState {
  const CreateArticleIdle();
}

class CreateArticleLoading extends CreateArticleState {
  const CreateArticleLoading();
}

class CreateArticleSuccess extends CreateArticleState {
  const CreateArticleSuccess();
}

class CreateArticleError extends CreateArticleState {
  final String message;
  const CreateArticleError(this.message);
}
