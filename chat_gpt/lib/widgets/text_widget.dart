import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.label, this.fontSizes, this.color,  this.fontWeight});

  final String label;
  final double? fontSizes;
  final Color? color;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: color ?? Colors.white,
        fontSize: fontSizes,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }
}
