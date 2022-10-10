// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDataResponse _$ArticleDataResponseFromJson(Map<String, dynamic> json) =>
    ArticleDataResponse(
      title: json['title'] as String?,
      img: json['urlToImage'] as String?,
      content: json['content'] as String?,
      time: json['publishedAt'] as String?,
      description: json['description'] as String?,
      author: json['author'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ArticleDataResponseToJson(
        ArticleDataResponse instance) =>
    <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.img,
      'publishedAt': instance.time,
      'content': instance.content,
    };

ArticleResponse _$ArticleResponseFromJson(Map<String, dynamic> json) =>
    ArticleResponse(
      status: json['status'] as String?,
      article: (json['articles'] as List<dynamic>?)
          ?.map((e) => ArticleDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleResponseToJson(ArticleResponse instance) =>
    <String, dynamic>{
      'articles': instance.article,
      'status': instance.status,
    };
