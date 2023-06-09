import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/presentation/providers/providers.dart';

class GlobalAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool showSettingsButton;
  final String appBarTitle;
  const GlobalAppBar({
    super.key,
    required this.showSettingsButton,
    required this.appBarTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(appBarTitle),
      actions: [
        IconButton(
          onPressed: () {
            context.push('/movie_language_selection');
          },
          icon: showSettingsButton
              ? const Icon(Icons.settings)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
