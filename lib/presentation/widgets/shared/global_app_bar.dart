import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';
import 'package:movies_app/presentation/delegates/delegates.dart';
import 'package:movies_app/presentation/providers/providers.dart';
import 'package:movies_app/presentation/providers/search/search_movies_provider.dart';

class GlobalAppBar extends ConsumerWidget {
  final bool showSettingsButton;
  final String appBarTitle;
  const GlobalAppBar({
    super.key,
    required this.showSettingsButton,
    required this.appBarTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    return SliverAppBar(
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        title: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Icon(
                    Icons.movie_creation_rounded,
                    color: colors.primary,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    appBarTitle,
                    style: textStyle.titleMedium,
                  ),
                  const Spacer(),
                  _IconsRow(showSettingsButton: showSettingsButton),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IconsRow extends ConsumerWidget {
  const _IconsRow({
    required this.showSettingsButton,
  });

  final bool showSettingsButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      children: [
        IconButton(
          onPressed: () {
            context.push('/movie_language_selection');
          },
          icon: showSettingsButton
              ? const Icon(
                  Icons.settings_rounded,
                )
              : const SizedBox.shrink(),
        ),
        IconButton(
          onPressed: () {
            final searchedMovies = ref.read(searchedMoviesProvider);
            final searchQuery = ref.read(searchQueryProvider);
            final movieProvider =
                ref.read(searchedMoviesProvider.notifier).searchedMovies;
            showSearch<MovieEntity?>(
              query: searchQuery,
              context: context,
              delegate: SearchMovieDelegate(
                initialMovies: searchedMovies,
                searchMoviesCallBack: movieProvider,
              ),
            ).then(
              (movie) {
                if (movie == null) return;
                context.push('/movie/${movie.id}');
              },
            );
          },
          icon: const Icon(
            Icons.search_rounded,
          ),
        ),
      ],
    );
  }
}
