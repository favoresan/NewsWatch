import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_watch/domain/usecase/entertainment_usecase.dart';
import 'package:news_watch/domain/usecase/popular_usecase.dart';
import 'package:news_watch/presentation/main/tabBar/popular/popular_viewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

import '../data/data_source/local_data_src.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/usecase/all_usecase.dart';
import '../domain/usecase/business_usecase.dart';
import '../domain/usecase/health_usecase.dart';
import '../domain/usecase/politics_usecase.dart';
import '../domain/usecase/science_usecase.dart';
import '../domain/usecase/search_usecase.dart';
import '../domain/usecase/sport_usecase.dart';
import '../domain/usecase/tech_usecase.dart';
import '../presentation/main/navBar/search/search_viewModel.dart';
import '../presentation/main/tabBar/all/all_viewModel.dart';
import '../presentation/main/tabBar/business/business_viewModel.dart';
import '../presentation/main/tabBar/entertainment/entertainment_viewModel.dart';
import '../presentation/main/tabBar/health/health_viewModel.dart';
import '../presentation/main/tabBar/politics/politics_viewModel.dart';
import '../presentation/main/tabBar/science/science_viewModel.dart';
import '../presentation/main/tabBar/sport/sport_viewModel.dart';
import '../presentation/main/tabBar/tech/tech_viewModel.dart';
import 'app_pref.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  //shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  //app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  // //network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(DataConnectionChecker()));
  //dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory());
  //app service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  //remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));
  //local data source
  instance.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImplementer());
  //repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(
        instance(),
        instance(),
        instance(),
      ));
}

initPopularModule() {
  if (!GetIt.I.isRegistered<PopularUseCase>()) {
    instance.registerFactory<PopularUseCase>(() => PopularUseCase(instance()));
    instance
        .registerFactory<PopularViewModel>(() => PopularViewModel(instance()));
  }
}

initScienceModule() {
  if (!GetIt.I.isRegistered<ScienceUseCase>()) {
    instance.registerFactory<ScienceUseCase>(() => ScienceUseCase(instance()));
    instance
        .registerFactory<ScienceViewModel>(() => ScienceViewModel(instance()));
  }
}

initSportModule() {
  if (!GetIt.I.isRegistered<SportUseCase>()) {
    instance.registerFactory<SportUseCase>(() => SportUseCase(instance()));
    instance.registerFactory<SportViewModel>(() => SportViewModel(instance()));
  }
}

initTechModule() {
  if (!GetIt.I.isRegistered<TechUseCase>()) {
    instance.registerFactory<TechUseCase>(() => TechUseCase(instance()));
    instance.registerFactory<TechViewModel>(() => TechViewModel(instance()));
  }
}

initAllModule() {
  if (!GetIt.I.isRegistered<AllUseCase>()) {
    instance.registerFactory<AllUseCase>(() => AllUseCase(instance()));
    instance.registerFactory<AllViewModel>(() => AllViewModel(instance()));
  }
}

initBusinessModule() {
  if (!GetIt.I.isRegistered<BusinessUseCase>()) {
    instance
        .registerFactory<BusinessUseCase>(() => BusinessUseCase(instance()));
    instance.registerFactory<BusinessViewModel>(
        () => BusinessViewModel(instance()));
  }
}

initEntertainmentModule() {
  if (!GetIt.I.isRegistered<EntertainmentUseCase>()) {
    instance.registerFactory<EntertainmentUseCase>(
        () => EntertainmentUseCase(instance()));
    instance.registerFactory<EntertainmentViewModel>(
        () => EntertainmentViewModel(instance()));
  }
}

initHealthModule() {
  if (!GetIt.I.isRegistered<HealthUseCase>()) {
    instance.registerFactory<HealthUseCase>(() => HealthUseCase(instance()));
    instance
        .registerFactory<HealthViewModel>(() => HealthViewModel(instance()));
  }
}

initPoliticsModule() {
  if (!GetIt.I.isRegistered<PoliticsUseCase>()) {
    instance
        .registerFactory<PoliticsUseCase>(() => PoliticsUseCase(instance()));
    instance.registerFactory<PoliticsViewModel>(
        () => PoliticsViewModel(instance()));
  }
}

initSearchModule() {
  if (!GetIt.I.isRegistered<SearchUseCase>()) {
    instance.registerFactory<SearchUseCase>(() => SearchUseCase(instance()));
    instance
        .registerFactory<SearchViewModel>(() => SearchViewModel(instance()));
  }
}
