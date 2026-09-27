// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:news_app_clean_architecture/core/di/app_module.dart' as _i904;
import 'package:news_app_clean_architecture/features/news/data/data_sources/local/app_database.dart'
    as _i924;
import 'package:news_app_clean_architecture/features/news/data/data_sources/remote/news_api_service.dart'
    as _i893;
import 'package:news_app_clean_architecture/features/news/data/data_sources/remote/user_articles_firebase_service.dart'
    as _i1;
import 'package:news_app_clean_architecture/features/news/data/repository/article_repository_impl.dart'
    as _i865;
import 'package:news_app_clean_architecture/features/news/data/repository/user_article_repository_impl.dart'
    as _i401;
import 'package:news_app_clean_architecture/features/news/domain/repository/article_repository.dart'
    as _i862;
import 'package:news_app_clean_architecture/features/news/domain/repository/user_article_repository.dart'
    as _i37;
import 'package:news_app_clean_architecture/features/news/domain/usecases/create_user_article.dart'
    as _i508;
import 'package:news_app_clean_architecture/features/news/domain/usecases/get_article.dart'
    as _i838;
import 'package:news_app_clean_architecture/features/news/domain/usecases/get_saved_article.dart'
    as _i572;
import 'package:news_app_clean_architecture/features/news/domain/usecases/remove_article.dart'
    as _i1042;
import 'package:news_app_clean_architecture/features/news/domain/usecases/save_article.dart'
    as _i150;
import 'package:news_app_clean_architecture/features/news/presentation/bloc/article/local/local_article_bloc.dart'
    as _i8;
import 'package:news_app_clean_architecture/features/news/presentation/bloc/article/remote/remote_article_bloc.dart'
    as _i933;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i1.UserArticlesFirebaseService>(
        () => _i1.UserArticlesFirebaseService());
    gh.singleton<_i361.Dio>(() => appModule.dio);
    gh.singleton<_i924.AppDatabase>(() => appModule.appDatabase);
    gh.singleton<_i893.NewsApiService>(
        () => appModule.newsApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i37.UserArticleRepository>(() =>
        _i401.UserArticleRepositoryImpl(gh<_i1.UserArticlesFirebaseService>()));
    gh.lazySingleton<_i508.CreateUserArticle>(
        () => _i508.CreateUserArticle(gh<_i37.UserArticleRepository>()));
    gh.lazySingleton<_i862.ArticleRepository>(() => _i865.ArticleRepositoryImpl(
          gh<_i893.NewsApiService>(),
          gh<_i924.AppDatabase>(),
        ));
    gh.lazySingleton<_i838.GetArticleUseCase>(
        () => _i838.GetArticleUseCase(gh<_i862.ArticleRepository>()));
    gh.lazySingleton<_i572.GetSavedArticleUseCase>(
        () => _i572.GetSavedArticleUseCase(gh<_i862.ArticleRepository>()));
    gh.lazySingleton<_i1042.RemoveArticleUseCase>(
        () => _i1042.RemoveArticleUseCase(gh<_i862.ArticleRepository>()));
    gh.lazySingleton<_i150.SaveArticleUseCase>(
        () => _i150.SaveArticleUseCase(gh<_i862.ArticleRepository>()));
    gh.factory<_i8.LocalArticleBloc>(() => _i8.LocalArticleBloc(
          gh<_i572.GetSavedArticleUseCase>(),
          gh<_i150.SaveArticleUseCase>(),
          gh<_i1042.RemoveArticleUseCase>(),
        ));
    gh.factory<_i933.RemoteArticlesBloc>(
        () => _i933.RemoteArticlesBloc(gh<_i838.GetArticleUseCase>()));
    return this;
  }
}

class _$AppModule extends _i904.AppModule {}
