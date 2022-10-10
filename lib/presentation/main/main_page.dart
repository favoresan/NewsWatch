import 'package:flutter/material.dart';
import 'package:news_watch/presentation/main/navBar/home.dart';
import 'package:news_watch/presentation/main/navBar/saved.dart';
import 'package:news_watch/presentation/main/navBar/search/search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_watch/presentation/main/tabBar/popular/popular_viewModel.dart';
import '../../app/di.dart';
import '../../provider.dart';
import '../resources/color_manager.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';

class MainView extends ConsumerStatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  ConsumerState<MainView> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  List<Widget> pages = [
    HomeView(),
    SearchView(),
    SavedView(),
  ];

  @override
  Widget build(BuildContext context) {
    final numIndex = ref.watch(numProvider);
    var currentIndex = numIndex;
    List<Widget> titles = [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'News',
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(
            'Watch',
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
      Text(
        AppStrings.search,
        style: Theme.of(context).textTheme.headline3,
      ),
      Text(
        AppStrings.saved,
        style: Theme.of(context).textTheme.headline3,
      ),
    ];

    var _title = titles[currentIndex];
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorManager.secondary,
          centerTitle: true,
          elevation: 0,
          title: _title),
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        height: 91,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: ColorManager.lightGrey,
                spreadRadius: 2,
                offset: Offset(0, 6)),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 10,
          selectedItemColor: ColorManager.secondary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: currentIndex,
          onTap: (int index) {
            ref.read(numProvider.notifier).state = index;
            _title = titles[index];
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 26,
              ),
              label: AppStrings.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 26,
              ),
              label: AppStrings.search,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
                size: 26,
              ),
              label: 'Saved',
            ),
          ],
        ),
      ),
    );
  }
}
