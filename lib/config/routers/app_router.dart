import 'package:go_router/go_router.dart';
import 'package:movies_app/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:screen',
      builder: (context, state) {
        final String screenIndex = state.pathParameters['screen'] ?? '0';
        return HomeScreen(
          screenIndex: int.parse(screenIndex),
        );
      },
      routes: [
        GoRoute(
          path: 'movie/:id',
          builder: (context, state) {
            final String movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(
              movieId: movieId,
            );
          },
        )
      ],
    ),
    GoRoute(
      path: '/movie_language_selection',
      builder: (context, state) {
        return const MovieLanguageSelectionScreen();
      },
    ),
    //* Redirect
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home/0',
    )
  ],
);
