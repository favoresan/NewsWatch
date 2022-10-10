import 'package:dartz/dartz.dart';
import 'package:news_watch/data/network/failure.dart';
import 'package:news_watch/domain/repository/repository.dart';
import 'package:news_watch/domain/usecase/base_usecase.dart';

import '../model/model.dart';

class SearchUseCase implements BaseUseCase<SearchUseCaseInput, Article> {
  Repository _repository;
  SearchUseCase(this._repository);
  @override
  Future<Either<Failure, Article>> execute(SearchUseCaseInput input) async {
    return await _repository
        .getSearchArticle(SearchRequest(search: input.search));
  }
}

class SearchUseCaseInput {
  String search;
  SearchUseCaseInput(this.search);
}
