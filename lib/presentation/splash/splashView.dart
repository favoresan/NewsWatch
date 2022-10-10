import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:news_watch/presentation/resources/routes_manager.dart';
import 'package:news_watch/presentation/resources/string_manager.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';

// class SplashView extends StatefulWidget {
//   const SplashView({Key? key}) : super(key: key);
//
//   @override
//   State<SplashView> createState() => _SplashViewState();
// }
//
// class _SplashViewState extends State<SplashView> {
//   late Timer _timer;
//
//   _startDelay() {
//     _timer = Timer(Duration(seconds: 3), () => _goNext());
//   }
//
//   _goNext() {
//     Navigator.pushReplacementNamed(context, Routes.mainRoute);
//   }
//
//   @override
//   void initState() {
//     _startDelay();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorManager.primary,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: Image(
//               image: AssetImage(ImageAssets.newsIcon),
//             ),
//           ),
//           AnimatedTextKit(
//             animatedTexts: [
//               TypewriterAnimatedText(
//                 AppStrings.splashText,
//                 textAlign: TextAlign.center,
//                 textStyle: Theme.of(context).textTheme.headline6,
//               ),
//             ],
//             onTap: () {
//               print("Tap Event");
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
