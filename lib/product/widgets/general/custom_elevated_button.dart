
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
        this.width,
        this.height,
        required this.child,
        this.onLongPress,
        required this.onPressed,
        this.backgroundColor,
        this.shadowColor,
        this.shape,
        this.padding,
        this.alignment,
        this.animationDuration,
        this.elevation});
  final double? width;
  final double? height;
  final Widget child;
  final void Function()? onLongPress;
  final void Function() onPressed;
  final Color? backgroundColor;
  final Color? shadowColor;
  final OutlinedBorder? shape;
  final EdgeInsets? padding;
  final AlignmentGeometry? alignment;
  final Duration? animationDuration;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 80,
      height: height ?? 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color?>(backgroundColor),
          shape: WidgetStatePropertyAll<OutlinedBorder>(
              shape ?? const RoundedRectangleBorder()),
          padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
              padding ?? EdgeInsets.zero),
          alignment: alignment,
          shadowColor: WidgetStatePropertyAll<Color?>(shadowColor),
          animationDuration: animationDuration,
          elevation: WidgetStatePropertyAll(elevation),
        ),
        onLongPress: onLongPress ?? () {},
        child: child,
      ),
    );
  }
}