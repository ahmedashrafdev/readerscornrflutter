import 'package:flutter/material.dart';
import 'package:readerscorner/ui/widgets/text.dart';


Widget appButton(
    {
    String btnTxt = "App Button",
    int btnHeight = 50,
    double btnPadding = 0.0,
    Color btnColor = Colors.black,
    Color bgColor = Colors.white,
    VoidCallback onBtnclicked
    }
  ) {
  return Padding(
    padding: new EdgeInsets.all(btnPadding),
    child: new RaisedButton(
      color: bgColor,
      onPressed: onBtnclicked,
      child: Container(
        height: 10,
        child: new Center(child: appText(text: btnTxt, color: btnColor)),
      ),
    ),
  );
}