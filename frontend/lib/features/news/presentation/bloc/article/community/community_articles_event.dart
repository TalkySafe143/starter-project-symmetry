part of 'community_articles_bloc.dart';

abstract class CommunityArticlesEvent extends Equatable {
  const CommunityArticlesEvent();

  @override
  List<Object?> get props => [];
}

class LoadCommunityArticles extends CommunityArticlesEvent {
  const LoadCommunityArticles();
}
