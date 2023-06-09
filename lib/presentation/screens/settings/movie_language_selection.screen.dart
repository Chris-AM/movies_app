import 'package:flutter/material.dart';
import 'package:movies_app/presentation/screens/widgets/widgets.dart';

class MovieLanguageSelectionScreen extends StatelessWidget {
  static const String name = 'movie_language_selection';
  final String title = 'Movie Language Selection';
  const MovieLanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(appBarTitle: title, showSettingsButton: false),
      body: Center(
        child: Text(title),
      ),
    );
  }
}
