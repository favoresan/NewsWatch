import 'dart:async';
import 'dart:convert';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:news_watch/app/di.dart';
import 'package:news_watch/presentation/resources/assets_manager.dart';
import 'package:news_watch/presentation/resources/color_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../app/app_pref.dart';
import '../../domain/model/model.dart';
import '../../provider.dart';
import '../resources/values_manager.dart';

class ArticleView extends ConsumerStatefulWidget {
  ArticleScreen data;
  ArticleView(
    this.data,
  );

  @override
  ConsumerState<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends ConsumerState<ArticleView> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  AppPreferences _appPreferences = instance<AppPreferences>();

  bool change = true;
  final _key = UniqueKey();
  late Timer _timer;

  @override
  Widget build(
    BuildContext context,
  ) {
    // final bookMark = ref.watch(bookMarkProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.secondary,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorManager.primary,
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.data.screenTitle,
          style: Theme.of(context).textTheme.headline2,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppPadding.p20),
            child: BouncingWidget(
              duration: Duration(milliseconds: 150),
              scaleFactor: 3,
              onPressed: () {
                DateTime then = DateTime.now();
                String formattedDate1 = DateFormat('d MMMM, y').format(then);
                // ref.read(bookMarkProvider.notifier).state = true;
                final save = ref.read(savedProvider);
                ToJsonArticleData savedData = ToJsonArticleData(
                    url: widget.data.articleData.url,
                    author: widget.data.articleData.author,
                    description: widget.data.articleData.description,
                    time: formattedDate1,
                    content: widget.data.articleData.content,
                    img: widget.data.articleData.img,
                    title: widget.data.articleData.title);
                String jsonString = jsonEncode(savedData.toJson());
                save.add(jsonString);
                _appPreferences.setSaved(save);
              },
              child: Icon(
                Icons.bookmark_outlined,
                color: ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebView(
            key: _key,
            onPageStarted: (finish) {
              setState(() {
                change = false;
              });
            },
            initialUrl: widget.data.articleData.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: ((WebViewController webViewController) {
              _completer.complete(webViewController);
            }),
          ),
          change
              ? Center(
                  child: SizedBox(
                    height: AppSize.s100,
                    width: AppSize.s100,
                    child: Lottie.asset(JsonAssets.loading), //json image
                  ),
                )
              : Stack(),
        ],
      ),
    );
  }
}
