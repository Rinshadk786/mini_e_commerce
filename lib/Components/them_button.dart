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
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) =>
            RotationTransition(turns: animation, child: child),
        child: Icon(
          themeProvider.isDarkMode
              ? Icons.light_mode_outlined
              : Icons.dark_mode_outlined,
          key: ValueKey(themeProvider.isDarkMode), // Important for animation
        ),
      ),
    );
  }
}
