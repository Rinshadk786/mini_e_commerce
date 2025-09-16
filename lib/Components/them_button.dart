import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/them_provider.dart';


class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return IconButton(
      onPressed: () => themeProvider.toggleTheme(),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: RotationTransition(
                turns: Tween<double>(begin: 0.75, end: 1.0).animate(animation),
                child: child,
              ),
            ),
          );
        },
        child: Icon(
          themeProvider.isDarkMode
              ? Icons.light_mode_outlined
              : Icons.dark_mode_outlined,
          key: ValueKey(themeProvider.isDarkMode),
        ),
      ),
    );
  }
}