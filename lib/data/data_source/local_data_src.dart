import 'package:news_watch/data/responses/responses.dart';

import '../error_handler.dart';

const CACHE_POPULAR_KEY = 'CACHE_POPULAR_KEY';
const CACHE_ALL_KEY = 'CACHE_ALL_KEY';
const CACHE_BUSINESS_KEY = 'CACHE_BUSINESS_KEY';
const CACHE_HEALTH_KEY = 'CACHE_HEALTH_KEY';
const CACHE_SPORT_KEY = 'CACHE_SPORT_KEY';
const CACHE_POLITICS_KEY = 'CACHE_POLITICS_KEY';
const CACHE_ENTERTAINMENT_KEY = 'CACHE_ENTERTAINMENT_KEY';
const CACHE_TECH_KEY = 'CACHE_TECH_KEY';
const CACHE_SCIENCE_KEY = 'CACHE_SCIENCE_KEY';
const CACHE_SEARCH_KEY = 'CACHE_SEARCH_KEY';
const CACHE_INTERVAL = 1800 * 1000;

abstract class LocalDataSource {
  Future<ArticleResponse> getPopularArticle();
  Future<ArticleResponse> getAllArticle();
  Future<ArticleResponse> getBusinessArticle();
  Future<ArticleResponse> getHealthArticle();
  Future<ArticleResponse> getSportArticle();
  Future<ArticleResponse> getPoliticsArticle();
  Future<ArticleResponse> getEntertainmentArticle();
  Future<ArticleResponse> getTechArticle();
  Future<ArticleResponse> getScienceArticle();
  Future<ArticleResponse> getSearchArticle();
  Future<void> savePopularToCache(ArticleResponse articleResponse);
  Future<void> saveAllToCache(ArticleResponse articleResponse);
  Future<void> saveBusinessToCache(ArticleResponse articleResponse);
  Future<void> saveHealthToCache(ArticleResponse articleResponse);
  Future<void> saveSportToCache(ArticleResponse articleResponse);
  Future<void> savePoliticsToCache(ArticleResponse articleResponse);
  Future<void> saveEntertainmentToCache(ArticleResponse articleResponse);
  Future<void> saveTechToCache(ArticleResponse articleResponse);
  Future<void> saveScienceToCache(ArticleResponse articleResponse);
  Future<void> saveSearchToCache(ArticleResponse articleResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImplementer implements LocalDataSource {
  Map<String, CachedItem> cacheMap = {};
  @override
  Future<ArticleResponse> getPopularArticle() async {
    CachedItem? cachedItem = cacheMap[CACHE_POPULAR_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> savePopularToCache(ArticleResponse articleResponse) async {
    cacheMap[CACHE_POPULAR_KEY] = CachedItem(articleResponse);
    print(cacheMap[CACHE_POPULAR_KEY]);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<ArticleResponse> getAllArticle() async {
    CachedItem? cachedItem = cacheMap[CACHE_ALL_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<ArticleResponse> getBusinessArticle() async {
    CachedItem? cachedItem = cacheMap[CACHE_BUSINESS_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<ArticleResponse> getEntertainmentArticle() async {
    CachedItem? cachedItem = cacheMap[CACHE_ENTERTAINMENT_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<ArticleResponse> getHealthArticle() async {
    CachedItem? cachedItem = cacheMap[CACHE_HEALTH_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<ArticleResponse> getPoliticsArticle() async {
    CachedItem? cachedItem = cacheMap[CACHE_POLITICS_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<ArticleResponse> getScienceArticle() async {
    CachedItem? cachedItem = cacheMap[CACHE_SCIENCE_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<ArticleResponse> getSearchArticle() async {
    CachedItem? cachedItem = cacheMap[CACHE_SEARCH_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<ArticleResponse> getSportArticle() async {
    CachedItem? cachedItem = cacheMap[CACHE_SPORT_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<ArticleResponse> getTechArticle() async {
    CachedItem? cachedItem = cacheMap[CACHE_TECH_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveAllToCache(ArticleResponse articleResponse) async {
    cacheMap[CACHE_ALL_KEY] = CachedItem(articleResponse);
    print(cacheMap[CACHE_ALL_KEY]);
  }

  @override
  Future<void> saveBusinessToCache(ArticleResponse articleResponse) async {
    cacheMap[CACHE_BUSINESS_KEY] = CachedItem(articleResponse);
    print(cacheMap[CACHE_BUSINESS_KEY]);
  }

  @override
  Future<void> saveEntertainmentToCache(ArticleResponse articleResponse) async {
    cacheMap[CACHE_ENTERTAINMENT_KEY] = CachedItem(articleResponse);
    print(cacheMap[CACHE_ENTERTAINMENT_KEY]);
  }

  @override
  Future<void> saveHealthToCache(ArticleResponse articleResponse) async {
    cacheMap[CACHE_HEALTH_KEY] = CachedItem(articleResponse);
    print(cacheMap[CACHE_HEALTH_KEY]);
  }

  @override
  Future<void> savePoliticsToCache(ArticleResponse articleResponse) async {
    cacheMap[CACHE_POLITICS_KEY] = CachedItem(articleResponse);
    print(cacheMap[CACHE_POLITICS_KEY]);
  }

  @override
  Future<void> saveScienceToCache(ArticleResponse articleResponse) async {
    cacheMap[CACHE_SCIENCE_KEY] = CachedItem(articleResponse);
    print(cacheMap[CACHE_SCIENCE_KEY]);
  }

  @override
  Future<void> saveSearchToCache(ArticleResponse articleResponse) async {
    cacheMap[CACHE_SEARCH_KEY] = CachedItem(articleResponse);
    print(cacheMap[CACHE_SEARCH_KEY]);
  }

  @override
  Future<void> saveSportToCache(ArticleResponse articleResponse) async {
    cacheMap[CACHE_SPORT_KEY] = CachedItem(articleResponse);
    print(cacheMap[CACHE_SPORT_KEY]);
  }

  @override
  Future<void> saveTechToCache(ArticleResponse articleResponse) async {
    cacheMap[CACHE_TECH_KEY] = CachedItem(articleResponse);
    print(cacheMap[CACHE_TECH_KEY]);
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;
  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    bool isCacheValid = currentTimeInMillis - expirationTime < cacheTime;
    return isCacheValid;
  }
}
