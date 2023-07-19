//* Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//* Own Imports
import 'config/config.dart';

// The main function is the entry point of the app.
Future<void> main() async {
  // Load environment variables from a .env file.
  await dotenv.load(fileName: '.env');
  // Start the app by running the MoviesApp widget inside a ProviderScope.
  runApp(
    const ProviderScope(
      child: MovieApp(),
    ),
  );
}

// The MoviesApp class is a ConsumerWidget that builds the app UI based on the current state of the app.
class MovieApp extends ConsumerWidget {
  const MovieApp({Key? key}) : super(key: key);

  // The build method is called whenever the app state changes.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current app theme from the globalAppThemeProvider provider.
    final GlobalAppTheme globalAppTheme = ref.watch(globalAppThemeProvider);
    // Return a MaterialApp.router widget that provides routing functionality for the app.
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: globalAppTheme.getTheme(),
      routerConfig: appRouter,
    );
  }
}
