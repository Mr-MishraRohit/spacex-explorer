import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ContentText extends StatelessWidget {
  const ContentText({
    super.key,
    this.textSize,
    required this.color,
    required this.text,
    this.maxLine,
    this.letterspacing,
    this.alignment,
    this.fontWeight,
    this.textDecoration,
  });

  final double? textSize;
  final double? letterspacing;
  final Color color;
  final String text;
  final int? maxLine;
  final TextAlign? alignment;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    if (maxLine != null) {
      return Text(
        text.tr,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontSize: textSize,
          decoration: textDecoration ?? TextDecoration.none,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
        textAlign: alignment ?? TextAlign.start,
      );
    } else {
      return Text(
        text.tr,
        style: TextStyle(
          height: 1.2,
          letterSpacing: letterspacing ?? 0.0,
          color: color,
          fontSize: textSize,
          decoration: textDecoration ?? TextDecoration.none,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
        textAlign: alignment ?? TextAlign.start,
      );
    }
  }
}
