import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app_clean_architecture/features/news/presentation/bloc/article/remote/remote_article_state.dart';

import '../../../domain/entities/article.entity.dart';
import '../../widgets/article_tile.dart';

class DailyNewsTab extends StatelessWidget {
  const DailyNewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
      builder: (context, state) {
        if (state is RemoteArticlesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteArticlesError) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is RemoteArticlesDone) {
          return _buildArticlesList(context, state.articles!);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildArticlesList(
      BuildContext context, List<ArticleEntity> articles) {
    return ListView(
      children: articles
          .map((article) => ArticleWidget(
                article: article,
                onArticlePressed: (pressed) => Navigator.pushNamed(
                  context,
                  '/ArticleDetails',
                  arguments: pressed,
                ),
              ))
          .toList(),
    );
  }
}
