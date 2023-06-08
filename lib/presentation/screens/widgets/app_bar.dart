import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/presentation/providers/providers.dart';

class GlobalAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String appBarTitle;
  const GlobalAppBar({
    super.key,
    required this.appBarTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return AppBar(
      title: Text(appBarTitle),
      actions: [
        IconButton(
          onPressed: () {
          },
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
