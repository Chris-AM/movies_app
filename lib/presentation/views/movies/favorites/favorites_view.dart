import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/domain.dart';
import 'package:movies_app/presentation/providers/providers.dart';
import 'package:movies_app/presentation/widgets/widgets.dart';

class FavoritesView extends ConsumerStatefulWidget {
  static const name = 'Favorites View';
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) {
      return;
    }
    isLoading = true;
    final loadNextPage =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if (loadNextPage.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<MovieEntity> movieMap =
        ref.watch(favoriteMoviesProvider).values.toList();
    if (movieMap.isEmpty) {
      final ColorScheme colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline_sharp,
              size: 100,
              color: colors.primary,
            ),
            Text(
              "you haven't added any movie to fav yet",
              maxLines: 4,
              style: TextStyle(
                fontSize: 15,
                color: colors.secondary,
              ),
            )
          ],
        ),
      );
    }
    return Scaffold(
      body: FavMoviesGridView(
        movies: movieMap,
        loadNextPage: loadNextPage,
      ),
    );
  }
}
