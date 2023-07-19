//* Dart/Flutter imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/presentation/views/settings/settings_view.dart';
//* Own Imports
import '../../views/views.dart';

// This is a stateless widget that displays the movie language selection screen
class SettingsScreen extends StatelessWidget {
  static const String name = 'settings'; // The name of the screen
  final String title = 'Settings'; // The title of the screen
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SettingsView(),
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
