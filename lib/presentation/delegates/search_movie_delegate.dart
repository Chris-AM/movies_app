import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';

typedef SearchMoviesCallBack = Future<List<MovieEntity>> Function(
    {String searchTerm, int movieLanguageIndex});

class SearchMovieDelegate extends SearchDelegate<MovieEntity?> {
  final SearchMoviesCallBack searchMoviesCallBack;

  SearchMovieDelegate({
    required this.searchMoviesCallBack,
  });

  @override
  String get searchFieldLabel => 'Search Movies';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('At Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMoviesCallBack(
        searchTerm: query,
        movieLanguageIndex: 0,
      ),
      builder: (context, snapshot) {
        final List<MovieEntity> movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return ListTile(
              title: Text(
                movie.title,
              ),
            );
          },
        );
      },
    );
  }
}
