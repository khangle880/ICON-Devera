import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:icon/utils/extensions/extensions.dart';

class AppTheme {
  static InputDecorationTheme _inputDecorationLightTheme() {
    return InputDecorationTheme(
      errorStyle:
          TextStyle(fontFamily: "Titillium Web", fontWeight: FontWeight.w500),
      hintStyle: _bodyText1.copyWith(color: ExpandedColor.fromHex("#3D4C63")),
      labelStyle: _subtitle1.copyWith(color: ExpandedColor.fromHex("#B5BBC9")),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ExpandedColor.fromHex("#B5BBC9")),
      ),
    );
  }

  static AppBarTheme _appBarLightTheme() {
    return AppBarTheme(
      color: Colors.white,
      elevation: 0,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: ExpandedColor.fromHex("#0D1F3C")),

      // textTheme: TextTheme(
      //   headline6: _headline6,
      // ),
    );
  }

  // static final TextStyle _headline3 = TextStyle(
  //   color: ExpandedColor.fromHex("#010101"),
  //   fontSize: 48.sp,
  //   fontWeight: FontWeight.w600,
  // );

  // static final TextStyle _headline4 = TextStyle(
  //   color: ExpandedColor.fromHex("#313131"),
  //   fontSize: 32.sp,
  //   fontWeight: FontWeight.w600,
  // );

  static final TextStyle _headline5 = TextStyle(
    fontSize: 26.sp,
    color: ExpandedColor.fromHex("#0D1F3C"),
    fontWeight: FontWeight.w600,
  );

  // static final TextStyle _headline6 = TextStyle(
  //   fontSize: 20.sp,
  //   color: ExpandedColor.fromHex("#313131"),
  //   fontWeight: FontWeight.w500,
  // );

  static final TextStyle _subtitle1 = TextStyle(
    fontSize: 19.sp,
    color: ExpandedColor.fromHex("#FFFFFF"),
    fontWeight: FontWeight.w600,
  );

  // static final TextStyle _subtitle2 = TextStyle(
  //   fontSize: 14.sp,
  //   color: ExpandedColor.fromHex("#313131"),
  //   fontWeight: FontWeight.w600,
  // );

  static final TextStyle _bodyText1 = TextStyle(
    fontSize: 19.sp,
    color: ExpandedColor.fromHex("#0D1F3C"),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle _bodyText2 = TextStyle(
    fontSize: 15.sp,
    color: ExpandedColor.fromHex("#485068"),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle _button = TextStyle(
    fontSize: 15.sp,
    color: ExpandedColor.fromHex("#347AF0"),
    fontWeight: FontWeight.w600,
  );

  // static final TextStyle _caption = TextStyle(
  //   fontSize: 16.sp,
  //   color: ExpandedColor.fromHex("#313131"),
  //   fontWeight: FontWeight.w500,
  // );

  static TextTheme _textLightTheme() {
    return TextTheme(
      // headline3: _headline3,
      // headline4: _headline4,
      headline5: _headline5,
      // headline6: _headline6,
      subtitle1: _subtitle1,
      // subtitle2: _subtitle2,
      bodyText1: _bodyText1,
      bodyText2: _bodyText2,
      button: _button,
    );
  }

  static ThemeData light() {
    return ThemeData(
      buttonColor: ExpandedColor.fromHex("#347AF0"),
      primaryColorLight: ExpandedColor.fromHex("#FFFFFF"),
      scaffoldBackgroundColor: const Color(0xFFEDF1F9),
      fontFamily: "Titillium Web",
      appBarTheme: _appBarLightTheme(),
      textTheme: _textLightTheme(),
      inputDecorationTheme: _inputDecorationLightTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData dark() {
    return ThemeData.dark();
  }
}
