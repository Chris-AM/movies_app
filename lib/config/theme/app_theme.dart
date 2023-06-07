import 'package:flutter/material.dart';

const Map<String, Color> namedColorList = <String, Color>{
  'Red Accent': Colors.redAccent,
  'Deep Orange': Colors.deepOrange,
  'Blue Accent': Colors.blueAccent,
  'Blue Grey': Colors.blueGrey,
  'tealAccent': Colors.tealAccent,
  'Purple Accent': Colors.purpleAccent,
  'Deep Purple': Colors.deepPurple,
  'Deep Purple Accent': Colors.deepPurpleAccent,
  'Light Blue Accent': Colors.lightBlueAccent,
  'Pink Accent': Colors.pinkAccent,
};

class GlobalAppTheme {
  final int selectedColor;
  final bool isDarkMode;

  GlobalAppTheme({
    this.isDarkMode = false,
    this.selectedColor = 0,
  })  : assert(
          selectedColor >= 0,
          'Selected color must be greater than or equal to 0',
        ),
        assert(
          selectedColor < namedColorList.length,
          'Selected color must be in range of ${namedColorList.length - 1}',
        );
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: !isDarkMode ? Brightness.light : Brightness.dark,
        colorSchemeSeed: namedColorList.values.toList()[selectedColor],
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
