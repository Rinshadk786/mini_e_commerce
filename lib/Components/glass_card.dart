// import 'dart:ui';
// import 'package:flutter/material.dart';
//
// class LiquidGlass extends StatelessWidget {
//
//   final Widget? child;
//   final double blurStrength;
//   final double opacity;
//   final BorderRadius borderRadius;
//
//   const LiquidGlass({
//     Key? key,
//
//     this.child,
//     this.blurStrength = 20.0,
//     this.opacity = 0.2,
//     this.borderRadius = const BorderRadius.all(Radius.circular(20)),
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: borderRadius,
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: borderRadius,
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.white.withOpacity(opacity + 0.05),
//                 Colors.white.withOpacity(opacity),
//               ],
//             ),
//             border: Border.all(
//               color: Colors.white.withOpacity(0.2),
//               width: 1.2,
//             ),
//           ),
//           child: child,
//         ),
//       ),
//     );
//   }
// }
import 'dart:ui';
import 'package:flutter/material.dart';

class LiquidGlass extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double elevation;
  final double x;
  final double y;
  final EdgeInsetsGeometry padding;

  const LiquidGlass({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.elevation = 8,
    this.x = 5,
    this.y = 5,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: elevation,
      //shadowColor: Colors.grey.shade700,
      borderRadius: BorderRadius.circular(borderRadius),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: x, sigmaY: y),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
