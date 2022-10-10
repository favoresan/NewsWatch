import 'package:dartz/dartz.dart';
import 'package:news_watch/domain/model/model.dart';

import '../../data/network/failure.dart';

abstract class Repository {
  Future<Either<Failure, Article>> getPopularArticle();
  Future<Either<Failure, Article>> getAllArticle();
  Future<Either<Failure, Article>> getBusinessArticle();
  Future<Either<Failure, Article>> getHealthArticle();
  Future<Either<Failure, Article>> getSportArticle();
  Future<Either<Failure, Article>> getPoliticsArticle();
  Future<Either<Failure, Article>> getEntertainmentArticle();
  Future<Either<Failure, Article>> getTechArticle();
  Future<Either<Failure, Article>> getScienceArticle();
  Future<Either<Failure, Article>> getSearchArticle(
      SearchRequest searchRequest);
  Future<Either<Failure, Article>> getPopularRefreshArticle();
  Future<Either<Failure, Article>> getAllRefreshArticle();
  Future<Either<Failure, Article>> getBusinessRefreshArticle();
  Future<Either<Failure, Article>> getHealthRefreshArticle();
  Future<Either<Failure, Article>> getSportRefreshArticle();
  Future<Either<Failure, Article>> getPoliticsRefreshArticle();
  Future<Either<Failure, Article>> getEntertainmentRefreshArticle();
  Future<Either<Failure, Article>> getTechRefreshArticle();
  Future<Either<Failure, Article>> getScienceRefreshArticle();
}
