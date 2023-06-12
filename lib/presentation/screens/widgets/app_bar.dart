import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GlobalAppBar extends ConsumerWidget {
  final bool showSettingsButton;
  final String appBarTitle;
  const GlobalAppBar({
    super.key,
    required this.showSettingsButton,
    required this.appBarTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie_creation_rounded,
                color: colors.primary,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                appBarTitle,
                style: textStyle.titleMedium,
              ),
              const Spacer(),
              _IconsRow(showSettingsButton: showSettingsButton),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconsRow extends StatelessWidget {
  const _IconsRow({
    required this.showSettingsButton,
  });

  final bool showSettingsButton;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        IconButton(
          onPressed: () {
            context.go('/movie_language_selection');
          },
          icon: showSettingsButton
              ? const Icon(
                  Icons.settings_rounded,
                )
              : const SizedBox.shrink(),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search_rounded,
          ),
        ),
      ],
    );
  }
}
