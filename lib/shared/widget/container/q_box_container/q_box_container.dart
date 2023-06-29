import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QBoxContainer extends StatelessWidget {
  final double height;
  final double width;
  Color? color;

  QBoxContainer({
    Key? key,
    required this.height,
    required this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(color: color ?? Colors.black),
    );
  }
}
