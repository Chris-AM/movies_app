import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/domain.dart';
import 'package:movies_app/presentation/providers/categories/movie_genres_provider.dart';
import 'package:movies_app/presentation/widgets/widgets.dart';

class CategoriesView extends ConsumerStatefulWidget {
  static const name = 'Categories View';
  const CategoriesView({super.key});

  @override
  CategoriesViewState createState() => CategoriesViewState();
}

class CategoriesViewState extends ConsumerState<CategoriesView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    ref.read(getGenresProvider.notifier).loadPage();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final List<GenresEntity> genres = ref.watch(getGenresProvider);
    return Scaffold(
      body: CategoriesGridView(genres: genres),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
