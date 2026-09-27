import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

import '../../bloc/article/community/community_articles_bloc.dart';
import '../../widgets/article_tile.dart';

class CommunityFeedTab extends StatelessWidget {
  const CommunityFeedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<CommunityArticlesBloc>()..add(const LoadCommunityArticles()),
      child: BlocBuilder<CommunityArticlesBloc, CommunityArticlesState>(
        builder: (context, state) {
          if (state is CommunityArticlesLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is CommunityArticlesDone) {
            return _buildArticlesList(context, state);
          }
          if (state is CommunityArticlesError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildArticlesList(
      BuildContext context, CommunityArticlesDone state) {
    if (state.articles.isEmpty) {
      return const Center(
        child: Text('NO COMMUNITY ARTICLES YET'),
      );
    }
    return ListView.builder(
      itemCount: state.articles.length,
      itemBuilder: (context, index) {
        final article = state.articles[index];
        return ArticleWidget(
          article: article,
          onArticlePressed: (pressed) => Navigator.pushNamed(
            context,
            '/ArticleDetails',
            arguments: pressed,
          ),
        );
      },
    );
  }
}
