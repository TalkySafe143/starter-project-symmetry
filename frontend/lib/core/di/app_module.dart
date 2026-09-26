import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';

@module
abstract class AppModule {
  @singleton
  Dio get dio => Dio();

  @singleton
  NewsApiService newsApiService(Dio dio) => NewsApiService(dio);

  /// AppDatabase requires an async builder, so we mark it @preResolve.
  /// injectable will await this before registering anything that depends on it.
  @preResolve
  @singleton
  Future<AppDatabase> get appDatabase =>
      $FloorAppDatabase.databaseBuilder('app_database.db').build();
}
