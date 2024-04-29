import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final Color? color;
  final double height;
  final Widget child;
  const Square({
    required this.height,
    required this.child,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Rectangle(
      width: height,
      height: height,
      color: color,
      child: child,
    );
  }
}

class Rectangle extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? height;
  final Widget child;
  const Rectangle({
    this.color,
    this.width,
    this.height,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: height,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color ?? const Color(0xff323244),
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
