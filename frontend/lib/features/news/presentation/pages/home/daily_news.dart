import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:news_app_clean_architecture/features/news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app_clean_architecture/features/news/presentation/bloc/article/remote/remote_article_state.dart';

import '../../../domain/entities/article.entity.dart';
import '../../widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  const DailyNews({
    super.key,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return _buildPage();
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Ionicons.menuOutline, color: Colors.black, size: 26),
        onPressed: () {
          if (onMenuPressed != null) {
            onMenuPressed!();
          } else {
            AwesomeDrawerBar.of(context)?.toggle();
          }
        },
      ),
      title: const Text(
        'Daily News',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        GestureDetector(
          onTap: () => _onShowSavedArticlesViewTapped(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.bookmark, color: Colors.black),
          ),
        ),
        _buildAuthIndicator(context),
      ],
    );
  }

  Widget _buildAuthIndicator(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoggedIn = state is Authenticated;
        final user = isLoggedIn ? state.user : null;

        return GestureDetector(
          onTap: () {
            if (isLoggedIn) {
              if (onMenuPressed != null) {
                onMenuPressed!();
              } else {
                AwesomeDrawerBar.of(context)?.toggle();
              }
            } else {
              Navigator.pushNamed(context, '/Login');
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 14, left: 4),
            child: Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: isLoggedIn ? Colors.black87 : Colors.black12,
                    child: Text(
                      isLoggedIn
                          ? (user!.displayName?.isNotEmpty == true
                              ? user.displayName![0].toUpperCase()
                              : user.email.isNotEmpty
                                  ? user.email[0].toUpperCase()
                                  : 'U')
                          : '?',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isLoggedIn ? Colors.white : Colors.black54,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isLoggedIn ? Colors.green : Colors.grey,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPage() {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
      builder: (context, state) {
        if (state is RemoteArticlesLoading) {
          return Scaffold(
            appBar: _buildAppbar(context),
            body: const Center(child: CupertinoActivityIndicator()),
          );
        }
        if (state is RemoteArticlesError) {
          return Scaffold(
            appBar: _buildAppbar(context),
            body: const Center(child: Icon(Icons.refresh)),
          );
        }
        if (state is RemoteArticlesDone) {
          return _buildArticlesPage(context, state.articles!);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildArticlesPage(
      BuildContext context, List<ArticleEntity> articles) {
    final articleWidgets = articles
        .map((article) => ArticleWidget(
              article: article,
              onArticlePressed: (article) => _onArticlePressed(context, article),
            ))
        .toList();

    return Scaffold(
      appBar: _buildAppbar(context),
      body: ListView(children: articleWidgets),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/CreateArticle'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }
}
