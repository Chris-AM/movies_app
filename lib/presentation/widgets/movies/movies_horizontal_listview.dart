import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/config/helpers/human_formats.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';

class MoviesHorizontalListView extends StatefulWidget {
  final List<MovieEntity> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MoviesHorizontalListView({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<MoviesHorizontalListView> createState() =>
      _MoviesHorizontalListViewState();
}

class _MoviesHorizontalListViewState extends State<MoviesHorizontalListView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) {
        return;
      }
      if ((scrollController.position.pixels + 200) >=
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
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _TitleView(
              title: widget.title,
              subTitle: widget.subTitle,
            ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                return _NowPlayingMoviesSlide(movie: widget.movies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleView extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _TitleView({
    this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Row(children: [
        if (title != null)
          Text(
            title!,
            style: textStyle.titleMedium,
          ),
        const Spacer(),
        if (subTitle != null)
          FilledButton.tonal(
            style: const ButtonStyle(
              visualDensity: VisualDensity.compact,
            ),
            onPressed: () {},
            child: Text(
              subTitle!,
              style: textStyle.titleMedium,
            ),
          ),
      ]),
    );
  }
}

class _NowPlayingMoviesSlide extends StatelessWidget {
  final MovieEntity movie;
  const _NowPlayingMoviesSlide({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MovieImages(movie: movie),
          _MovieTitles(movie: movie, textStyle: textStyle),
          _MovieRating(movie: movie, textStyle: textStyle)
        ],
      ),
    );
  }
}

class _MovieRating extends StatelessWidget {
  const _MovieRating({
    required this.movie,
    required this.textStyle,
  });

  final MovieEntity movie;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Row(
        children: [
          Icon(
            Icons.star_half_rounded,
            color: Colors.yellow.shade800,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '${movie.voteAverage}',
            style: textStyle.titleSmall,
          ),
          const Spacer(),
          Text(
            HumanFormats.numberToFormat(movie.popularity),
            style: textStyle.titleSmall,
          ),
        ],
      ),
    );
  }
}

class _MovieTitles extends StatelessWidget {
  const _MovieTitles({
    required this.movie,
    required this.textStyle,
  });

  final MovieEntity movie;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          movie.title,
          maxLines: 2,
          style: textStyle.bodyMedium,
        ),
      ),
    );
  }
}

class _MovieImages extends StatelessWidget {
  const _MovieImages({
    required this.movie,
  });

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          movie.posterPath,
          width: 150,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            }
            return FadeIn(
              child: child,
            );
          },
        ),
      ),
    );
  }
}
