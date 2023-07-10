import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Own Imports
import 'package:movies_app/domain/entities/movie_entity.dart';
import 'package:movies_app/presentation/providers/providers.dart';
import 'package:movies_app/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  static const title = 'Movies App';
  const HomeView({super.key});

  @override
  HomeViewState createState() {
    return HomeViewState();
  }
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final bool isAppStarting = ref.watch(appInitialLoadProvider);
    if (isAppStarting) {
      return const AppInitialLoader();
    }
    final List<MovieEntity> carrouselOfMovies =
        ref.watch(moviesSlideshowProvider);
    final List<MovieEntity> nowPlayingMovies =
        ref.watch(nowPlayingMoviesProvider);
    final List<MovieEntity> popularMovies = ref.watch(popularMoviesProvider);
    final List<MovieEntity> upComingMovies = ref.watch(upComingMoviesProvider);
    final List<MovieEntity> topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(
      slivers: [
        const GlobalAppBar(
          showSettingsButton: true,
          appBarTitle: HomeView.title,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  MoviesSlideshow(movies: carrouselOfMovies),
                  MoviesHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'Now In Cinemas!',
                    subTitle: 'Today',
                    loadNextPage: () => ref
                        .read(nowPlayingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MoviesHorizontalListView(
                    movies: popularMovies,
                    title: 'Popular Movies',
                    subTitle: 'Most Watched',
                    loadNextPage: () =>
                        ref.read(popularMoviesProvider.notifier).loadNextPage(),
                  ),
                  MoviesHorizontalListView(
                    movies: upComingMovies,
                    title: 'Upcoming',
                    subTitle: 'Soon on Theaters',
                    loadNextPage: () => ref
                        .read(upComingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MoviesHorizontalListView(
                    movies: topRatedMovies,
                    title: 'Top Rated',
                    subTitle: 'Community Favs!',
                    loadNextPage: () => ref
                        .read(upComingMoviesProvider.notifier)
                        .loadNextPage(),
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
