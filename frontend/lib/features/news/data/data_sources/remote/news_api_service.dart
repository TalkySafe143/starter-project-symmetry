import 'package:news_app_clean_architecture/features/news/data/models/news_api_response.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/constants.dart';
import 'package:dio/dio.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: newsAPIBaseURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio, {String? baseUrl}) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<NewsApiResponse>> getNewsArticles({
    @Query('apiKey') String? apiKey,
    @Query('country') String? country,
    @Query('category') String? category,
  });
}
