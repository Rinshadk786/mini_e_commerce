// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../themes/them_provider.dart';
//
// class ThemeButton extends StatefulWidget {
//   const ThemeButton({super.key});
//
//   @override
//   State<ThemeButton> createState() => _ThemeButtonState();
// }
//
// class _ThemeButtonState extends State<ThemeButton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _triggerBurst() {
//     _controller
//       ..reset()
//       ..forward();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = context.watch<ThemeProvider>();
//
//     return GestureDetector(
//       onTap: () {
//         themeProvider.toggleTheme();
//         _triggerBurst();
//       },
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           /// 🌟 Radial burst behind icon
//           AnimatedBuilder(
//             animation: _controller,
//             builder: (context, child) {
//               return CustomPaint(
//                 painter: StarburstPainter(
//                   progress: _controller.value,
//                   color: themeProvider.isDarkMode ? Colors.amber : Colors.indigo,
//                 ),
//                 size: const Size(100, 100),
//               );
//             },
//           ),
//
//           /// 🌗 Icon with smooth transition
//           AnimatedSwitcher(
//             duration: const Duration(milliseconds: 600),
//             transitionBuilder: (child, animation) {
//               return ScaleTransition(
//                 scale: CurvedAnimation(
//                   parent: animation,
//                   curve: Curves.elasticOut,
//                 ),
//                 child: RotationTransition(
//                   turns: animation,
//                   child: child,
//                 ),
//               );
//             },
//             child: Icon(
//               themeProvider.isDarkMode
//                   ? Icons.light_mode_outlined
//                   : Icons.dark_mode_outlined,
//               key: ValueKey(themeProvider.isDarkMode),
//               size: 20,
//               color: themeProvider.isDarkMode ? Colors.amber : Colors.indigo,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// /// 🎨 Custom Painter for radial starburst
// class StarburstPainter extends CustomPainter {
//   final double progress;
//   final Color color;
//   final int rays;
//
//   StarburstPainter({
//     required this.progress,
//     required this.color,
//     this.rays = 12,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color.withOpacity(1 - progress)
//       ..strokeWidth = 2
//       ..strokeCap = StrokeCap.round;
//
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = progress * 50;
//
//     for (int i = 0; i < rays; i++) {
//       final angle = (2 * pi / rays) * i;
//       final dx = cos(angle) * radius;
//       final dy = sin(angle) * radius;
//
//       canvas.drawLine(center, center + Offset(dx, dy), paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant StarburstPainter oldDelegate) =>
//       oldDelegate.progress != progress;
// }




import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';

import '../themes/them_provider.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({super.key});

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Stack(
      alignment: Alignment.center,
      children: [
        /// 🎊 Confetti widget behind the button
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive, // in all directions
          emissionFrequency: 0.8,
          numberOfParticles: 12,
          maxBlastForce: 20,
          minBlastForce: 5,
          gravity: 0.3,
          colors: const [
            Colors.orange,
            Colors.blue,
            Colors.green,
            Colors.purple,
            Colors.pink,
          ],
        ),

        /// 🌗 Theme toggle button
        IconButton(
          onPressed: () {
            themeProvider.toggleTheme();
            _confettiController.play(); // trigger confetti on toggle
          },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: CurvedAnimation(
                  parent: animation,
                  curve: Curves.elasticOut,
                ),
                child: child,
              );
            },
            child: Icon(
              themeProvider.isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              key: ValueKey(themeProvider.isDarkMode),
              size: 28,
              color: themeProvider.isDarkMode ? Colors.amber : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
