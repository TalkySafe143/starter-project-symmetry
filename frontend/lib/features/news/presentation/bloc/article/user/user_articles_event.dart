part of 'user_articles_bloc.dart';

abstract class UserArticlesEvent extends Equatable {
  const UserArticlesEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserArticles extends UserArticlesEvent {
  const LoadUserArticles();
}
