import 'package:flutter/material.dart';

class AppInitialLoader extends StatelessWidget {
  const AppInitialLoader({super.key});

  Stream<String> getLoadingMessages() {
    final List<String> loadingMessages = <String>[
      'Loading Categories',
      'Loading Genres',
      'This is taking more than expected',
    ];

    return Stream.periodic(
      const Duration(milliseconds: 800),
      (step) => loadingMessages[step],
    ).take(loadingMessages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Loading'),
          const SizedBox(
            height: 10,
          ),
          const CircularProgressIndicator(),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading ...');
              }
              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}
