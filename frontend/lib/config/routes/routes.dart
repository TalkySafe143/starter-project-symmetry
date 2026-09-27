import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/edit_profile/edit_profile_page.dart';
import '../../features/auth/presentation/pages/login/login_page.dart';
import '../../features/auth/presentation/pages/register/register_page.dart';
import '../../features/home/presentation/pages/main_layout.dart';
import '../../features/news/domain/entities/article.entity.dart';
import '../../features/news/presentation/pages/article_detail/article_detail.dart';
import '../../features/news/presentation/pages/create_article/create_article_page.dart';
import '../../features/news/presentation/pages/my_articles/my_articles_page.dart';
import '../../features/news/presentation/pages/saved_article/saved_article.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const MainLayout());

      case '/ArticleDetails':
        return _materialRoute(ArticleDetailsView(article: settings.arguments as ArticleEntity));

      case '/SavedArticles':
        return _materialRoute(const SavedArticles());

      case '/MyArticles':
        return _materialRoute(const MyArticlesPage());

      case '/CreateArticle':
        return _materialRoute(const CreateArticlePage());

      case '/Login':
        return _materialRoute(const LoginPage());

      case '/Register':
        return _materialRoute(const RegisterPage());

      case '/EditProfile':
        return _materialRoute(const EditProfilePage());

      default:
        return _materialRoute(const MainLayout());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
