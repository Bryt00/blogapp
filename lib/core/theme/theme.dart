import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
      );
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppPallete.backgroundColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(27),
        enabledBorder: _border(),
        focusedBorder: _border(AppPallete.gradient2)),
  );
}
