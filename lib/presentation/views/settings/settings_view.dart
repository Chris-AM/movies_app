import 'package:flutter/material.dart';
import 'package:movies_app/presentation/widgets/widgets.dart';

import '../views.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        GlobalAppBar(
          showSettingsButton: false,
          appBarTitle: 'Settings',
        ),
        LanguageSelectionView(),
      ],
    );
  }
}
