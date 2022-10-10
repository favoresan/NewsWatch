import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class ArticleDataResponse {
  @JsonKey(name: 'author')
  String? author;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'urlToImage')
  String? img;
  @JsonKey(name: 'publishedAt')
  String? time;
  @JsonKey(name: 'content')
  String? content;
  ArticleDataResponse(
      {this.title,
      this.img,
      this.content,
      this.time,
      this.description,
      this.author,
      this.url});
  factory ArticleDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticleDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleDataResponseToJson(this);
}

@JsonSerializable()
class ArticleResponse {
  @JsonKey(name: 'articles')
  List<ArticleDataResponse>? article;
  @JsonKey(name: 'status')
  String? status;
  ArticleResponse({this.status, this.article});
  factory ArticleResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticleResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleResponseToJson(this);
}
