//* Dart/Flutter imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//* Own Imports
import '../../views/views.dart';

// This is a stateless widget that displays the movie language selection screen
class SettingsScreen extends StatelessWidget {
  static const String name =
      'movie_language_selection'; // The name of the screen
  final String title = 'Movie Language Selection'; // The title of the screen
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LanguageSelectionView(
          title: title,
        ), // Display the language selection view
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pop();
        },
        child: Platform.isIOS
            ? const Icon(Icons.arrow_back_ios_new_rounded)
            : const Icon(Icons.arrow_back_rounded),
      ),
    );
  }
}

// This is a consumer widget that displays the language selection view
