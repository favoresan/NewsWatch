import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class HealthUseCase implements BaseUseCase<void, Article> {
  Repository _repository;
  HealthUseCase(this._repository);

  @override
  Future<Either<Failure, Article>> execute(void input) async {
    return await _repository.getHealthArticle();
  }

  Future<Either<Failure, Article>> executeIn(void input) async {
    return await _repository.getHealthRefreshArticle();
  }
}
