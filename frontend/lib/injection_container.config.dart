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
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/local/app_database.dart'
    as _i832;
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart'
    as _i552;
import 'package:news_app_clean_architecture/features/daily_news/data/repository/article_repository_impl.dart'
    as _i1071;
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repository.dart'
    as _i458;
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/get_article.dart'
    as _i579;
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/get_saved_article.dart'
    as _i587;
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/remove_article.dart'
    as _i521;
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/save_article.dart'
    as _i701;
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart'
    as _i1053;
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart'
    as _i498;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.singleton<_i361.Dio>(() => appModule.dio);
    await gh.singletonAsync<_i832.AppDatabase>(
      () => appModule.appDatabase,
      preResolve: true,
    );
    gh.singleton<_i552.NewsApiService>(
        () => appModule.newsApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i458.ArticleRepository>(
        () => _i1071.ArticleRepositoryImpl(
              gh<_i552.NewsApiService>(),
              gh<_i832.AppDatabase>(),
            ));
    gh.lazySingleton<_i579.GetArticleUseCase>(
        () => _i579.GetArticleUseCase(gh<_i458.ArticleRepository>()));
    gh.lazySingleton<_i587.GetSavedArticleUseCase>(
        () => _i587.GetSavedArticleUseCase(gh<_i458.ArticleRepository>()));
    gh.lazySingleton<_i521.RemoveArticleUseCase>(
        () => _i521.RemoveArticleUseCase(gh<_i458.ArticleRepository>()));
    gh.lazySingleton<_i701.SaveArticleUseCase>(
        () => _i701.SaveArticleUseCase(gh<_i458.ArticleRepository>()));
    gh.factory<_i1053.LocalArticleBloc>(() => _i1053.LocalArticleBloc(
          gh<_i587.GetSavedArticleUseCase>(),
          gh<_i701.SaveArticleUseCase>(),
          gh<_i521.RemoveArticleUseCase>(),
        ));
    gh.factory<_i498.RemoteArticlesBloc>(
        () => _i498.RemoteArticlesBloc(gh<_i579.GetArticleUseCase>()));
    return this;
  }
}

class _$AppModule extends _i904.AppModule {}
