import 'dart:math' as math;
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CustomBackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Builder(
        builder: (context) {
          return Transform(
            alignment: Alignment.center,
            transform: (Directionality.of(context) == TextDirection.rtl)
                ? Matrix4.rotationY(math.pi) // Flip horizontally for RTL
                : Matrix4.rotationY(0), // No rotation for LTR
            child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          );
        },
      ),
    );
  }
}
