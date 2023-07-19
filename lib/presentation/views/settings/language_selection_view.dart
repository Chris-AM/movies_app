//* Flutter imports
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
//* Own imports
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class LanguageSelectionView extends ConsumerStatefulWidget {
  const LanguageSelectionView({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      LanguageSelectionViewState();
}

class LanguageSelectionViewState extends ConsumerState<LanguageSelectionView> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> languagesMapState =
        ref.watch(moviesLanguagesProvider);
    final int selectedLanguage = ref.watch(moviesLanguageIndexProvider);
    return SizedBox(
      height: 300,
      child: Expanded(
        child: Scrollbar(
          child: ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.zero,
            itemCount: languagesMapState.length,
            itemBuilder: (context, index) {
              final entries = languagesMapState.entries.toList()[index];
              return LanguageRadioListTile(
                languageNames: entries.key,
                codes: entries.value,
                selectedLanguage: selectedLanguage,
                value: index,
                onChanged: (value) {
                  ref.read(moviesLanguageIndexProvider.notifier).state = index;
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  ref.read(popularMoviesProvider.notifier).loadNextPage();
                  ref.read(upComingMoviesProvider.notifier).loadNextPage();
                  ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

// This is a stateless widget that displays a radio button for a language
