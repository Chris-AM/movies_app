import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/config/theme/app_theme.dart';

final Provider<Map<String, Color>> colorListProvider =
    Provider<Map<String, Color>>((ref) => namedColorList);

final StateNotifierProvider<GlobalAppThemeNotifier, GlobalAppTheme>
    globalAppThemeProvider =
    StateNotifierProvider<GlobalAppThemeNotifier, GlobalAppTheme>(
  (ref) => GlobalAppThemeNotifier(),
);

class GlobalAppThemeNotifier extends StateNotifier<GlobalAppTheme> {
  GlobalAppThemeNotifier() : super(GlobalAppTheme());
  void toggleDarkTheme() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void toggleSelectedColor(int colorIndex) {
    print(colorIndex);
    state = state.copyWith(selectedColor: colorIndex);
  }
}
