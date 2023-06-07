import 'package:flutter/material.dart';
class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  const GlobalAppBar({
    super.key,
    required this.appBarTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(appBarTitle),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
