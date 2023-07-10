//* Flutter Imports
import 'package:flutter/material.dart';
import 'package:movies_app/presentation/views/views.dart';
import 'package:movies_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static String name = 'Home_Screen';
  final Widget childView;
  const HomeScreen({
    super.key,
    required this.childView,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
