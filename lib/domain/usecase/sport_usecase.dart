import 'package:dartz/dartz.dart';
import 'package:news_watch/domain/model/model.dart';
import 'package:news_watch/domain/repository/repository.dart';
import 'package:news_watch/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';

class SportUseCase implements BaseUseCase<void, Article> {
  Repository _repository;
  SportUseCase(this._repository);

  @override
  Future<Either<Failure, Article>> execute(void input) async {
    return await _repository.getSportArticle();
  }

  Future<Either<Failure, Article>> executeIn(void input) async {
    return await _repository.getSportRefreshArticle();
  }
}
