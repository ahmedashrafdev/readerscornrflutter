import 'package:flutter/material.dart';


Widget appLogo({Alignment alignment, double width, double height}) {
  alignment = alignment == null ? Alignment.topCenter : alignment;
  width = width == null ? 150.0 : width;
  height = height == null ? 200.0 : height;
  return Container(
      alignment: alignment,
      child: Image(
        image: AssetImage('images/logo.png'),
        width: width,
        height: height,
      ));
}