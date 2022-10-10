import 'package:news_watch/app/extensions.dart';
import 'package:news_watch/domain/model/model.dart';

import '../responses/responses.dart';

const EMPTY = '';
const ZERO = 0;

extension ArticleDataResponseMapper on ArticleDataResponse? {
  ArticleData toDomain() {
    return ArticleData(
        url: this?.url?.orEmpty() ?? EMPTY,
        author: this?.author?.orEmpty() ?? EMPTY,
        description: this?.description?.orEmpty() ?? EMPTY,
        time: this?.time?.orEmpty() ?? EMPTY,
        content: this?.content?.orEmpty() ?? EMPTY,
        img: this?.img?.orEmpty() ?? EMPTY,
        title: this?.title?.orEmpty() ?? EMPTY);
  }
}

extension ArticleResponseMapper on ArticleResponse? {
  Article toDomain() {
    List<ArticleData> mappedArticles =
        (this?.article?.map((src) => src.toDomain()) ?? Iterable.empty())
            .cast<ArticleData>()
            .toList();

    return Article(
        article: mappedArticles, status: this?.status?.orEmpty() ?? EMPTY);
  }
}
