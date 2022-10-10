import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import '../../app/constant.dart';
import '../responses/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
  @GET('/v2/everything')
  Future<ArticleResponse> getPopularArticle(
    @Query("q") String query,
    @Query("from") String from,
    @Query('apiKey') String apiKey,
  );

  @GET('/v2/top-headlines')
  Future<ArticleResponse> getAllArticle(
    @Query("q") String query,
    @Query('sortBy') String sort,
    @Query('apiKey') String apiKey,
  );

  @GET('/v2/top-headlines')
  Future<ArticleResponse> getPoliticsArticle(
    @Query("category") String category,
    @Query('country') String country,
    @Query('apiKey') String apiKey,
  );

  @GET('/v2/top-headlines')
  Future<ArticleResponse> getBusinessArticle(
    @Query("category") String category,
    @Query('country') String country,
    @Query('apiKey') String apiKey,
  );

  @GET('/v2/top-headlines')
  Future<ArticleResponse> getEntertainmentArticle(
    @Query("category") String category,
    @Query('country') String country,
    @Query('apiKey') String apiKey,
  );

  @GET('/v2/top-headlines')
  Future<ArticleResponse> getHealthArticle(
    @Query("category") String category,
    @Query('country') String country,
    @Query('apiKey') String apiKey,
  );

  @GET('/v2/top-headlines')
  Future<ArticleResponse> getSportsArticle(
    @Query("category") String category,
    @Query('country') String country,
    @Query('apiKey') String apiKey,
  );

  @GET('/v2/top-headlines')
  Future<ArticleResponse> getTechArticle(
    @Query("category") String category,
    @Query('country') String country,
    @Query('apiKey') String apiKey,
  );

  @GET('/v2/top-headlines')
  Future<ArticleResponse> getScienceArticle(
    @Query("category") String category,
    @Query('country') String country,
    @Query('apiKey') String apiKey,
  );

  @GET('/v2/everything')
  Future<ArticleResponse> getSearchArticle(
    @Query("q") String query,
    @Query('sortBy') String sort,
    @Query('apiKey') String apiKey,
    @Query('from') String from,
  );
}
