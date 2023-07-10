//* Flutter Imports
import 'package:flutter/material.dart';
import 'package:movies_app/presentation/views/views.dart';
import 'package:movies_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static String name = 'Home_Screen';
  final int screenIndex;
  const HomeScreen({
    super.key,
    required this.screenIndex,
  });

  final viewRoutes = const <Widget>[
    HomeView(),
    CategoriesView(),
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: screenIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar:  CustomNavigationBar( currentIndex: screenIndex ),
    );
  }
}
