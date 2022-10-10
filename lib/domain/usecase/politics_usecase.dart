import 'package:dartz/dartz.dart';
import 'package:news_watch/domain/model/model.dart';
import 'package:news_watch/domain/repository/repository.dart';
import 'package:news_watch/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';

class PoliticsUseCase implements BaseUseCase<void, Article> {
  Repository _repository;
  PoliticsUseCase(this._repository);

  @override
  Future<Either<Failure, Article>> execute(void input) async {
    return await _repository.getPoliticsArticle();
  }

  Future<Either<Failure, Article>> executeIn(void input) async {
    return await _repository.getPoliticsRefreshArticle();
  }
}
