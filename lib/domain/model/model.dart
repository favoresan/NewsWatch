class ArticleData {
  String title, img, content, time, description, author, url;
  ArticleData(
      {required this.url,
      required this.author,
      required this.description,
      required this.time,
      required this.content,
      required this.img,
      required this.title});
}

class Article {
  List<ArticleData> article;
  String status;
  Article({required this.article, required this.status});
}

class ArticleScreen {
  ArticleData articleData;
  String screenTitle;
  ArticleScreen({required this.articleData, required this.screenTitle});
}

class SearchRequest {
  String search;
  SearchRequest({required this.search});
}

class ToJsonArticleData {
  String title, img, content, time, description, author, url;
  ToJsonArticleData(
      {required this.url,
      required this.author,
      required this.description,
      required this.time,
      required this.content,
      required this.img,
      required this.title});

  Map toJson() => {
        'title': title,
        'img': img,
        'content': content,
        'time': time,
        'desc': description,
        'author': author,
        'url': url
      };
}

class FromJsonArticleData {
  String title, img, content, time, description, author, url;
  FromJsonArticleData(
      {required this.url,
      required this.author,
      required this.description,
      required this.time,
      required this.content,
      required this.img,
      required this.title});

  factory FromJsonArticleData.fromJson(dynamic json) {
    return FromJsonArticleData(
        url: json['url'],
        author: json['author'],
        description: json['desc'],
        time: json['time'],
        content: json['content'],
        img: json['img'],
        title: json['title']);
  }

  //#FAFAFA
}
