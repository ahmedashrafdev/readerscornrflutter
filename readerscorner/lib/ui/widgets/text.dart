import 'package:flutter/material.dart';
Widget appText(
    {String text, bool isBold, Color color, double fontSize, TextAlign align}) {
  isBold = isBold == null ? false : isBold;
  fontSize = fontSize == null ? 18.0 : fontSize;
  color = color == null ? Colors.black : color;
  align = align == null ? TextAlign.left : align;
  FontWeight bold = isBold == false ? FontWeight.normal : FontWeight.bold;
  return Text(
    text,
    style: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: bold,
        color: color,
        fontSize: fontSize),
    textAlign: TextAlign.center,
  );
}