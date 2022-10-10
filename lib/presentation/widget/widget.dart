import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_watch/presentation/resources/assets_manager.dart';
import 'package:news_watch/presentation/resources/routes_manager.dart';
import '../../domain/model/model.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class BlogTile extends ConsumerWidget {
  String img, title, desc, time, screenTitle;
  ArticleData article;
  // Function onTap;
  BlogTile({
    required this.title,
    required this.img,
    required this.desc,
    required this.time,
    required this.article,
    required this.screenTitle,
    // required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String timeDiff(String time) {
      DateTime now = DateTime.parse(time);
      Duration dur = DateTime.now().difference(now);
      Duration diff1 = Duration(hours: 1);
      Duration diff2 = Duration(hours: 24);
      String inMins = dur.inMinutes.floor().toString();
      String inDays = dur.inDays.floor().toString();
      String inHrs = dur.inHours.floor().toString();
      if (dur.inHours < diff1.inHours) {
        return '$inMins min ago';
      } else if (dur.inHours >= diff2.inHours) {
        return '$inDays days ago';
      } else {
        return '$inHrs hr ago';
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.articleRoute,
            arguments:
                ArticleScreen(articleData: article, screenTitle: screenTitle));
      },
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSize.s8,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.s12),
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline1,
                )),
            SizedBox(
              height: AppSize.s8,
            ),
            Center(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: img,
                placeholder: (context, url) => Image.asset(
                  ImageAssets.newsIcon,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  ImageAssets.newsIcon,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: AppPadding.p12),
                          child: Text(
                            timeDiff(
                              time,
                            ),
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     DateTime then = DateTime.now();
                        //     String formattedDate1 =
                        //         DateFormat('d MMMM, y').format(then);
                        //     ref.read(bookMarkProvider.notifier).state = true;
                        //     final save = ref.read(savedProvider);
                        //     ToJsonArticleData savedData = ToJsonArticleData(
                        //         url: article.url,
                        //         author: article.author,
                        //         description: article.description,
                        //         time: formattedDate1,
                        //         content: article.content,
                        //         img: article.img,
                        //         title: article.title);
                        //     String jsonString =
                        //         jsonEncode(savedData.toJson());
                        //     save.add(jsonString);
                        //     _appPreferences.setSaved(save);
                        //   },
                        //   child: Icon(
                        //
                        //     color: ColorManager.secondary,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Divider(
                    color: ColorManager.lightGrey,
                  ),
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.s12),
                    child: Text(
                      desc,
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: AppSize.s8,
              color: ColorManager.sky,
            ),
            // SizedBox(
            //   height: AppSize.s12,
            // ),
          ],
        ),
      ),
    );
  }
}

// GestureDetector(
//   onTap: () {
//     DateTime then = DateTime.now();
//     String formattedDate1 =
//         DateFormat('d MMMM, y').format(then);
//     ref.read(bookMarkProvider.notifier).state = true;
//     final save = ref.read(savedProvider);
//     ToJsonArticleData savedData = ToJsonArticleData(
//         url: article.url,
//         author: article.author,
//         description: article.description,
//         time: formattedDate1,
//         content: article.content,
//         img: article.img,
//         title: article.title);
//     String jsonString =
//         jsonEncode(savedData.toJson());
//     save.add(jsonString);
//     _appPreferences.setSaved(save);
//   },
//   child: Icon(
//
//     color: ColorManager.secondary,
//   ),
// )
