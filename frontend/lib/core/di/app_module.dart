import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app_clean_architecture/features/news/data/data_sources/local/app_database.dart';
import 'package:news_app_clean_architecture/features/news/data/data_sources/remote/news_api_service.dart';

@module
abstract class AppModule {
  @singleton
  Dio get dio => Dio();

  @singleton
  NewsApiService newsApiService(Dio dio) => NewsApiService(dio);

  /// AppDatabase is synchronous in Drift — no async builder needed.
  @singleton
  AppDatabase get appDatabase => AppDatabase();
}
