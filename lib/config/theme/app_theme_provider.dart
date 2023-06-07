import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/config/theme/app_theme.dart';

// Define a provider that provides a map of named colors
final Provider<Map<String, Color>> namedColorListProvider =
    Provider<Map<String, Color>>((ref) => appColorPalette);

// Define a state notifier provider that provides an instance of GlobalAppThemeNotifier and GlobalAppTheme
final StateNotifierProvider<GlobalAppThemeNotifier, GlobalAppTheme>
    globalAppThemeProvider =
    StateNotifierProvider<GlobalAppThemeNotifier, GlobalAppTheme>(
  (ref) => GlobalAppThemeNotifier(),
);

// Define a state notifier that manages the global app theme
class GlobalAppThemeNotifier extends StateNotifier<GlobalAppTheme> {
  // Initialize the state with a default global app theme
  GlobalAppThemeNotifier() : super(GlobalAppTheme());

  // Toggle the dark mode of the global app theme
  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  // Set the selected color of the global app theme
  void setSelectedColor(int colorIndex) {
    state = state.copyWith(selectedColor: colorIndex);
  }
}
