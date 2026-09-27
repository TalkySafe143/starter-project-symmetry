import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../injection_container.dart';
import '../../bloc/article/user/user_articles_bloc.dart';
import '../../widgets/article_tile.dart';

class MyArticlesPage extends StatelessWidget {
  const MyArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserArticlesBloc>()..add(const LoadUserArticles()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.pop(context),
          child: const Icon(Ionicons.chevronBack, color: Colors.black),
        ),
      ),
      title: const Text('My Articles', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<UserArticlesBloc, UserArticlesState>(
      builder: (context, state) {
        if (state is UserArticlesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is UserArticlesDone) {
          if (state.articles.isEmpty) {
            return const Center(
              child: Text(
                'YOU HAVE NOT WRITTEN ANY ARTICLES YET',
                style: TextStyle(color: Colors.black),
              ),
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
        } else if (state is UserArticlesError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.black),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
