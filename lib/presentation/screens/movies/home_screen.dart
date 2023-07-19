//* Flutter Imports
import 'package:flutter/material.dart';
import 'package:movies_app/presentation/views/views.dart';
import 'package:movies_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static String name = 'Home_Screen';
  final int screenIndex;
  const HomeScreen({
    super.key,
    required this.screenIndex,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final viewRoutes = const <Widget>[
    HomeView(),
    CategoriesView(),
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_pageController.hasClients) {
      _pageController.animateToPage(
        widget.screenIndex,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: viewRoutes,
      ),
      bottomNavigationBar:
          CustomNavigationBar(currentIndex: widget.screenIndex),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
