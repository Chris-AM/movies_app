import 'package:flutter/material.dart';

final Map<String, Color> appColorPalette = <String, Color>{
  'Red Accent': const Color(0xFFFF5252),
  'Deep Orange': const Color(0xFFFF5722),
  'Blue Accent': const Color(0xFF2979FF),
  'Blue Grey': const Color(0xFF607D8B),
  'Teal Accent': const Color(0xFF009688),
  'Purple Accent': const Color(0xFF9C27B0),
  'Deep Purple': const Color(0xFF673AB7),
  'Deep Purple Accent': const Color(0xFF7C4DFF),
  'Light Blue Accent': const Color(0xFF03A9F4),
  'Pink Accent': const Color(0xFFE91E63),
};

class GlobalAppTheme {
  final int selectedColor;
  final bool isDarkMode;

  GlobalAppTheme({
    this.isDarkMode = false,
    this.selectedColor = 0,
  }) : assert(
          selectedColor >= 0 && selectedColor < appColorPalette.length,
          'Selected color must be between 0 and ${appColorPalette.length - 1}',
        );

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: !isDarkMode ? Brightness.light : Brightness.dark,
        colorSchemeSeed: appColorPalette.values.toList()[selectedColor],
        appBarTheme: const AppBarTheme(centerTitle: false),
      );

  GlobalAppTheme copyWith({
    int? selectedColor,
    bool? isDarkMode,
  }) =>
      GlobalAppTheme(
        selectedColor: selectedColor ?? this.selectedColor,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
}
