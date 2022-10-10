import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:news_watch/presentation/main/tabBar/politics/politics_viewModel.dart';
import 'dart:io' show Platform;

import '../../../../app/di.dart';
import '../../../../data/network/network_info.dart';
import '../../../../domain/model/model.dart';
import '../../../common/state_renderer/state_renderer_impl.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../widget/widget.dart';

class PoliticsTab extends StatefulWidget {
  const PoliticsTab({Key? key}) : super(key: key);

  @override
  State<PoliticsTab> createState() => _PoliticsTabState();
}

class _PoliticsTabState extends State<PoliticsTab> {
  late PoliticsViewModel _viewModel;
  NetworkInfo _networkInfo = instance<NetworkInfo>();

  @override
  void initState()  {
    initPoliticsModule();
    _viewModel = instance<PoliticsViewModel>();
   _call();
    super.initState();
  }

  _call() async {
    if (await _networkInfo.isConnected) {
      _viewModel.start();
    } else {
      _showAlertDialog(
          context: context,
          title: AppStrings.netCon,
          content: AppStrings.networkError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: ColorManager.secondary,
        onRefresh: () async {
          _viewModel.refresh();
        },
        child: Center(child: _scienceDetailsView()));
  }

  Widget _scienceDetailsView() {
    return StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _gridData(), () {
                _viewModel.start();
              }) ??
              Container();
        });
  }

  _gridData() {
    return StreamBuilder<List<ArticleData>>(
        stream: _viewModel.outputPoliticsDetails,
        builder: (context, snapshot) {
          return _scienceList(snapshot.data);
        });
  }

  Widget _scienceList(List<ArticleData>? data) {
    String screenTitle = AppStrings.politics;

    if (data != null) {
      return AnimationLimiter(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(seconds: 1),
                  child: SlideAnimation(
                      verticalOffset: 44,
                      child: FadeInAnimation(
                          child: nullCheck(data, index, screenTitle))));
            }),
      );
    } else {
      return Container();
    }
  }

  Widget nullCheck(List<ArticleData> data, index, screenTitle) {
    if (data[index].img.isNotEmpty &&
        data[index].title.isNotEmpty &&
        data[index].description.isNotEmpty) {
      // reset.add(data[index]);
      return BlogTile(
        article: data[index],
        title: data[index].title,
        img: data[index].img,
        desc: data[index].description,
        time: data[index].time,
        screenTitle: screenTitle,
      );
    } else {
      return Container();
    }
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
                    onPressed: () async {
                      if (await _networkInfo.isConnected) {
                        _viewModel.start();
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      AppStrings.retryAgain,
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
                        AppStrings.retryAgain,
                      ),
                      onPressed: () async {
                        if (await _networkInfo.isConnected) {
                          _viewModel.start();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ));
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
