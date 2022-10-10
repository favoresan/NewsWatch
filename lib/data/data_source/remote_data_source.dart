import 'package:news_watch/data/responses/responses.dart';
import 'package:news_watch/app/constant.dart';
import 'package:news_watch/domain/model/model.dart';
import '../network/app_api.dart';
import 'package:intl/intl.dart';

abstract class RemoteDataSource {
  Future<ArticleResponse> getPopularArticle();
  Future<ArticleResponse> getAllArticle();
  Future<ArticleResponse> getPoliticsArticle();
  Future<ArticleResponse> getBusinessArticle();
  Future<ArticleResponse> getHealthArticle();
  Future<ArticleResponse> getEntertainmentArticle();
  Future<ArticleResponse> getSportArticle();
  Future<ArticleResponse> getTechArticle();
  Future<ArticleResponse> getScienceArticle();
  Future<ArticleResponse> getSearchArticle(SearchRequest searchRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  AppServiceClient _appServiceClient;
  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<ArticleResponse> getPopularArticle() async {
    return await _appServiceClient.getPopularArticle(
        Constant.nig, formattedDate1, Constant.apiKey);
  }

  @override
  Future<ArticleResponse> getAllArticle() async {
    return await _appServiceClient.getAllArticle(
        Constant.query, Constant.sort, Constant.apiKey);
  }

  @override
  Future<ArticleResponse> getPoliticsArticle() async {
    return await _appServiceClient.getPoliticsArticle(
        Constant.politics, Constant.country, Constant.apiKey);
  }

  @override
  Future<ArticleResponse> getBusinessArticle() async {
    return await _appServiceClient.getPoliticsArticle(
        Constant.business, Constant.country, Constant.apiKey);
  }

  @override
  Future<ArticleResponse> getEntertainmentArticle() async {
    return await _appServiceClient.getPoliticsArticle(
        Constant.entertainment, Constant.country, Constant.apiKey);
  }

  @override
  Future<ArticleResponse> getHealthArticle() async {
    return await _appServiceClient.getPoliticsArticle(
        Constant.health, Constant.country, Constant.apiKey);
  }

  @override
  Future<ArticleResponse> getSportArticle() async {
    return await _appServiceClient.getPoliticsArticle(
        Constant.sport, Constant.country, Constant.apiKey);
  }

  @override
  Future<ArticleResponse> getScienceArticle() async {
    return await _appServiceClient.getPoliticsArticle(
        Constant.science, Constant.country, Constant.apiKey);
  }

  @override
  Future<ArticleResponse> getTechArticle() async {
    return await _appServiceClient.getPoliticsArticle(
        Constant.tech, Constant.country, Constant.apiKey);
  }

  @override
  Future<ArticleResponse> getSearchArticle(SearchRequest searchRequest) async {
    return await _appServiceClient.getSearchArticle(
        searchRequest.search, Constant.sort, Constant.apiKey, formattedDate2);
  }
}

DateTime then = DateTime.now().subtract(
  Duration(hours: 6),
);
String formattedDate1 = DateFormat('yyyy-MM-dd').format(then);

DateTime week = DateTime.now().subtract(
  Duration(days: 7),
);
String formattedDate2 = DateFormat('yyyy-MM-dd').format(week);
