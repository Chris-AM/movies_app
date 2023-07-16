//* Using Masonry
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movies_app/domain/domain.dart';
import 'movie_poster_link.dart';

class FavMoviesGridView extends StatefulWidget {
  final List<MovieEntity> movies;
  final VoidCallback? loadNextPage;
  const FavMoviesGridView({
    super.key,
    required this.movies,
    this.loadNextPage,
  });

  @override
  State<FavMoviesGridView> createState() => _FavMoviesGridViewState();
}

class _FavMoviesGridViewState extends State<FavMoviesGridView> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) {
        return;
      }
      if ((scrollController.position.pixels + 100) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<MovieEntity> movies = widget.movies;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: movies.length,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 3,
        itemBuilder: (context, index) {
          final MovieEntity movie = movies[index];
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(height: 30),
                MoviePosterLink(movie: movie),
              ],
            );
          }
          return MoviePosterLink(movie: movie);
        },
      ),
    );
  }
}
