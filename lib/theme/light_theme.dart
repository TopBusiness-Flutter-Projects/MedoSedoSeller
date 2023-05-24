import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'TitilliumWeb',
  primaryColor: Color(0xFFF89B1D),

  bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
  brightness: Brightness.light,
  highlightColor: Colors.white,
  hintColor: Color(0xFF9E9E9E),

  disabledColor:  Color(0xFF343A40),
  canvasColor: Color(0xFFFCFCFC),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }), colorScheme: const ColorScheme.light(
    primary: Color(0xFFFFF4E2),
    secondary: Color(0xFFF89B1D),
    tertiary: Color(0xFFF9D4A8),
    tertiaryContainer: Color(0xFFF89B1D),
    onTertiaryContainer: Color(0xFF33AF74),
    primaryContainer: Color(0xFF9AECC6),
    secondaryContainer: Color(0xFFF2F2F2),
    surface: Color(0xFF00FF58),
    surfaceTint: Color(0xFFF89B1D),
    onPrimary: Color(0xFFF89B1D),
    onSecondary: Color(0xFFFC9926)
  ).copyWith(error: Color(0xFFFF5A5A)),
);