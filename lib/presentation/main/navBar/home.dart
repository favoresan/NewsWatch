import 'package:flutter/material.dart';
import 'package:news_watch/presentation/main/tabBar/all/all.dart';
import 'package:news_watch/presentation/main/tabBar/business/business.dart';
import 'package:news_watch/presentation/main/tabBar/entertainment/entertainment.dart';
import 'package:news_watch/presentation/main/tabBar/popular/popular.dart';
import 'package:news_watch/presentation/main/tabBar/popular/popular_viewModel.dart';
import 'package:news_watch/presentation/main/tabBar/science/science.dart';
import 'package:news_watch/presentation/main/tabBar/tech/tech.dart';
import 'package:news_watch/presentation/resources/color_manager.dart';

import '../../resources/string_manager.dart';
import '../../resources/values_manager.dart';
import '../tabBar/health/health.dart';
import '../tabBar/politics/politics.dart';
import '../tabBar/sport/sport.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 9,
      vsync: this,
      initialIndex: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: TabBar(
            splashFactory: NoSplash.splashFactory,
            labelPadding: EdgeInsets.only(right: AppSize.s8, left: AppSize.s8),
            controller: _tabController,
            labelColor: ColorManager.black,
            unselectedLabelColor: ColorManager.lightGrey,
            isScrollable: true,
            indicator:
                CircleTabIndicator(color: ColorManager.secondary, radius: 4),
            physics: BouncingScrollPhysics(),
            tabs: const [
              Tab(
                text: AppStrings.popular,
              ),
              Tab(
                text: AppStrings.all,
              ),
              Tab(
                text: AppStrings.politics,
              ),
              Tab(
                text: AppStrings.sport,
              ),
              Tab(
                text: AppStrings.health,
              ),
              Tab(
                text: AppStrings.science,
              ),
              Tab(
                text: AppStrings.tech,
              ),
              Tab(
                text: AppStrings.business,
              ),
              Tab(
                text: AppStrings.entertainment,
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              PopularTab(),
              AllTab(),
              PoliticsTab(),
              SportTab(),
              HealthTab(),
              ScienceTab(),
              TechTab(),
              BusinessTab(),
              EntertainmentTab(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
