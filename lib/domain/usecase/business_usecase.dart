import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class BusinessUseCase implements BaseUseCase<void, Article> {
  Repository _repository;
  BusinessUseCase(this._repository);

  @override
  Future<Either<Failure, Article>> execute(void input) async {
    return await _repository.getBusinessArticle();
  }

  Future<Either<Failure, Article>> executeIn(void input) async {
    return await _repository.getBusinessRefreshArticle();
  }
}
