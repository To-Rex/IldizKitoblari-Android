import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextLarge extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int maxLines;
  final double? fontSize;

  const TextLarge({super.key, required this.text, this.color = Colors.black, this.fontWeight = FontWeight.normal, this.textAlign = TextAlign.start, this.overflow = TextOverflow.ellipsis, this.maxLines = 1, this.fontSize});

  @override
  Widget build(BuildContext context) => Text(text.tr, style: TextStyle( color: color, fontSize: fontSize ?? Theme.of(context).textTheme.headlineSmall!.fontSize, fontWeight: fontWeight), textAlign: textAlign, overflow: overflow, maxLines: maxLines);
}