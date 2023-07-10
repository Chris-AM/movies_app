import 'package:go_router/go_router.dart';
import 'package:movies_app/presentation/screens/screens.dart';
import 'package:movies_app/presentation/views/views.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const HomeView();
          },
          routes: [
            GoRoute(
              path: 'movie/:id',
              name: MovieScreen.name,
              builder: (context, state) =>
                  MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id'),
            ),
          ],
        ),
        GoRoute(
          path: '/movie_language_selection',
          name: MovieLanguageSelectionScreen.name,
          builder: (context, state) => const MovieLanguageSelectionScreen(),
        ),
        GoRoute(
          path: '/categories',
          builder: (context, state) {
            return const CategoriesView();
          },
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            return const FavoritesView();
          },
        ),
      ],
    )
  ],
);
