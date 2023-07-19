import 'package:flutter/material.dart';
import 'package:movies_app/presentation/widgets/widgets.dart';

import '../views.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isTileEnabled = false;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const GlobalAppBar(
          showSettingsButton: false,
          appBarTitle: 'Settings',
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      title: const Text('Language Settings'),
                      children: const [
                        LanguageSelectionView(),
                      ],
                      onExpansionChanged: (bool expanded) {
                        setState(() => isTileEnabled = expanded);
                      },
                    ),
                  ),
                ],
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
