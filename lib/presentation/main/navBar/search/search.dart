import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:news_watch/app/di.dart';
import 'package:news_watch/data/network/network_info.dart';
import 'package:news_watch/domain/model/model.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:news_watch/presentation/main/navBar/search/search_viewModel.dart';
import 'package:news_watch/presentation/resources/color_manager.dart';
import 'package:news_watch/presentation/resources/values_manager.dart';
import 'package:news_watch/provider.dart';
import 'dart:io' show Platform;
import '../../../../app/app_pref.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/string_manager.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

TextEditingController _controller = TextEditingController();

class _SearchViewState extends ConsumerState<SearchView> {
  late SearchViewModel _viewModel;
  late FocusNode focus1;
  late FocusNode focus2;
  NetworkInfo _networkInfo = instance<NetworkInfo>();
  AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    focus1 = FocusNode();
    focus2 = FocusNode();
    initSearchModule();
    _viewModel = instance<SearchViewModel>();
    _controller.addListener(() => _viewModel.setSearch(_controller.text));
    super.initState();
  }

  bool autoFocus = false;

  @override
  Widget build(BuildContext context) {
    final savedSearchDataWatch = ref.watch(savedSearchProvider);
    var savedToSet = savedSearchDataWatch.toSet();
    var savedToList = savedToSet.toList();
    final searchBool = ref.watch(searchProvider);
    final changeTextField = ref.watch(changeTextFieldProvider);
    return Column(
      children: [
        Column(
          children: [
            SizedBox(
              height: AppSize.s12,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: changeTextField
                  ? Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          onTap: () {
                            ref.read(changeTextFieldProvider.notifier).state =
                                false;
                            setState(() {
                              if (autoFocus == false) {
                                autoFocus = true;
                              } else {
                                autoFocus = false;
                              }
                            });
                          },
                          // autofocus: false,
                          focusNode: focus1,
                          enableSuggestions: true,
                          cursorColor: ColorManager.grey,
                          style: Theme.of(context).textTheme.headline6,
                          keyboardAppearance: Brightness.light,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (_) {},
                          controller: _controller,
                          decoration: InputDecoration(
                              isCollapsed: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(AppSize.s10),
                                ),
                              ),
                              hintText: 'Search...',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.5,
                                  color: ColorManager.grey,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(AppSize.s10),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 280,
                          child: TextField(
                            enableSuggestions: true,
                            autofocus: autoFocus,
                            cursorColor: ColorManager.grey,
                            style: Theme.of(context).textTheme.headline6,
                            focusNode: focus2,
                            keyboardAppearance: Brightness.light,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (_) async {
                              if (_controller.text.length >= 3) {
                                _call();
                              }
                            },
                            controller: _controller,
                            decoration: InputDecoration(
                              isCollapsed: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.secondary,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(AppSize.s10),
                                ),
                              ),
                              hintText: 'Search...',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.grey,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(AppSize.s10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              ref.read(changeTextFieldProvider.notifier).state =
                                  true;
                              ref.read(searchProvider.notifier).state = true;
                              _controller.clear();
                              setState(() {
                                autoFocus = false;
                              });
                            },
                            child: Text(
                              'Cancel',
                              style: Theme.of(context).textTheme.headline1,
                            ))
                      ],
                    ),
            ),
            SizedBox(
              height: AppSize.s20,
            ),
          ],
        ),
        searchBool
            ? Expanded(child: recentSearch(savedToList))
            : Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        _searchView(),
                      ],
                    )),
              ),
      ],
    );
  }

  Widget _searchView() {
    return StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _searchData(), () {
                _viewModel.start();
              }) ??
              Container();
        });
  }

  Widget _searchData() {
    return StreamBuilder<List<ArticleData>>(
        stream: _viewModel.outputSearch,
        builder: (context, snapshot) {
          return _searchList(snapshot.data);
        });
  }

  Widget _searchList(List<ArticleData>? articleList) {
    if (articleList != null) {
      if (articleList.isNotEmpty) {
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: articleList.length,
            itemBuilder: (context, index) {
              return savedWidget(
                  articleList[index].img,
                  articleList[index].title,
                  articleList[index].time,
                  articleList[index]);
            });
      } else {
        return Column(
          children: [
            SizedBox(
              height: AppSize.s10,
            ),
            Lottie.asset(
              JsonAssets.empty,
            ),
            SizedBox(
              height: AppSize.s15,
            ),
            Text(
              'No search results',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: AppSize.s10,
            ),
            Text(
              'No results found. Please revise your\nsearch and try again.',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ],
        );
      }
    } else {
      return Container();
    }
  }

  Widget savedWidget(String img, String title, String time, articleData) {
    DateTime now = DateTime.parse(time);
    String formattedDate = DateFormat('d MMMM, y').format(now);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.articleRoute,
            arguments: ArticleScreen(
                articleData: articleData, screenTitle: AppStrings.search));
        focus2.unfocus();
      },
      child: Container(
        height: 120,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.visible,
                    maxLines: 4,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 60,
                  width: 110,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: img,
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.lightGrey,
                          ),
                          borderRadius: BorderRadius.circular(5),
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
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.asset(
                          ImageAssets.newsIcon,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              formattedDate,
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(
              height: 3,
            ),
            Divider(
              color: ColorManager.lightGrey,
            ),
          ],
        ),
      ),
    );
  }

  Widget recentSearch(List<String> recent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
          child: recent.isEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: AppSize.s15,
                    ),
                    Text(
                      'No recent searches',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent searches',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    TextButton(
                      onPressed: () {
                        var savedSearchData =
                            ref.read(savedSearchProvider.notifier).state;
                        savedSearchData.clear();
                        ref.read(savedSearchProvider.notifier).state = [];

                        _appPreferences.setSavedSearch(savedSearchData);
                      },
                      child: Text(
                        'Clear',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: recent.length,
              padding: EdgeInsets.only(left: AppPadding.p10),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      enableFeedback: false,
                      dense: true,
                      visualDensity: VisualDensity(vertical: -4),
                      onTap: () async {
                        _viewModel.setSearch(recent[index]);
                        if (await _networkInfo.isConnected) {
                          _viewModel.start();
                        } else {
                          _showAlertDialog(
                              context: context,
                              title: AppStrings.netCon,
                              content: AppStrings.networkError);
                        }
                        _controller.text = recent[index];
                        focus2.unfocus();
                        ref.read(searchProvider.notifier).state = false;
                      },
                      title: Text(
                        recent[index],
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 17.3),
                      child: Divider(
                        color: ColorManager.lightGrey,
                      ),
                    ),
                  ],
                );
              }),
        )
      ],
    );
  }

  Future _showAlertDialog(
      {required BuildContext context,
      required String title,
      required String content}) async {
    if (!Platform.isIOS) {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: ColorManager.primary,
                title: Text(title),
                content: Text(content),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppStrings.dismiss,
                    ),
                  ),
                ],
              ));
    } else {
      return showCupertinoDialog(
          context: context,
          builder: (context) => Theme(
                data: ThemeData.light(),
                child: CupertinoAlertDialog(
                  title: Text(
                    title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  content: Text(content),
                  actions: [
                    CupertinoDialogAction(
                      child: Text(
                        AppStrings.dismiss,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ));
    }
  }

  _call() async {
    if (await _networkInfo.isConnected) {
      _viewModel.start();
      final savedSearchData = ref.read(savedSearchProvider);
      savedSearchData.add(_controller.text);
      _appPreferences.setSavedSearch(savedSearchData);
      _controller.clear();
      ref.read(searchProvider.notifier).state = false;
    } else {
      _showAlertDialog(
          context: context,
          title: AppStrings.netCon,
          content: AppStrings.networkError);
    }
  }

  @override
  void dispose() {
    focus1.dispose();
    focus2.dispose();
    _viewModel.dispose();
    super.dispose();
  }
}
