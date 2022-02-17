import 'package:flutter/material.dart';

class TransparentBackground extends StatelessWidget {
  final Widget? child;
  final double? radius;
  final Color? bgColor;

  const TransparentBackground({
    Key? key,
    this.child,
    this.radius,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 16.0)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      child: child ?? const SizedBox(),
    );
  }
}
