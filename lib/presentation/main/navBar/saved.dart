import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_watch/app/app_pref.dart';
import 'package:news_watch/app/di.dart';
import 'package:news_watch/presentation/resources/color_manager.dart';
import 'package:news_watch/presentation/resources/values_manager.dart';
import 'package:news_watch/provider.dart';
import '../../../domain/model/model.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/string_manager.dart';

class SavedView extends ConsumerWidget {
  SavedView({Key? key}) : super(key: key);

  AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedList = ref.watch(savedProvider);
    var savedArticles = savedList.toSet();
    var savedArticlesList = savedArticles.toList();
    if (savedArticlesList.isNotEmpty) {
      return ListView.builder(
          // shrinkWrap: true,
          itemCount: savedArticlesList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            var toString = FromJsonArticleData.fromJson(
                jsonDecode(savedArticlesList[index]));
            ArticleData articleData = ArticleData(
                url: toString.url,
                author: toString.author,
                description: toString.description,
                time: toString.time,
                content: toString.content,
                img: toString.img,
                title: toString.title);
            return savedWidget(toString.img, toString.title, toString.time,
                context, ref, articleData, savedArticlesList[index]);
          });
    } else {
      return Column(
        children: [
          SizedBox(
            height: AppSize.s28,
          ),
          Image.asset(
            ImageAssets.bookmarkIcon,
          ),
          SizedBox(
            height: AppSize.s15,
          ),
          Text(
            'Find your saved\narticles here',
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: AppSize.s10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'When reading an article, tap the',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                Icon(
                  Icons.bookmark_outline,
                  color: ColorManager.grey,
                ),
              ],
            ),
          ),
          Text(
            'icon to save it. You\'ll be able to come\n back here to read it later.',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }

  Widget savedWidget(
      String img,
      String title,
      String time,
      BuildContext context,
      WidgetRef ref,
      ArticleData articleData,
      String savedListString) {
    // DateTime then = DateTime.now();
    // String formattedDate1 = DateFormat('d MMMM, y').format(then);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.articleRoute,
            arguments: ArticleScreen(
                articleData: articleData, screenTitle: AppStrings.saved));
      },
      child: Container(
        height: 156,
        width: double.infinity,
        padding: EdgeInsets.only(top: AppPadding.p10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                    width: 120,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: img,
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.lightGrey,
                          ),
                        ),
                        child: Image.asset(
                          ImageAssets.newsIcon,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.lightGrey,
                          ),
                        ),
                        child: Image.asset(
                          ImageAssets.newsIcon,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline1,
                      overflow: TextOverflow.visible,
                      maxLines: 4,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s5,
            ),
            Padding(
              padding: EdgeInsets.only(right: AppPadding.p15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Saved on $time',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    width: AppSize.s10,
                  ),
                  GestureDetector(
                    onTap: () {
                      final List<String> remove = ref.read(savedProvider);
                      var removeToSet = remove.toSet();
                      var backToList = removeToSet.toList();
                      backToList.remove(savedListString);
                      ref.read(savedProvider.notifier).state =
                          List.from(backToList);

                      _appPreferences.setSaved(backToList);
                    },
                    child: Icon(
                      Icons.delete_outline_outlined,
                      size: AppSize.s25,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              color: ColorManager.lightGrey,
            ),
          ],
        ),
      ),
    );
  }
}
