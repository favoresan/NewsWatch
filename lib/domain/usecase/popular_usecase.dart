import 'package:dartz/dartz.dart';
import 'package:news_watch/data/network/failure.dart';
import 'package:news_watch/domain/model/model.dart';
import 'package:news_watch/domain/repository/repository.dart';
import 'package:news_watch/domain/usecase/base_usecase.dart';

class PopularUseCase implements BaseUseCase<void, Article> {
  Repository _repository;
  PopularUseCase(this._repository);
  @override
  Future<Either<Failure, Article>> execute(void input) async {
    return await _repository.getPopularArticle();
  }

  Future<Either<Failure, Article>> executeIn(void input) async {
    return await _repository.getPopularRefreshArticle();
  }
}
