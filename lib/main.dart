//* Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//* Own Imports
import 'package:movies_app/config/routers/app_router.dart';
import 'package:movies_app/config/theme/app_theme.dart';
import 'package:movies_app/config/theme/app_theme_provider.dart';

void main() => runApp(const ProviderScope(child: MoviesApp()));

class MoviesApp extends ConsumerWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalAppTheme globalAppTheme = ref.watch(globalAppThemeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: globalAppTheme.getTheme(),
      routerConfig: appRouter,
    );
  }
}
