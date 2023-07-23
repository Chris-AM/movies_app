import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movies_app/domain/domain.dart';

import '../../providers/providers.dart';

class CategoriesGridView extends StatefulWidget {
  final List<GenresEntity> genres;
  final VoidCallback? loadPage;

  const CategoriesGridView({
    super.key,
    required this.genres,
    this.loadPage,
  });

  @override
  State<CategoriesGridView> createState() => _CategoriesGridViewState();
}

class _CategoriesGridViewState extends State<CategoriesGridView> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadPage == null) {
        return;
      }
      if ((scrollController.position.pixels + 100) >=
          scrollController.position.maxScrollExtent) {
        widget.loadPage!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<GenresEntity> genres = widget.genres;
    return PosterCard(scrollController: scrollController, genres: genres);
  }
}

class PosterCard extends ConsumerWidget {
  const PosterCard({
    super.key,
    required this.scrollController,
    required this.genres,
  });

  final ScrollController scrollController;
  final List<GenresEntity> genres;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: genres.length,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 3,
        itemBuilder: (context, index) {
          final GenresEntity genre = genres[index];
          final posterProvider = ref.read(getPosters(genre.id));
          final movies = posterProvider.when(
            data: (List<MovieEntity> data) {
              return Column(
                children: [
                  const SizedBox(height: 30),
                  Image.network(data.first.posterPath),
                  Text(genre.name),
                ],
              );
            },
            error: (_, __) => throw UnimplementedError(),
            loading: () => const CircularProgressIndicator(),
          );
          return movies;
        },
      ),
    );
  }
}
