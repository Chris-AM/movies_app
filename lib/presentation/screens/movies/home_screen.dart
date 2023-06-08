//* Flutter Imports
import 'package:flutter/material.dart';
//* Own Imports
import 'package:movies_app/config/constants/environment.dart';
import 'package:movies_app/presentation/screens/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static String name = 'Home_Screen';
  final String title = 'Movies App';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        appBarTitle: title,
      ),
      body: Center(
        child: Text(Environment.tmdbKey),
      ),
    );
  }
}
