import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movies_app/domain/domain.dart';

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
          return Column(
            children: [
              const SizedBox(height: 30),
              Text(genre.name),
            ],
          );
        },
      ),
    );
  }
}
