
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  
  unselectedWidgetColor: Color(0xFF2F80ED),
  checkboxTheme: CheckboxThemeData(
    side: WidgetStateBorderSide.resolveWith(
      (states) => BorderSide(color: Color(0xFF2F80ED), width: 2.0),
    ),
  ),

  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Color(0xFF2F80ED),
    secondary: Color(0xFF5DC6FF),
    tertiary: Color(0xFFB9E6FF),
  )
);

