//* Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//* Own Imports
import 'package:movies_app/domain/entities/movie_entity.dart';
import 'package:movies_app/presentation/providers/movies/movies_provider.dart';
import 'package:movies_app/presentation/screens/widgets/widgets.dart';
import 'package:movies_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static String name = 'Home_Screen';
  static String title = 'Movies App';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final List<MovieEntity> nowPlayingMovies =
        ref.watch(nowPlayingMoviesProvider);
    return Column(
      children: [
        GlobalAppBar(
          appBarTitle: HomeScreen.title,
          showSettingsButton: true,
        ),
        MoviesSlideshow(movies: nowPlayingMovies),
      ],
    );
  }
}
