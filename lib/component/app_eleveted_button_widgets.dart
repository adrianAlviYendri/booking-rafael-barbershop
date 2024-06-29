import 'package:flutter/material.dart';

class AppElevetedButtonWidgets extends StatelessWidget {
  const AppElevetedButtonWidgets({
    super.key,
    this.onPressed,
    this.child,
    this.backgroundColor,
    this.side,
    this.shadowColor,
    this.surfaceTintColor,
    required this.elevation,
    required this.borderRadius,
  });

  final void Function()? onPressed;
  final Widget? child;
  final Color? backgroundColor;
  final BorderSide? side;
  final BorderRadius borderRadius;
  final double elevation;
  final Color? shadowColor;
  final Color? surfaceTintColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        surfaceTintColor: backgroundColor,
        backgroundColor: backgroundColor,
        shadowColor: backgroundColor,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          side: side ?? BorderSide.none,
          borderRadius: borderRadius,
        ),
      ),
      child: child,
    );
  }
}
