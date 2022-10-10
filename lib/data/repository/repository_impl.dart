import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_watch/data/mapper/mapper.dart';
import 'package:news_watch/provider.dart';

import '../../app/constant.dart';
import '../../app/di.dart';
import '../../domain/model/model.dart';
import '../../domain/repository/repository.dart';
import '../data_source/local_data_src.dart';
import '../data_source/remote_data_source.dart';
import '../error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';

class RepositoryImpl extends Repository {
  NetworkInfo _networkInfo;
  RemoteDataSource _remoteDataSource;
  LocalDataSource _localDataSource;

  RepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
    this._localDataSource,
  );
  @override
  Future<Either<Failure, Article>> getPopularArticle() async {
    try {
      final response = await _localDataSource.getPopularArticle();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getPopularArticle();
          if (response.status == Constant.ok) {
            _localDataSource.savePopularToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
          }
        } catch (err) {
          return Left(ErrorHandler.handle(err).failure);
        }
      } else {
        return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION));
      }
    }
  }

  @override
  Future<Either<Failure, Article>> getAllArticle() async {
    try {
      final response = await _localDataSource.getAllArticle();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getAllArticle();
          if (response.status == Constant.ok) {
            _localDataSource.saveAllToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
          }
        } catch (err) {
          return Left(ErrorHandler.handle(err).failure);
        }
      } else {
        return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION));
      }
    }
  }

  @override
  Future<Either<Failure, Article>> getBusinessArticle() async {
    try {
      final response = await _localDataSource.getBusinessArticle();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getBusinessArticle();
          if (response.status == Constant.ok) {
            _localDataSource.saveBusinessToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
          }
        } catch (err) {
          return Left(ErrorHandler.handle(err).failure);
        }
      } else {
        return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION));
      }
    }
  }

  @override
  Future<Either<Failure, Article>> getEntertainmentArticle() async {
    try {
      final response = await _localDataSource.getEntertainmentArticle();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getEntertainmentArticle();
          if (response.status == Constant.ok) {
            _localDataSource.saveEntertainmentToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
          }
        } catch (err) {
          return Left(ErrorHandler.handle(err).failure);
        }
      } else {
        return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION));
      }
    }
  }

  @override
  Future<Either<Failure, Article>> getHealthArticle() async {
    try {
      final response = await _localDataSource.getHealthArticle();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getHealthArticle();
          if (response.status == Constant.ok) {
            _localDataSource.saveHealthToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
          }
        } catch (err) {
          return Left(ErrorHandler.handle(err).failure);
        }
      } else {
        return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION));
      }
    }
  }

  @override
  Future<Either<Failure, Article>> getPoliticsArticle() async {
    try {
      final response = await _localDataSource.getPoliticsArticle();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getPoliticsArticle();
          if (response.status == Constant.ok) {
            _localDataSource.savePoliticsToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
          }
        } catch (err) {
          return Left(ErrorHandler.handle(err).failure);
        }
      } else {
        return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION));
      }
    }
  }

  @override
  Future<Either<Failure, Article>> getSportArticle() async {
    try {
      final response = await _localDataSource.getSportArticle();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getSportArticle();
          if (response.status == Constant.ok) {
            _localDataSource.saveSportToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
          }
        } catch (err) {
          return Left(ErrorHandler.handle(err).failure);
        }
      } else {
        return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION));
      }
    }
  }

  @override
  Future<Either<Failure, Article>> getScienceArticle() async {
    try {
      final response = await _localDataSource.getScienceArticle();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getScienceArticle();
          if (response.status == Constant.ok) {
            _localDataSource.saveScienceToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
          }
        } catch (err) {
          return Left(ErrorHandler.handle(err).failure);
        }
      } else {
        return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION));
      }
    }
  }

  @override
  Future<Either<Failure, Article>> getTechArticle() async {
    try {
      final response = await _localDataSource.getTechArticle();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getTechArticle();
          if (response.status == Constant.ok) {
            _localDataSource.saveTechToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
          }
        } catch (err) {
          return Left(ErrorHandler.handle(err).failure);
        }
      } else {
        return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION));
      }
    }
  }

  @override
  Future<Either<Failure, Article>> getSearchArticle(
      SearchRequest searchRequest) async {
    // try {
    //   // final response = await _localDataSource.getSearchArticle();
    //   // return Right(response.toDomain());
    // } catch (cacheError) {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.getSearchArticle(searchRequest);
        if (response.status == Constant.ok) {
          // _localDataSource.saveSearchToCache(response);
          return Right(response.toDomain());
        } else {
          return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
        }
      } catch (err) {
        return Left(ErrorHandler.handle(err).failure);
      }
    } else {
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION));
    }
  }

  @override
  Future<Either<Failure, Article>> getPopularRefreshArticle() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getPopularArticle();
        if (response.status == Constant.ok) {
          _localDataSource.savePopularToCache(response);
          return Right(response.toDomain());
        } else {
          return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
        }
      } catch (err) {
        return Left(ErrorHandler.handle(err).failure);
      }
    } else {
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION));
    }
  }

  @override
  Future<Either<Failure, Article>> getAllRefreshArticle() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getAllArticle();
        if (response.status == Constant.ok) {
          _localDataSource.saveAllToCache(response);
          return Right(response.toDomain());
        } else {
          return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
        }
      } catch (err) {
        return Left(ErrorHandler.handle(err).failure);
      }
    } else {
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION));
    }
  }

  @override
  Future<Either<Failure, Article>> getBusinessRefreshArticle() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getBusinessArticle();
        if (response.status == Constant.ok) {
          _localDataSource.saveBusinessToCache(response);
          return Right(response.toDomain());
        } else {
          return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
        }
      } catch (err) {
        return Left(ErrorHandler.handle(err).failure);
      }
    } else {
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION));
    }
  }

  @override
  Future<Either<Failure, Article>> getEntertainmentRefreshArticle() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getEntertainmentArticle();
        if (response.status == Constant.ok) {
          _localDataSource.saveEntertainmentToCache(response);
          return Right(response.toDomain());
        } else {
          return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
        }
      } catch (err) {
        return Left(ErrorHandler.handle(err).failure);
      }
    } else {
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION));
    }
  }

  @override
  Future<Either<Failure, Article>> getHealthRefreshArticle() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getHealthArticle();
        if (response.status == Constant.ok) {
          _localDataSource.saveHealthToCache(response);
          return Right(response.toDomain());
        } else {
          return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
        }
      } catch (err) {
        return Left(ErrorHandler.handle(err).failure);
      }
    } else {
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION));
    }
  }

  @override
  Future<Either<Failure, Article>> getPoliticsRefreshArticle() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getPoliticsArticle();
        if (response.status == Constant.ok) {
          _localDataSource.savePoliticsToCache(response);
          return Right(response.toDomain());
        } else {
          return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
        }
      } catch (err) {
        return Left(ErrorHandler.handle(err).failure);
      }
    } else {
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION));
    }
  }

  @override
  Future<Either<Failure, Article>> getScienceRefreshArticle() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getScienceArticle();
        if (response.status == Constant.ok) {
          _localDataSource.saveScienceToCache(response);
          return Right(response.toDomain());
        } else {
          return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
        }
      } catch (err) {
        return Left(ErrorHandler.handle(err).failure);
      }
    } else {
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION));
    }
  }

  @override
  Future<Either<Failure, Article>> getSportRefreshArticle() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getSportArticle();
        if (response.status == Constant.ok) {
          _localDataSource.saveSportToCache(response);
          return Right(response.toDomain());
        } else {
          return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
        }
      } catch (err) {
        return Left(ErrorHandler.handle(err).failure);
      }
    } else {
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION));
    }
  }

  @override
  Future<Either<Failure, Article>> getTechRefreshArticle() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getTechArticle();
        if (response.status == Constant.ok) {
          _localDataSource.saveTechToCache(response);
          return Right(response.toDomain());
        } else {
          return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
        }
      } catch (err) {
        return Left(ErrorHandler.handle(err).failure);
      }
    } else {
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION));
    }
  }
}
