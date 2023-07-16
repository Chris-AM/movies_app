import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
  });

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/$index');
        break;
      case 1:
        context.go('/home/$index');
        break;
      case 2:
        context.go('/home/$index');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: currentIndex,
      onTap: (currentIndex) {
        onItemTapped(context, currentIndex);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.label_outline_rounded,
          ),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_rounded),
          label: 'Favorites',
        ),
      ],
    );
  }
}
