import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'TitilliumWeb',
  primaryColor: Color(0xFFF89B1D),
  brightness: Brightness.dark,
  useMaterial3: false,
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
  highlightColor: Color(0xFF252525),
  hintColor: Color(0xFFc7c7c7),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFF89B1D),
    secondary: Color(0xFFF89B1D),
    tertiary: Color(0xFF865C0A),
    tertiaryContainer: Color(0xFF6C7A8E),
    onTertiaryContainer: Color(0xFF0F5835),
    primaryContainer: Color(0xFF208458),
    secondaryContainer: Color(0xFFF2F2F2),
    surface: Color(0xFFF2F2F2),
    surfaceTint: Color(0xFFF89B1D),
    onPrimary: Color(0xFFF89B1D),
    onSecondary: Color(0xFFFC9926),
  ),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
