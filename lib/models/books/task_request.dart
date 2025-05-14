import 'package:flutter/material.dart';

class TaskRequest {
  final double fontSize;
  final double fontHeight;
  final double maxWidth;
  final double maxTextHeight;
  final EdgeInsetsGeometry padding;

  TaskRequest(this.fontSize, this.fontHeight, this.maxWidth, this.padding, this.maxTextHeight);
}