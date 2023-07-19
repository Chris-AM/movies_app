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
                  _ThemedExpansionTile(
                    title: 'Language Settings',
                    children: const [
                      LanguageSelectionView(),
                    ],
                    onExpansionChanged: (value) =>
                        setState(() => isTileEnabled = value),
                  ),
                  _ThemedExpansionTile(
                    title: 'Theme Settings',
                    children: const [
                      ThemeSelectionView(),
                    ],
                    onExpansionChanged: (value) =>
                        setState(() => isTileEnabled = value),
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

class _ThemedExpansionTile extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final ValueChanged<bool> onExpansionChanged;

  const _ThemedExpansionTile({
    required this.title,
    required this.children,
    required this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: Text(title),
        onExpansionChanged: onExpansionChanged,
        children: children,
      ),
    );
  }
}
