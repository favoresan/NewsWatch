import 'package:flutter/material.dart';
import 'package:news_watch/presentation/resources/styles_manager.dart';
import 'package:news_watch/presentation/resources/values_manager.dart';

import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main colors of the app
    primaryColor: ColorManager.primary,
    // primaryColorLight: ColorManager.primaryOpacity70,
    // primaryColorDark: ColorManager.darkPrimary,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: ColorManager.secondary),
    //ripple color
    // splashColor: ColorManager.primaryOpacity70,
    disabledColor: ColorManager.grey1, //will be used incase of disabled btns
    //card view theme
    cardTheme: CardTheme(
      color: ColorManager.primary,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),
    //button theme
    buttonTheme: ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      // splashColor: ColorManager.primaryOpacity70,
    ),
    //elevated btnTheme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
              color: ColorManager.primary,
            ),
            primary: ColorManager.secondary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s20)))),
    //text theme
    textTheme: TextTheme(
      headline1:
          getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
      headline6:
          getMediumStyle(color: ColorManager.black, fontSize: FontSize.s16),
      headline2:
          getRegularStyle(color: ColorManager.primary, fontSize: FontSize.s16),
      headline3:
          getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s16),
      headline4:
          getBoldStyle(color: ColorManager.black, fontSize: FontSize.s22),
      headline5:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s17),
      subtitle1: getRegularStyle(
          color: ColorManager.lightGrey, fontSize: FontSize.s14),
      subtitle2:
          getRegularStyle(color: ColorManager.black, fontSize: FontSize.s14),
      caption: getLightStyle(
        color: ColorManager.lightGrey,
        fontSize: FontSize.s12,
      ),
      bodyText1: getRegularStyle(
        color: ColorManager.secondary,
        fontSize: FontSize.s16,
      ),
      bodyText2: getSemiBoldStyle(
        color: ColorManager.secondary,
        fontSize: FontSize.s14,
      ),
      overline:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s18),
    ),
    //appBar theme
    appBarTheme: AppBarTheme(
      color: ColorManager.primary,
      centerTitle: true,
      elevation: AppSize.s4,
      // shadowColor: ColorManager.primaryOpacity70,
      titleTextStyle:
          getRegularStyle(color: ColorManager.primary, fontSize: FontSize.s16),
    ),
    //inputDecoration theme (textForm field)
    // inputDecorationTheme: InputDecorationTheme(
    //   contentPadding: EdgeInsets.all(AppPadding.p8),
    //   //hintStyle
    //   hintStyle: getRegularStyle(color: ColorManager.grey),
    //   //label style
    //   labelStyle: getMediumStyle(
    //     color: ColorManager.darkGrey,
    //   ),
    //   //error style
    //   errorStyle: getRegularStyle(
    //     color: ColorManager.error,
    //   ),
    //   //enabled border
    //   enabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       color: ColorManager.grey,
    //       width: AppSize.s1_5,
    //     ),
    //     borderRadius: BorderRadius.all(
    //       Radius.circular(
    //         AppSize.s8,
    //       ),
    //     ),
    //   ),
    //   //focused border
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       color: ColorManager.primary,
    //       width: AppSize.s1_5,
    //     ),
    //     borderRadius: BorderRadius.all(
    //       Radius.circular(
    //         AppSize.s8,
    //       ),
    //     ),
    //   ),
    //   //error border
    //   errorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       color: ColorManager.error,
    //       width: AppSize.s1_5,
    //     ),
    //     borderRadius: BorderRadius.all(
    //       Radius.circular(
    //         AppSize.s8,
    //       ),
    //     ),
    //   ),
    //   //focused error border
    //   focusedErrorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       color: ColorManager.primary,
    //       width: AppSize.s1_5,
    //     ),
    //     borderRadius: BorderRadius.all(
    //       Radius.circular(
    //         AppSize.s8,
    //       ),
    //     ),
    //   ),
    // ),
  );
}
