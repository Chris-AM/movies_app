//* Flutter Imports
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
//* Own Imports
import '../../../config/config.dart';

class ThemeSelectionView extends ConsumerStatefulWidget {
  const ThemeSelectionView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ThemeSelectionViewState();
}

class ThemeSelectionViewState extends ConsumerState<ThemeSelectionView> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Color> colorList = ref.watch(namedColorListProvider);
    final int colorIndex = ref.watch(globalAppThemeProvider).selectedColor;
    final List<String> colorNames = colorList.keys.toList();
    final List<Color> colors = colorList.values.toList();
    return SizedBox(
        height: 800,
        child: Scrollbar(
          child: ListView.builder(
            controller: scrollController,
            itemCount: colorList.length,
            padding: const EdgeInsets.only(
              top: 0,
              bottom: 500,
            ),
            itemBuilder: (context, index) {
              final String colorName = colorNames[index];
              final Color color = colors[index];
              return RadioListTile(
                title: Text(
                  colorName,
                  style: TextStyle(color: color),
                ),
                subtitle: Text(
                  'RGB: (${color.red}, ${color.green}, ${color.blue})',
                ),
                activeColor: color,
                value: index,
                groupValue: colorIndex,
                onChanged: (value) {
                  ref
                      .read(globalAppThemeProvider.notifier)
                      .setSelectedColor(index);
                  GlobalAppTheme(selectedColor: index).getTheme();
                },
              );
            },
          ),
        ));
  }
}
